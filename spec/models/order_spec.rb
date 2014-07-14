require 'spec_helper'

describe Spree::Order do
	let(:order) { FactoryGirl.create(:order) }

	it "properly modifies the order when a promotion exists" do
		# setup order
		v1 = FactoryGirl.create :variant, price: 10.00
		v2 = FactoryGirl.create :variant, price: 15.00
		order.add_variant(v1)
		order.add_variant(v2)

		# setup promo
		promo = Spree::Promotion.create(:name => "20% off")
		flat_percent = Spree::Calculator::FlatPercentItemTotal.create
		flat_percent.preferred_flat_percent = 20.0
		Spree::Promotion::Actions::CreateAdjustment.create({
		  promotion: promo,
		  calculator: flat_percent
		}, without_protection: true)
		promo.reload

		# trigger promotion
		promo.activate({ order: order })
		order.reload

		expect(order.line_items.where(variant_id: v1.id).first.price.to_f).to eq(10.00)
		expect(order.total.to_f).to eq(20.00)
		expect(order.item_total.to_f).to eq(25.00)
		expect(order.promo_total.to_f).to eq(-5.00)

		attributed_order = order.with_promotion_attribution

		expect(attributed_order.line_items.detect { |l| l.variant_id == v1.id }.price.to_f).to eq(8.00)
		expect(attributed_order.promo_total.to_f).to eq(0.0)
		expect(attributed_order.total.to_f).to eq(20.00)
		expect(attributed_order.item_total.to_f).to eq(20.00)
	end
end