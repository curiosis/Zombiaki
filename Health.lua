local G = love.graphics
local A = love.audio

function Health()
  local self = {
    current = currentHealth,
    heart = G.newImage('Sprites/Heart.png'),
    loseLifeSoundEffect = A.newSource("Audio/Sigh.mp3", "static")
  }

  function self.drawHearts()
    for i=1, self.current do
      local x = 20 + 80 * (i-1)
      G.draw(self.heart, x, 20)
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

    return self.current
  end

  function self.addLife()
      self.current = self.current + 1
  end

  function self.die()
    isAlive = false
  end

  return self
end
