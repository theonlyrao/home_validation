module ApplicationHelper
  def cache_key_for(user)
    return "user-#{user.id}-validations-0" unless user.validations.last
    "user-#{user.id}-validations-#{user.validations.last.id}"
  end
end
