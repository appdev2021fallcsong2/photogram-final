# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  comments_count  :integer
#  email           :string
#  likes_count     :integer
#  password_digest :string
#  private         :boolean
#  username        :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
class User < ApplicationRecord
  validates :email, :uniqueness => { :case_sensitive => false }
  validates :email, :presence => true
  has_secure_password

  has_many  :photos, :foreign_key => "owner_id", :dependent => :destroy
  has_many  :comments, :foreign_key => "author_id", :dependent => :destroy
  has_many  :likes, :foreign_key => "fan_id", :dependent => :destroy
  has_many  :followrequestsfromothers, :class_name => "FollowRequest", :foreign_key => "recipient_id", :dependent => :destroy
  has_many  :followrequeststoothers, :class_name => "FollowRequest", :foreign_key => "sender_id", :dependent => :destroy

  has_many :requestrecipients, :through => :followrequeststoothers, :source => :recipient
  has_many :requesters, :through => :followrequestsfromothers, :source => :sender

end
