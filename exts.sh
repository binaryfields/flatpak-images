#!/usr/bin/env bash

repo=~/.var/repo/dsio
build_dir=build
gpg_dir=~/.gnupg
gpg_key=596AE2EE4A73DB1605334629662603BD42FFB34C

declare -a apps=(
	"org.freedesktop.Sdk.Extension.openjdk8"
)


mkdir -p "${build_dir}"

for app in "${apps[@]}"; do
	if [ -e "${app}/${app}.json" ]; then
		flatpak-builder --force-clean --gpg-homedir=${gpg_dir} --gpg-sign=${gpg_key} --repo=${repo} ${build_dir}/${app} ${app}/${app}.json
	fi
done
flatpak build-update-repo --generate-static-deltas --gpg-homedir=${gpg_dir} --gpg-sign=${gpg_key} ${repo}