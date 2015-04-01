require "color-proximity/version"

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
    color_red, color_green, color_blue = split_color(color)
    another_color_red, another_color_green, another_color_blue = split_color(another_color)

    color_red_mean = (color_red + another_color_red) / 2
    color_red_gap  = color_red - another_color_red
    color_green_gap = color_green - another_color_green
    color_blue_gap  = color_blue - another_color_blue

    euclidean_distance(color_red_mean, color_red_gap, color_green_gap, color_blue_gap)
  end

  def split_color(color)
    red   = (color[0] + color[1]).to_i(16)
    green = (color[2] + color[3]).to_i(16)
    blue  = (color[4] + color[5]).to_i(16)

    [red, green, blue]
  end

  def euclidean_distance(red_mean, red_gap, green_gap, blue_gap)
    red_weight   = ((512 + red_mean) * red_gap**2) >> 8
    green_weight = 4 * green_gap**2
    blue_weight  = ((767 - red_mean) * blue_gap**2) >> 8

    Math.sqrt(red_weight + green_weight + blue_weight)
  end
end
