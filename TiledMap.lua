_G.pix = 56

local G = love.graphics
local A = love.audio

local fog1 = G.newImage("Sprites/fog_01.png")
local fog2 = G.newImage("Sprites/fog_01.png")
local waveMusic = A.newSource("Audio/Epic Battle Music (No Copyright) _.mp3","stream")

function loadMap(path)
  local map = require(path)
  map.quads = {}

  waveMusic:setVolume(0.3)
  waveMusic:setLooping(true)
  waveMusic:play()


  local tileset = map.tilesets[1]
  map.tileset = tileset

  if mA then
    map.image = G.newImage("Map/TilesetArena.png")
  else
    map.image = G.newImage("Map/Tileset.png")
  end

  for y=0, (tileset.imageheight / tileset.tileheight) - 1 do
    for x=0, (tileset.imagewidth / tileset.tilewidth) - 1 do
      local quad = G.newQuad(
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



  G.setColor(1, 1, 1, 1)
  for i, layer in ipairs(self.layers) do
    for y=0, layer.height - 1 do
      for x=0, layer.width - 1 do
        local index = (x + y * layer.width) + 1
        local tid = layer.data[index]
        if tid ~= 0 then
          local quad = self.quads[tid]
          local xx = x * self.tileset.tilewidth
          local yy = y * self.tileset.tileheight

          G.draw(self.image,quad,xx,yy)
      end
    end
  end
end
end
return map
end

function drawFog()
  G.draw(fog1,100,50)
  G.draw(fog2,500,0)
  G.draw(fog2,800,450)
end

function getWidthMap()
  if m1 or m2 then return 30*pix
  elseif m3 then return 35*pix
  elseif mA then return 40*pix
  end
end

function getHeightMap()
  if m1 or m2 then return 20*pix
  elseif m3 then return 25*pix
  elseif mA then return 40*pix
  end
end
