class Admin < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end




    def self.admin
    find_or_create_by!(email: 'potore@potore') do |admin|
      admin.password = "1414kendo".urlsafe_base64
      admin.user_name = "@admin"
      # poster.confirmed_at = Time.now  # Confirmable を使用している場合は必要
      # 例えば name を入力必須としているならば， user.name = "ゲスト" なども必要
      end
    end