wasBossSpawn = false
currentWave = 0

function Wave()
  local self = {}

  function self.start()
    if mA then
      MAX_WAVES = 999999
    else
      MAX_WAVES = 15
    end
    if currentWave < MAX_WAVES then
      if #zombies == 0 and #bosses == 0 then
        currentWave = currentWave + 1
        changeMap(currentWave)
        self.newWave()
      end
    elseif not wasBossSpawn and #zombies == 0 and #bosses == 0 then
      self.spawnBoss()
    end
  end

  function self.newWave()
    -- count, img, speed, HP, distance, money
    local w = currentWave
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
      strongZombieImg,
      80,
      calcHP(200, w),
      200,
      4 + w)

    -- STRONGER
    -- spawn stronger zombies but farther
    if w >= 5 then
      spawnZombies(
      w,
      strongZombieImg,
      80,
      calcHP(200, w),
      calcDist(2000, w),
      9 + w)
    end

    -- FASTER
    -- spawn faster zombies
    spawnZombies(
      w - 5,
      fastZombieImg,
      calcSpeed(180, w, 50),
      100,
      calcDist(1200, w),
      9 + w)

    -- SHOOTING
    spawnZombies(
      math.floor(w / 2),
      shootZombieImg,
      calcSpeed(60, w, 50),
      200,
      calcDist(300, w),
      19 + w,
      true)
  end

  function self.spawnBoss()
    BOSS_HP = 10000
    wasBossSpawn = true
    spawnBoss(bossImage, 100, BOSS_HP, 200, getWidthMap() / 2, getHeightMap() + 200)

    -- STRONGER
    spawnZombies(10,
      strongZombieImg,
      150, 300, 200, 25)

    spawnZombies(15,
      strongZombieImg,
      150, 300, 2000, 25)

    spawnZombies(20,
      strongZombieImg,
      150, 300, 5000, 25)

    -- FASTER
    spawnZombies(10,
      fastZombieImg,
      250, 200, 500, 25)

    spawnZombies(10,
      fastZombieImg,
      250, 200, 2500, 25)

    spawnZombies(15,
      fastZombieImg,
      250, 200, 5000, 25)

    -- SHOOTING
    spawnZombies(5,
      shootZombieImg,
      150, 200, 500, 25, true)

    spawnZombies(7,
      shootZombieImg,
      150, 200, 2500, 25, true)

    spawnZombies(10,
      shootZombieImg,
      150, 200, 4000, 25, true)
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

function changeMap()
  if currentWave >= 6 then map = loadMap("Map/map2") m1 = false m2 = true end
  if currentWave >= 11 then map = loadMap("Map/map3") m2 = false m3 = true end
end
