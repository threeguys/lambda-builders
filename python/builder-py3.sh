#!/bin/bash

NAME=${1:-package}
ARCHIVE_NAME="/src/build/lambda-$NAME.zip"
TEMP_ARCHIVE="/tmp/archive"

# Prep build space
mkdir -p /src/build && rm -f $ARCHIVE_NAME 2> /dev/null
mkdir -p $TEMP_ARCHIVE

# Download and install dependencies
cd /src \
    && pip install --target $TEMP_ARCHIVE -r requirements.txt \
    && cp /src/*.py $TEMP_ARCHIVE \
    && cd $TEMP_ARCHIVE \
    && zip -r $ARCHIVE_NAME . \
    && rm -rf $TEMP_ARCHIVE

echo
echo "Build complete!"
du -h -b $ARCHIVE_NAME
