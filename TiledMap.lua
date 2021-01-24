_G.map = require("Map/map")

function loadMap()
  map.quads = {}

  local tileset = map.tilesets[1]
  map.tileset = tileset
  map.image = love.graphics.newImage(tileset.image)

  for y=0, (tileset.imageheight / tileset.tileheight) - 1 do
    for x=0, (tileset.imagewidth / tileset.tilewidth) - 1 do
      local quad = love.graphics.newQuad(
        x * tileset.tilewidth,
        y * tileset.tileheight,
        tileset.tilewidth,
        tileset.tileheight,
        tileset.imagewidth,
        tileset.imageheight
      )
      table.insert(map.quads, quad)
    end
  end

  function map:draw()
    for i, layer in ipairs(map.layers) do
      for y=0, layer.height - 1 do
        for x=0, layer.width - 1 do
          local index = (x + y * layer.width) + 1
          local tid = layer.data[index]
          if tid ~= 0 then
            local quad = map.quads[tid]
            local xx = x * map.tileset.tilewidth
            local yy = y * map.tileset.tileheight

            love.graphics.draw(
              map.image,
              quad,
              xx,
              yy
            )
          end
        end
      end
    end
  end
  return map
end
