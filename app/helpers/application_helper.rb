module ApplicationHelper
  def full_title(title)
    default_title = "Private Events"
    if title.empty?
      default_title
    else
      title + " | " + default_title
    end
  end
end
