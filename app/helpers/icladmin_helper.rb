module IcladminHelper
	def self.isPluginEnabled
		@configuration = IcladminHelper.getConfiguration
		return ((!@configuration['enabled'].nil?) and (@configuration['enabled'].to_s == '1'))
	end

	def self.getConfiguration
		file = File.open(IcladminHelper.getConfigurationFile)
		json = file.read
		@return = JSON.parse(json)
		return @return[0]
	end

	def self.getConfigurationFile
		@AppRoot = File.expand_path(File.dirname(__FILE__) << '/../../')
		return File.join(@AppRoot, "configuration.json")
	end

	def self.getSettingsDisplay
		@configuration = IcladminHelper.getConfiguration
		return @configuration['css']
	end
end
