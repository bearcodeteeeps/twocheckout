module Twocheckout
  class LineItem < HashObject

    def refund!(opts)
      opts = opts.merge(:lineitem_id => self.lineitem_id)
      Twocheckout::API.request(:post, 'sales/refund_lineitem', opts)
    end

    def active?
      self.billing.recurring_status == 'active'
    end

    def stop_recurring!
      Twocheckout::API.request(:post, 'sales/stop_lineitem_recurring', lineitem_id: self.lineitem_id)
    end

    protected

    def _key
      self.lineitem_id
    end

  end
end
