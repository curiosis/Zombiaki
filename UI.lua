require "Sprite"
require "Zombie"
require "Shop"

local G = love.graphics
local T = love.timer
local K = love.keyboard

local lastAlertTime = 0
local lastWaveTime = 0
isAlive = true
isWinner = false
isNewWave = false
monets = 0
alert = ""
local waveString = "Wave: "
local killsString = "Kills: "
local zombiesString = "Zombies: "
local font = G.newFont("Fonts/Kampung_Zombie.ttf", 32)

local shop
local shop2
local coin
local dark
local cursorGun

function UIDraw(hiden)
  G.draw(dark,0,0)
  love.mouse.setCursor(cursorGun)
  if not hiden then
    health.drawHearts()
    G.draw(shop2, 320, 550)
    G.draw(coin, 1210, 12)
    G.setNewFont(28)
    G.print(monets, font, 1150, 20)
    G.print(alert, font, 10, 500)
    G.print(zombiesString .. #zombies, font, 900, 20)
    G.setNewFont(40)
    G.print(waveString .. currentWave, font, 1000, 650)
    G.print(killsString .. kills, font, 50, 650)
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
  if isNewWave then
    local waveInfo = "WAVE "..currentWave
    G.setNewFont(100)
    G.print(waveInfo, font, 520,320)
    waveTime = (love.timer.getTime() - lastWaveTime) * 1000
    if waveTime >= 2000 then
      lastWaveTime = love.timer.getTime()
      waveInfo = ""
      G.print(waveInfo,520,320)
    end
  end

  if not isAlive and not isWinner then
    gameOverDraw()
    if K.isDown('space') then
      love.event.quit('restart')
    end
  end
end

function UILoad()
  shop = G.newImage('Sprites/shop.png')
  shop2 = G.newImage('Sprites/shop2.png')
  coin = G.newImage('Sprites/coin.png')
  dark = G.newImage('Map/Darker.png')
  cursorGun = love.mouse.newCursor("Sprites/cursorGun.png", 25, 25)
  G.setNewFont(28)
end
