require "github-key-upload/version"
require "github_api"

module Github
  module Key
    module Upload
      def self.create_auth(options)
        github = Github.new :basic_auth => "#{options[:user]}:#{options[:password]}"
        github.oauth.create 'scopes' => ['user']
        github
      end

      def self.upload(options)
        github = create_auth(options)
        github.users.keys.create({:title => options[:title], :key => File.read(options[:key])})
      end

      def self.check_for_both(options)
        github = create_auth(options)
        matching_key = nil

        github.users.keys.all.each_page do |page|
          if page.map {|k| [k["title"], k["key"]]}.include?(
              [options[:title], File.read(options[:key]).split(" ")[0,2].join(" ")])
            matching_key = true
            break
          end
        end

        matching_key
      end

      def self.check(options)
        github = create_auth(options)
        matching_key = nil
        search_key = options[:search_key].to_s
        search_proc = options[:search_proc]

        github.users.keys.all.each_page do |page|
          if page.map {|k| k[search_key]}.include?(search_proc.call(options))
            matching_key = true
            break
          end
        end

        matching_key
      end

      def self.check_for_key(options)
        check(options.merge({
                              :search_key => :key,
                              :search_proc => Proc.new {|opts|
                                File.read(opts[:key]).split(" ")[0,2].join(" ")
                              }
                            }))
      end

      def self.check_for_title(options)
        check(options.merge({
                              :search_key => :title,
                              :search_proc => Proc.new {|opts| opts[:title]}
                            }))
      end
    end
  end
end
