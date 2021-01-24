local G = love.graphics

camera = {
  x = 0,
  y = 0,
  scaleX = 1,
  scaleY = 1,
  r = 0,
  resH = 720,
  resW = 1280
}

function camera:set()
  G.push()
  G.rotate(-1 * camera.r)
  G.scale(1/camera.scaleX, 1/camera.scaleY)
  G.translate(-camera.x, -camera.y)
end

function camera:unset()
  G.pop()
end

function camera:move(dx, dy)
  self.x = self.x + dx
  self.y = self.y + dy
end

function camera:rotate(dr)
  self.r = self.r + dr
end

function camera:scale(sx, sy)
  sx = sx or 1
  self.scaleX = self.scaleX * sx
  self.scaleY = self.scaleY * sy
end

function camera:setPosition(x, y)
  self.x = x
  self.y = y
end

function camera:setScale(sx, sy)
  self.scaleX = sx
  self.scaleY = sy
end
