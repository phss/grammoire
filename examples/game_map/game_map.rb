require File.expand_path(File.dirname(__FILE__) + "/../../lib/grammoire")

class Map
  def initialize(x, y)
    @grid = Array.new(x) { Array.new(y, nil) }
  end

  def room_at(x, y, room)
    @grid[x][y] = room
  end

  def width
    @grid.size
  end

  def height
    @grid[0].size
  end

  def to_s
    description = "Map (#{width}, #{height})\n"  
    @grid.each do |rooms| 
      line = rooms.collect do |room|
        if room.nil?
          " "
        else
          "#"
        end
      end 
      description += line.join + "|\n"
    end  
    return description
  end
end

class Room
end

map_grammar = Grammoire.define do
  rule(:map) do 
    produce do
      map = Map.new(data(:width), data(:height))
      data(:width).times do |x|
        data(:height).times do |y|
          map.room_at(x, y, eval(:room))
        end
      end
      map
    end
  end

  rule(:room) do 
    produce do 
      Room.new
    end
  end

  rule(:room) { produce { nil } }
end


map = map_grammar.evaluate(:map, :width => 60, :height => 120)
puts map
