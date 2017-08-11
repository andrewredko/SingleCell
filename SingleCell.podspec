Pod::Spec.new do |s|

  s.name     = "SingleCell"
  s.version  = "1.0.0"
  s.summary  = "Custom UI control that simulates appearance of UITableViewCell, but can be used as a single control without UITableView."

  s.description = <<-DESC
Custom UI control that simulates appearance of UITableViewCell, but can be used as a single control without UITableView. It comprises of a main label, optional image on the left and optional detail view on the right. Also, it can show disclosure icon on the right side. Layout of all elements is provided by auto-layout constraints. SingleCell can be placed, previewed and configured in the interface builder.
DESC

  s.author    = { "Andrew Redko" => "scrumone.contactus@gmail.com" }
  s.license   = { :type => "MIT", :file => "LICENSE" }
  s.homepage  = "https://github.com/andrewredko/SingleCell"

  s.platform  = :ios
  s.ios.deployment_target = "9.0"

  s.source = { :git => "https://github.com/andrewredko/SingleCell.git", :tag => "#{s.version}" }
  s.source_files  = "SingleCell/**/*.{swift}"
  s.framework     = "UIKit"
  s.requires_arc  = true

end
