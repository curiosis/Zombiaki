function Wave()
  local self = {}

  function self.start()
    if currentWave <= MAX_WAVES then
      if #zombies == 0 then
        self.newWave()
      end
    end
    return
  end

  function self.newWave()

    currentWave = currentWave + 1
    spawnZombies(3, zombieImg, 100, 100, 0)
    return
  end

  return self
end
