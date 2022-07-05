#!/bin/bash

set -ue

CURRENT_DIR=$(cd "$(dirname "$0")"; pwd)

ln -fs "$CURRENT_DIR/com.knollsoft.Rectangle.plist" ~/Library/Preferences
