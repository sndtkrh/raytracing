
type raycol = {
    cr: float;
    cg: float;
    cb: float
  }

type emittingSurface = {
    e_surface: Geometry3d.surface;
    e_color: raycol
  }

type absorbingSurface = {
    a_surface: Geometry3d.surface;
    a_color: raycol
  }

type coloredSurface =
  | ES of emittingSurface
  | AS of absorbingSurface

val color_convertor : raycol -> raycol -> raycol
