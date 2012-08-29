module Twocheckout
  class Product < HashObject

    def self.find(options)
      response = Twocheckout::API.request(:get, 'products/detail_product', options)
      Product.new(response['product'])
    end

    def self.with_product_id(product_id)
      find(:product_id => product_id)
    end

    def self.create(opts)
      response = Twocheckout::API.request(:post, 'products/create_product', opts)
      find(:product_id => response['product_id'])
    end

    def update!(opts)
      opts = opts.merge(:product_id => self.product_id)
      Twocheckout::API.request(:post, 'products/update_product', opts)
      response = Twocheckout::API.request(:get, 'products/detail_product', opts)
      Product.new(response['product'])
    end

    def delete!
      opts = {:product_id => self.product_id}
      Twocheckout::API.request(:post, 'products/delete_product', opts)
    end

    def self.list(opts)
      response = Twocheckout::API.request(:get, 'products/list_products', opts)
      response['products']
    end

    protected

    def _key
      self.product_id
    end

  end
end
