Pod::Spec.new do |s|

  # ―――  Spec Metadata  ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #

  s.name         = "SingleCell"
  s.version      = "0.2.0"
  s.summary      = "Custom UI control that simulates appearance of UITableViewCell, but can be used as a single control without UITableView."

  # This description is used to generate tags and improve search results.
  s.description = <<-DESC
Custom UI control that simulates appearance of UITableViewCell, but can be used as a single control without UITableView. It comprises of a main label, optional image on the left and optional detail view on the right. Also, it can show disclosure icon on the right side. Layout of all elements is provided by auto-layout constraints. SingleCell can be placed, previewed and configured in the interface builder.
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
