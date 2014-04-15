def search_link(search)
  if search.class.name == "Post"
    partial 'search/post', :locals =>{ :search =>search}
  else 
    search.inspect
  end

  

end
