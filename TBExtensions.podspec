Pod::Spec.new do |s|
  s.name         = "TBExtensions"
  s.version      = "1.0.0"
  s.summary      = "Common extended interface collection project."
  s.description  = <<-DESC
This project mainly concentrates on some commonly used extension interfaces, which is convenient for rapid project development using Swift.
                   DESC

  s.homepage     = "https://github.com/trusbe/TBExtensions.git"
  s.license = { type: 'MIT', file: 'LICENSE' }
  s.author       = { "TrusBe" => "theplough.891127@163.com" }
  s.source       = { :git => "https://github.com/trusbe/TBExtensions.git", :tag => "#{s.version}" }

  s.ios.deployment_target = '8.0'

  s.swift_version    = '5.0'
  s.requires_arc = true

  s.source_files  = "TBExtensions/TBExtensions/Classes/**/*.swift"
end
