require "Health"
require "Player"

local K = love.keyboard

function Shop()
  local self = {
    open_shop = false,
    healthSoundEffect = love.audio.newSource("Audio/HealthPotion.mp3", "static"),
    speedSoundEffect = love.audio.newSource("Audio/SpeedPotion.mp3", "static"),
    strengthSoundEffect = love.audio.newSource("Audio/StrengthPotion.mp3", "static"),
    sniperSoundEffect = love.audio.newSource("Audio/SniperPotion.mp3", "static"),
    noCoinsSoundEffect = love.audio.newSource("Audio/NoCoins.mp3", "static"),
  }

  function self.addMonets(money)
    monets = monets + money
  end

  function self.notEnoughCoins()
    alert = "Not enough coins"
    self.noCoinsSoundEffect:play()
  end

  function self.keys()
    if K.isDown('q') then
      shop_open = true
    else
      shop_open = false
    end

    if K.isDown('1') then
      function love.keyreleased(key)
        if key == "1" and monets >= 250 and health.current < maxHealth then
          self.healthSoundEffect:play()
          health.addLife()
          monets = monets - 250
          alert = "+1 health"
        elseif key == "1" and health.current >= maxHealth then
          alert = "You have too much HP"
        elseif key == "1" and monets < 250 then
          self.notEnoughCoins()
        end
      end
    end

    if K.isDown('2') then
      function love.keyreleased(key)
        if key == "2" and monets >= 250 and player.speed < 350 then
          self.speedSoundEffect:play()
          player:addMove()
          monets = monets - 250
          alert = "+10 speed"
        elseif key == "2" and player.speed == 350 then
          alert = "Your speed is maximum"
        elseif key == "2" and monets < 250 then
          self.notEnoughCoins()
        end
      end
    end

    if K.isDown('3') then
      function love.keyreleased(key)
        if key == "3" and monets >= 300 and player.damage < 200 then
          self.strengthSoundEffect:play()
          player:addDamage()
          monets = monets - 300
          alert = "+20 damage"
        elseif key == "3" and player.damage == 200 then
          alert = "Your damage is maximum"
        elseif key == "3" and monets < 300 then
          self.notEnoughCoins()
        end
      end
    end

    if K.isDown('4') then
      function love.keyreleased(key)
        if key == "4" and monets >= 300 and speedBullet < 600 then
          self.speedSoundEffect:play()
          addSpeedBullet()
          monets = monets - 300
          alert = "+25 speed bullet"
        elseif key == "4" and speedBullet == 600 then
          alert = "Your speed bullet is maximum"
        elseif key == "4" and monets < 300 then
          self.notEnoughCoins()
        end
      end
    end

  end
  return self

end
