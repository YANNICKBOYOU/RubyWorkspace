require 'gosu'


class Game < Gosu::Window

  SCREEN_HEIGHT = 1000
  SCREEN_WIDTH = 1000

  def initialize
    super(SCREEN_WIDTH, SCREEN_HEIGHT, false)
    @background_sprite = Gosu::Image.new(self,'images/bckgrd.png')
    @large_font = Gosu::Font.new(self, "Futura", SCREEN_HEIGHT / 20)
    self.caption = "Tutorial Games"
    @cursor = Cursor.new(self, true)
    @player_choices = [Rock.new(80, 300, self), Paper.new(80,475, self), Scissors.new(80, 650, self)]
    @mouse_locations = []
  end

  # Mandatory methods in order for gosu to work (draw & update)
  def draw
    @background_sprite.draw(0,0,0)
    @cursor.draw
    draw_text(80, 170, "Player Choice", @large_font, 0xffffd700)
    draw_text(650, 170, "Computer Choice", @large_font, 0xffffd700)
    @player_choices.each { |c| c.draw }
  end

  def update
    @player_choices.each { |c| c.update }
    player_picked?
     # Automatically calling #button_up/button_down 60 frames per second
     # Automatically calling #button_up/button_down 60 frames per second
  end

  # Methods I created to help make the game
  def draw_text(x, y, text, font, color)
    font.draw(text, x, y, 3, 1, 1, color)
  end

  def button_down(id)
    case id
    when Gosu::KbUp
      puts "Up button_down"
    when Gosu::KbDown
      puts "Down button_down"
    when Gosu::KbLeft
      puts "Left button_down"
    when Gosu::KbRight
      puts "Right button_down"
    end
  end

  def button_up(id)
    case id
    when Gosu::KbUp
      puts "Up button_up"
    when Gosu::KbDown
      puts "Down button_up"
    when Gosu::KbLeft
      puts "Left button_up"
    when Gosu::KbRight
      puts "Right button_up"
    end
  end

  module Keys
  def button_down(id)
    case id
    when Gosu::MsLeft
      @mouse_locations << [mouse_x, mouse_y]
    end
  end
end

def player_picked?
  @player_choices.each do |choice|
    @mouse_locations.each do |location|
      if choice.bounds.collide?(location[0], location[1])
        if choice.state != :selected
          choice.state = :selected
        end
      end
    end
  end
end

end


class Rock

  attr_accessor :state
  def initialize(x, y, window)
    @rock_image = Gosu::Image.new(window, 'img/rock.png')
    @x = x
    @y = y
    @state = :unselected
  end

  def bounds
    BoundingBox.new(@x, @y, 150, 150)
  end


class BoundingBox
  attr_reader :left, :bottom, :width, :height, :right, :top

  def initialize(left, bottom, width, height)
    @left = left
    @bottom = bottom
    @width = width
    @height = height
    @right = @left + @width
    @top = @bottom + @height
  end

  def collide?(x, y)
    x >= left && x <= right && y >= bottom && y <= top
  end

  def intersects?(box)
    self.right > box.left && self.bottom < box.top && self.left < box.right &&
self.top > box.bottom
  end
end


class Paper
  attr_accessor :state
  def initialize(x, y, window)
    @paper_image = Gosu::Image.new(window, 'img/paper.png')
    @x = x
    @y = y
    @state = :unselected
  end

  def bounds
    BoundingBox.new(@x, @y, 150, 150)
  end

  def draw
    @paper_image.draw(@x, @y, 0)
  end

  def update
    if @state == :selected
      @x = 400
      @y = 400
    end
  end
end



class Scissors
  attr_accessor :state
  def initialize(x, y, window)
    @paper_image = Gosu::Image.new(window, 'img/scissors.png')
    @x = x
    @y = y
    @state = :unselected
  end

  def bounds
    BoundingBox.new(@x, @y, 150, 150)
  end

  def draw
    @paper_image.draw(@x, @y, 0)
  end

  def update
    if @state == :selected
      @x = 400
      @y = 400
    end
  end
end
end
Game.new.show
