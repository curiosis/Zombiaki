function Zombie(sprite)
  local self = {
    _sprite = sprite,
    _speed = 10,
  }

  -- movement
  function self.move(dt, pX, pY)
    local nexX = 0
    local newY = 0
    -- horizontal movement
    if self._sprite.x <= pX then
      newX = self._sprite.x + (self._speed * dt)
    else
      newX = self._sprite.x - (self._speed * dt)
    -- vertical movement
    if self._sprite.y <= pY then
      newX = self._sprite.y + (self._speed * dt)
    else
      newX = self._sprite.y - (self._speed * dt)

    self._sprite.x = newX
    self._sprite.y = newY
  end

  -- init position
  function self.initPosition(x, y)
    self._sprite.x = x
    self._sprite.y = y
  end

  return self
end
