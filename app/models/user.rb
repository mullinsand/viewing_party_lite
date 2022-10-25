# frozen_string_literal: true

class User < ApplicationRecord
  validates_presence_of :user_name, :email, :password_digest, :role
  validates :email, uniqueness: true
  enum role: %i[default admin]
  has_many :viewing_party_users
  has_many :viewing_parties, through: :viewing_party_users

  has_secure_password

  def find_invited_parties
    viewing_parties.where.not('host = ?', user_name)
  end

  def find_hosted_parties
    viewing_parties.where('host = ?', user_name)
  end
end
