# typed: true

class Knight < Entity
  include InputManager::InputComponent

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
    @control_scheme = InputManager.keyboard_and_mouse
    @action_map = InputManager.action_maps['Player']
    run_animation_sequence(:idle)
  end

  def tick
    process_input
  end

  def on_attack
    run_animation_sequence(:attack)
  end
end
