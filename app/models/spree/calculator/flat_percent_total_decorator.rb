Spree::Calculator::FlatPercentItemTotal.class_eval do
  
  def report(object = nil)
    discount = BigDecimal(self.preferred_flat_percent.to_s) / 100.0

    object.line_items.map(&:dup).each do |line_item|
      line_item.price *= 1.0 - discount
    end
  end

end
