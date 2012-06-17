#!/bin/bash

mkdir -p plugins/$1/templates/etc/yavdr/vdr/plugins/plugin.$1.conf
mkdir -p plugins/$1/templates/etc/yavdr/vdr/plugins.conf

echo "etc/yavdr/vdr/plugins" > debian/yavdr-vdr-plugin-$1.dirs
echo "usr/share/yavdr/templates" >> debian/yavdr-vdr-plugin-$1.dirs

echo "#!/bin/sh -e" > debian/yavdr-vdr-plugin-$1.postinst
echo "" >> debian/yavdr-vdr-plugin-$1.postinst
echo "case \"\$1\" in" >> debian/yavdr-vdr-plugin-$1.postinst
echo "  configure)" >> debian/yavdr-vdr-plugin-$1.postinst
echo "    yavdr-template-vdr" >> debian/yavdr-vdr-plugin-$1.postinst
echo "  ;;" >> debian/yavdr-vdr-plugin-$1.postinst
echo "esac" >> debian/yavdr-vdr-plugin-$1.postinst
echo "" >> debian/yavdr-vdr-plugin-$1.postinst
echo "exit 0" >> debian/yavdr-vdr-plugin-$1.postinst

echo "#!/bin/sh -e" > debian/yavdr-vdr-plugin-$1.postrm
echo "" >> debian/yavdr-vdr-plugin-$1.postrm
echo "if [ remove = \"\$1\" ]; then" >> debian/yavdr-vdr-plugin-$1.postrm
echo "  yavdr-template-vdr" >> debian/yavdr-vdr-plugin-$1.postrm
echo "  rm /etc/yavdr/vdr/plugins/$1.conf" >> debian/yavdr-vdr-plugin-$1.postrm
echo "fi" >> debian/yavdr-vdr-plugin-$1.postrm
echo "" >> debian/yavdr-vdr-plugin-$1.postrm
echo "exit 0" >> debian/yavdr-vdr-plugin-$1.postrm

echo "plugins/$1/templates/*	usr/share/yavdr/templates/" > debian/yavdr-vdr-plugin-$1.install
echo '<?cs include:"/usr/share/yavdr/templates/includes/header.cs" ?>' > plugins/$1/templates/etc/yavdr/vdr/plugins/plugin.$1.conf/02_header.cs

echo $1 > plugins/$1/templates/etc/yavdr/vdr/plugins.conf/50_$1.cs

chmod a+x debian/yavdr-vdr-plugin-$1.postinst
chmod a+x debian/yavdr-vdr-plugin-$1.postrm
