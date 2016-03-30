require 'fog/oracle/core'

module Fog
  module Compute
    class Oracle < Fog::Service
      requires :oracle_username, :oracle_password

    end
  end
end
