from PIL import Image


im = Image.open('f0013.jpg')
width, height = im.size

print(width,height)