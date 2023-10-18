# frozen_string_literal: true

# Test scene class
class KnightPlaygroundScene < Zif::Scene
  attr_reader :knight

  def prepare_scene
    @knight = Knight.new(640, 360)
    $gtk.args.outputs.static_sprites << @knight
  end

  def perform_tick
    @knight.tick
  end
end
