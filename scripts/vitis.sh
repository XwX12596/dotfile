#!/usr/bin/env bash

cd /tmp

unset SWT_GTK4

exec env \
  SWT_GTK3=1 \
  GDK_BACKEND=x11 \
  LD_PRELOAD="/usr/lib/libstdc++.so.6:/usr/lib/libgcc_s.so.1:/usr/lib/libfreetype.so.6:/usr/lib/libharfbuzz.so.0" \
  /opt/Xilinx/Vitis/2024.2/bin/vitis "$@"
