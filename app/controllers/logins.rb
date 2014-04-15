Blog::App.controllers :logins do
  get :new  do
    @title = "Login or please signup with Jo Goes Green"
    render 'logins/new'  
  end
  post :create do
    if @account = Account.authenticate(params[:email], params[:password])
      hash ={ :account_id => @account.id,
              :logged_in => true,
              :remote  => request.ip
            }
      login = Login.new(hash)
      if login.save!
        set_current_account(@account)
        flash[:notice]  = "Successfully Logged in"
        #cookies['time_in'] = login.created_at
        redirect_back_or_default('/')
      end
    else
      flash[:alert] = "Unsuccessful Log in"
      redirect '/'  
    end
  end
  
  get :destroy  do
    hash ={ :account_id => current_account.id,
            :logged_in => false,
            :remote  => request.ip }
      login = Login.new(hash)
      if login.save!
        set_current_account(nil)
        flash[:notice]  = "Successfully Logged out"
        redirect_back_or_default(url_for(:logins, :new))
      else  
        flash[:error] = current_account.inspect
        redirect_back_or_default(url_for(:logins,:new) )
      end

  end

end
