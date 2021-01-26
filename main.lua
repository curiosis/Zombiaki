require "mainMenu"
require "Shop"
require "UI"

function love.load()
  menuLoad()
  startLoad()
  UILoad()

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
  elseif credits then
    menuDraw()
    creditsDraw()
  else
    menuDraw()
  end
end
