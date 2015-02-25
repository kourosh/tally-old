class FavoritesController < ApplicationController
  def create
    find_favorited.favorites.build(user: current_user).save
    redirect_to :back
  end

  private

    def find_favorited
      params.each do |name, value|
        if name =~ /(.+)_id$/
          return $1.classify.constantize.find(value)
        end
      end
      nil
    end
end
