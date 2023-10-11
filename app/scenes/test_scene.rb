# frozen_string_literal: true

# Test scene class
class TestScene < Zif::Scene
  attr_reader :sprites

  def prepare_scene
    @sprites = []
    11.times do |i|
      16.times { |j| @sprites << Knight.new(25 + j * 75, 45 + i * 60) }
    end
    $gtk.args.outputs.static_sprites.concat(@sprites)
  end

  def perform_tick
    @sprites.each do |knight|
      knight.run_animation_sequence(:attack) if knight.cur_animation == :idle && rand < 0.1
    end
  end
end
