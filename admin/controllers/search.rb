Blog::Admin.controllers :search do
  post :create do
   @search =  ThinkingSphinx.search(params[:search],
                             :classes => [ Post, Recipe, Comment],
                             :ranker => :bm25,
                             :match_mode => :any,
                             :order => '@weight DESC',
                             :page => params[:page],
                             :per_page => 10)
      render 'search/search'
  end
end
