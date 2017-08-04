Pod::Spec.new do |s|

  # ―――  Spec Metadata  ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #

  s.name         = "SingleCell"
  s.version      = "0.1.0"
  s.summary      = "Custom UI control that simulates appearance of UITableViewCell, but can be as a single control without UITableView."

  # This description is used to generate tags and improve search results.
  s.description  = <<-DESC
                   DESC

  s.homepage     = "https://github.com/andrewredko/SingleCell"


  # ―――  Spec License  ――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #

  s.license = { :type => "MIT", :file => "LICENSE" }


  # ――― Author Metadata  ――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #

  s.author = { "Andrew Redko" => "scrumone.contactus@gmail.com" }


  # ――― Platform Specifics ――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #

  s.platform     = :ios
  s.ios.deployment_target = "9.0"


  # ――― Source Location ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #

  s.source = { :git => "https://github.com/andrewredko/SingleCell.git", :tag => "#{s.version}" }


  # ――― Source Code ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #

  s.source_files  = "SingleCell/**/*.{swift}"
  #  s.exclude_files = "Classes/Exclude"

  # s.public_header_files = "SingleCell/**/*.h"


  # ――― Resources ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #

  # s.resources = "Resources/*.png"


  # ――― Project Linking ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #

  s.framework  = "UIKit"


  # ――― Project Settings ――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #

  s.requires_arc = true

end
