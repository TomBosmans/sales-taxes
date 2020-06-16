# frozen_string_literal: true

require './app'
require 'spec_helper'

RSpec.describe 'SALES TAXES' do
  describe 'input 1' do
    it 'returns correct receipt' do
      receipt = Receipt.new(
        items: [
          Item.new(name: 'The Last Wish', type: :book, price: 12.49),
          Item.new(name: 'In Flames: I, The Mask (2019)', type: :cd, price: 14.99),
          Item.new(name: 'Nougatti', type: :food, price: 0.85)
        ]
      )

      expect(receipt.to_h).to(
        eq(
          'The Last Wish': 12.49,
          'In Flames: I, The Mask (2019)': 16.49,
          'Nougatti': 0.85,
          total_tax: 1.50,
          total_cost: 29.83
        )
      )
    end
  end

  describe 'input 2' do
    it 'returns correct receipt' do
      receipt = Receipt.new(
        items: [
          Item.new(name: 'Box of Bounty', type: :food, price: 10.00, imported: true),
          Item.new(name: "Box of L'Oreal", type: :parfum, price: 47.50, imported: true)
        ]
      )

      expect(receipt.to_h).to(
        eq(
          'Box of Bounty': 10.50,
          "Box of L'Oreal": 54.65,
          total_tax: 7.65,
          total_cost: 65.15
        )
      )
    end
  end

  describe 'input 3' do
    it 'returns correct receipt' do
      receipt = Receipt.new(
        items: [
          Item.new(name: "L'Oreal", type: :parfum, price: 27.99, imported: true),
          Item.new(name: "Ma liberte", type: :parfum, price: 18.99, imported: false),
          Item.new(name: 'Excedryn', type: :medical, price: 9.75, imported: false),
          Item.new(name: 'Box of Bounty', type: :food, price: 11.25, imported: true)
        ]
      )

      expect(receipt.to_h).to(
        eq(
          "L'Oreal": 32.19,
          "Ma liberte": 20.89,
          'Excedryn': 9.75,
          'Box of Bounty': 11.85,
          total_tax: 6.70,
          total_cost: 74.68
        )
      )
    end
  end
end
