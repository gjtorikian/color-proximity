require 'spec_helper'

describe ColorProximity do
  it 'has a version number' do
    expect(ColorProximity::VERSION).not_to be nil
  end

  it 'works for an exact hex color' do
    cp = ColorProximity.new(0.5, ['000000']).within_threshold?('000000')
    expect(cp.first).to eq(false)
    expect(cp.last).to eq(['000000'])
  end

  it 'works for complete opposites' do
    cp = ColorProximity.new(0.5, ['000000', '000001']).within_threshold?('ffffff')
    expect(cp.first).to eq(true)
  end

  it 'works for multiple failures' do
    cp = ColorProximity.new(0.5, ['000001', '000002', 'ffffff']).within_threshold?('000003')
    expect(cp.first).to eq(false)
    expect(cp.last).to eq(['000001', '000002'])
  end

  it 'can change collections' do
    cp = ColorProximity.new(0.5, ['000001', '000002'])
    expect(cp.within_threshold?('000003').first).to eq(false)

    cp.collection = ['ffffff']
    expect(cp.within_threshold?('000003').first).to eq(true)
  end

  it 'can change thresholds' do
    cp = ColorProximity.new(0.5, ['000001', '000002'])
    expect(cp.within_threshold?('000003').first).to eq(false)

    cp.threshold = 0.000001
    expect(cp.within_threshold?('000003').first).to eq(true)
  end

  it 'lists thresholds' do
    cp = ColorProximity.new(0.5, ['000001', '000002', 'ffffff']).thresholds('000003')
    expect(cp).to eq([0.00832, 0.00412, 0.99948])
  end

  it 'is better at yellow detection' do
    cp = ColorProximity.new(0.1, ['fdcd00'])

    expect(cp.within_threshold?('f3ca0a').first).to eq(false)
  end
end
