require "Sprite"
require "Zombie"
require "Shop"

local lg = love.graphics

local lastAlertTime = 0
isAlive = true
isWinner = false
monets = 0
alert = ""
local waveString = "Wave: "
local killsString = "Kills: "
local zombiesString = "Zombies: "

local shop
local shop2
local coin

function UIDraw()
  health.drawHearts()
  lg.draw(shop2, 320, 550)
  lg.draw(coin, 1210, 12)
  lg.setNewFont(28)
  lg.print(monets, 1150, 20)
  lg.print(alert, 10, 500)
  lg.print(zombiesString .. #zombies, 900, 20)
  lg.setNewFont(40)
  lg.print(waveString .. wave.currentWave, 1000, 650)
  lg.print(killsString .. kills, 50, 650)

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
      currentHealth = maxHealth
      health = Health()
      startLoad()
      isAlive = true
    end
  end
end

function UILoad()
  shop = lg.newImage('Sprites/shop.png')
  shop2 = lg.newImage('Sprites/shop2.png')
  coin = lg.newImage('Sprites/coin.png')
  lg.setNewFont(28)
end
