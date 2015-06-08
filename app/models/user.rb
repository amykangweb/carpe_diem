class User < ActiveRecord::Base
  has_many :goals, dependent: :destroy
  has_many :entries, dependent: :destroy
  has_many :cheers, dependent: :destroy
  has_many :cheered_entries, through: :cheers, source: :entry
  validates :username, presence: true
  validates_uniqueness_of :username
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end
