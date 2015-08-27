module ApplicationHelper
# helper method for hiding edit and destroy links in views
  def authorized_user?(record)
    if user_signed_in? && current_user == record.user ||
      current_user.try(:admin?)
      return true
    else
      return false
    end
  end

  def page_title(title = " ")
    if title.blank?
      return "Carpe Diem"
    else
      return title + " | " + "Carpe Diem"
    end
  end
end
