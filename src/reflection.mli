
type raytrace_res =
  | Collide of Raycolor.raycol
  | Diverge of Geometry3d.line
  | Absorbed  

val raytrace:
  Geometry3d.line
  -> Raycolor.coloredSurface list
  -> raytrace_res
