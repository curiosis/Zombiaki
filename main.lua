require "mainMenu"
require "Shop"
require "UI"

local K = love.keyboard
local T = love.timer
local hiden = false

function love.load()
  menuLoad()
  startLoad()
  UILoad()
end

function love.update(dt)
  if start or arena then
    startUpdate(dt)
    if K.isDown('e') then T.sleep(0.1) if hiden==false then hiden = true elseif hiden==true then hiden=false end end
    if K.isDown('escape') then T.sleep(0.1) backToMainMenu() end
  end
  Shop().keys()
end

function love.draw()
  if start or arena then
    startDraw()
    UIDraw(hiden)
  elseif about then
    menuDraw()
    aboutDraw()
  elseif credits then
    menuDraw()
    creditsDraw()
  else
    menuDraw()
  end
end
