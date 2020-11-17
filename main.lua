local lg = love.graphics

local player
local playerX
local playerY
local speed = 300

local windowMode

local screenResW = 1280
local screenResH = 720
local playerRot
function love.load()
  player = lg.newImage('Sprites/Player.png')
  playerX = love.graphics.getWidth() / 2
  playerY = love.graphics.getHeight() / 2
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
end

function love.draw()
  lg.draw(player, playerX, playerY, playerRot, 1, 1, player:getWidth() / 2, player:getHeight() / 2)
end
