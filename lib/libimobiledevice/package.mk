################################################################################
#      This file is part of OpenELEC - http://www.openelec.tv
#      Copyright (C) 2009-2012 Stephan Raue (stephan@openelec.tv)
#
#  This Program is free software; you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation; either version 2, or (at your option)
#  any later version.
#
#  This Program is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
#  GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with OpenELEC.tv; see the file COPYING.  If not, write to
#  the Free Software Foundation, 51 Franklin Street, Suite 500, Boston, MA 02110, USA.
#  http://www.gnu.org/copyleft/gpl.html
################################################################################

PKG_NAME="libimobiledevice"
PKG_VERSION="1.2.0"
PKG_REV="0"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="http://www.libimobiledevice.org"
PKG_URL="http://www.libimobiledevice.org/downloads/$PKG_NAME-$PKG_VERSION.tar.bz2"
PKG_DEPENDS_TARGET="toolchain libusbmuxd"
PKG_SECTION="libs"
PKG_PRIORITY="optional"
PKG_SHORTDESC=""
PKG_LONGDESC=""

PKG_IS_ADDON="no"

PKG_AUTORECONF="yes"

PKG_MAINTAINER="Lukas Rusak (lorusak@gmail.com)"

PKG_CONFIGURE_OPTS_TARGET="--enable-static \
                           --disable-shared \
                           --without-cython \
                           --disable-largefile"

post_makeinstall_target() {
  cp $ROOT/$PKG_BUILD/common/utils.h $SYSROOT_PREFIX/usr/include/libimobiledevice/
}
