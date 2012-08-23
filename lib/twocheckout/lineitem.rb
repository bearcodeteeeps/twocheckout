module Twocheckout
  class LineItem < HashObject

    protected

    def _key
      self.lineitem_id
    end

  end
end
