class ArticleController
  def create_article(article)
    article_exists = Article.exists?(:title => article['title'])

    return { ok: false, msg: 'Article with given title already exists' } if article_exists

    new_article = Article.new(title: article['title'], content: article['content'], created_at: Time.now)
    new_article.save!

    { ok: true, obj: new_article }
  rescue StandardError
    { ok: false }
  end

  def update_article(id, new_data)

    article = Article.where(id: id).first

    return { ok: false, msg: 'Article could not be found' } if article.nil?

    article.title = new_data['title']
    article.content = new_data['content']
    article.save!

    { ok: true, msg: 'Article updated', obj: article }
  rescue StandardError
    { ok: false }
  end

  def get_article(id)
    res = Article.find_by(id: id)

    if res.present?
      { ok: true, data: res }
    else
      { ok: false, msg: 'Article not found' }
    end
  end

  def delete_article(id)
    delete_count = Article.delete(id)

    if delete_count == 0
      { ok: false }
    else
      { ok: true, delete_count: delete_count }
    end
  end

  def get_batch
    # TODO: Add pagination
    res = Article.all.order(created_at: :desc)

    if res.present?
      { ok: true, data: res }
    else
      { ok: false, msg: 'Could not get articles.' }
    end
  end
end
