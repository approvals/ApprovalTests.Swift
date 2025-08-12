#!/bin/bash

set -e # exit when any command fails

swift build -v
xcodebuild test -scheme ApprovalTests.Swift CODE_SIGNING_ALLOWED='NO'
xcodebuild test -scheme ApprovalTests_iOS -sdk iphonesimulator -destination "platform=iOS Simulator,OS=latest,name=iPhone 16" CODE_SIGNING_ALLOWED='NO'
