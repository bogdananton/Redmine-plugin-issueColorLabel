class CssInserterHooks < Redmine::Hook::ViewListener

  def view_layouts_base_html_head(context = { })

    $css_block = '<style type="text/css">' << "\n"

    $css_block == $css_block << "#admin-menu .issue-color-label {background-image: url(images/changeset.png)} \n";

    $scopes = ['tracker', 'status', 'priority'];
    $scopes.each do |scope|
        $i  = 1
        $nr = 10

        while $i <= $nr  do
            $key = "#{scope}." << $i.to_s

            if (!Setting.plugin_issue_color_label[$key].nil?)
                $css_block = $css_block << "table.list.issues .#{scope}-" << $i.to_s << " .#{scope} {" << Setting.plugin_issue_color_label[$key] << "}\n"
            end

           $i +=1
        end
    end

    return $css_block << '</style>'
  end
end