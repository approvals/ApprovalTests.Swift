#!/bin/bash

SCHEME='ApprovalTests.Swift'

xcodebuild test -scheme $SCHEME CODE_SIGNING_ALLOWED='NO'
