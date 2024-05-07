#!/bin/bash

set -e # exit when any command fails

swift build -v
xcodebuild test -project ApprovalTests.Swift.xcodeproj -scheme ApprovalTests.Swift 
xcodebuild test -project ApprovalTests.Swift.xcodeproj -scheme ApprovalTests_iOS -sdk iphonesimulator -destination "platform=iOS Simulator,OS=latest,name=iPhone 15"
