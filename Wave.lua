function Wave()
  local self = {
    currentWave = 1
  }

  function self.start()
    if self.currentWave <= MAX_WAVES then
      if #zombies == 0 then
        self.newWave()
      end
    end
  end

  function self.newWave()
    self.currentWave = self.currentWave + 1
    print("wave: " .. self.currentWave)
    spawnZombies(3, zombieImg, 100, 100, 0)
  end

  return self
end
