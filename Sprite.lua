function Sprite (_image)
  local self = {
    x = 0,
    y = 0,
    image = _image,
    width = _image.getWidth,
    height = _image.getHeight
  }

  -- check if this sprite is colliding with other sprite
  function self.isCollided(sprite)
    return sprite.x < self.x + self.width
    and sprite.x + sprite.width > self.x
    and sprite.y < self.y + self.height
    and sprite.y + sprite.height > self.y
  end
  return self
end
