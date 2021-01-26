bosses = {}

function Boss(_sprite, _speed, _HP, _money)
  local self = {
    sprite = _sprite,
    speed = _speed,
    HP = _HP,
    money = _money,
    lastHitTime = 0,
    deathSound = love.audio.newSource("Audio/Zombie-death.mp3", "static"),
    hitSound = love.audio.newSource("Audio/Zombie-hit.mp3", "static")
  }

  -- init position
  function self.initPosition(x, y)
    self.sprite.x = x
    self.sprite.y = y
  end

  -- movement
  function self.move(dt)
    local newX = 0
    local newY = 0

    local speed = self.speed

    if self.canRun() then
      speed = self.speed * 2
    end

    -- horizontal movement
    if self.sprite.x <= player.x then
      newX = self.sprite.x + (speed * dt)
    else
      newX = self.sprite.x - (speed * dt)
    end

    -- vertical movement
    if math.abs(self.sprite.x - player.x) < 600 then
      if self.sprite.y <= player.y then
        newY = self.sprite.y + (speed * dt)
      else
        newY = self.sprite.y - (speed * dt)
      end
    else
      newY = self.sprite.y
    end

    if not self.isClose() then
      self.sprite.x = newX
      self.sprite.y = newY
    end
  end

  function self.isClose()
    return math.abs(player.x - self.sprite.x) < 50
    and math.abs(player.y - self.sprite.y) < 50
  end

  function self.canRun()
    return math.abs(player.x - self.sprite.x) < 300
    and math.abs(player.y - self.sprite.y) < 300
  end

  -- rotate
  function self.rotate()
    return math.atan2((player.y - self.sprite.y), (player.x - self.sprite.x))
  end

  -- get damage
  function self.getDamage(bosses, i, damage)
    self.HP = self.HP - damage
    if(self.HP <= 0) then
      table.remove(bosses, i)
      Shop().addMonets(self.money)
      self.playSoundEffectDeath()
      kills = kills + 1
    else
      self.playSoundEffectHit()
    end
  end

  -- sound effects
  function self.playSoundEffectDeath()
    self.deathSound:setVolume(0.2)
    self.deathSound:play()
  end
  function self.playSoundEffectHit()
    self.hitSound:setVolume(0.25)
    self.hitSound:play()
  end

  return self
end

function moveBoss(dt)
  for i = 1, #bosses do
    local boss = bosses[i]
    local t = copyTable(bosses, i)
    boss.move(dt)
  end
end

-- spawn boss
function spawnBoss(image, speed, HP, money, x, y)
  local bossSprite = Sprite(image)
  local boss = Boss(bossSprite, speed, HP, money)
  boss.initPosition(x, y)
  table.insert(bosses, boss)
end
