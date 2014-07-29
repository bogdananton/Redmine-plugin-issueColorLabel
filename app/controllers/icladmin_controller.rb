require "rubygems"
require "json"

require File.dirname(__FILE__) + '/../helpers/icladmin_helper.rb'

class IcladminController < ApplicationController
	unloadable

	def settings
		@settingsDisplay = IcladminHelper.getSettingsDisplay
		@is_enabled = IcladminHelper.isPluginEnabled

		@tracker_list  = Tracker.all
		@priority_list = IssuePriority.all
		@status_list   = IssueStatus.all
		@isUserAdmin   = (User.current.admin?)
	end

	def update_settings
		if (User.current.admin?)
			@parameters = request.request_parameters

			@enabled = "0"
			@css = []

			if (!@parameters['enabled'].nil?)
				@enabled = @parameters['enabled'].to_s
			end

			if (!@parameters['css'].nil?)
				@css = @parameters['css']
			end

			@storedData = ['enabled' => @enabled, 'css' => @css]

			@configuration_file = IcladminHelper.getConfigurationFile
			File.open(@configuration_file, 'w') { |file| file.write(@storedData.to_json) }
		end
		
		redirect_to('/issue-color-label/settings')
	end
end
