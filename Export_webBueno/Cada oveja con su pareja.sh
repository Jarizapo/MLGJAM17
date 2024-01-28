#!/bin/sh
echo -ne '\033c\033]0;Cada oveja con su pareja\a'
base_path="$(dirname "$(realpath "$0")")"
"$base_path/Cada oveja con su pareja.x86_64" "$@"
