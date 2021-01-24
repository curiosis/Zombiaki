require "camera"
require "TiledMap"

local G = love.graphics
local K = love.keyboard
local M = love.mouse

player = {
  speed = 300,
  sprite = G.newImage('Sprites/Player.png'),
  x = G.getWidth() / 2,
  y = G.getHeight() / 2
}

function player:direction()
  return math.atan2(
    (M.getY() - player.y/(getWidthMap()/camera.resW)),
    (M.getX() - player.x/(getHeightMap()/camera.resH))
  )
end

function player:update(dt)
  self:move(dt)
  self:camera()
  print(M.getY() - player.y)
  print(M.getX() - player.x)
  print(player:direction())
end

function player:draw()
  G.draw(
    self.sprite,
    self.x,
    self.y,
    self:direction(),
    1,
    1,
    self.sprite:getWidth() / 2,
    self.sprite:getHeight() / 2
  )
end

function player:move(dt)
  local speedDT = self.speed * dt
  if K.isDown("right", 'd')  then self.x = self.x + speedDT
  elseif K.isDown("left",'a') then self.x = self.x - speedDT end
  if K.isDown("down",'s') then self.y = self.y + speedDT
  elseif K.isDown("up",'w') then self.y = self.y - speedDT end
end

function player:camera()
  if player.x > G.getWidth() / 2 and player.x < 1040 then camera.x = player.x - G.getWidth() / 2 end
  if player.y > G.getHeight() / 2 and player.y < 760 then camera.y = player.y - G.getHeight() / 2 end
end
