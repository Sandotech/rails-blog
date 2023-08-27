class ArticlesController < ApplicationController
  def index
    # to fetch all articles from the database
    @articles = Article.all
  end

  def show
    # To fetch an article from the database,
    # we can call find on the model and pass the id as an argument
    @article = Article.find(params[:id])
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    # To save the object to the database, we must call save
    if @article.save
      # redirects the browser to the article's page
      redirect_to @article
    else
      # see about new template on https://g.co/bard/share/a746318072cf 
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    # The edit action fetches the article from the database,
    # and stores it in @article so that it can be used when building the form
    # By default, the edit action will render app/views/articles/edit.html.erb
    @article = Article.find(params[:id])
  end

  def update
    # (re-)fetches the article from the database, and attempts to update it with
    # the submitted form data filtered by article_params
    @article = Article.find(params[:id])
    #  redirects the browser to the article's page if no validations fail and the update is successful,
    if @article.update(article_params)
      redirect_to @article
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    # Fetch the article from the database and calls detroy on it
    @article = Article.find(params[:id])
    @article.destroy
    # redirects the browser to the root path with status code 303 See Other
    redirect_to root_path, status: :see_other
  end

  private

  # filters params
  def article_params
    params.require(:article).permit(:title, :body)
  end
end
