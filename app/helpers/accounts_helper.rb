Blog::App.helpers do
  def is_admin?
    current_account(:role) == "admin"
  end
end
