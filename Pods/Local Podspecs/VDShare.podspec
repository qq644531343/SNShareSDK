Pod::Spec.new do |s|
	s.name          = 'VDShare'
	s.version       = '0.0.3'
	s.license       = 'Sina CopyRight'
	s.summary       = 'VDShareShare是统一的分享类库'
	s.homepage      = 'http://svn1.intra.sina.com.cn/sinavideo_app/ios/VideoDept_V2.0/VDShare/'
	s.author = { 'Sun Xiao' => 'sunxiao1@staff.sina.com.cn' }
	s.source = { :svn => 'http://svn1.intra.sina.com.cn/sinavideo_app/ios/VideoDept_V2.0/VDShare/' }
	s.platform = :ios
	s.source_files = 'Lib/**/**/**/**/*.{h,m,a}'  
	s.libraries = 'sqlite3', 'stdc++', 'z'
	s.vendored_libraries = 'Lib/ShareTo/SinaWeibo/libs/libWeiboSDK.a', 'Lib/ShareTo/Weixin/libs/libWeChatSDK.a', 'Lib/ShareTo/MobileQQ/libs/TencentOpenAPI.framework'
	s.preserve_path = 'Lib/ShareTo/MobileQQ/libs/TencentOpenAPI.framework'
	s.vendored_frameworks = 'Lib/ShareTo/MobileQQ/libs/TencentOpenAPI.framework'
	s.resources = ['Lib/ShareTo/SinaWeibo/libs/WeiboSDK.bundle', 'Lib/ShareTo/MobileQQ/libs/TencentOpenApi_IOS_Bundle.bundle'] 
	s.frameworks = 'MediaPlayer', 'CoreGraphics', 'CoreFoundation', 'CoreTelephony', 'CFNetwork', 'UIKit', 'SystemConfiguration', 'Foundation'
end 
