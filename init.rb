module RedmineSecurity4216Patch
  def self.included(base)
    base.class_eval do
      unloadable
      if Rails.version > "2.1.2"
        protect_from_forgery
      else
        protect_from_forgery :secret => 'edit_this_to_be_a_random_value_of_hex_letters_and_numbers'
      end
    end
  end
end

# Patches to the Redmine core.
require 'dispatcher'

Dispatcher.to_prepare :redmine_security_4216 do
  begin
    require_dependency 'application'
  rescue LoadError
    require_dependency 'application_controller' # Rails 2.3
  end
  
  ApplicationController.send(:include, RedmineSecurity4216Patch) unless ApplicationController.included_modules.include? RedmineSecurity4216Patch
  
end
