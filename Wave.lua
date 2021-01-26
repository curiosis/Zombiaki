function Wave()
  local self = {
    currentWave = 0
  }

  function self.start()
    if self.currentWave < MAX_WAVES then
      if #zombies == 0 then
        self.currentWave = self.currentWave + 1
        self.newWave()
      end
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
      10)                     -- money

    -- spawn default zombies but farther
    spawnZombies(
      w + 1,
      defaultZombieImg,
      calcSpeed(100, w, 20),
      calcHP(100, w),
      calcDist(2000, w),
      10)

    -- spawn default zombies buuuut farther
    if self.currentWave >= 5 then
      spawnZombies(
      w + 5,
      defaultZombieImg,
      calcSpeed(100, w, 100),
      calcHP(100, w),
      calcDist(4000, w),
      10)
    end

    -- STRONGER
    -- spawn stronger zombies
    spawnZombies(
      w - 3,
      defaultZombieImg,
      80,
      calcHP(200, w),
      200,
      10)

    -- STRONGER
    -- spawn stronger zombies but farther
    if self.currentWave >= 5 then
      spawnZombies(
      w,
      defaultZombieImg,
      80,
      calcHP(200, w),
      calcDist(1000, w),
      10)
    end

    -- FASTER
    -- spawn faster zombies
    spawnZombies(
      w - 5,
      defaultZombieImg,
      calcSpeed(180, w, 50),
      100,
      calcDist(1200, w),
      10)

    -- SHOOTING
    spawnZombies(
      math.ceil(w / 2),
      defaultZombieImg,
      calcSpeed(60, w, 50),
      200,
      calcDist(300, w),
      20,
      true)
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
