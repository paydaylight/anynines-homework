require_relative '../controllers/articles'

class ArticleRoutes < Sinatra::Base
  use AuthMiddleware

  def initialize
    super
    @article_controller = ArticleController.new
  end

  before do
    content_type :json
  end

  get('/') do
    summary = article_controller.get_batch

    if summary[:ok]
      { articles: summary[:data] }.to_json
    else
      { msg: 'Could not get articles.' }.to_json
    end
  end

  get('/:id') do
    summary = article_controller.get_article(params['id'])

    if summary[:ok]
      { article: summary[:data] }.to_json
    else
      { msg: summary[:msg] }.to_json
    end
  end

  post('/') do
    payload = JSON.parse(request.body.read)
    summary = article_controller.create_article(payload)

    if summary[:ok]
      { msg: 'Article created' }.to_json
    else
      { msg: summary[:msg] }.to_json
    end
  end

  put('/:id') do
    payload = JSON.parse(request.body.read)
    summary = article_controller.update_article params['id'], payload

    status 400 unless summary[:ok]

    { msg: summary[:msg] }.to_json
  end

  delete('/:id') do
    summary = article_controller.delete_article params['id']

    if summary[:ok]
      { msg: 'Article deleted' }.to_json
    else
      { msg: 'Article does not exist' }.to_json
    end
  end

  private

  attr_reader :article_controller
end
