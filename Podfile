# Uncomment the next line to define a global platform for your project
platform :ios, '11.0'

target 'LegheFantaChallenge' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for LegheFantaChallenge
  pod 'Kingfisher'
  pod 'Anchorage'
  pod 'RxSwift'
  pod 'NotificationBannerSwift', '~> 3.0.0'
  pod 'RxCocoa'
  pod 'SwiftLint'
  pod 'IQKeyboardManager'
end


post_install do |installer|
    installer.generated_projects.each do |project|
        project.targets.each do |target|
            target.build_configurations.each do |config|
                config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '13.0'
            end
        end
    end
end
