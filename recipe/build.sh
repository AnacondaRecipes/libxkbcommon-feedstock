#!/bin/bash
set -ex

export PKG_CONFIG_PATH="${PKG_CONFIG_PATH:-}:${PREFIX}/lib/pkgconfig:$BUILD_PREFIX/$BUILD/sysroot/usr/lib64/pkgconfig:$BUILD_PREFIX/$BUILD/sysroot/usr/share/pkgconfig"

export CFLAGS="${CFLAGS} -lxcb -lxcb-xkb -lXau"

# Error with undefined variables in this version, will be fixed in the next version
# https://github.com/xkbcommon/libxkbcommon/commit/75b7da3f8698b3482ba6b11f3835561a3efb6a29
export XKB_CONFIG_UNVERSIONED_EXTENSIONS_PATH=''
export XKB_CONFIG_VERSIONED_EXTENSIONS_PATH=''

meson setup build \
  --prefix="${PREFIX}" \
  --libdir="${PREFIX}/lib" \
  --includedir=${PREFIX}/include \
  --pkg-config-path="${PKG_CONFIG_PATH}" \
  -Denable-wayland=false \
  -Denable-docs=false
ninja -C build install -v
