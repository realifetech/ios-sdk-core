#
#  Be sure to run `pod spec lint RealifeTech-CoreSDK.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see https://guides.cocoapods.org/syntax/podspec.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |spec|

  # ―――  Spec Metadata  ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  These will help people to find your library, and whilst it
  #  can feel like a chore to fill in it's definitely to your advantage. The
  #  summary should be tweet-length, and the description more in depth.
  #

  spec.name         = "RealifeTech-CoreSDK"
  spec.version      = "1.0.0"
  spec.summary      = "Providing the core services with the RealifeTech Experience Automation Platform."

  spec.description  = "This is RealifeTech Core SDK, it provides the core services with RealifeTech backend services. Creating a better experience of the real world for every person."

  spec.homepage     = "https://realifetech.com"


  # ―――  Spec License  ――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  Licensing your code is important. See https://choosealicense.com for more info.
  #  CocoaPods will detect a license file if there is a named LICENSE*
  #  Popular ones are 'MIT', 'BSD' and 'Apache License, Version 2.0'.
  #

  #  spec.license      = "MIT"
  #  spec.license      = { :type => "MIT", :file => "LICENSE" }


  # ――― Author Metadata  ――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  Specify the authors of the library, with email addresses. Email addresses
  #  of the authors are extracted from the SCM log. E.g. $ git log. CocoaPods also
  #  accepts just a name if you'd rather not provide an email address.
  #
  #  Specify a social_media_url where others can refer to, for example a twitter
  #  profile URL.
  #

  spec.author             = { "RealifeTech iOS Team" => "ios@realifetech.com" }
  spec.authors            = { "Mickey Lee" => "mickey.lee.25@outlook.com", "Jonathon Albert" => "jonathon.albert@live.com" }


  # ――― Platform Specifics ――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  If this Pod runs only on iOS or OS X, then specify the platform and
  #  the deployment target. You can optionally include the target after the platform.
  #

  spec.platform      = :ios, "13.0"
  spec.swift_version = "5.0"


  # ――― Source Location ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  Specify the location from where the source should be retrieved.
  #  Supports git, hg, bzr, svn and HTTP.
  #

  spec.source       = { :git => "https://github.com/realifetech/ios-sdk-core.git", :branch => 'master', :tag => "#{spec.version}" }


  # ――― Source Code ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  CocoaPods is smart about how it includes source code. For source files
  #  giving a folder will include any swift, h, m, mm, c & cpp files.
  #  For header files it will include any header in the folder.
  #  Not including the public_header_files will make all headers public.
  #

  spec.source_files  = [
    '**/*.swift',
    'RealifeTech-CoreSDK/RealifeTech_CoreSDK.h'
  ]
  spec.exclude_files = [
    'Pods/**/*',
    '**/Tests/**/*',
    '**/**/Tests/**/*'
  ]


  # ――― Project Settings ――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  If your library depends on compiler flags you can set them in the xcconfig hash
  #  where they will only apply to your library. If you depend on other Podspecs
  #  you can include multiple dependencies to ensure it works.

  spec.dependency 'SwiftLint'
  spec.dependency 'RxSwift', '~> 5.1.1'
  spec.dependency 'RxCocoa', '~> 5.1.1'
  spec.dependency 'Apollo', '~> 0.30.0'
  spec.dependency 'Apollo/SQLite'

end
