#!/bin/bash
# Double-click this to run the slide deck through a local web server so the
# embedded YouTube video plays inline. Leave the small Terminal window open
# while presenting; close it when you're done.
cd "$(dirname "$0")" || exit 1
PORT=8137
URL="http://localhost:$PORT/agentic-ai-presentation.html"

# Start a tiny static web server using whatever is available on the Mac.
if command -v python3 >/dev/null 2>&1; then
  python3 -m http.server "$PORT" >/dev/null 2>&1 &
elif command -v ruby >/dev/null 2>&1; then
  ruby -run -e httpd . -p "$PORT" >/dev/null 2>&1 &
elif command -v python >/dev/null 2>&1; then
  python -m SimpleHTTPServer "$PORT" >/dev/null 2>&1 &
else
  echo "No python or ruby found. Please install one, or open the .html directly (video won't play inline)."
  read -r -p "Press Return to close."
  exit 1
fi

SERVER_PID=$!
sleep 1.5
open "$URL"

echo "Presentation running at $URL"
echo "Keep this window open while presenting."
echo "Press Ctrl+C (or close this window) to stop the server."
# Keep the server alive in the foreground.
wait "$SERVER_PID"
