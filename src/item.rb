# frozen_string_literal: true

class Item
  EXEMPT_TYPES = %i[book food medical].freeze
  BASIC_TAX = 10
  IMPORT_TAX = 5

  attr_reader :name, :type, :price, :imported

  def initialize(name:, type:, price:, imported: false)
    @name = name
    @type = type
    @price = price
    @imported = imported
  end

  def price_including_tax
    price + total_tax
  end

  def total_tax
    import_tax + basic_tax
  end

  private

  def calculate_tax(tax)
    ((tax * price / 100) * 20.0).ceil / 20.0
  end

  def basic_tax
    return 0 unless basic_tax_applicable?

    calculate_tax(BASIC_TAX)
  end

  def import_tax
    return 0 unless import_tax_applicable?

    calculate_tax(IMPORT_TAX)
  end

  def basic_tax_applicable?
    !EXEMPT_TYPES.include? type
  end

  def import_tax_applicable?
    imported
  end
end
