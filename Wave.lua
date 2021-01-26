MAX_WAVES = 2
wasBossSpawn = false

function Wave()
  local self = {
    currentWave = 0
  }

  function self.start()
    if self.currentWave < MAX_WAVES then
      if #zombies == 0 and #bosses == 0 then
        self.currentWave = self.currentWave + 1
        self.newWave()
      end
    elseif not wasBossSpawn and #zombies == 0 and #bosses == 0 then
      self.spawnBoss()
    end
  end

  function self.newWave()
    -- count, img, speed, HP, distance, money
    local w = self.currentWave
    -- DEFAULT
    -- spawn default zombies
    spawnZombies(
      w + 3,                  -- count
      defaultZombieImg,       -- img
      calcSpeed(100, w, 50),  -- speed
      calcHP(100, w),         -- HP
      100,                    -- distance
      4 + w)                  -- money

    -- spawn default zombies but farther
    local far = 1000
    if w > 4 then far = 3000 end
    spawnZombies(
      w + 1,
      defaultZombieImg,
      calcSpeed(100, w, 20),
      calcHP(100, w),
      calcDist(far, w),
      4 + w)

    -- spawn default zombies buuuut farther
    if w >= 5 then
      spawnZombies(
      w,
      defaultZombieImg,
      calcSpeed(100, w, 100),
      calcHP(100, w),
      calcDist(5000, w),
      4 + w)
    end

    -- STRONGER
    -- spawn stronger zombies
    spawnZombies(
      w - 3,
      defaultZombieImg,
      80,
      calcHP(200, w),
      200,
      4 + w)

    -- STRONGER
    -- spawn stronger zombies but farther
    if w >= 5 then
      spawnZombies(
      w,
      defaultZombieImg,
      80,
      calcHP(200, w),
      calcDist(2000, w),
      9 + w)
    end

    -- FASTER
    -- spawn faster zombies
    spawnZombies(
      w - 5,
      defaultZombieImg,
      calcSpeed(180, w, 50),
      100,
      calcDist(1200, w),
      9 + w)

    -- SHOOTING
    spawnZombies(
      math.floor(w / 2),
      defaultZombieImg,
      calcSpeed(60, w, 50),
      200,
      calcDist(300, w),
      19 + w,
      true)

  end

  function self.spawnBoss()
    BOSS_HP = 2000
    wasBossSpawn = true
    spawnBoss(bossImage, 100, BOSS_HP, 200, getWidthMap() / 2, 0)
  end
  return self
end

function calcSpeed(n, w, m)
  return n * (1 + (w - 1) / m)
end

function calcDist(d, w)
  return d + w * 50
end

function calcHP(hp, w)
  if w > 5 then
    return hp * (1 + w / 10)
  else
    return hp
  end
end
