#!/usr/bin/env bash

repo=~/.var/repo/dsio
build_dir=build
gpg_dir=gpg
gpg_key=61631B1ADEDD6AC12ECFE71E0BC5AF3C03677912

declare -a apps=(
	#"com.google.AndroidStudio"
	#"com.jetbrains.CLion"
	"com.jetbrains.IntelliJIDEA"
	#"net.sf.jasperstudio"
	#"net.fsuae.FS-UAE"
	#"net.sf.VICE"
)

mkdir -p "${build_dir}"

for app in "${apps[@]}"; do
	if [ -e "${app}/${app}.yml" ]; then
		flatpak-builder --repo=${repo} --force-clean ${build_dir}/${app} ${app}/${app}.yml
	fi
done
flatpak build-sign ${repo} --gpg-sign=${gpg_key} --gpg-homedir=${gpg_dir}
flatpak build-update-repo ${repo} --gpg-sign=${gpg_key} --gpg-homedir=${gpg_dir}

#flatpak build-update-repo --generate-static-deltas --gpg-homedir=${gpg_dir} --gpg-sign=${gpg_key} ${repo}
