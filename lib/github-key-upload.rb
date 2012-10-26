require "github-key-upload/version"

module Github
  module Key
    module Upload
      def self.upload(key, user, password)
        puts key
        puts user
        puts password
      end
    end
  end
end
