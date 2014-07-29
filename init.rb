require 'redmine'
require 'issuecolor_admin_helper_patch'
require_dependency 'css_inserter_hooks'

Redmine::Plugin.register :issue_color_label do
  name 'Issue Color Label plugin'
  author 'Bogdan Anton'
  description 'Simple plugin that sets different labels for Status, Tracker and Priority columns. Currently the plugin uses CSS set in the default settings.'
  version '0.1'
  url 'http://github.com/bogdananton/Redmine-plugin-issueColorLabel'
  author_url 'http://bogdananton.ro'

#    defaults: 
#    - tracker 1 is "Bug"
#    - tracker 2 is "Feature"
#    - tracker 3 is "Support"
#
#    - status 2 is "New"
#    - status 3 is "In Progress"
#    - status 4 is "Resolved"
#    - status 7 is "Rejected"
#
#    - priority 1 is "Low"
#    - priority 2 is "Normal"
#    - priority 3 is "High"
#    - priority 4 is "Urgent"
#    - priority 5 is "Immediate"

  settings :default => {
    'admin.label' => 'Issue Color Label',

    'tracker.1' => '
	    background-repeat: no-repeat;
		background-image: url("data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAB5UlEQVR42q2TS0gbYRSFL/gIKJrGzJAwEzSNr4VFTcUoRJ1Km1J8xhgXolEiIqWlUEUFXehCgyKlRRSyKH1hacCdi9ad4E58gPhYCaULNypFQUQp4rXnV4OS6MofDnM457uXn2GG6L6O2Wz2KoryCj448tbqr9A6iwrsA1DrC60TGTowYKMtyJEkaevTeF9wJjR2Ntj/ml0ulxA8MnSyLG+BjXqLl56y0PL8V15bCLHXU81Op1PI464UGTowUYcP/WY5WJl1YLPZ+C6BAXtj2Gg0Lo6VqXOHfU95sL6CtZxslvTJrNPphOCRoQMDFjPXd6QUpSsn32szmHsdzENuPh7x8Y+ORp7+r3+jPpGhAwMWMzduoWWpZ5st6Xz6JlNo8rmVVVUVmqp6GM7BgI14B9vNppOjDpWPL7XrV/hdocQfHBL/bVPCORiwEQtW3fHre80JvFT3gDe8ybzvS+QdV5wQPDJ0YMBGLJh9QsPvixPC1+4u0PPvUhKCv8rB/NIoELHgs53kifzYg7xUkwAfp5l4zUFC8MjQgQEb9VtoV6jnyyPiKXscr5QQL+ReCB4ZOjC3/g8Gg+FneRIFRtPoz7ds4o/WC8EjK9dTAMytCywWSxOeDUQx3UZ6VpNIXRA8suvMvZ1z0tYUzprfin4AAAAASUVORK5CYII=");
		background-position: 0px 2px;
	',
    'tracker.2' => '
		background-repeat: no-repeat;
		background-image: url("data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAMAAAAoLQ9TAAAAbFBMVEUAAAArKysyMjIxMTExMTEuLi4xMTEyMjIyMjIoKCgcHBwuLi4wMDAxMTExMTExMTExMTEyMjIpKSkAAAAxMTEyMjIuLi4xMTEuLi4yMjItLS0yMjIyMjIyMjIzMzMxMTEnJycsLCwyMjIzMzN/Hp0HAAAAI3RSTlMAGd54pEHrsPcSCQUlycaWWuUoA7/RHmlNhTC7/dXshg06qZbU/N8AAACCSURBVBjTVc5XDsIwEEVR23FNT0jHhPL2v0dwRgPh/p0nWxrxq2j1uPvT0PgI3L6UNVKaHSp0KiK2/H8AyqDgS3KuAZi+QyOoDFSdMDnnPLmSHxsF7hrSg8WydSGo+aDPcuLD3I/B8UWrC8PfMG4irPNp8NPmjLC25yHur+dFLJL9BslGDReMg7h/AAAAAElFTkSuQmCC");
		background-position: 0px 2px;
    ',
    'tracker.3' => '
    	background-repeat: no-repeat;
		background-image: url("data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAACSklEQVR42mNgoBWI2fmyQWnR47lkaV5057NYy5n3Pw1WPvkXvvOFDskGzLj8ccmex9//1Z18/9dw+ePtJGmO3vPc9OjzH793PPr2fd3dL9+t1zx9Z7fuWRDRBiy/+enokec//px6/uPT7fe/3hisePIjbd/Lc0RpLjr8Ju7W+18fpl7++PfBh19PgewHfptffG889faG6/pntXg13779n3317S9Pdj78+mHB9c/frr79dffEy5+Xsw++eRq54+WDsqNvbnaceSeH04DK4296n335/WTBtU/v5137/HbHg28nZ13+vD374NtrDuuevjr76sdBj43PlsDU////nxWuOf/Ia/W1d7+8PPf6x5PWU+8/T7v0+TJIMwj3X/i8z3fL8yf1J99dnXDh/WWntY/sMG0/9nb948+/r+cfevPaecPzl2HbXl5Gxparnr6xWvX4FdCCA/kH3+wHahEAYi4gZmaI2PHcu+vsu6ehG+7fil158ZT2wrufc7fdu5q/48HVol2PrhbveXLVfPnDd6V7nhyP2fbk7uLrH9+GzjvaAtQsA8S8DMFbn28PW3nlXMaaC0cSVl08ZbX07su87XevFoANeHi1ZO/jqy5rHj2P2/b46oTTr0+tv/XpXv6Bly8kJCRMgQYIgUM/aMODpqBll886Lrl+z3/1nYfoBuTsenrTcfXDh7MuvLlVufHcofDUbB+gZh6UcAja9MBIY+HdmxZL7jy3XHr3udXS+8+tlz14brvy4XPbVQ+fGy57+DqoZ1WapKSkCFVzLQCm/nDgsIoRKQAAAABJRU5ErkJggg==");
		background-position: 0px 2px;
    ',
    'tracker.4' => '',
    'tracker.5' => '',

    'status.1' => '',
    'status.2' => 'background:rgb(92, 222, 255) !important',
    'status.3' => 'background:rgb(253, 229, 51) !important',
    'status.4' => 'background:rgb(182, 236, 123) !important',
    'status.5' => '',
    'status.6' => '',
    'status.7' => 'background:rgb(233, 177, 224) !important',
    'status.8' => '',
    'status.9' => '',
    'status.10' => '',

    'priority.1' => '',
    'priority.2' => '',
    'priority.3' => '',
    'priority.4' => 'background: #FF3333 !important; color: #fff !important',
    'priority.5' => '',

    # @todo Make values dynamic by using a table and a config panel
  }

  menu :admin_menu, :issue_color_label, 'issue-color-label/settings', :caption => 'Issue Color Label', :html_options => [:class => 'info'], :last => true
end