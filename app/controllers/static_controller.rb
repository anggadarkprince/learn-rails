class StaticController < ApplicationController

  def agreement
    http_cache_forever(public: true) do
      render
    end
  end

  def privacy
    http_cache_forever(public: true) do
      render
    end
  end

end
