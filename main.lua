require "Health"
require "Sprite"
require "Zombie"
require "Injure"
require "Bullet"

local lg = love.graphics

local player
local playerX
local playerY
local speed = 300
local maxHealth = 10

local background
local background_quad

local windowMode

local screenResW = 1280
local screenResH = 720
local playerRot
local injure

bullets = {}
zombies = {}
currentHealth = maxHealth
health = Health()

function love.load()
  player = lg.newImage('Sprites/Player.png')
  background = lg.newImage('Sprites/Background.png')
  background:setWrap("repeat", "repeat")
  background_quad = lg.newQuad(0, 0, screenResW, screenResH, background:getWidth(), background:getHeight())
  playerX = lg.getWidth() / 2
  playerY = lg.getHeight() / 2
  playerRot = math.atan2((love.mouse.getY() - playerY), (love.mouse.getX() - playerX))
  lg.setNewFont(20)
  zombieImg = lg.newImage('Sprites/Zombie.png')
  list = {{50, 50}, {1000, 50}, {10, 400}, {1000, 800}, {100, 50}, {1000, 250}, {600, 400}, {800, 800}, {700, 400}, {800, 400}}
  for i = 1, 1 do
    local zombieSprite = Sprite(zombieImg)
    local zombie = Zombie(zombieSprite)
    zombie.initPosition(list[i][1], list[i][2])
    table.insert(zombies, zombie)
  end

  bulletImg = lg.newImage('Sprites/Bullet.jpg')

  windowMode = love.window.setMode(screenResW, screenResH)
end

function love.update(dt)
  moveZombie(dt, playerX, playerY)
  injure = Injure(player, playerX, playerY)
  injure.touchZombie()
  print(currentHealth)
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

  if love.keyboard.isDown("space") then
    local bulletSprite = Sprite(bulletImg)
    local bullet = Bullet(bulletSprite)
    bullet.initPosition(playerX, playerY)
    table.insert(bullets, bullet)
  end

  for i = 1, #bullets do
    bullets[i].move(dt)
  end
end

function love.draw()
  lg.draw(background, background_quad, 0, 0)
  lg.draw(player, playerX, playerY, playerRot, 1, 1, player:getWidth() / 2, player:getHeight() / 2)

  for i = 1, #zombies do
    local zombie = zombies[i].sprite
    local rotate = zombies[i].rotate(playerX, playerY)
    lg.draw(
      zombie.image, zombie.x, zombie.y, rotate, 1, 1,
      zombie.width / 2, zombie.height / 2)
  end

  for i = 1, #bullets do
    local bullet = bullets[i]
    lg.draw(bullet.sprite.image, bullet.sprite.x, bullet.sprite.y)
  end

  health.drawHearts()
  local stats = lg.getStats(10)
  local str = string.format("Estimated amount of texture memory used: %.2f MB", stats.texturememory / 1024 / 1024)
  lg.print(str, 10, 10)
end

function moveZombie(dt, pX, pY)
  for i = 1, #zombies do
    local zombie = zombies[i]
    local t = copyTable(zombies, i)
    zombie.move(dt, pX, pY, t)
  end
end

function copyTable(old, n)
  local t = {}
  for i = 1, #old do
    if i ~= n then
      table.insert(t, old[i])
    end
  end
  return t
end
