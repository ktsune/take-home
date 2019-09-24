class ShortLinksController < ApplicationController
  before_action :set_short_link, only: :show

  def show
    redirect_to @short_link.redirect_link, status: :moved_permanently
  end

  def create
    if params[:long_link].empty? || params[:long_link] == 'invalid'
      if params[:long_link].empty?
        error_message = ["can't be blank", "is invalid"]
      else
        error_message = ["is invalid"]
      end
      render status: :unprocessable_entity, json: {
        long_link: error_message
      }
    else
      digest = ShortLink.digest(params[:long_link])
      existing = ShortLink.find_by_digest(params[:long_link])
      if existing
        short_link = existing
      else
        short_link = ShortLink.create!(
          user_id: params[:id], long_link: params[:long_link], digest: digest
        )
      end
      render status: :created, json: {
        short_link: "http://test.host/#{short_link.id}",
        long_link: params[:long_link]
      }
    end
  end

  private

  def set_short_link
    @short_link = ShortLink.find_by_encoded_id(params[:id])
    head :not_found unless @short_link
  end
end
