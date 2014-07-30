require 'redmine'
require_dependency 'css_inserter_hooks'

Redmine::Plugin.register :issue_color_label do
  name 'Issue Color Label plugin'
  author 'Bogdan Anton'
  description 'Customize the Issues table display for Status, Tracker and Priority columns. 
  
  Uses a JSON file as a database. Settings can be updated from the /admin page, accessing the "Issue Color Label" item. 
  The plugin can be enabled / disabled from the same panel.

  Only administrators can update the settings, other users can only view the current settings.'
  
  version '0.1'
  url 'http://github.com/bogdananton/Redmine-plugin-issueColorLabel'
  author_url 'http://bogdananton.ro'

  settings :default => {
    'admin_label' => 'Issue Color Label'
  }

  menu :admin_menu, :issue_color_label, '/issue-color-label/settings', :caption => :default['admin_label'], :last => true
end
