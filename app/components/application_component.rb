class ApplicationComponent < ViewComponentContrib::Base
  include Polaris::ViewHelper

  extend Dry::Initializer

  def identifier
    @identifier ||= self.class.name.sub('::Component', '').underscore.sub('_', '-').split('/').join('--')
  end

  def class_names(*args)
    prefix = "c-#{identifier}-"

    super(*args.map do |arg|
      if arg.is_a?(Hash)
        new_hash = {}
        arg.each do |key, value|
          new_hash["#{prefix}#{key}"] = value
        end
        new_hash
      else
        "#{prefix}#{arg}"
      end
    end)
  end

  def controller(tag = :div, *args, **kwargs, &block)
    kwargs[:data] ||= {}
    kwargs[:data][:controller] = controller_name
    content_tag(tag, *args, **kwargs, &block)
  end

  def controller_name
    identifier.dasherize
  end

  def controller_action(trigger, action_name)
    kwargs[:data] ||= {}
    kwargs[:data][:action] = "#{trigger}->#{controller_name}##{action_name}"
    content_tag(tag, *args, **kwargs, &block)
  end

  def controller_target(target)
    kwargs[:data] ||= {}
    kwargs[:data][:target] = "#{controller_name}.#{target}"
    content_tag(tag, *args, **kwargs, &block)
  end
end
