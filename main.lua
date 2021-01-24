require "mainMenu"
require "TiledMap"
require "Sprite"
require "Zombie"

function love.load()
    menuLoad()
    startLoad()
end

function love.update(dt)
  if start then
    startUpdate(dt)
  end
end

function love.draw()
  if start then
    startDraw()
  else
    menuDraw()
  end
end
