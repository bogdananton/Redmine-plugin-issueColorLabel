require File.dirname(__FILE__) + '/../app/helpers/icladmin_helper.rb'

class CssInserterHooks < Redmine::Hook::ViewListener
    def view_layouts_base_html_head(context = { })
        $css_block = '<style type="text/css">' << "\n" << "#admin-menu .issue-color-label {background-image: url(/images/changeset.png)} \n";

        if (IcladminHelper.isPluginEnabled)
            $settingsDisplay = IcladminHelper.getSettingsDisplay

            $settingsDisplay.each_pair do |trSettingKey, value|
                $tdGenericClass = trSettingKey.split('-')[0]
                
                if (!value.nil?)
                    $css_block = $css_block << "table.list.issues .#{trSettingKey} ." << $tdGenericClass << " { #{value} }\n"
                end
            end
        end

        return $css_block << '</style>'
    end
end
