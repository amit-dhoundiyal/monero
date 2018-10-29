class HomesController < ApplicationController

	
	def index
	end

	def generate_address
		 uri = URI.parse("http://172.16.21.12:28083/json_rpc")
		request = Net::HTTP::Post.new(uri)
		request.content_type = "application/json"
		request.body = JSON.dump({
		  "jsonrpc" => "2.0",
		  "id" => "0",
		  "method" => "get_address",
		  "params" => {
		    "account_index" => 0,
		    "address_index" => [
		      0
		    ]
		  }
		})

		req_options = {
		  use_ssl: uri.scheme == "https",
		}

		response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
		  http.request(request)
		end
		p response
		response = JSON.parse(response.body)
		User.create(address: response["result"]["address"],address_index: response["result"]["addresses"][0]["address_index"])
		redirect_to root_path
	end

	# def generate_account
	# 	 uri = URI.parse("http://172.16.21.12:28083/json_rpc")
	# 	request = Net::HTTP::Post.new(uri)
	# 	request.content_type = "application/json"
	# 	request.body = JSON.dump({
	# 	  "jsonrpc" => "2.0",
	# 	  "id" => "0",
	# 	  "method" => "create_account",
	# 	  "params" => {
	# 	    "label" => "Demo"
	# 	  }
	# 	})

	# 	req_options = {
	# 	  use_ssl: uri.scheme == "https",
	# 	}

	# 	response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
	# 	  http.request(request)
	# 	end
	# 	p response
	# 	JSON.parse(response.body)
	# end

	def check_balance
		user = User.find_by(address: params[:address])
		uri = URI.parse("http://172.16.21.12:28083/json_rpc")
			request = Net::HTTP::Post.new(uri)
			request.content_type = "application/json"
			request.body = JSON.dump({
			  "jsonrpc" => "2.0",
			  "id" => "0",
			  "method" => "get_balance",
			  "params" => {
			    "account_index" => user.address_index
			  }
			})

			req_options = {
			  use_ssl: uri.scheme == "https",
			}

			response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
			  http.request(request)
			end
			response = JSON.parse(response.body)
			user.update(balance: response["result"]["balance"]/10**12.to_f)
			redirect_to root_path(id: user&.id)
	end

	def random_address
		a = SecureRandom.hex(8)
		uri = URI.parse("http://172.16.21.12:28083/json_rpc")
		request = Net::HTTP::Post.new(uri)
			request.content_type = "application/json"
			request.body = JSON.dump({
			  "jsonrpc" => "2.0",
			  "id" => "0",
			  "method" => "make_integrated_address",
			  "params" => {
			    # "standard_address" => "55LTR8KniP4LQGJSPtbYDacR7dz8RBFnsfAKMaMuwUNYX6aQbBcovzDPyrQF9KXF9tVU6Xk3K8no1BywnJX6GvZX8yJsXvt",
			    "payment_id" => a
			  }
			})

			req_options = {
			  use_ssl: uri.scheme == "https",
			}
			response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
			  http.request(request)
			end
      binding.pry
      response = JSON.parse(response.body)
      WalletAddress.create(integrated_address: response["result"]["integrated_address"],user_id: User.last.id)
      redirect_to root_path
	end
end
