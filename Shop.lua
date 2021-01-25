require "Health"
require "Player"

function Shop()
  local self={
    open_shop = false,
    speedBullet = 0
  }

  function self.addMonets(money)
    monets = monets + money
  end

  function self.keys()
    if love.keyboard.isDown('q') then
      shop_open = true
    else
      shop_open = false
    end

    if love.keyboard.isDown('r') then
      function love.keypressed(key)
        if key == "r" then
          monets = monets + 100
        end
      end
    end

    if love.keyboard.isDown('1') then
      function love.keyreleased(key)
        if key == "1" and monets >= 200 and health.current < 5 then
          health.addLife()
          monets = monets - 200
          alert = "+1 heart"
        elseif key == "1" and health.current >= 5 then
          alert = "You have too much HP"
        elseif key == "1" and monets < 200 then
          alert = "Not enough coins"
        end
      end
    end

    if love.keyboard.isDown('2') then
      function love.keyreleased(key)
        if key == "2" and monets >= 250 and player.speed < 350 then
          player:addMove()
          monets = monets - 250
          alert = "+10 speed"
        elseif key == "2" and player.speed == 350 then
          alert = "Your speed is maximum"
        elseif key == "2" and monets < 250 then
          alert = "Not enough coins"
        end
      end
    end

    if love.keyboard.isDown('3') then
      function love.keyreleased(key)
        if key == "3" and monets >= 300 and player.damage < 150 then
          player:addDamage()
          monets = monets - 300
          alert = "+10 damage"
        elseif key == "3" and player.damage == 150 then
          alert = "Your damage is maximum"
        elseif key == "3" and monets < 300 then
          alert = "Not enough coins"
        end
      end
    end

    if love.keyboard.isDown('4') then
      function love.keyreleased(key)
        if key == "4" and monets >= 250 and speedBullet < 600 then
          addSpeedBullet()
          monets = monets - 250
          alert = "+25 speed bullet"
        elseif key == "4" and speedBullet == 600 then
          alert = "Your speed bullet is maximum"
        elseif key == "4" and monets < 250 then
          alert = "Not enough coins"
        end
      end
    end

  end
  return self

end
