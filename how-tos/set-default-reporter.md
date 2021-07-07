# How to Set a Default Reporter

<!-- toc -->
## Contents

* [Supported Diff Tools](#supported-diff-tools)
    * [Mac](#mac)
    * [iOS](#ios)<!-- endToc -->

## One-Time Initialization in XCTest

Doing a one-time setup in XCTest requires two parts:

### Create Initialization Class

XCTest has an init method that can do one-time set-up. Here is an example:

snippet: approvaltests_initialization_class

### Set Initialization Class in Your Plist

Next, set this in your test Info.plist like this:

snippet: approvaltests_initialization_plist

---

[Back to README](../README.md)
