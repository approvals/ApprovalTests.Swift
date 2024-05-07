#!/bin/bash

xcodebuild test -project ApprovalTests.Swift.xcodeproj -scheme ApprovalTests_iOS -sdk iphonesimulator -destination "platform=iOS Simulator,OS=latest,name=iPhone 15"
