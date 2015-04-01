# ColorProximity

[![Build Status](https://travis-ci.org/gjtorikian/color-proximity.svg?branch=master)](https://travis-ci.org/gjtorikian/color-proximity)

Given a threshold and a collection of colors, you'll be able to determine how close a given color is to matching a list.

A [Euclidean distance algorithm](http://www.compuphase.com/cmetric.htm) is used to determine matches.

## Usage

``` ruby
require 'color-proximity'
cp = ColorProximity.new(0.5, ['000000'])
cp.within_threshold?('000000') # [false, ['000000']]

cp.collection = ['ffffff'])
cp.within_threshold?('000000') # [true]

cp.collection = ['000001', '000002', 'ffffff'])
cp.thresholds('000003') # [3.3166247903554, 1.4142135623730951, 762.3437544835007]
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
