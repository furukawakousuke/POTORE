class HomesController < ApplicationController
  def top
  end
  
  def new_guest
    poster = Poster.find_or_create_by!(email: 'guest@example.com') do |poster|
      poster.password = SecureRandom.urlsafe_base64
      poster.user_name = "@guest"
      # user.skip_confirmation!  # Confirmable を使用している場合は必要
      # 例えば name を入力必須としているならば， user.name = "ゲスト" なども必要
    end
    sign_in poster
    redirect_to post_photos_path, notice: 'ゲストユーザーとしてログインしました。'
  end
  def guest_sign_in
    poster = Poster.guest
    sign_in poster
    redirect_to post_photos_path, notice: 'ゲストユーザーとしてログインしました。'
  end
end
