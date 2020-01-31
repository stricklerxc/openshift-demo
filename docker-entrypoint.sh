#!/bin/sh

# Do some work/setup before running the main process

# Run main process
# Executes the commands that are given after the ENTRYPOINT defined in the Dockerfile
exec "$@"