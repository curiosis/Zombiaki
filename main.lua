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
local lastWaveTime = 0
isAlive = true
isWinner = false
isNewWave = false
monets = 0
alert = ""
local waveString = "Wave: "
local killsString = "Kills: "
local zombiesString = "Zombies: "

function love.load()
  menuLoad()
  startLoad()

  shop = lg.newImage('Sprites/shop.png')
  shop2 = lg.newImage('Sprites/shop2.png')
  coin = lg.newImage('Sprites/coin.png')
  lg.setNewFont(28)
end

function love.update(dt)
  if start or arena then
    startUpdate(dt)
  end

  Shop().keys()
end

function love.draw()
  if start or arena then
    startDraw()
    UIDraw()
  elseif about then
    menuDraw()
    aboutDraw()
  else
    menuDraw()
  end

end

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

  if isNewWave then
    local waveInfo = "WAVE "..wave.currentWave
    lg.setNewFont('Fonts/Kampung_Zombie.ttf', 100)
    lg.print(waveInfo,520,320)
    waveTime = (love.timer.getTime() - lastWaveTime) * 1000
    if waveTime >= 2000 then
      lastWaveTime = love.timer.getTime()
      waveInfo = ""
      lg.print(waveInfo,520,320)
    end
  end

  if not isAlive and not isWinner then
    gameOverDraw()
    wave.currentWave = 0
    if love.keyboard.isDown('space') then
      currentHealth = maxHealth
      health = Health()
      startLoad()
      isAlive = true
    end
  end
end
