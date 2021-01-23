function Health(currentHealth)
  local self = {
    current = currentHealth,
    heart = love.graphics.newImage('Sprites/Heart.png')
  }

  function self.drawHearts()
    for i=1,self.current do
      local x = 20 + 80 * (i-1)
      love.graphics.draw(self.heart, x, 20)
    end
  end

  function self.loseLife(amount)

    if self.current - amount > 0 then
      self.current = self.current - amount
    else
      self.current = 0
      self.die()
    end

    return self.current
  end

  function self.die()
    print("Player died")
  end

  return self
end
