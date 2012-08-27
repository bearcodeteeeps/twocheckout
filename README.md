# Twocheckout

This gem aims at providing an ORM-like interface to access the [2Checkout API](https://www.2checkout.com/documentation/api/) from Ruby code.

## Installation

Add this line to your application's Gemfile:

    gem 'twocheckout'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install twocheckout

## Usage

The first step is to define your credentials to access the API:

    Twcocheckout::API.credentials = { :username => 'api.user', :password => 'secret' }

Then you can start making things like this:

    sale = Twocheckout::Sale.find(:sale_id => '4769044324')
    puts "#{sale.sale_id} has #{sale.invoices.count} invoices"

You can work on child objects too, like invoices and lineitems:

    last_invoice = sale.invoices.last
    specific_invoice = sale.invoice['4769044335']
    puts "Invoice #{last_invoice.invoice_id} has #{last_invoice.lineitems.count} lineitems..."
    puts "...and #{last_invoice.active_lineitems.count} of them are active"

You can perform actions on them too, not just query their attributes:

    last_lineitem = last_invoice.lineitems.last
    last_lineitem.refund!
    sale.stop_recurring!

Sales and invoices are not everything. You can easily query the company info and contact details:

    company = Twocheckout::Company.instance
    contact_info = company.contact_info
    puts "Company: #{company.vendor_name}"
    puts "City: #contact_info.mailing_city"

And this is just the beginning. We plan to provide an interface to every single 2Checkout API call available.

### Direct API calls

ORM-like interfaces are not a panacea. Sometimes it may be more convenient to perform low-level API calls directly:

    sales = Twocheckout::API.request(:get, 'sales/list_sales')
    first_sale = sales['sale_summary'].first

In this case, the resulting object is a hash containing the parsed JSON response obtained from the call.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
