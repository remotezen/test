Warden::Strategies.add(:password) do
  def valid?
    params["email"] || params["password"]
  end

  def authenticate!
    if account  = Account.authenticate(params["email"], params["password"])
      success!(account)
    else
      fail!("Could not log in")
    end
  end
end

Warden::Manager.serialize_into_session { |account| account.id }
Warden::Manager.serialize_from_session { |id| Acccount[id] }
