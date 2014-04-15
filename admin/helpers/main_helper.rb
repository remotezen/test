Blog::Admin.helpers do
  def admin_title(t=nil)
    if t.nil?
      title = "Jo Goes Green"
    else
      title = t
    end 
    simple_format(title, :tag => :div,  :class => "admin-title")
  end
  
end
