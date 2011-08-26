module AuthenticationsHelper
  # Provides a graphic for the service specified
  def link_to_service(name, path, *args)
    "<a href=\"#{path}\"><img src=\"/assets/#{name.downcase}_64.png\" alt=\"#{name}\" /><span>#{name}</span></a>".html_safe
  end
end
