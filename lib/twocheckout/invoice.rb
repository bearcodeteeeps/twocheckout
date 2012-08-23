module Twocheckout
  class Invoice < HashObject

    def self.find(options)
      response = Twocheckout::API.request(:get, 'sales/detail_sale', options)
      Sale.new(response['sale']).invoice[options[:invoice_id]]
    end

    #
    # An array of all line-items in this invoice
    #
    def lineitems
      if @lineitems.nil?
        @lineitems = @hash['lineitems'].map { |li| Twocheckout::LineItem.new(li) }
        @lineitems.freeze
      end
      @lineitems
    end

    #
    # A hash to index line-items by id
    #
    def lineitem
      if @lineitem.nil?
        @lineitem = {}
        lineitems.each { |li| @lineitem[li.lineitem_id] = li }
        @lineitem.freeze
      end
      return @lineitem
    end

    def refund!(opts)
      opts = opts.merge(:invoice_id => self.invoice_id)
      Twocheckout::API.request(:post, 'sales/refund_invoice', opts)
    end

    protected

    def _key
      self.invoice_id
    end

  end
end
