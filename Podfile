platform :ios, '10.0'
use_frameworks!
inhibit_all_warnings!

post_install do |pi|
  pi.pods_project.targets.each do |t|
    t.build_configurations.each do |config|
      config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '10.0'
    end
  end
end

def common_pods_for_target
  # Rx
  pod 'RxSwift', '~> 5.1'
  pod 'RxCocoa', '~> 5.1'
  pod 'Alamofire'
  pod 'SnapKit', '5.0.1'
end

target 'BHomeWork' do
  common_pods_for_target
end
