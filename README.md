# ColorProximity

[![Build Status](https://travis-ci.org/gjtorikian/color-proximity.svg?branch=master)](https://travis-ci.org/gjtorikian/color-proximity)

Given a threshold and a collection of colors, you'll be able to determine how close a given color is to matching a list.

[A gem](https://github.com/mmozuras/color_difference) that implements a [CIEDE2000 color-difference formula](http://www.ece.rochester.edu/~gsharma/ciede2000/ciede2000noteCRNA.pdf) is the main backend used.

## Usage

``` ruby
require 'color-proximity'
cp = ColorProximity.new(0.5, ['000000'])
cp.past_threshold?('000000') # [false, ['000000']]

cp.collection = (['ffffff'])
cp.past_threshold?('000000') # [true]

cp.collection = (['000001', '000002', 'ffffff'])
cp.thresholds('000003') # [0.00832, 0.00412, 0.99948]
```

A failure case returns an array with two elements: `false`, and the collection of colors that failed the threshold. Success cases return an array with one element: `true`. This is designed to make it easy to call `.first` on the result to validate it.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'color-proximity'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install color-proximity
