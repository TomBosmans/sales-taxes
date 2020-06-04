# frozen_string_literal: true

class Receipt
  attr_reader :items

  def initialize(items: [])
    @items = items
  end

  def to_h
    items.inject(total_cost: total_cost.round(2), total_tax: total_tax.round(2)) do |hash, item|
      hash[item.name.to_sym] = item.price_including_tax.round(2)
      hash
    end
  end

  private

  def total_cost
    items.inject(0) { |sum, item| sum + item.price_including_tax }
  end

  def total_tax
    items.inject(0) { |sum, item| sum + item.total_tax }
  end
end
