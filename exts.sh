#!/usr/bin/env bash

repo=~/.var/repo/dsio
build_dir=build
gpg_dir=gpg
gpg_key=61631B1ADEDD6AC12ECFE71E0BC5AF3C03677912

declare -a apps=(
	"org.freedesktop.Sdk.Extension.openjdk8"
)

mkdir -p "${build_dir}"

for app in "${apps[@]}"; do
	if [ -e "${app}/${app}.json" ]; then
		flatpak-builder --repo=${repo} --force-clean ${build_dir}/${app} ${app}/${app}.json
	fi
done

flatpak build-sign ${repo} --gpg-sign=${gpg_key} --gpg-homedir=${gpg_dir}
flatpak build-update-repo ${repo} --gpg-sign=${gpg_key} --gpg-homedir=${gpg_dir}
