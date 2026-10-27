#!/bin/sh
set -eu

if [ "$#" -eq 0 ] || { [ "$#" -eq 1 ] && [ "$1" = "ready" ]; }; then
    echo "handarm image ready"
    exit 0
fi

needs_display=0
is_help=0
prev=""
for arg in "$@"; do
    case "$arg" in
        -h|--help) is_help=1 ;;
    esac
    if [ "$prev" = "-m" ] && [ "$arg" = "handarm" ]; then
        needs_display=1
    fi
    prev=$arg
done

if [ "$needs_display" -eq 1 ] && [ "$is_help" -eq 0 ] && [ -z "${DISPLAY:-}" ]; then
    echo "This command opens an OpenCV window and needs a display."
    echo "Docker Desktop on macOS cannot pass a display or the webcam into this container."
    echo "Use the web demo at http://localhost:8080 (Watch it run needs no camera)."
    exit 1
fi

exec "$@"
