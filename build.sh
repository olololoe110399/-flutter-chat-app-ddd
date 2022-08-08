#!/bin/bash
generate_dart_defines() {
    INPUT=".env"
    while IFS= read -r line; do
        DART_DEFINES="$DART_DEFINES--dart-define=$line "
    done <"$INPUT"
    echo "$DART_DEFINES"
}

check_flavor() {
    EXPORT_OPTIONS_DIR="$(pwd)/ios/ExportOptions.plist"
    echo $EXPORT_OPTIONS_DIR
}

if [ -z "$1" ]; then
    echo -e "Missing arguments: [build|run]"
    # invalid arguments
    exit 128
fi

if [ -z "$2" ] || [ -z "$3" ]; then
    echo -e "Missing arguments: [apk|appbundle|ios|ipa] [release|debug]"
    # invalid arguments
    exit 128
fi

DART_DEFINES=$(generate_dart_defines)

if [ $? -ne 0 ]; then
    echo -e "Failed to generate dart defines"
    exit 1
fi

echo -e "artifact: $2, type: $3"
echo -e "DART_DEFINES: $DART_DEFINES\n"

case "$1" in
"build")
    if [ -z "$4" ]; then
        echo -e "Missing arguments: Build number ex: [0|1|2...]"
        # invalid arguments
        exit 128
    fi
    if [ -z "$5" ]; then
        BUILD_NAME="1.0.0"
    fi
    BUILD_NAME="$5"
    echo $BUILD_NAME
    EXPORT_OPTIONS_DIR=$(check_flavor)
    EXPORT_OPTIONS=""
    if [ -f $EXPORT_OPTIONS_DIR ]; then
        EXPORT_OPTIONS="--export-options-plist=$EXPORT_OPTIONS_DIR"
    fi
    echo $EXPORT_OPTIONS

    if [ "$2" == "ipa" ] && [ -f $EXPORT_OPTIONS_DIR ]; then
        echo "EXPORT_OPTIONS_DIR: $EXPORT_OPTIONS_DIR"
        eval "flutter build $2 --$3 -t lib/main.dart --build-number=$4 --build-name=$BUILD_NAME $EXPORT_OPTIONS $DART_DEFINES"
    else
        eval "flutter build $2 --$3 -t lib/main.dart --build-number=$4 --build-name=$BUILD_NAME $DART_DEFINES"
    fi
    ;;
"run")
    eval "flutter run --$3 -t lib/main.dart $4 $DART_DEFINES"
    ;;
*) ;;
esac
