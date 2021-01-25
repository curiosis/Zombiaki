function Zombie(_sprite, _speed, _HP, _money)
  local self = {
    sprite = _sprite,
    speed = _speed,
    HP = _HP,
    money = _money,
    deathSound = love.audio.newSource("Audio/Zombie-death.mp3", "static"),
    hitSound = love.audio.newSource("Audio/Zombie-hit.mp3", "static")
  }

  -- init position
  function self.initPosition(x, y)
    self.sprite.x = x
    self.sprite.y = y
  end

  -- movement
  function self.move(dt, zombies)
    local newX = 0
    local newY = 0
    -- horizontal movement
    if self.sprite.x <= player.x then
      newX = self.sprite.x + (self.speed * dt)
    else
      newX = self.sprite.x - (self.speed * dt)
    end

    -- vertical movement
    if math.abs(self.sprite.x - player.x) < 400 then
      if self.sprite.y <= player.y then
        newY = self.sprite.y + (self.speed * dt)
      else
        newY = self.sprite.y - (self.speed * dt)
      end
    else
      newY = self.sprite.y
    end

    self.sprite.x = newX
    self.sprite.y = newY
  end

  -- init position
  function self.rotate()
    return math.atan2((player.y - self.sprite.y), (player.x - self.sprite.x))
  end

  -- get damage
  function self.getDamage(zombies, i, damage)
    self.HP = self.HP - damage
    if(self.HP <= 0) then
      table.remove(zombies, i)
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

function moveZombie(dt)
  for i = 1, #zombies do
    local zombie = zombies[i]
    local t = copyTable(zombies, i)
    zombie.move(dt, t)
  end
end

function copyTable(old, n)
  local t = {}
  for i = 1, #old do
    if i ~= n then
      table.insert(t, old[i])
    end
  end
  return t
end

-- spawn zombies
function spawnZombies(count, image, speed, HP, distance, money)
  for i = 1, count do
      local zombieSprite = Sprite(image)
      local zombie = Zombie(zombieSprite, speed, HP, money)
      local position = randomPosition(distance)
      zombie.initPosition(position.x, position.y)
      table.insert(zombies, zombie)
  end
end

-- generate random position
function randomPosition(d)
  local self = { x, y }
  local width = getWidthMap()
  local r = love.math.random(0, 100) >= 50
  if r then
    self.x = love.math.random(width + 100 + d, width + 500 + d)
  else
    self.x = love.math.random(-500 - d, -100 - d)
  end
    self.y = love.math.random(-400, getHeightMap() - 400)
  return self
end
