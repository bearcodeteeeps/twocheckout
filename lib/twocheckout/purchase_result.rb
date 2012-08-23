require 'digest/md5'

module Twocheckout
  #
  # Represents the parameters returned back by 2Checkout after a purchase.
  #
  class PurchaseResult < HashObject

    def self.credentials=(opts)
      @@sid = opts['sid']
      @@secret = opts['secret']
      opts
    end

    def demo?
      self.demo == 'Y'
    end

    def order_number
      self.demo? ? 1 : super.order_number
    end

    #
    # Verifies that this 2Checkout return parameters actually represent a valid sale that was
    # processed and approved by 2Checkout.
    #
    def valid?
      Digest::MD5.hexdigest("#{@@secret}#{@@sid}#{order_number}#{total}").upcase == key
    end

    protected

    def _key
      self.invoice_id
    end

  end
end
