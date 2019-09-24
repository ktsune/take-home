require 'digest'

class ShortLink < ApplicationRecord
  validates :user_id, :long_link, presence: { message: 'can\'t be blank' }
  validates :long_link, format: {
  with: /(http:\/\/www\.|https:\/\/www\.|http:\/\/|https:\/\/)?[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?/,
  message: 'invalid'
}

  HASH_LENGTH = 6

  def self.find_by_encoded_id(id)
    self.find_by(id: id)
  end

  def self.find_by_digest(long_link)
    ShortLink.find_by(long_link: long_link)
  end

  def encoded_id
    object_id
  end

  def redirect_link
    long_link.start_with?("http") ? long_link : "http://#{long_link}"
  end

  def self.digest(long_link)
    full_digest = Digest::MD5.hexdigest long_link
    full_digest[0...HASH_LENGTH]
  end
end
