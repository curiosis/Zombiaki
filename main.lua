require "mainMenu"
require "TiledMap"
require "Sprite"
require "Zombie"
require "Shop"

local lg = love.graphics
local shop
local shop2
local coin
monets = 0

function love.load()
    menuLoad()
    startLoad()

  shop = lg.newImage('Sprites/shop.png')
  shop2 = lg.newImage('Sprites/shop2.png')
  coin = lg.newImage('Sprites/coin.png')
  lg.setNewFont(28)
end

function love.update(dt)
  if start then
    startUpdate(dt)
  end

  Shop().keys()
end

function love.draw()
  if start then
    startDraw()
    lg.draw(shop2, 320, 550)
    lg.draw(coin, 1210,12)
    love.graphics.print(monets,1150,20)
    lg.print(monets,1150,20)

    if(shop_open) then
      love.graphics.draw(shop,0,0)
      lg.draw(shop,0,0)
    else
      love.graphics.draw(shop,1500,0)
      lg.draw(shop,1500,0)
    end
  else
    menuDraw()
  end

end
