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
currentHealth = maxHealth
health = Health()
BUTTON_HEIGHT = 64

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

lastShotTime = 0

function menuLoad()
  font = G.newFont("Fonts/Kampung_Zombie.ttf", 32)

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
      about = true
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

  local ww = love.graphics.getWidth()
  local wh = love.graphics.getHeight() + 150

  local button_width = ww * (1/3)

  local margin = 16
  local total_height = (BUTTON_HEIGHT + margin) * #buttons
  local cursor_y = 0

  for i, button in ipairs(buttons) do
    button.last = button.now

    local bx = (ww * 0.5) - (button_width * 0.5)
    local by = (wh * 0.5) - (total_height * 0.5) + cursor_y

    local color = {0.4, 0.4, 0.4, 1.0}

    local mouseXPos, mouseYPos = love.mouse.getPosition()

    local hover = mouseXPos > bx and
                  mouseXPos < bx + button_width and
                  mouseYPos > by and
                  mouseYPos < by + BUTTON_HEIGHT

    if hover then
      color = {0.8, 0.8, 0.9, 1.0}
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

    love.graphics.print(
      button.text,
      font,
      (ww * 0.5) - textW * 0.5,
      by + textH * 0.5
    )

    cursor_y = cursor_y + (BUTTON_HEIGHT + margin)

  end
  love.graphics.setColor(1, 1, 1, 1)
end

function startLoad()
  zombieImg = G.newImage('Sprites/Zombie.png')
  list = {{-200, 0}, {-500, 0}, {-100, 100}, {-100, 300}, {-100, 500}, {2000, 150}, {1600, 400}, {1800, 800}, {1700, 300}, {1800, 400}}
  for i = 1, 10 do
      local zombieSprite = Sprite(zombieImg)
      local zombie = Zombie(zombieSprite)
      zombie.initPosition(list[i][1], list[i][2])
      table.insert(zombies, zombie)
  end

  bulletImg = G.newImage('Sprites/Bullet.jpg')
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
  health.drawHearts()
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
