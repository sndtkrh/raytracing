
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

let color_convertor decrese_rate color =
  { cr = color.cr *. decrese_rate.cr;
    cg = color.cg *. decrese_rate.cg;
    cb = color.cb *. decrese_rate.cb }
