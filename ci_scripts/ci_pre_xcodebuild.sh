#!/bin/sh

echo "Decoding GoogleService-Info.plist from environment variable..."
echo "$Secrets" | base64 --decode > ../Apps/Main/Egzaminy-ULC/SupportingFiles/Configuration/Secrets.xcconfig
echo "Stage: PRE-Xcode Build is DONE .... "
