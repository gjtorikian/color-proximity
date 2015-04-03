require 'color-proximity/version'
require 'color_difference'

class ColorProximity

  attr_accessor :threshold, :collection

  def initialize(threshold, collection)
    @threshold = threshold
    @collection = collection
  end

  def within_threshold?(color)
    @collection.each_with_object([true]) do |collection_color, arr|
      proximity = proximity_of(color, collection_color)
      next unless @threshold > proximity
      arr[0] = false
      arr[1] = [] if arr[1].nil?
      arr[1] << collection_color
    end
  end

  def thresholds(color)
    @collection.map { |collection_color| proximity_of(color, collection_color) }
  end

  private

  def proximity_of(color, another_color)
    ColorDifference.cie2000(split_color(color), split_color(another_color)).round(5)
  end

  def split_color(color)
    red   = (color[0] + color[1]).to_i(16)
    green = (color[2] + color[3]).to_i(16)
    blue  = (color[4] + color[5]).to_i(16)

    { r: red, g: green, b: blue }
  end
end
