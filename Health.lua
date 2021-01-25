function Health()
  local self = {
    current = currentHealth,
    heart = love.graphics.newImage('Sprites/Heart.png'),
    loseLifeSoundEffect = love.audio.newSource("Audio/Sigh.mp3", "static")
  }

  function self.drawHearts()
    for i=1, self.current do
      local x = 20 + 80 * (i-1)
      love.graphics.draw(self.heart, x, 20)
    end
  end

  function self.playSoundEffect()
    self.loseLifeSoundEffect:setVolume(0.1)
    self.loseLifeSoundEffect:play()
  end

  function self.loseLife(amount)
    if self.current - amount > 0 then
      self.playSoundEffect()
      self.current = self.current - amount
    else
      self.current = 0
      self.die()
    end

    function self.addLife()
      if self.current < 3 then
        self.current = self.current + 1
      end
    end

    return self.current
  end

  function self.die()
    isAlive = false
    print("Player died")
  end

  return self
end
