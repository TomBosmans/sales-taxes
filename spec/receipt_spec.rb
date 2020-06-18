# frozen_string_literal: true

require './app'
require 'spec_helper'

RSpec.describe Receipt do
  describe '#to_h' do
    it 'returns a hash including all item#name + item#price_including_tax rounded to 2 + total_cost rounded to 2 and total_tax rounded to 2' do
      item1 = Item.new(name: 'item 1', price: 100, type: :random, imported: false)
      item2 = Item.new(name: 'item 2', price: 100, type: :random, imported: true)
      receipt = Receipt.new(items: [item1, item2])

      total_tax = item1.total_tax + item2.total_tax
      total_cost = item1.price_including_tax + item2.price_including_tax

      expect(receipt.to_h).to include(
        item1.name.to_sym => item1.price_including_tax.round(2),
        item2.name.to_sym => item2.price_including_tax.round(2),
        total_tax: total_tax.round(2),
        total_cost: total_cost.round(2)
      )
    end
  end
end
