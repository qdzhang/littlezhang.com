#!/usr/bin/env bash
wget https://files.stork-search.net/releases/latest/stork-ubuntu-latest
chmod +x stork-ubuntu-latest
hugo --minify --gc
./stork-ubuntu-latest --build public/index.toml
