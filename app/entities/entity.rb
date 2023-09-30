# typed: true

class Entity < Zif::Sprite
  class << self
    def width(value)
      @@width = value
    end

    def height(value)
      @@height = value
    end

    def animation(name:, path:, durations:, repeat: :forever, type: :tiled, &block)
      @@animations ||= {}
      @@animations[name] = {
        type: :tiled,
        params: {
          named: name,
          path: path,
          width: @@width,
          height: @@height,
          durations: durations,
          repeat: repeat
        },
        block: block
      }
    end
  end

  def initialize
    super

    @w = width
    @h = height
    @source_x = 0
    @source_y = 0
    @source_w = width
    @source_h = height

    register_animations
  end

  def register_animations
    @@animations.values.select { |animation| animation[:type] == :tiled }.each do |animation|
      new_tiled_animation(animation[:params]) { instance_exec(&animation[:block]) }
    end

    $game.services[:action_service].register_actionable(self)
  end

  def width
    @@width
  end

  def height
    @@height
  end

  def animations
    @@animations
  end
end
