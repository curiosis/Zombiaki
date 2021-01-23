function Sprite (image)
  local self = {
    _x = x,
    _y = y,
    _image = image,
    _width = image.getWidth,
    _height = image.getHeight
  }

  -- check if this sprite is colliding with other sprite
  function self.isCollided(sprite)
    return sprite.x < self._x + self._width
    and sprite.x + sprite.width > self._x
    and sprite.y < self._y + self._height
    and sprite.y + sprite.height > self._y
  end

end
