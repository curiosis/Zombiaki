require "Sprite"
require "Zombie"
require "Shop"

local G = love.graphics
local T = love.timer
local K = love.keyboard

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
local dark

function UIDraw(hiden)
  G.draw(dark,0,0)
  if not hiden then
    health.drawHearts()
    G.draw(shop2, 320, 550)
    G.draw(coin, 1210, 12)
    G.setNewFont(28)
    G.print(monets, 1150, 20)
    G.print(alert, 10, 500)
    G.print(zombiesString .. #zombies, 900, 20)
    G.setNewFont(40)
    G.print(waveString .. wave.currentWave, 1000, 650)
    G.print(killsString .. kills, 50, 650)
  end

  alertResult = (T.getTime() - lastAlertTime) * 1000
  if alertResult >= 2000 then
    lastAlertTime = T.getTime()
    alert = ""
  end

  if(shop_open) then
    G.draw(shop,0,0)
  else
    G.draw(shop,1500,0)
  end

  if not isAlive and not isWinner then
    gameOverDraw()
    if K.isDown('space') then
      currentHealth = maxHealth
      health = Health()
      startLoad()
      isAlive = true
    end
  end
end

function UILoad()
  shop = G.newImage('Sprites/shop.png')
  shop2 = G.newImage('Sprites/shop2.png')
  coin = G.newImage('Sprites/coin.png')
  dark = G.newImage('Map/Darker.png')
  G.setNewFont(28)
end
