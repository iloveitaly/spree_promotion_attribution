Spree::Calculator::PercentPerItem.class_eval do

  def report(object = nil)
    object.line_items.map(&:dup).each do |line_item|
      next if compute_on_promotion? && !matching_products.include?(line_item.product)

      line_item.price *= 1.0 - preferred_percent
    end
  end
  
end
