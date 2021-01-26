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

playerCamera = {
  m1x = 1040,
  m1y = 760,
  m2x = 1040,
  m2y = 760,
  m3x = 1320,
  m3y = 1040,
  mAx = 1600,
  mAy = 1880
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
  if m1 then
    if player.x > G.getWidth() / 2 and player.x < playerCamera.m1x then camera.x = player.x - G.getWidth() / 2 end
    if player.y > G.getHeight() / 2 and player.y < playerCamera.m1y then camera.y = player.y - G.getHeight() / 2 end
  elseif m2 then
    if player.x > G.getWidth() / 2 and player.x < playerCamera.m2x then camera.x = player.x - G.getWidth() / 2 end
    if player.y > G.getHeight() / 2 and player.y < playerCamera.m2y then camera.y = player.y - G.getHeight() / 2 end
  elseif m3 then
    if player.x > G.getWidth() / 2 and player.x < playerCamera.m3x then camera.x = player.x - G.getWidth() / 2 end
    if player.y > G.getHeight() / 2 and player.y < playerCamera.m3y then camera.y = player.y - G.getHeight() / 2 end
  elseif mA then
    if player.x > G.getWidth() / 2 and player.x < playerCamera.mAx then camera.x = player.x - G.getWidth() / 2 end
    if player.y > G.getHeight() / 2 and player.y < playerCamera.mAy then camera.y = player.y - G.getHeight() / 2 end
  end
end

function player:addMove()
  self.speed = self.speed + 10
end

function player:addDamage()
  self.damage = self.damage + 10
end
