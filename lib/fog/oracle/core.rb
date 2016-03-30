require 'fog/core'
require 'fog/json'

module Fog
  module Oracle
    extend Fog::Provider

    service(:storage, 'Storage')
    service(:java, 'Java')
    service(:soa, 'SOA')


    class Mock
      class << self
				def create_java_instance(service_name, parameters = {})
          {
            "service_name"      => service_name,
            "status" 						=> "Running",
            "content_url" 			=> "http://129.144.6.59",
            "version"						=> parameters[0][:version]
           }
        end
        def create_database_instance(service_name, parameters = {})
          {
            "service_name"      => service_name,
            "status" 						=> "Running",
            "version"						=> parameters.version
           }
        end
      end
    end
  end
end
