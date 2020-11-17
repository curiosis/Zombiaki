local lg = love.graphics

local player
local playerX
local playerY
local playerRot
local speed = 150

local windowMode

function love.load()
  player = lg.newImage('Sprites/Player.png')
  playerX = love.graphics.getWidth() / 2
  playerY = love.graphics.getHeight() / 2
  playerRot = math.atan2((love.mouse.getY() - playerY), (love.mouse.getX() - playerX))

  windowMode = love.window.setMode(1280, 720)
end

function love.update(dt)
  playerRot = math.atan2((love.mouse.getY() - playerY), (love.mouse.getX() - playerX) - 120)
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
end

function love.draw()
  lg.draw(player, playerX, playerY, playerRot, 1, 1, player:getWidth() / 2, player:getHeight() / 2)
end
