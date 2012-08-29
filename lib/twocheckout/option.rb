module Twocheckout
  class Option < HashObject

    def self.find(options)
      response = Twocheckout::API.request(:get, 'products/detail_option', options)
      Option.new(response['option'][0])
    end

    def self.with_option_id(option_id)
      find(:option_id => option_id)
    end

    def self.create(opts)
      response = Twocheckout::API.request(:post, 'products/create_option', opts)
      find(:option_id => response['option_id'])
    end

    def update!(opts)
      opts = opts.merge(:option_id => self.option_id)
      Twocheckout::API.request(:post, 'products/update_option', opts)
      response = Twocheckout::API.request(:get, 'products/detail_option', opts)
      Option.new(response['option'][0])
    end

    def delete!
      opts = {:option_id => self.option_id}
      Twocheckout::API.request(:post, 'products/delete_option', opts)
    end

    def self.list(opts=nil)
      response = Twocheckout::API.request(:get, 'products/list_options', opts)
      response['options']
    end

    protected

    def _key
      self.option_id
    end

  end
end
