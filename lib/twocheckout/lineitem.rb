module Twocheckout
  class LineItem < HashObject

    def refund!(opts)
      opts = opts.merge(:lineitem_id => self.lineitem_id)
      Twocheckout::API.request(:post, 'sales/refund_lineitem', opts)
    end

    protected

    def _key
      self.lineitem_id
    end

  end
end
