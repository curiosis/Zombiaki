_G.pix = 56

local fog1 = love.graphics.newImage("Sprites/fog_01.png")
local fog2 = love.graphics.newImage("Sprites/fog_01.png")

function loadMap(path)
  local map = require(path)
  map.quads = {}

  local tileset = map.tilesets[1]
  map.tileset = tileset

  if mA then
    map.image = love.graphics.newImage("Map/TilesetArena.png")
  else
    map.image = love.graphics.newImage("Map/Tileset.png")
  end

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
  love.graphics.setColor(1, 1, 1, 1)
  for i, layer in ipairs(self.layers) do
    for y=0, layer.height - 1 do
      for x=0, layer.width - 1 do
        local index = (x + y * layer.width) + 1
        local tid = layer.data[index]
        if tid ~= 0 then
          local quad = self.quads[tid]
          local xx = x * self.tileset.tilewidth
          local yy = y * self.tileset.tileheight

          love.graphics.draw(
          self.image,
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

function drawFog()
  love.graphics.draw(
  fog1,
  100,
  50
)
love.graphics.draw(
fog2,
500,
0
)
love.graphics.draw(
fog2,
800,
450
)
end

function getWidthMap()
  if m1 or m2 then
    return 30*pix
  elseif m3 then
    return 35*pix
  elseif mA then
    return 40*pix
  end
end

function getHeightMap()
  if m1 or m2 then
    return 20*pix
  elseif m3 then
    return 25*pix
  elseif mA then
    return 40*pix
  end
end
