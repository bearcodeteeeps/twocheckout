module Twocheckout
  class Sale < HashObject

    def self.find(options)
      response = Twocheckout::API.request(:get, 'sales/detail_sale', options)
      Sale.new(response['sale'])
    end

    def self.with_sale_id(sale_id)
      find(:sale_id => sale_id)
    end

    def self.with_invoice_id(invoice_id)
      find(:invoice_id => invoice_id)
    end

    #
    # An array of all invoices in this sale
    #
    def invoices
      if @invoices.nil?
        @invoices = @hash['invoices'].map { |i| Twocheckout::Invoice.new(i) }
        @invoices.freeze
      end
      @invoices
    end

    #
    # A hash to index invoices by id
    #
    def invoice
      if @invoice.nil?
        @invoice = {}
        invoices.each { |inv| @invoice[inv.invoice_id] = inv }
        @invoice.freeze
      end
      return @invoice
    end

    protected

    def _key
      self.sale_id
    end

  end
end
