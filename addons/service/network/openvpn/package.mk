################################################################################
#      This file is part of OpenELEC - http://www.openelec.tv
#      Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
#
#  OpenELEC is free software: you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation, either version 2 of the License, or
#  (at your option) any later version.
#
#  OpenELEC is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with OpenELEC.  If not, see <http://www.gnu.org/licenses/>.
################################################################################

PKG_NAME="openvpn"
PKG_VERSION="6c2d790"
PKG_REV="0"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="http://openvpn.net"
PKG_URL="$DISTRO_SRC/openvpn-$PKG_VERSION.tar.xz"
PKG_DEPENDS_TARGET="toolchain lzo lz4 libressl"
PKG_PRIORITY="optional"
PKG_SECTION="service/network"
PKG_SHORTDESC="OpenVPN is a full featured open-source VPN"
PKG_LONGDESC="OpenVPN is an open-source software application that implements virtual private network (VPN) techniques for creating secure point-to-point or site-to-site connections in routed or bridged configurations and remote access facilities."

PKG_AUTORECONF="yes"

PKG_IS_ADDON="yes"
PKG_ADDON_NAME="OpenVPN"
PKG_ADDON_TYPE="xbmc.service"
PKG_ADDON_PROVIDES=""
PKG_ADDON_REPOVERSION="7.0"
PKG_DISCLAIMER="This is an unofficial addon. Please don't ask for support in openelec forum / irc channel"

PKG_MAINTAINER="Lukas Rusak (lorusak@gmail.com)"

PKG_CONFIGURE_OPTS_TARGET="ac_cv_have_decl_TUNSETPERSIST=no \
                           --disable-server \
                           --enable-password-save \
                           --disable-plugins \
                           --enable-iproute2 IPROUTE=/sbin/ip \
                           --enable-management \
                           --disable-socks \
                           --disable-http-proxy \
                           --enable-fragment \
                           --disable-multihome \
                           --disable-port-share \
                           --disable-debug"

makeinstall_target() {
  : # use addon
}

addon() {
  mkdir -p $ADDON_BUILD/$PKG_ADDON_ID/bin
  cp $PKG_BUILD/.$TARGET_NAME/src/openvpn/openvpn $ADDON_BUILD/$PKG_ADDON_ID/bin
}
