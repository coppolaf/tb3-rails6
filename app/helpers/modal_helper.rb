module ModalHelper

  def default_options
    return {:id => 'modal', :size => '', :show_close => true, :dismiss => true}
  end

  #modals have a header, a body, a footer for options.
  def modal_dialog(options = {}, &block)
    default_options.merge!(options)
    content_tag :div, :class => "bootstrap-modal modal fade", :id => options[:id] do
      content_tag :div, :class => "modal-dialog " + (!options[:size].nil? ? options[:size] : ''), :style => options[:style] do
        content_tag :div, :class => "modal-content" do
          modal_header(options[:header].merge(:id => options[:id]), &block) +
          modal_body(options[:body].merge(:id => options[:id]), &block) +
          modal_footer(options[:footer].merge(:id => options[:id]), &block)
        end
      end
    end
  end

  def modal_header(options, &block)
    content_tag :div, :class => 'modal-header', :id => options[:id]+"-header", :style => options[:style] do
      if options[:show_close]
        close_button(options[:dismiss]) +
        content_tag(:h4, options[:title], :class => 'modal-title', &block)
      else
        content_tag(:h4, options[:title], :class => 'modal-title', &block)
      end
    end
  end

  def modal_body(options, &block)
    content_tag :div, options[:content], :class => 'modal-body', :id => options[:id]+"-body", :style => options[:style], &block
  end

  def modal_footer(options, &block)
    content_tag :div, options[:content], :class => 'modal-footer', :id => options[:id]+"-footer", :style => options[:style], &block
  end

  def close_button(dismiss)
    #It doesn't seem to like content_tag, so we do this instead.
    raw("<button class=\"close\" data-dismiss=\"#{dismiss}\" aria-hidden=\"true\">&times;</button>")
  end

  def modal_toggle(content_or_options = nil, options, &block)
    if block_given?
      options = content_or_options if content_or_options.is_a?(Hash)
      default_options = { :class => 'btn btn-default', "data-toggle" => "modal", "href" => options[:dialog] }.merge(options)

      content_tag :a, nil, default_options, true, &block
    else
      default_options = { :class => 'btn btn-default', "data-toggle" => "modal", "href" => options[:dialog] }.merge(options)
      content_tag :a, content_or_options, default_options, true
    end
  end

  def modal_cancel_button(content, options)
    default_opts = { :class => "btn bootstrap-modal-cancel-button" }

    content_tag_string "a", content, default_opts.merge(options)
  end

end
