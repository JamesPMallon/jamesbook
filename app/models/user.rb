class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me,
                  :first_name, :last_name, :profile_name
  # attr_accessible :title, :body

   validates :first_name, presence: true
   validates :last_name, presence: true
   validates :profile_name, presence: true,
                            uniqueness: true,
                            format: {
                              with: /\A[0-9a-zA-Z\-\_]+\Z/,
                              message: 'must be formatted correctly'
                            }


#STATUS RELATIONSHIPS

  has_many :statuses

  def full_name
  	first_name + " " + last_name
  end

  #GRAVATAR

  def gravatar_url
    stripped_email = email.strip
    downcased_email = stripped_email.downcase
    hash = Digest::MD5.hexdigest(downcased_email)

    "http://gravatar.com/avatar/#{hash}?d=mm"
  end


  #FRIENDSHIPS
has_many :user_friendships
has_many :friends, through: :user_friendships

#PROFILE PAGE
  def to_param
    profile_name
  end


end
