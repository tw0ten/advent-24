module D6 where

data Direction = UP | RIGHT | DOWN | LEFT

turnRight UP = RIGHT
turnRight RIGHT = DOWN
turnRight DOWN = LEFT
turnRight LEFT = UP

dirVec UP = (0, 1)
dirVec RIGHT = (1, 0)
dirVec DOWN = (0, -1)
dirVec LEFT = (-1, 0)

data Cell = GUARD Direction | WALL | EMPTY

---- ??????????????????????????????????

p1 i =
  length $
    l
      [ [ (i, j, v)
        | (j, v) <- zip [0 ..] row
        ]
      | (i, row) <- zip [0 ..] i
      ]
      []
  where
    (h, w) = (length i, length (i !! 0))
    f _ = True
    l m visited = map (map f) m
      where
        f (i, j, GUARD a) = (i, j, let (x, y) = dirVec a in o (GUARD a) (id m (i + x) (j + y)))
        f a = a
        o (GUARD a) (_, _, WALL) = GUARD (turnRight a)
        o _ _ = EMPTY
    id k i j
      | i < 0 || j < 0 || i >= h || j >= w = undefined
      | otherwise = k !! i !! j

p2 i = ()

p i = do
  print $ p1 k
  print $ p2 k
  where
    k = map (map p) $ lines i
      where
        p '^' = GUARD UP
        p '#' = WALL
        p _ = EMPTY
