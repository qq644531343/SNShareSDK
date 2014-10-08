Pod::Spec.new do |s|
    s.name = 'VDLib'
    s.version = '0.2.18'
    s.license = 'Sina CopyRight'
    s.summary = 'VDLib 是一个工具集，2.0版本，整理了目录并加入了新的log方法'
    s.homepage = 'http://svn1.intra.sina.com.cn/sinavideo_app/ios/VideoDept_V2.0/VDLib/'
    s.author = { 'sunxiao' => 'sunxiao1@staff.sina.com.cn' }
    s.source = { :svn => 'http://svn1.intra.sina.com.cn/sinavideo_app/ios/VideoDept_V2.0/VDLib/' }
    s.platform = :ios
    
    s.source_files = 'vdLib/lib/**/**/*.{h,m,c}'
    s.dependency 'RegexKitLite'
    s.dependency 'Reachability'
    s.dependency 'UIDeviceIdentifier'
    s.frameworks = 'SystemConfiguration', 'CFNetwork', 'CoreGraphics', 'QuartzCore'
    
    s.requires_arc = false
end