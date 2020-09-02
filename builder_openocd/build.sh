#! /bin/bash

PKG_ROOT=pkg_root

rm -rf $PKG_ROOT

docker build -t openocd .
docker run --rm -v $PWD/$PKG_ROOT:/usr/local openocd

package() {
	local ROOT=$1

	cp rpi3bp.cfg $ROOT/share/openocd/scripts/board

	mkdir $ROOT/DEBIAN

	cat << EOF > $ROOT/DEBIAN/control
Package: openocd
Version: 0.10.0
Maintainer: Your Name <maintainer@test.com>
Description: openocd local build
Homepage: http://openocd.org/
Architecture: amd64
Section: non-free
Priority: optional
EOF
#Depends: libusb-1.0.0

	cat << EOF > $ROOT/DEBIAN/conffiles
EOF

	cat << EOF > $ROOT/DEBIAN/preinst
#! /bin/bash

case "\$1" in
  install) ;;
  upgrade) ;;
  *) echo "Unrecognized argument '\$1'" ;;
esac
EOF

	cat << EOF > $ROOT/DEBIAN/postinst
#! /bin/bash

case "\$1" in
  configure) ;;
  upgrade) ;;
  *) echo "Unrecognized argument '\$1'" ;;
esac
EOF

	cat << EOF > $ROOT/DEBIAN/prerm
#! /bin/bash

case "\$1" in
  upgrade) ;;
  remove) ;;
  *) echo "Unrecognized argument '\$1'" ;;
esac
EOF

	cat << EOF > $ROOT/DEBIAN/postrm
#! /bin/bash

case "\$1" in
  remove) ;;
  purge) ;;
  *) echo "Unrecognized argument '\$1'" ;;
esac
EOF

	chmod 555 $ROOT/DEBIAN/p*

	dpkg-deb --build $ROOT openocd_0.10.0.deb
}

package $PKG_ROOT
