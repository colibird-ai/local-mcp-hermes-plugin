#!/bin/sh
# Starts the MCP server bundled inside the LMCP app the user installed separately.
# It never downloads or installs anything: if LMCP is not found, it exits with a message.
for dir in "$HOME/Applications" "/Applications"; do
  for app in "LMCP.app" "LocalMCPTray.app"; do
    bin="$dir/$app/Contents/MacOS/local-mcp-server"
    if [ -x "$bin" ]; then
      exec "$bin" --auto
    fi
  done
done
echo "LMCP is not installed. Download it from https://local-mcp.com/download and restart Hermes." >&2
exit 1

