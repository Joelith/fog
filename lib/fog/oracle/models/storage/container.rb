require 'fog/core/model'

module Fog
  module Storage
    class Oracle
      class Container < Fog::Model
        identity  :name

        attribute :name
        attribute :count
        attribute :bytes
        attribute :deleteTimestamp
        attribute :containerId

        def save
          requires :name
          data = service.create_container(name)
        end 
        
      end
    end
  end
end
