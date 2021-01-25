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

-- DEFAULT
    -- spawn default zombies
--     local zombieCount = self.currentWave + 3
--     spawnZombies(zombieCount, defaultZombieImg, 100, 100, 100, 10)
--
--     -- spawn default zombies but farther
--     spawnZombies(zombieCount - 2, defaultZombieImg, 100, 100, 1000, 10)
--
--     -- spawn default zombies buuuut farther
--     if self.currentWave >= 5 then
--       spawnZombies(zombieCount + 2, defaultZombieImg, 100, 100, 3000, 10)
--     end
--
-- -- STRONGER
--     -- spawn stronger zombies
--     spawnZombies(zombieCount - 6, defaultZombieImg, 80, 200, 100, 10)
--
-- -- FASTER
--     -- spawn faster zombies
--     spawnZombies(zombieCount - 8, defaultZombieImg, 180, 100, 1000, 10)

-- SHOOTING
    spawnZombies(10, defaultZombieImg, 80, 200, 100, 10, true)
  end

  return self
end
