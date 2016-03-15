require "r509"

module R509::Validity::Dir
   class Checker < R509::Validity::Checker
      def initialize(options)
         @config = {}
         options.each do |key, config|
            if config[:new_certs_dir] && File.directory?(config[:new_certs_dir]) && config[:crl] && File.file?(config[:crl])
               parsed_crl = R509::CRL::SignedList.load_from_file(config[:crl])
               @config[parsed_crl.issuer.to_s] = config
            end
         end
         raise ArgumentError.new("OpenSSL new_certs_dir and crl file must be provided for each issuer (at least one)") if @config.empty?
      end

      # @return [R509::Validity::Status]
      def check(issuer, serial)
         raise ArgumentError.new("Serial and issuer must be provided") if serial.to_s.empty? || issuer.to_s.empty?

         if config = @config[issuer]
            if File.exists?("#{config[:new_certs_dir]}/#{File.basename(serial.to_s(16))}.pem")
               parsed_crl = R509::CRL::SignedList.load_from_file(config[:crl])
               if revocation_data = parsed_crl.revoked[serial.to_i]
                  return R509::Validity::Status.new(
                     :status => R509::Validity::REVOKED,
                     :revocation_time => revocation_data[:time].to_i,
                     :revocation_reason => revocation_data[:reason]
                  )
               else
                  return R509::Validity::Status.new(:status => R509::Validity::VALID)
               end
            end
            R509::Validity::Status.new(:status => R509::Validity::UNKNOWN)
         end

         def is_available?
            true
         end
      end
   end
end
