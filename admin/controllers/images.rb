Blog::Admin.controllers :images do
  get :new do
    @image = Image.new
    render 'images/new'
  end
  post :create do
    render 'images/new'
  end
end

