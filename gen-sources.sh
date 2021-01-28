#!/bin/bash
if [ ! -d joplin ];then
	url=`grep -oE "https://[^\"\']*" ./*.yml | grep joplin`
	wget -nv $url -O joplin.tar && tar -xf joplin.tar
	mv joplin-* joplin
fi

if [ ! -d joplin/git ];then
	mkdir joplin/git
	pushd joplin/git
	git clone https://github.com/laurent22/node-emoji.git
	git clone https://github.com/laurent22/uslug.git
	cd uslug && git checkout emoji-support
	popd
fi

nodegen=./flatpak-builder-tools/node/flatpak-node-generator.py
packages=`find joplin -type f -iname package-lock.json|grep -vE 'tests|Assets'`
nopackages=`find joplin -type f -iname package-lock.json|grep -E 'tests|Assets'`
echo '-----Not include-----'
for pack in $nopackages; do echo $pack; done
echo -e '--------------------\n'
for pack in $packages; do
	pattern="$pattern -R $pack"
done

$nodegen --xdg-layout -r $pattern npm joplin/package-lock.json
