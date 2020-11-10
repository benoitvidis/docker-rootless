#!/bin/sh

eval $(fixuid -q)
sudo chown -R me:me $HOME

exec "$@"
