# typed: true

require 'smaug.rb'
require 'app/entities/entity.rb'
require 'app/entities/knight.rb'
require 'app/scenes/test_scene.rb'

$gtk.reset

class MyGame < Zif::Game
  attr_reader :scene

  def initialize
    super
    register_scene(:test_scene, TestScene)
    @scene = TestScene.new
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
