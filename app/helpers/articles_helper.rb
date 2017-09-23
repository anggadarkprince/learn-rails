module ArticlesHelper

  def random_string
    SecureRandom.urlsafe_base64
  end

  def article_published_at(article)
    article.created_at.strftime('%B %d, %Y') if article && article.created_at.present?
  end

end
