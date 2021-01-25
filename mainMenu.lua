require "TiledMap"
require "camera"
require "player"
require "Health"
require "Sprite"
require "Zombie"
require "Injure"
require "Bullet"


-- local player
local playerX
local playerY
local speed = 300
local maxHealth = 10

local background
local background_quad

local windowMode
local G = love.graphics

local screenResW = 1280
local screenResH = 720
local playerRot
local injure

bullets = {}
zombies = {}
lastShotTime = 0
currentHealth = maxHealth
health = Health()
BUTTON_HEIGHT = 56

_G.about = false
_G.start = false

local
function newButton(text, fn)
  return{
    text = text,
    fn = fn,

    now = false,
    last = false
  }
end

local buttons = {}
local font = nil
local mainMenuBackgroundAudio = nil
local buttonHoverSoundEffect = nil
local backgroundMM = nil
local aboutPanel = nil

function menuLoad()
  font = G.newFont("Fonts/Kampung_Zombie.ttf", 32)

  backgroundMM = G.newImage('Sprites/MainMenuBackground.png')
  aboutPanel = G.newImage('Sprites/AboutPanel.png')

  mainMenuBackgroundAudio = love.audio.newSource("Audio/Royalty Free Music - Zombie Apocalypse - Scary Cinematic Industrial Action Background Music.mp3","stream")
  buttonHoverSoundEffect = love.audio.newSource("Audio/buttonHover.mp3", "static")

  mainMenuBackgroundAudio:setVolume(0.3)
  buttonHoverSoundEffect:setPitch(0.35)
  buttonHoverSoundEffect:setVolume(0.4)

  mainMenuBackgroundAudio:play()

  table.insert(buttons, newButton(
    "Start Game",
    function()
      _G.map = loadMap("Map/map")
      start = true
    end))

  table.insert(buttons, newButton(
    "About",
    function()
      if about then
        about = false
      else
        about = true
      end
    end))

  table.insert(buttons, newButton(
    "Credits",
    function()
      print("Credits page")
    end))

  table.insert(buttons, newButton(
    "Quit",
    function()
      love.event.quit(0)
    end))
end

function menuDraw()

  G.draw(backgroundMM,0,0)

  local ww = love.graphics.getWidth()
  local wh = love.graphics.getHeight() + 300

  local button_width = ww * (1/3)

  local margin = 16
  local total_height = (BUTTON_HEIGHT + margin) * #buttons
  local cursor_y = 0

  for i, button in ipairs(buttons) do
    button.last = button.now

    local bx = (ww * 0.7) - (button_width * 0.5)
    local by = (wh * 0.45) - (total_height * 0.5) + cursor_y

    local color = {0.1, 0.1, 0.1, 1.0}

    local mouseXPos, mouseYPos = love.mouse.getPosition()

    local hover = mouseXPos > bx and
                  mouseXPos < bx + button_width and
                  mouseYPos > by and
                  mouseYPos < by + BUTTON_HEIGHT

    if hover then
      color = {75/255, 60/255, 60/255, 1.0}
      bx = bx - 60
    end

    button.now = love.mouse.isDown(1)
    if button.now and not button.last and hover then
      buttonHoverSoundEffect:play()
      button.fn()
    end

    love.graphics.setColor(unpack(color))
    love.graphics.rectangle("fill",bx,by,button_width, BUTTON_HEIGHT)


    love.graphics.setColor(0, 0, 0, 1)

    local textW = font:getWidth(button.text)
    local textH = font:getHeight(button.text)

    if hover then
      love.graphics.print(
        button.text,
        font,
        (ww * 0.7) - textW * 0.5 - 60,
        by + textH * 0.5
      )
    else
      love.graphics.print(
        button.text,
        font,
        (ww * 0.7) - textW * 0.5,
        by + textH * 0.5
      )
    end

    cursor_y = cursor_y + (BUTTON_HEIGHT + margin)

  end
  love.graphics.setColor(1, 1, 1, 1)
end

function aboutDraw()
  G.draw(aboutPanel, 50, 100)
end

function startLoad()
  print("start")
  zombieImg = G.newImage('Sprites/Zombie.png')
  bulletImg = G.newImage('Sprites/Bullet.jpg')
  list = {{50, 50}, {1000, 50}, {10, 400}, {1000, 800}, {100, 50}, {1000, 250}, {600, 400}, {800, 800}, {700, 400}, {800, 400}}
  for i = 1, 10 do
      local zombieSprite = Sprite(zombieImg)
      local zombie = Zombie(zombieSprite)
      zombie.initPosition(list[i][1], list[i][2])
      table.insert(zombies, zombie)
  end
end

function startDraw()
  camera:set()
  _G.map:draw()
  player:draw()

  for i = 1, #zombies do
    local zombie = zombies[i].sprite
    local rotate = zombies[i].rotate(player.x, player.y)
    G.draw(
      zombie.image, zombie.x, zombie.y, rotate, 1, 1,
      zombie.width / 2, zombie.height / 2)
  end

  for i = 1, #bullets do
    local bullet = bullets[i]
    G.draw(bullet.sprite.image, bullet.sprite.x, bullet.sprite.y)
  end

  drawFog()

  camera:unset()
end

function startUpdate(dt)
  player:update(dt)
  moveZombie(dt, player.x, player.y)
  injure = Injure(player, player.x, player.y)
  injure.touchZombie()
  shot(dt)
  shooting()
end
