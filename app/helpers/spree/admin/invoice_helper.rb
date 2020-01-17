module Spree
  module Admin
    module InvoiceHelper

      def addresses
        bill_address = @order.bill_address
        ship_address = @order.ship_address
        anonymous = @order.email =~ /@example.net$/

        return [[" "," "]] * 5 if anonymous && Spree::HtmlInvoice::Config[:suppress_anonymous_address]

        all_addresses = [address_as_array(bill_address), address_as_array(ship_address)]
        all_addresses = all_addresses.transpose # array from whole address by whole address -> address row by address row
        all_addresses.select {|row| row != ['', ''] }
      end

      def address_as_array(address)
        return [''] * 6 unless address

        [
          "#{ship_address.firstname} #{ship_address.lastname}",
          ship_address.address1,
          ship_address.address2 || '',
          "#{ship_address.zipcode} #{ship_address.city}",
          "#{(ship_address.state.name rescue ship_address.state_name)} #{ship_address.country.name}",
          ship_address.phone
        ]
      end

      def

      def show_label(adjustment)
        label =  adjustment.label
        type = ""
        if adjustment.adjustable.is_a?(Spree::Shipment)
          type += Spree.t(:ship_adjustment)
        elsif adjustment.adjustable.is_a?(Spree::LineItem)
          type += adjustment.adjustable.product.name
        end
        type = "(#{type})" unless type.empty?
        label += type
      end
    end
  end
end
