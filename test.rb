# frozen_string_literal: true

module Players
  class PlayerType
    attr_reader :name, :memory

    DEFAULT_VALUES = {
      name: 'ipod',
      memory: 32
    }.freeze

    def initialize(params = {})
      params.each do |key, value|
        if value.nil?
          instance_variable_set("@#{key}", DEFAULT_VALUES[key.to_sym])
        else
          instance_variable_set("@#{key}", value)
        end
      end
    end
  end

  class PlayerTypeWithTouch < PlayerType
    def touch_me
      puts 'I touched'
    end
  end

  class PlayerTypeWithoutTouch < PlayerType
    def drop_me
      puts 'I dropped'
    end
  end

  class Player
    attr_reader :player_type

    def initialize(**args)
      @player_type = if args[:touch]
                       PlayerTypeWithTouch.new(args)
                     else
                       PlayerTypeWithoutTouch.new(args)
                     end
    end

    def self.detect_type(touch)
      if touch
        PlayerTypeWithTouch.class.name
      else
        PlayerTypeWithoutTouch.class.name
      end
    end
  end
end

p_type = Players::Player.detect_type(true)
p = Players::Player.new(name: 'ipod', memory: 32, touch: p_type)
puts p
