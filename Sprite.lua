function Sprite (_image)
  local self = {
    x = 0,
    y = 0,
    image = _image,
    width = _image:getWidth(),
    height = _image:getHeight()
  }
  return self
end
