class Oracle < Fog::Bin
  class << self
    def class_for(key)
      case key
      when :java
        Fog::Oracle::Java
      when :soa
        Fog::Oracle::SOA
      when :storage
        Fog::Storage::Oracle
      else
        raise ArgumentError, "Unsupported #{self} service: #{key}"
      end
    end

    def [](service)
      @@connections ||= Hash.new do |hash, key|
        hash[key] = case key
        when :java
          Fog::Oracle::Java.new
        when :soa
          Fog::Oracle::SOA.new
        when :storage
          Fog::Storage.new(:provider => 'Oracle')
        else
          raise ArgumentError, "Unrecognized service: #{service}"
        end
      end
      @@connections[service]
    end

    def services
      Fog::Oracle.services
    end
  end
end
