
class Rock

  attr_accessor :state
  def initialize(x, y, window)
    @rock_image = Gosu::Image.new(window, 'images/enemy.png')
    @x = x
    @y = y
    @state = :unselected
  end

  def bounds
    BoundingBox.new(@x, @y, 150, 150)
  end
