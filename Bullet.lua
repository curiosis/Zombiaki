function Bullet (_sprite)
  local self = {
    sprite = _sprite,
    speed = 200,
    dir
  }

  -- init position
  function self.initPosition(pX, pY)
    self.sprite.x = pX
    self.sprite.y = pY

    self.dir = -math.atan2(self.sprite.y - love.mouse.getY(),
                     self.sprite.x- love.mouse.getX())
  end

  -- movement
  function self.move(dt)


    local dx = self.speed * dt * math.cos(self.dir)
    local dy = self.speed * dt * math.sin(self.dir)

    self.sprite.x = self.sprite.x + dx
    self.sprite.y = self.sprite.y + dy
    -- self.sprite.y = self.sprite.y - self.speed * dt
  end

  return self
end
