#!/usr/bin/env bash
# Compare files between two specified git commits, using Kompare
#
# To-do:  integrate with klaw, and take some old throwaway code from view
#
# Note:  this script uses temporary copies of your git, so you can't mess anythi
# ng up in the Kompare window, as i don't know about any user's skill issues.
#
# Creates CMIT_MSG.txt files, at the directory roots, with the commit messages.
#
# Usage (see):  #1


set -eu

if [[ $# -lt 2 ]]; then
# see:  git_kompare_diff_in_range.sh HEAD..HEAD~3 /git/path
    echo "Usage: $0 <commitA>..<commitB> path1 [path2 ...]"
    exit 1
fi

range="$1"
shift

if [[ "$range" != *".."* ]]; then
    echo "Invalid range. Use: <commitA>..<commitB>"
    exit 1
fi


commit_a="${range%%..*}"
commit_b="${range##*..}"

paths=("$@")

repo_root=""
for p in "${paths[@]}"; do
    dir="$p"
    [[ -f "$dir" ]] && dir="$(dirname "$dir")"
    while [[ "$dir" != "/" ]]; do
        if git -C "$dir" rev-parse --show-toplevel >/dev/null 2>&1; then
            repo_root=$(git -C "$dir" rev-parse --show-toplevel)
            break 2
        fi
        dir="$(dirname "$dir")"
    done
done

if [[ -z "$repo_root" ]]; then
    echo "Not inside a Git repository"
    exit 1
fi


if git -C "$repo_root" merge-base --is-ancestor "$commit_a" "$commit_b"; then
    older_commit="$commit_a"
    newer_commit="$commit_b"
elif git -C "$repo_root" merge-base --is-ancestor "$commit_b" "$commit_a"; then
    older_commit="$commit_b"
    newer_commit="$commit_a"
else
    echo "Commits are not of the same historic lineage"
    exit 1
fi


tmpdir=$(mktemp -d /tmp/gitkompare-XXXXXX)
trap 'rm -rf "$tmpdir"' EXIT

compare_dir="$tmpdir/compare"	# left  (older)
work_dir="$tmpdir/work"		# right (newer)

mkdir -p "$compare_dir" "$work_dir"

found_any=false


for p in "${paths[@]}"; do
    rel=$(realpath --relative-to="$repo_root" "$p")

    while IFS= read -r relfile; do
        mkdir -p "$compare_dir/$(dirname "$relfile")"
        mkdir -p "$work_dir/$(dirname "$relfile")"

        if git -C "$repo_root" show "$older_commit:$relfile" >"$compare_dir/$relfile" 2>/dev/null &&
           git -C "$repo_root" show "$newer_commit:$relfile" >"$work_dir/$relfile" 2>/dev/null; then
           found_any=true
        fi
    done < <(git -C "$repo_root" ls-tree -r --name-only "$newer_commit" -- "$rel")
done

if [[ "$found_any" != true ]]; then
    echo "No files available in both commits to compare"
    exit 1
fi

git -C "$repo_root" show -s --format=%B "$older_commit" \
    | fold -w 80 -s >"$compare_dir/CMIT_MSG.txt"

git -C "$repo_root" show -s --format=%B "$newer_commit" \
    | fold -w 80 -s >"$work_dir/CMIT_MSG.txt"


kompare "$compare_dir" "$work_dir" 2> >(grep -v "kf.kio" >&2)



