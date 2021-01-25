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
    -- count, img, speed, HP, distance

    -- spawn default zombies
    local zombieCount = self.currentWave + 3
    spawnZombies(zombieCount, defaultZombieImg, 100, 100, 100)

    -- spawn default zombies but farther
    local zombieCount = self.currentWave - 2
    spawnZombies(zombieCount, defaultZombieImg, 100, 100, 1000)

    -- spawn stronger zombies
    local zombieCount2 = self.currentWave - 3
    spawnZombies(zombieCount2, defaultZombieImg, 80, 200, 100)

    -- spawn stronger zombies
    local zombieCount3 = self.currentWave - 5
    spawnZombies(zombieCount3, defaultZombieImg, 150, 100, 1000)
  end

  return self
end
