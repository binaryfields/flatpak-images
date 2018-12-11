#!/usr/bin/env bash

build_dir=build

declare -a apps=(
	"org.freedesktop.Sdk.Extension.openjdk8"
)


mkdir -p "${build_dir}"

for app in "${apps[@]}"; do
	if [ -e "${app}/${app}.json" ]; then
		flatpak-builder --install --force-clean ${build_dir}/${app} ${app}/${app}.json
	fi
done
