# typed: true

class Knight < Entity
  width 120
  height 80

  animation(name: :idle, path: 'knight/_Idle', durations: Array.new(10, 4))
  animation(name: :run, path: 'knight/_Run', durations: Array.new(10, 4))
  animation(name: :attack, path: 'knight/_Attack', durations: Array.new(4, 4), repeat: :once) do
    run_animation_sequence(:idle)
  end

  def initialize(x, y)
    super()

    @x = x
    @y = y
    run_animation_sequence(:idle)
  end

  def tick
    run_animation_sequence(:attack) if $gtk.args.inputs.keyboard.key_down.space
  end
end
