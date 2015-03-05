class FavoritesController < ApplicationController
  def create
    find_favorited.favorites.build(user: current_user).save
    redirect_to :back
  end

  def destroy
    Favorite.where(id: params[:id].to_i).where(user_id: current_user.id).first.destroy
    redirect_to :back, notice: 'Favorite removed'
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
