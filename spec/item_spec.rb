# frozen_string_literal: true

require './app'
require 'spec_helper'

RSpec.describe Item do
  describe '#price_including_tax' do
    it 'returns the price + total_tax' do
      item = Item.new(name: 'something', type: :something, price: 100)
      allow(item).to receive(:total_tax).and_return 15
      expect(item.price_including_tax).to eq 115
    end
  end

  describe '#total_tax' do
    context 'when not imported' do
      it 'adds basic tax of 10% to the total' do
        item = Item.new(name: 'something', type: :something, price: 100, imported: false)
        expect(item.total_tax).to eq 10
      end

      %i[book food medical].each do |type|
        it "does not add basic tax when #type is #{type}" do
          item = Item.new(name: 'something', type: type, price: 100, imported: false)
          expect(item.total_tax).to eq 0
        end
      end
    end

    context 'when imported' do
      it 'adds basic tax of 10% and import tax of 5%' do
        item = Item.new(name: 'something', type: :something, price: 100, imported: true)
        expect(item.total_tax).to eq 15
      end

      %i[book food medical].each do |type|
        it "only adds imported tax when #type is #{type}" do
          item = Item.new(name: 'something', type: type, price: 100, imported: true)
          expect(item.total_tax).to eq 5
        end
      end
    end
  end
end
