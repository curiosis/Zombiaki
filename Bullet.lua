function Bullet (_sprite)
  local self = {
    sprite = _sprite,
    speed = 500,
    dir,
    x, y,
    ratio
  }

  -- init position
  function self.initPosition(pX, pY)
    self.sprite.x = pX
    self.sprite.y = pY

    local mX = love.mouse.getX()
    local mY = love.mouse.getY()

    self.dir = math.atan2(mY - pY, mX - pX)

    self.x = mX - pX
    self.y = mY - pY

  end

  -- movement
  function self.move(dt)
    -- local dx = self.speed * dt * math.cos(self.dir)
    -- local dy = self.speed * dt * math.sin(self.dir)

    local dx = self.speed * dt
    local dy = self.speed * dt

    if math.abs(self.x) > math.abs(self.y) then
      dy = dy * math.abs(self.y/self.x)
    else
      dx = dx * math.abs(self.x/self.y)
    end

    local dirX = 1
    local dirY = 1

    if self.x < 0 then
      dirX = -1
    end

    if self.y < 0 then
      dirY = -1
    end

    self.sprite.x = self.sprite.x + dx * dirX
    self.sprite.y = self.sprite.y + dy * dirY
    -- self.sprite.y = self.sprite.y - self.speed * dt
  end

  return self
end

function show()
  if love.keyboard.isDown('p') then
    print("----------------------------------")
    print("px: " .. player.x .. " py: " .. player.y)
    print("mx: " .. love.mouse.getX() .. " my: " .. love.mouse.getY())
    print("x:  " .. love.mouse.getX() - player.x .. " y:  " .. love.mouse.getY() - player.y)
  end
end
