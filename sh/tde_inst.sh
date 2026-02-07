#!/bin/sh
set -e

inst_vi_plugins() {
  # gvim
  sudo apt install vim-gtk3
  
  # fuzzbox (url):  https://github.com/vim-fuzzbox/fuzzbox.vim
  if [ !  -d "$HOME/.vim/pack/plugins/start/fuzzbox" ]; then
    git clone https://github.com/vim-fuzzbox/fuzzbox.vim \
      "$HOME/.vim/pack/plugins/start/fuzzbox"
  else
    echo "[vi] fuzzbox installed already"
  fi
}

bark_bark() {
  echo "bark";
  echo "bark";
  echo "<3";
}

usage() {
  echo "Usage: $0 {vi|bark|all}"
}


case "$1" in
  vi)
    inst_vi_plugins
    ;;
  bark)
    bark_bark
    ;;
  all)
    inst_vi_plugins
    bark_bark
    ;;
  *)
    usage
    exit 1
    ;;
esac