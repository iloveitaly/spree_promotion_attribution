Spree::Calculator::NToYProductsXOff.class_eval do

  def report(object = nil)
    # TODO this needs to be much DRYer
    more_count = 1

    line_items_copy = object.line_items.map(&:dup)

    line_items_copy.select { |l| self.matching_variants.include?(l.variant) }.sort_by { |l| l.variant.price }.each do |line_item|
      discount = 0

      break if more_count > self.preferred_y_items

      line_item.quantity.times do
        break if more_count > self.preferred_y_items

        if more_count > self.preferred_n_items
          discount += line_item.price * self.preferred_percent / 100.0
        end

        more_count += 1
      end

      line_item.price = (line_item.total - discount) / line_item.quantity
    end

    line_items_copy
  end
  
end if defined?(Spree::Calculator::NToYProductsXOff)
