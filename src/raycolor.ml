
type t = {
    r: float;
    g: float;
    b: float
  }

type emittingSurface = {
    e_surface: Geometry3d.surface;
    e_color: t
  }

type absorbingSurface = {
    a_surface: Geometry3d.surface;
    a_color: t
  }

type coloredSurface =
  | ES of emittingSurface
  | AS of absorbingSurface

let color_convertor decrese_rate color =
  { r = color.r *. decrese_rate.r;
    g = color.g *. decrese_rate.g;
    b = color.g *. decrese_rate.b }
