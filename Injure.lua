function Injure(_player, _playerX, _playerY)
  local self = {
    player = _player,
    playerX = _playerX,
    playerY = _playerY
  }

  -- player loses life if get injured
  function self.touchZombie()
    for i, zombie in ipairs(zombies) do
      for j = 1, #zombies do
        local zombie = zombies[j]
        if isInjured(zombie.sprite) then
          currentHealth = health.loseLife(1)
          table.remove(zombies, j)
          break
        end
      end
    end
    for i, boss in ipairs(bosses) do
      for j = 1, #bosses do
        local boss = bosses[j]
        if isInjured(boss.sprite) then
          local timeOut = (love.timer.getTime() - boss.lastHitTime) * 1000
          if timeOut >= 500 then
            currentHealth = health.loseLife(1)
            boss.lastHitTime = love.timer.getTime()
          end
          break
        end
      end
    end
  end

  -- checks if player is near zombie
  function isInjured(zombie)
    -- print("pX: "..self.playerX.." pY: "..self.playerY.." x: "..zombie.x.." y: "..zombie.y)
    return math.abs(self.playerX - zombie.x) < 5
    and math.abs(self.playerY - zombie.y) < 5
  end

  return self
end
