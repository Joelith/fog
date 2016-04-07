require 'fog/core/collection'
require 'fog/oracle/models/storage/container'

module Fog
  module Storage
    class Oracle
      class Containers < Fog::Collection

      	model Fog::Storage::Oracle::Container

      	def all
          containers = service.list_containers().body
          load(containers)
        end

        def get(id)
        	begin
          #  new(service.get_container(id).body)
          rescue Fog::Storage::Oracle::NotFound
            nil
          end
        end

      end
    end

  end
end
