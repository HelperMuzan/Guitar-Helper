Function DisplayScrollingImage (x, y, index, image&)
    _PutImage ((x - 25) + (34 * index), y - 8), image&, , (0, 0)-(447 - (34 * index), 120)
    _PutImage (x + 7, y - 9), image&, , (447 - (34 * index), 0)-(447, 120)
    DisplayScrollingImage = 1
End Function

