#!/usr/bin/env bash
wally-update minor
wally install
if [ ! -d "Packages" ]; then
  mkdir "Packages"
fi
rojo sourcemap dev.project.json --output sourcemap.json
wally-package-types --sourcemap sourcemap.json Packages