function Bullet (_sprite)
  local self = {
    sprite = _sprite,
    speed = 500,
    isVisible = true
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

function shot(dt)
  local timeOut = (love.timer.getTime() - lastShotTime) * 1000
  if love.mouse.isDown(1) and timeOut >= 500 then
    local bulletSprite = Sprite(bulletImg)
    local bullet = Bullet(bulletSprite)
    bullet.initPosition()
    table.insert(bullets, bullet)
    lastShotTime = love.timer.getTime()
  end

  for i = 1, #bullets do
    bullets[i].move(dt)
  end
end

function shooting()
  for i, zombie in ipairs(zombies) do
    for j = 1, #bullets do
      local bullet = bullets[j]
      if isHit(bullet.sprite, zombie.sprite) then
        bullet.isVisible = false
        zombie.getDamage(zombies, i, player.damage)
        break
      end
    end
  end
  for j, bullet in ipairs(bullets) do
    if not bullet.isVisible then
      table.remove(bullets, j)
    end
  end
end

function isHit(bullet, zombie)
  return math.abs(bullet.x - zombie.x) < 50
  and math.abs(bullet.y - zombie.y) < 50
end
