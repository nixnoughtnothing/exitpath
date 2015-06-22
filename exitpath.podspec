
Pod::Spec.new do |s|

  s.name         = "exitpath"
  s.version      = "0.1"
  s.summary      = "URL Handling for simpletons. "

  s.description  = <<-DESC
                   A Simple way to manage actions for clicked links and URLs.
                   DESC
  s.platform     = :ios, '8.0'
  s.requires_arc = true
  s.homepage     = "https://github.com/Nirma/exitpath"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author             = { "Nicholas Maccharoli" => "nmaccharoli@gmail.com" }
  s.source       = { :git => "https://github.com/Nirma/exitpath.git", :tag => "v0.1" }
  s.source_files = "exitpath" 

end
