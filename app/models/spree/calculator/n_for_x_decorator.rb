Spree::Calculator::NForX.class_eval do

  def report(object = nil)
    # unfortunately there is no way to attribute a discount to an individual item in a line item if multiple 
    # items of the same variant were purchased. If someone purchased 4 of one product and five of another in
    # a 5 for $50 deal then the discount for the one product of the five purchased would have to be spread
    # over the 5 products even though the discount only applied to one.
    # This isn't completely accurate, but it is the best we can do.

    discount = compute(object)
    applicable_total = applicable_variants.map(&:price).sum
    discount_schedule = {}

    applicable_variants.map(&:id).uniq.each do |variant_id|
      percentage = applicable_variants.select { |v| v.id == variant_id }.map(&:price).sum / applicable_total
      discount_schedule[variant_id] = percentage
    end

    object.line_items.map(&:dup).each do |line_item|
      next unless applicable_variants.include? line_item.variant

      line_item.price -= discount_schedule[line_item.variant.id] * discount / line_item.quantity
    end
  end

end if defined?(Spree::Calculator::NForX)