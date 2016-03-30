require 'fog/oracle/core'

module Fog
  module Storage
    class Oracle < Fog::Service
      requires :oracle_username, :oracle_password, :oracle_domain

			model_path 'fog/oracle/models/storage'
      model :container
      collection :containers

      request_path 'fog/oracle/requests/storage'
			request :list_containers
			request :create_container

 			class Real
        def initialize(options={})
      		@username = options[:oracle_username]
      		@password = options[:oracle_password]
      		@identity_domain   = options[:oracle_domain]

          @connection = Fog::XML::Connection.new("https://us2.storage.oraclecloud.com")

          # Get Authentication Token
          response = @connection.request({
        		:expects  => [200],
		        :headers  => {
		          'X-Storage-User'  => "Storage-#{@identity_domain}:#{@username}",
		          'X-Storage-Pass' => @password
		        },
		        :method   => 'GET',
		        :path     => '/auth/v1.0'
		      })
		      @auth_token = response.headers['X-Auth-Token']

      	end

      	def request(params, parse_json = true, &block)
					begin
						response = @connection.request(params.merge!({
							:headers  => {
								'X-Auth-Token' => @auth_token,
							}.merge!(params[:headers] || {})
						}), &block)
					rescue Excon::Errors::HTTPStatusError => error
						raise case error
						when Excon::Errors::NotFound
							Fog::Oracle::Java::NotFound.slurp(error)
						else
							error
						end
					end
					if !response.body.empty? && parse_json
            response.body = Fog::JSON.decode(response.body)
          end
          response
        end
      end

      class Mock

			end
    end
  end
end
