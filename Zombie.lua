function Zombie(_sprite)
  local self = {
    sprite = _sprite,
    speed = 100,
    hp = 100
  }

  -- init position
  function self.initPosition(x, y)
    self.sprite.x = x
    self.sprite.y = y
  end

  -- movement
  function self.move(dt, pX, pY, zombies)
    local nexX = 0
    local newY = 0
    -- horizontal movement
    if self.sprite.x <= pX then
      newX = self.sprite.x + (self.speed * dt)
    else
      newX = self.sprite.x - (self.speed * dt)
    end
    -- vertical movement
    if self.sprite.y <= pY then
      newY = self.sprite.y + (self.speed * dt)
    else
      newY = self.sprite.y - (self.speed * dt)
    end

      self.sprite.x = newX
      self.sprite.y = newY
  end

  -- init position
  function self.rotate(pX, pY)
    return math.atan2((pY - self.sprite.y), (pX - self.sprite.x))
  end

  return self
end
