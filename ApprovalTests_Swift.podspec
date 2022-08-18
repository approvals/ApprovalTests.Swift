Pod::Spec.new do |s|
  s.name         = 'ApprovalTests_Swift'
  s.version      = '2.0.0'
  s.summary      = 'ApprovalTests for Swift, a powerful alternative to assertions'

  s.description = <<-DESC
                    Approval Tests are an alternative to assertions. You’ll find them useful for
                    testing objects with complex values (such as long strings), lots of properties,
                    or collections of objects.

                    ApprovalTests.Swift is compatible with the XCTest testing framework.
                  DESC

  s.homepage = 'https://github.com/approvals/ApprovalTests.Swift'
  s.license  = { :type => 'Apache License, Version 2.0', :file => 'LICENSE' }
  s.author   = { 'Jon Reid' => 'jon@qualitycoding.org' }
  s.social_media_url = 'https://twitter.com/qcoding'

  s.swift_version = '5.0'
  s.ios.deployment_target = '12.0'
  s.osx.deployment_target = '10.15'

  s.source = { :git => 'https://github.com/approvals/ApprovalTests.Swift.git', :tag => 'v2.0.0' }
  s.framework = 'XCTest'
  s.source_files      = "ApprovalTests.Swift/iOSApprovalsWatcher.py", "ApprovalTests.Swift/**/*.swift" 
  s.ios.exclude_files = "ApprovalTests.Swift/Reporters/macOS/*.swift"
  s.osx.exclude_files = "ApprovalTests.Swift/Reporters/iOS/*.swift"

end
