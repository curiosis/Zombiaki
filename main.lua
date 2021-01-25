require "mainMenu"
require "TiledMap"
require "Sprite"
require "Zombie"
require "Shop"

local lg = love.graphics
local shop
local shop2
local coin
local lastAlertTime = 0
isAlive = true
isWinner = false
monets = 0
alert = ""

function love.load()
  menuLoad()
  startLoad()

  shop = lg.newImage('Sprites/shop.png')
  shop2 = lg.newImage('Sprites/shop2.png')
  coin = lg.newImage('Sprites/coin.png')
  lg.setNewFont(28)
end

function love.update(dt)
  if start then
    startUpdate(dt)
  end

  Shop().keys()
end

function love.draw()
  if start then
    startDraw()
    health.drawHearts()
    lg.draw(shop2, 320, 550)
    lg.draw(coin, 1210,12)
    lg.print(monets,1150,20)
    lg.print(alert,10,500)

    alertResult = (love.timer.getTime() - lastAlertTime) * 1000
    if alertResult >= 2000 then
      lastAlertTime = love.timer.getTime()
      alert = ""
    end

    if(shop_open) then
      lg.draw(shop,0,0)
    else
      lg.draw(shop,1500,0)
    end

    if not isAlive and not isWinner then
      gameOverDraw()
      if love.keyboard.isDown('space') then
        print("space")
        menuDraw()
        break
      end
    end

  elseif about then
    menuDraw()
    aboutDraw()
  else
    menuDraw()
  end

end
