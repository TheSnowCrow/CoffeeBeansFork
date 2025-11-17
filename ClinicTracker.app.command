#!/bin/bash
# macOS Application Launcher for Clinic Visit Tracker
# Double-click this file to launch the app

# Get the directory where this script is located
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd "$DIR"

# Use the universal launcher
exec "$DIR/launch_app.sh"
