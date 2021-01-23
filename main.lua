require "Sprite"
require "Zombie"

local lg = love.graphics

local player
local playerX
local playerY
local speed = 300

local background
local background_quad

local windowMode

local screenResW = 1280
local screenResH = 720
local playerRot

zombies = {}

function love.load()
  player = lg.newImage('Sprites/Player.png')
  background = lg.newImage('Sprites/Background.png')
  background:setWrap("repeat", "repeat")
  background_quad = lg.newQuad(0, 0, screenResW, screenResH, background:getWidth(), background:getHeight())
  playerX = love.graphics.getWidth() / 2
  playerY = love.graphics.getHeight() / 2
  playerRot = math.atan2((love.mouse.getY() - playerY), (love.mouse.getX() - playerX))

  -- create Zombies and add them to the table
  zombieImg = lg.newImage('Sprites/Zombie.png')
  for i = 1, 4 do
    local zombieSprite = Sprite(zombieImg)
    local zombie = Zombie(zombieSprite)
    zombie.initPosition(0, i * 150 - 150)
    table.insert(zombies, zombie)
  end

  windowMode = love.window.setMode(screenResW, screenResH)
end

function love.update(dt)
  moveZombie(dt, playerX, playerY)
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
  lg.draw(background, background_quad, 0, 0)
  lg.draw(player, playerX, playerY, playerRot, 1, 1, player:getWidth() / 2, player:getHeight() / 2)

  for i = 1, #zombies do
    local zombie = zombies[i].sprite
    lg.draw(zombie.image, zombie.x, zombie.y)
  end
end

function moveZombie(dt, pX, pY)
  for i = 1, #zombies do
    local zombie = zombies[i]
    zombie.move(dt, pX, pY)
  end
end
