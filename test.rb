module Players
  class PlayerType
    attr_reader :name, :memory

    def initialize(params = {})
      params.each do |key, value|
        instance_variable_set("@#{key}", value) unless value.nil?
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
      if args[:touch]
        @player_type = PlayerTypeWithTouch.new(args)
      else
        @player_type = PlayerTypeWithoutTouch.new(args)
      end
    end
  end
end

p = Players::Player.new(name: 'ipod', memory: 32, touch: false)
