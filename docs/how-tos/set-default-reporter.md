# How to Set a Default Reporter

<!-- toc -->
## Contents

  * [One-Time Initialization in XCTest](#one-time-initialization-in-xctest)
    * [Create Initialization Class](#create-initialization-class)
    * [Set Initialization Class in Your Plist](#set-initialization-class-in-your-plist)<!-- endToc -->

## One-Time Initialization in XCTest

Doing a one-time setup in XCTest requires two parts:

### Create Initialization Class

XCTest has an init method that can do one-time set-up. Here is an example:

<!-- snippet: approvaltests_initialization_class -->
<a id='snippet-approvaltests_initialization_class'></a>
```swift
public class TestSetup: NSObject {

    override init() {
        super.init()
```
<sup><a href='/ApprovalTests_SwiftTests/TestSetup.swift#L8-L13' title='Snippet source file'>snippet source</a> | <a href='#snippet-approvaltests_initialization_class' title='Start of snippet'>anchor</a></sup>
<!-- endSnippet -->

### Set Initialization Class in Your Plist

Next, set this in your test Info.plist like this:

<!-- snippet: approvaltests_initialization_plist -->
<a id='snippet-approvaltests_initialization_plist'></a>
```plist
<key>NSPrincipalClass</key>
<string>$(TARGET_NAME).TestSetup</string>
```
<sup><a href='/ApprovalTests_SwiftTests/Info.plist#L21-L24' title='Snippet source file'>snippet source</a> | <a href='#snippet-approvaltests_initialization_plist' title='Start of snippet'>anchor</a></sup>
<!-- endSnippet -->

---

[Back to README](../README.md)
