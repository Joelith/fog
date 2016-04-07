require 'fog/core/model'

module Fog
  module Oracle
    class SOA
      class Instance < Fog::Model
        identity  :service_name

        attribute :service_name       
        attribute :service_type
        attribute :resource_count
        attribute :status
        attribute :description
        attribute :identity_domain
        attribute :creation_job_id
        attribute :creation_time
        attribute :last_modified_time
        attribute :created_by
        attribute :service_uri
        attribute :provisioning_progress

        # The following are only used to create an instance and are not returned in the list action
        attribute :cloudStorageContainer
        attribute :cloudStorageUser
        attribute :cloudStoragePassword
        attribute :level
        attribute :subscriptionType
        attribute :topology
        attribute :parameters

        def save
          #identity ? update : create
          create
        end

        def ready?
          status == "Running"
        end


        def ip_address
          # TODO: Replace with regex
          #service_uri.sub('http://', '')
        end

        private

        def create
          requires :service_name, :topology, :cloudStorageContainer, :cloudStorageUser, :cloudStoragePassword, :parameters 
          data = service.create_instance(service_name, topology, cloudStorageContainer, cloudStorageUser, cloudStoragePassword, parameters,
                                            :level => level,
                                            :subscriptionType => subscriptionType,
                                            :description => description)
        end
      end
    end
  end
end
