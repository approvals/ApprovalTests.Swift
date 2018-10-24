#
#  Be sure to run `pod spec lint ApprovalTests_Swift.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|
  s.name         = "ApprovalTests_Swift"
  s.version      = "0.0.1"
  s.summary      = "ApprovalTests for Swift."

  s.description  = <<-DESC
Capturing Human Intelligence - ApprovalTests is an open source assertion/verification library to aid unit testing.
ApprovalsTest Swift is compatible with the XCUnit testing framework
                   DESC

  s.homepage     = "https://github.com/approvals"

  s.license      = { :type => "Apache 2.0 License", :file => "LICENSE" }
  # s.license      = { :type => "MIT", :file => "FILE_LICENSE" }

  s.author    = "Matthew Carlson"

  s.swift_version = '4.1'
  s.ios.deployment_target = "11.0"
  s.osx.deployment_target = "10.13"

  s.source       = { :git => "https://github.com/approvals/ApprovalTests.Swift.git" }

  s.framework = "XCTest"

  s.source_files      = "ApprovalTests.Swift", "ApprovalTests.Swift/**/*.swift" 
  s.ios.exclude_files = "ApprovalTests.Swift/**/DiffMergReporter.swift"
  s.osx.exclude_files = "ApprovalTests.Swift/reporters/ios/XCTReporter.swift"

end
