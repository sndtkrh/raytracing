type t = {
    r: float;
    g: float;
    b: float
  }

let color_convertor decrese_rate color =
  { r = color.r *. decrese_rate.r;
    g = color.g *. decrese_rate.g;
    b = color.g *. decrese_rate.b }
