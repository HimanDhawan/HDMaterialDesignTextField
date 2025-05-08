#
#  Be sure to run `pod spec lint HDMaterialTextField.podspec' to ensure this is a
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

  spec.name         = "HDMaterialTextField"
  spec.version      = "1.0.0"
  spec.summary      = "HDMaterialTextField is replica of material design textfield in swiftui."
  spec.description = "HDMaterialTextField is a customizable Material Design text field for iOS."
  spec.homepage     = "https://github.com/HimanDhawan/HDMaterialDesignTextField"
  spec.license = { :type => "MIT", :file => "LICENSE" }
  spec.author             = { "Himan Dhawan" => "himandhawandhd@gmail.com" }
  spec.source       = { :git => "https://github.com/HimanDhawan/HDMaterialDesignTextField.git", :tag => "#{spec.version}" }
  spec.source_files  = "Classes", "Classes/**/*.{h,m}"
  spec.exclude_files = "Classes/Exclude"


end
