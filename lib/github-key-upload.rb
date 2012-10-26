require "github-key-upload/version"
require "github_api"

module Github
  module Key
    module Upload
      def self.upload(options)
        github = Github.new basic_auth: "#{options[:user]}:#{options[:password]}"
        github.oauth.create 'scopes' => ['user']
        github.users.keys.create({title: options[:title], key: File.read(options[:key])})
      end
    end
  end
end
