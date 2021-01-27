require "TiledMap"
require "camera"
require "Player"
require "Health"
require "Sprite"
require "Zombie"
require "Injure"
require "Bullet"
require "Wave"
require "Boss"
require "UI"

-- local player
local playerX
local playerY
local speed = 300

local background
local background_quad

local G = love.graphics
local M = love.mouse
local E = love.event
local A = love.audio

local screenResW = 1280
local screenResH = 720
local playerRot
local injure
local cursorBlood

wave = Wave()
kills = 0
lastShotTime = 0
maxHealth = 5
currentHealth = maxHealth
health = Health()
BUTTON_HEIGHT = 56

_G.about = false
_G.start = false
_G.arena = false
_G.credits = false
_G.letterB = false

_G.map = nil
_G.m1 = false
_G.m2 = false
_G.m3 = false
_G.mA = false

local
function newButton(text, fn)
  return{
    text = text,
    fn = fn,

    now = false,
    last = false
  }
end
local letter = nil
local buttons = {}
local font = nil
local mainMenuBackgroundAudio = nil
local buttonHoverSoundEffect = nil
local backgroundMM = nil
local aboutPanel = nil
local creditsPanel = nil

function menuLoad()
  cursorBlood = love.mouse.newCursor("Sprites/cursorBlood.png", 0, 0)
  letter = G.newImage("Sprites/letter.png")
  font = G.newFont("Fonts/Kampung_Zombie.ttf", 32)

  backgroundMM = G.newImage('Sprites/MainMenuBackground.png')
  aboutPanel = G.newImage('Sprites/AboutPanel.png')
  creditsPanel = G.newImage('Sprites/CreditsPanel.png')

  mainMenuBackgroundAudio = A.newSource("Audio/Royalty Free Music - Zombie Apocalypse - Scary Cinematic Industrial Action Background Music.mp3","stream")
  buttonHoverSoundEffect = A.newSource("Audio/buttonHover.mp3", "static")

  mainMenuBackgroundAudio:setVolume(0.3)
  buttonHoverSoundEffect:setPitch(0.35)
  buttonHoverSoundEffect:setVolume(0.4)

  mainMenuBackgroundAudio:play()

  table.insert(buttons, newButton(
  "Story Mode",
  function()
    letterB = true
  end))

  table.insert(buttons, newButton(
  "Endless mode",
  function()
    mA = true
    map = loadMap("Map/mapArena")
    arena = true
  end))

  table.insert(buttons, newButton(
  "About",
  function()
    credits = false
    if about then
      about = false
    else
      about = true
    end
  end))

  table.insert(buttons, newButton(
  "Credits",
  function()
    about = false
    if credits then
      credits = false
    else
      credits = true
    end
  end))

  table.insert(buttons, newButton(
  "Quit",
  function()
    E.quit(0)
  end))
end

function menuDraw()
  love.mouse.setCursor(cursorBlood)
  G.draw(backgroundMM,0,0)

  local ww = G.getWidth()
  local wh = G.getHeight() + 300

  local button_width = ww * (1/3)

  local margin = 16
  local total_height = (BUTTON_HEIGHT + margin) * #buttons
  local cursor_y = 0

  for i, button in ipairs(buttons) do
    button.last = button.now

    local bx = (ww * 0.7) - (button_width * 0.5)
    local by = (wh * 0.45) - (total_height * 0.5) + cursor_y

    local color = {0.1, 0.1, 0.1, 1.0}

    local mouseXPos, mouseYPos = M.getPosition()

    local hover = mouseXPos > bx and
    mouseXPos < bx + button_width and
    mouseYPos > by and
    mouseYPos < by + BUTTON_HEIGHT

    if hover then
      color = {75/255, 60/255, 60/255, 1.0}
      bx = bx - 60
    end

    button.now = M.isDown(1)
    if button.now and not button.last and hover then
      buttonHoverSoundEffect:play()
      button.fn()
    end

    G.setColor(unpack(color))
    G.rectangle("fill",bx,by,button_width, BUTTON_HEIGHT)


    G.setColor(0, 0, 0, 1)

    local textW = font:getWidth(button.text)
    local textH = font:getHeight(button.text)

    if hover then
      G.print(
        button.text,
        font,
        (ww * 0.7) - textW * 0.5 - 60,
        by + textH * 0.5
      )
    else
      G.print(
        button.text,
        font,
        (ww * 0.7) - textW * 0.5,
        by + textH * 0.5
      )
    end

    cursor_y = cursor_y + (BUTTON_HEIGHT + margin)

  end
  G.setColor(1, 1, 1, 1)

end

function letterDraw()
  G.draw(letter,0,0)
end

function aboutDraw()
  G.draw(aboutPanel, 50, 100)
end

function creditsDraw()
  G.draw(creditsPanel, 50, 100)
end

function startLoad()
  print("start")
  defaultZombieImg = G.newImage('Sprites/Zombie1.png')
  fastZombieImg = G.newImage('Sprites/Zombie3.png')
  strongZombieImg = G.newImage('Sprites/Zombie2.png')
  shootZombieImg = G.newImage('Sprites/Zombie4.png')
  bossImage = G.newImage('Sprites/Zombie.png')
  bulletImg = G.newImage('Sprites/Bullet.jpg')
end

function startDraw()
  camera:set()
  _G.map:draw()
  player:draw()

  for i = 1, #zombies do
    local zombie = zombies[i].sprite
    local rotate = zombies[i].rotate()
    G.draw(
    zombie.image, zombie.x, zombie.y, rotate, 1, 1,
    zombie.width / 2, zombie.height / 2)

    if zombies[i].canShooting then
      for j = 1, #zombies[i].bullets do
        local bullet = zombies[i].bullets[j]
        G.draw(bullet.sprite.image, bullet.sprite.x, bullet.sprite.y)
      end
    end
  end

  for i = 1, #bullets do
    local bullet = bullets[i]
    G.draw(bullet.sprite.image, bullet.sprite.x, bullet.sprite.y)
  end

  for i = 1, #bosses do
    local boss = bosses[i].sprite
    local rotate = bosses[i].rotate()
    G.draw(boss.image, boss.x, boss.y, rotate, 1, 1,
    boss.width / 2, boss.height / 2)
    bosses[i].displayHP()
  end

  drawFog()
  camera:unset()
end

function gameOverDraw()
  backgroundGameOver = G.newImage('Sprites/gameover.png')
  G.draw(backgroundGameOver,0,0)
end

function startUpdate(dt)
  if(m1 or m2 or m3 or mA) then
    mainMenuBackgroundAudio:stop()
  end
  player:update(dt)
  moveZombie(dt)
  moveBoss(dt)
  injure = Injure(player, player.x, player.y)
  injure.touchZombie()
  shot(dt)
  shooting()
  wave.start()
end

function backToMainMenu()
  E.quit('restart')
end
