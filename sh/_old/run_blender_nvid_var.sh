#!/bin/bash

# Environment variables to explicitly run using an NVIDIA card:
export __NV_PRIME_RENDER_OFFLOAD=1
export __GLX_VENDOR_LIBRARY_NAME=nvidia
export __VK_LAYER_NV_optimus=NVIDIA_only

# Once upon a time in Blender:
blender