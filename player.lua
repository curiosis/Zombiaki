require "camera"
require "TiledMap"

local G = love.graphics
local K = love.keyboard
local M = love.mouse

player = {
  speed = 300,
  sprite = G.newImage('Sprites/Player.png'),
  x = G.getWidth() / 2,
  y = G.getHeight() / 2,
  damage = 80
}

function player:direction()
  return math.atan2(
  (M.getY() - player.y/(getHeightMap()/camera.resH)),
  (M.getX() - player.x/(getWidthMap()/camera.resW))
)
end

function player:update(dt)
  self:move(dt)
  self:camera()
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
  if K.isDown("right", 'd') and self.x < 1626  then self.x = self.x + speedDT
  elseif K.isDown("left",'a') and self.x > 56 then self.x = self.x - speedDT end
  if K.isDown("down",'s') and self.y < 839 then self.y = self.y + speedDT
  elseif K.isDown("up",'w') and self.y > 56 then self.y = self.y - speedDT end
end

function player:camera()
  if player.x > G.getWidth() / 2 and player.x < 1040 then camera.x = player.x - G.getWidth() / 2 end
  if player.y > G.getHeight() / 2 and player.y < 760 then camera.y = player.y - G.getHeight() / 2 end
end

function player:addMove()
  self.speed = self.speed + 10
end
