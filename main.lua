local lg = love.graphics

local player
local playerX
local playerY
local speed = 300
local open_shop = false

local background
local background_quad
local shop
local shop2
local coin
local monets = 0

local windowMode

local screenResW = 1280
local screenResH = 720
local playerRot
function love.load()
  player = lg.newImage('Sprites/Player.png')
  background = lg.newImage('Sprites/Background.png')
  background:setWrap("repeat", "repeat")
  background_quad = lg.newQuad(0, 0, screenResW, screenResH, background:getWidth(), background:getHeight())
  shop = love.graphics.newImage('Sprites/shop.png')

  shop2 = lg.newImage('Sprites/shop2.png')
  coin = lg.newImage('Sprites/coin.png')
  love.graphics.setNewFont(28)

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

  if love.keyboard.isDown('q') then
    shop_open = true
  else
    shop_open = false
  end

if love.keyboard.isDown('r') then
  function love.keypressed(key)
     if key == "r" then
        monets = monets + 100
     end
  end
end

if love.keyboard.isDown('1') then
  function love.keyreleased(key)
   if key == "1" and monets >= 200 then
      monets = monets - 200
   end
  end
end

if love.keyboard.isDown('2') then
  function love.keyreleased(key)
   if key == "2" and monets >= 250 then
      monets = monets - 250
   end
  end
end

if love.keyboard.isDown('3') then
  function love.keyreleased(key)
   if key == "3" and monets >= 300 then
      monets = monets - 300
   end
  end
end

if love.keyboard.isDown('4') then
  function love.keyreleased(key)
   if key == "4" and monets >= 250 then
      monets = monets - 250
   end
  end
end

end

function love.draw()
  lg.draw(background, background_quad, 0, 0)
  lg.draw(player, playerX, playerY, playerRot, 1, 1, player:getWidth() / 2, player:getHeight() / 2)
  lg.draw(shop2, 320, 550)
  lg.draw(coin, 1210,12)
  love.graphics.print(monets,1150,20)

  if(shop_open) then
    love.graphics.draw(shop,0,0)
  else
    love.graphics.draw(shop,1500,0)
  end

  --Zużycie RAM
  local stats = love.graphics.getStats(10)
  local str = string.format("Estimated amount of texture memory used: %.2f MB", stats.texturememory / 1024 / 1024)
  love.graphics.print(str, 10, 10)
end
