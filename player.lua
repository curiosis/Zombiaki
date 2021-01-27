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
  damage = 100
}

function player:direction()
  x, y = love.mouse.getPosition()
  return math.atan2(
  (y - player.y/(getHeightMap()/camera.resH)),
  (x - player.x/(getWidthMap()/camera.resW))
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

  if K.isDown("right", 'd') then
    if (m1 and self.x < 1620) or (m2 and self.x < 1620) or (m3 and self.x < 1900) or (mA and self.x < 2180)  then
      self.x = self.x + speedDT end

  elseif K.isDown("left",'a') and self.x > 60 then
      self.x = self.x - speedDT end

  if K.isDown("down",'s') then
    if (m1 and self.y < 840) or (m2 and self.y < 1060) or (m3 and self.y < 1340) or (mA and self.y < 2180) then
      self.y = self.y + speedDT end


  elseif K.isDown("up",'w') then
    if ((m1 or m2 or mA) and self.y > 60) or (m3 and self.y > 452) then
      self.y = self.y - speedDT end
    end
end

function player:camera()
    if player.x > G.getWidth() / 2 and player.x < getWidthMap() - G.getWidth() / 2 then camera.x = player.x - G.getWidth() / 2 end
    if player.y > G.getHeight() / 2 and player.y < getHeightMap() - G.getHeight() / 2 then camera.y = player.y - G.getHeight() / 2 end
end

function player:addMove()
  self.speed = self.speed + 10
end

function player:addDamage()
  self.damage = self.damage + 20
end
