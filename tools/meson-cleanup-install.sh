#!/bin/sh
#
# Copyright (C) 2017 Facebook
#
# This source code is licensed under the license found in the
# LICENSE file in the root directory of this source tree.
#

if [ -z "${MESON_INSTALL_PREFIX}" ]; then
  echo 'MESON_INSTALL_PREFIX is not set, aborting'
  exit 1
fi

rm -rf "${DESTDIR}/${MESON_INSTALL_PREFIX}/../etc"
rm -rf "${DESTDIR}/${MESON_INSTALL_PREFIX}/../var"

rm -rf "${DESTDIR}/${MESON_INSTALL_PREFIX}/bin"
rm -rf "${DESTDIR}/${MESON_INSTALL_PREFIX}/include"
rm -rf "${DESTDIR}/${MESON_INSTALL_PREFIX}/lib"
rm -rf "${DESTDIR}/${MESON_INSTALL_PREFIX}/share"

rm -f "${DESTDIR}/${MESON_INSTALL_PREFIX}"/lib*/libnss*
rm -f "${DESTDIR}/${MESON_INSTALL_PREFIX}"/lib*/libsystemd.so*
rm -f "${DESTDIR}/${MESON_INSTALL_PREFIX}"/lib*/libudev.so*

rm -f "${DESTDIR}/${MESON_INSTALL_PREFIX}"/lib*/pkgconfig/libsystemd.pc
rm -f "${DESTDIR}/${MESON_INSTALL_PREFIX}"/lib*/pkgconfig/libudev.pc
rm -rf "${DESTDIR}/${MESON_INSTALL_PREFIX}"/lib*/security

exit 0
