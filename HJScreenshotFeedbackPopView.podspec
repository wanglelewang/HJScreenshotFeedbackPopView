Pod::Spec.new do |s|
    s.name         = 'HJScreenshotFeedbackPopView'
    s.version      = '0.0.1'
    s.summary      = 'snapshot popview'
    s.homepage     = 'https://github.com/wanglelewang/HJScreenshotFeedbackPopView.git'
    s.license      = 'MIT'
    s.authors      = {'Wanglelewang' => 'lameshuaia@163.com'}
    s.platform     = :ios, '7.0'
    s.source       = {:git => 'https://github.com/wanglelewang/HJScreenshotFeedbackPopView.git', :tag => s.version}
    s.source_files = 'Classes/**/*.{h,m}'
    s.resource     = 'Classes/HJScreenshot.bundle'
    s.requires_arc = true
end
