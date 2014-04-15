Spree::Order.class_eval do

  def with_promotion_attribution
    order_copy = Spree::Order.find(self.id)
    promotions = order_copy.adjustments.eligible.promotion

    # right now only one promotion can exist per order; this might change in the future

    if promotion = promotions.first
      # the calculator can also be targeted via `promotion.originator.actions.first.calculator
      # originator is often Spree::Promotion::Actions::CreateAdjustment
      promotion_calculator = promotion.originator.calculator

      if promotion_calculator.respond_to?(:report)
        # TODO this is the ugliest hack ever; there has to be a better way to set
        #      the line items without overriding all of them
        
        attributed_line_items = promotion_calculator.report(order_copy)

        order_copy.instance_eval do
          @promotion_attributed_line_items = attributed_line_items

          def line_items
            @promotion_attributed_line_items
          end
        end

        order_copy.adjustments.reject! {|a| a == promotion }
      end
    end

    order_copy
  end

end
