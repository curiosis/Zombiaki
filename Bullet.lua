speedBullet = 500
currentTimeOut = 500
bullets = {}

function Bullet (_sprite)
  local self = {
    sprite = _sprite,
    isVisible = true,
    shotSound = love.audio.newSource("Audio/Shot.mp3", "static")
  }

  -- init position
  function self.initPosition(sprite, isZombie)
    self.sprite.x = sprite.x
    self.sprite.y = sprite.y

    -- if player shots
    local mX = love.mouse.getX() + camera.x
    local mY = love.mouse.getY() + camera.y

    -- if zombie shots
    if isZombie then
      mX = player.x
      mY = player.y
      self.speed = 350
    end

    self.dir = math.atan2(mY - sprite.y, mX - sprite.x)

    self.x = mX - sprite.x
    self.y = mY - sprite.y
  end

  -- movement
  function self.move(dt)
    local dx = speedBullet * dt
    local dy = speedBullet * dt

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

  -- sound effects
  function self.playSoundEffectShot()
    self.shotSound:setVolume(0.3)
    self.shotSound:play()
  end
  return self
end

function shot(dt)
  local timeOut = (love.timer.getTime() - lastShotTime) * 1000
  if love.mouse.isDown(1) and timeOut >= currentTimeOut then
    Bullet().playSoundEffectShot()
    local bulletSprite = Sprite(bulletImg)
    local bullet = Bullet(bulletSprite)
    bullet.initPosition(player)
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
  for i, boss in ipairs(bosses) do
    for j = 1, #bullets do
      local bullet = bullets[j]
      if isHit(bullet.sprite, boss.sprite, false, true) then
        bullet.isVisible = false
        boss.getDamage(bosses, i, player.damage)
        break
      end
    end
  end
  for j, bullet in ipairs(bullets) do
    if not bullet.isVisible or bulletIsOut(bullet) then
      table.remove(bullets, j)
    end
  end
end

function isHit(bullet, sprite, isZombieShoot, isBossGetShot)
  local hitbox = 8
  if not isZombieShoot then hitbox = 10 end
  if isBossGetShot then hitbox = 20 end
  return math.abs(bullet.x - sprite.x) < 5 * hitbox
  and math.abs(bullet.y - sprite.y) < 5 * hitbox
end

function bulletIsOut(bullet)
  local b = bullet.sprite
  return b.x > getWidthMap() or
  b.x < 0 or
  b.y > getHeightMap() or
  b.y < 0
end

function addSpeedBullet()
  speedBullet = speedBullet + 25
  currentTimeOut = currentTimeOut - 50
end
