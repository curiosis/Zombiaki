require "Shop"
local lg = love.graphics

local player
local playerX
local playerY
local speed = 300

local background
local background_quad
local shop
local shop2
local coin
monets = 0

local windowMode

local screenResW = 1280
local screenResH = 720
local playerRot

function love.load()
  player = lg.newImage('Sprites/Player.png')
  background = lg.newImage('Sprites/Background.png')
  background:setWrap("repeat", "repeat")
  background_quad = lg.newQuad(0, 0, screenResW, screenResH, background:getWidth(), background:getHeight())
  shop = lg.newImage('Sprites/shop.png')
  shop2 = lg.newImage('Sprites/shop2.png')
  coin = lg.newImage('Sprites/coin.png')
  lg.setNewFont(28)

  playerX = lg.getWidth() / 2
  playerY = lg.getHeight() / 2
  playerRot = math.atan2((love.mouse.getY() - playerY), (love.mouse.getX() - playerX))

  windowMode = love.window.setMode(screenResW, screenResH)
end

function love.update(dt)
  playerRot = math.atan2((love.mouse.getY() - playerY), (love.mouse.getX() - playerX))
  if love.keyboard.isDown("right", 'd')  then
    playerX = playerX+speed*dt
  elseif love.keyboard.isDown("left",'a') then
    playerX = playerX - speed * dt
  end
  if love.keyboard.isDown("down",'s') then
    playerY = playerY+speed*dt
  elseif love.keyboard.isDown("up",'w') then
    playerY = playerY - speed * dt
  end

  Shop().keys()
end

function love.draw()
  lg.draw(background, background_quad, 0, 0)
  lg.draw(player, playerX, playerY, playerRot, 1, 1, player:getWidth() / 2, player:getHeight() / 2)
  lg.draw(shop2, 320, 550)
  lg.draw(coin, 1210,12)
  lg.print(monets,1150,20)

  if(shop_open) then
    lg.draw(shop,0,0)
  else
    lg.draw(shop,1500,0)
  end

  --Zużycie RAM
  local stats = lg.getStats(10)
  local str = string.format("Estimated amount of texture memory used: %.2f MB", stats.texturememory / 1024 / 1024)
  lg.print(str, 10, 10)
end
