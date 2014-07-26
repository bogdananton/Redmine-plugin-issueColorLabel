# Plugin's routes
# See: http://guides.rubyonrails.org/routing.html

RedmineApp::Application.routes.draw do
	match 'projects/:project_id/issues', :to => 'issueslist#insertstyle', :via => [:get, :post]
	match 'admin', :to => 'issueslist#insertstyle', :via => [:get, :post]
end
