# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'MSP_Customer' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for MSP_Customer

  pod 'SlideMenuControllerSwift'
  pod 'IQKeyboardManagerSwift'
  pod 'SDWebImage'
#  pod 'AlamofireImage'
  pod 'Alamofire', '~> 4.0'
  pod 'NotificationBannerSwift', '~> 3.0.0'
  pod 'lottie-ios'
  pod 'Toast-Swift', '~> 5.0.1'
  pod 'SwiftGifOrigin'
  pod 'HCSStarRatingView', '~> 1.5'
  pod "ImageSlideshow/Alamofire"
  pod 'NHRangeSlider', '~> 0.2'
  pod 'DPOTPView'
  pod 'Firebase/Analytics'
  pod 'Kingfisher'
  pod 'QCropper'

  pod 'GoogleAnalytics'
 pod 'Firebase/Core'
  pod 'FirebaseAuth'
  pod 'FirebaseFirestore'
  pod 'Firebase/Messaging'
  pod 'Firebase/Analytics'
  

end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
           if config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'].to_f < 11.0
             config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '11.0'
           end
        end
    end
 end
