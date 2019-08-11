
type t = {
    r: float;
    g: float;
    b: float
  }

type emittingSurface = {
    e_surface: Geometry.surface;
    e_color: t
  }

type absorbingSurface = {
    a_surface: Geometry.surface;
    a_color: t
  }

type coloredSurface =
  | ES of emittingSurface
  | AS of absorbingSurface

val color_convertor : t -> t -> t
