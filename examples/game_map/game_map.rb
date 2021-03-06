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
        if room.nil? || room == :no_room
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

map_grammar = Grammoire.define do
  rule(:completely_random_map) do 
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

  rule(:map) do
    produce do
      store(:map, Map.new(data(:width), data(:height)))
      eval(:room, :x => 10, :y => 10)
      data(:map)
    end
  end

  rule(:room) { produce { :room } }
  rule(:room) { produce { data(:map).room_at(data(:x), data(:y), :no_room) } }
end


map = map_grammar.evaluate(:map, :width => 60, :height => 120)
puts map
