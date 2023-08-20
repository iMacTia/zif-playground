# typed: true

require 'smaug.rb'

$gtk.reset

class MyGame < Zif::Game
  attr_reader :scene

  def initialize
    super
    register_scene(:my_scene, MyScene)
    @scene = MyScene.new
  end
end

class MyScene < Zif::Scene
  attr_reader :knight

  def prepare_scene
    @knight = prepare_knight
    $game.services[:action_service].register_actionable(@knight)
    $gtk.args.outputs.static_sprites << @knight
  end

  def new_knight
    Zif::Sprite.new.tap do |s|
      s.x = 640
      s.y = 360
      s.w = 120
      s.h = 80
      s.source_x = 0
      s.source_y = 0
      s.source_w = s.w
      s.source_h = s.h
    end
  end

  def prepare_knight
    knight = new_knight

    knight.new_tiled_animation(
      named: :idle,
      path: 'knight/_Idle',
      width: 120,
      height: 80,
      durations: Array.new(10, 4)
    )

    knight.new_tiled_animation(
      named: :attack,
      path: 'knight/_Attack',
      width: 120,
      height: 80,
      durations: Array.new(4, 4),
      repeat: :once
    ) do
      $return_knight_to_idle = true
    end

    knight.run_animation_sequence(:idle)
    knight
  end

  def perform_tick
    # puts @knight.source_rect
    @knight.run_animation_sequence(:attack) if $gtk.args.inputs.keyboard.key_down.space
  end
end

def tick(args)
  $game = args.state.game
  if args.tick_count == 2
    args.state.game = MyGame.new
    $game = args.state.game
    args.state.game.scene.prepare_scene
  end
  if $return_knight_to_idle
    $return_knight_to_idle = false
    args.state.game.scene.knight.run_animation_sequence(:idle)
  end
  $game&.perform_tick
  args.outputs.labels << [100, 100, args.state.game.scene.knight.cur_animation, 1, 1]
  args.outputs.labels << [200, 50, args.state.game.scene.knight.source_rect.join(', '), 1, 1]
end
