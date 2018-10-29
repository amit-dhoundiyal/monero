class User < ApplicationRecord
	has_many :wallet_addresses,dependent: :destroy
end
