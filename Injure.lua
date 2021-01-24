function Injure(_player, _playerX, _playerY)
  local self = {
    player = _player,
    playerX = _playerX,
    playerY = _playerY
  }

  -- player loses life if get injured
  function self.touchZombie()
    for i = 1, #zombies do
      local zombie = zombies[i].sprite
      if isInjured(zombie) then
        currentHealth = health.loseLife(1)
        zombies[i].speed = 0
        zombie.x = 2000
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
