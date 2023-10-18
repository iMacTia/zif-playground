# typed: true

require 'smaug.rb'
require 'app/entities/entity.rb'
require 'app/entities/knight.rb'
require 'app/scenes/test_scene.rb'
require 'app/scenes/knight_playground_scene.rb'

$gtk.reset

InputManager.register_action_map(
  'Player',
  InputManager::ActionMap.new('Player').tap do |am|
    am.register_action(
      :attack,
      [
        InputManager::Binding.new(:keyboard, :space, :key_down),
        InputManager::Binding.new(:keyboard, :a, :key_down),
        [
          InputManager::Binding.new(:mouse, :click),
          InputManager::Binding.new(:mouse, :button_left)
        ]
      ]
    )
  end
)

class MyGame < Zif::Game
  attr_reader :scene

  def initialize
    super
    register_scene(:test_scene, TestScene)
    register_scene(:knight_playground, KnightPlaygroundScene)
    @scene = KnightPlaygroundScene.new
  end
end

def tick(args)
  $game = args.state.game
  if args.tick_count == 2
    args.state.game = MyGame.new
    $game = args.state.game
    args.state.game.scene.prepare_scene
  end
  $game&.perform_tick
end
