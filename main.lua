function love.load()
  x = 200
  y = 200
  speed = 150
end

function love.update(dt)
  if love.keyboard.isDown("right", 'd')  then
    x = x+speed*dt
  elseif love.keyboard.isDown("left",'a') then
    x = x - speed * dt
  end
  if love.keyboard.isDown("down",'s') then
    y = y+speed*dt
  elseif love.keyboard.isDown("up",'w') then
    y = y - speed * dt
  end
end

function love.draw()
  love.graphics.rectangle("fill", x, y, 20, 20)
end
