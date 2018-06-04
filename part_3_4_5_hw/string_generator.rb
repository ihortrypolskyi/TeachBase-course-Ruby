# frozen_string_literal: true

require 'openssl'

module StringGenerator
  def random_string
    OpenSSL::Random.random_bytes(5).unpack('H*').join
  end
end
