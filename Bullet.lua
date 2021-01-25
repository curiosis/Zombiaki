function Bullet (_sprite)
  local self = {
    sprite = _sprite,
    speed = 500,
    dir,
    x, y,
    ratio
  }

  -- init position
  function self.initPosition()
    self.sprite.x = player.x
    self.sprite.y = player.y

    local mX = love.mouse.getX() + camera.x
    local mY = love.mouse.getY() + camera.y

    self.dir = math.atan2(mY - player.y, mX - player.x)

    self.x = mX - player.x
    self.y = mY - player.y

  end

  -- movement
  function self.move(dt)
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
  end

  return self
end
