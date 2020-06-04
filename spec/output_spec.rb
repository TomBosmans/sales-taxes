# frozen_string_literal: true

require './app'
require 'spec_helper'

RSpec.describe 'SALES TAXES' do
  describe 'input 1' do
    it 'returns correct receipt' do
      receipt = Receipt.new(
        items: [
          Item.new(name: 'The Last Wish', type: :book, price: 12.49), # the book
          Item.new(name: 'In Flames: I, The Mask (2019)', type: :cd, price: 14.99), # the music cd
          Item.new(name: 'snickers', type: :food, price: 0.85) # the chocolate bar
        ]
      )

      expect(receipt.to_h).to(
        eq(
          'The Last Wish': 12.49,
          'In Flames: I, The Mask (2019)': 16.49,
          snickers: 0.85,
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
          Item.new(name: 'box of snickers', type: :food, price: 10.00, imported: true),
          Item.new(name: "box of L'Oreal", type: :parfum, price: 47.50, imported: true)
        ]
      )

      expect(receipt.to_h).to(
        eq(
          'box of snickers': 10.50,
          "box of L'Oreal": 54.65,
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
          Item.new(name: "Fake L'Oreal", type: :parfum, price: 18.99, imported: false),
          Item.new(name: 'pills for headache', type: :medical, price: 9.75, imported: false),
          Item.new(name: 'box of snickers', type: :food, price: 11.25, imported: true)
        ]
      )

      expect(receipt.to_h).to(
        eq(
          "L'Oreal": 32.19,
          "Fake L'Oreal": 20.89,
          'pills for headache': 9.75,
          'box of snickers': 11.85,
          total_tax: 6.70,
          total_cost: 74.68
        )
      )
    end
  end
end
