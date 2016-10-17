Pod::Spec.new do |spec|
spec.name             = 'HLTimerCenter'
spec.version          = '1.0.0'
spec.license          = { :type => "MIT", :file => 'LICENSE' }
spec.homepage         = 'https://github.com/QianKun-HanLin/HLTimerCenter'
spec.authors          = {"wangshiyu13" => "wangshiyu13@163.com"}
spec.summary          = '基于GCD的定时管理器'
spec.source           =  {:git => 'https://github.com/QianKun-HanLin/HLTimerCenter', :tag => spec.version }
spec.source_files     = 'HLTimerCenter/Source/**/*.{h,m}'
spec.requires_arc     = true
spec.ios.deployment_target = '8.0'
end
