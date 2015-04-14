class User < ActiveRecord::Base
    # Include default devise modules. Others available are:
    # :confirmable, :lockable, :timeoutable and :omniauthable
    devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

    validates_presence_of :role

    has_many :topics
    has_many :comments

    def admin?
      self.role == "admin"
    end

    def md5hash
        Digest::MD5.hexdigest self.email
    end
end
