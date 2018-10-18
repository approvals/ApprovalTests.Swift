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
ApprovalTests for Swift
                   DESC

  s.homepage     = "https://github.com/approvals"

  s.license      = "Apache 2.0 License"
  # s.license      = { :type => "MIT", :file => "FILE_LICENSE" }

  s.author    = "Matthew Carlson"

  s.platform = :osx
  s.osx.deployment_target = "10.13"

  s.source       = { :git => "https://github.com/approvals/ApprovalTests.Swift.git" }


  s.source_files  = "ApprovalTests.Swift", "ApprovalTests.Swift/**/*.swift"
  #s.exclude_files = "Classes/Exclude"

  # s.public_header_files = "Classes/**/*.h"
end
