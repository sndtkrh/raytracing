type point = {
    px: float;
    py: float;
    pz: float
  }
type line = {
    l_pt: point; (* start point *)
    l_dir: point (* direction vector *)
  }
type triangle = {
    tri_pt0: point;
    tri_pt1: point;
    tri_pt2: point
  }
type sphere = {
    s_center: point;
    s_rad: float
  }
type surface =
  | Sphere of sphere
  | Triangle of triangle

val eps : float
val zero_vec : point
val almost_equal : float -> float -> bool
val cross_product : point -> point -> point
val v_plus : point -> point -> point
val v_minus : point -> point -> point
val inner_product : point -> point -> float
val norm : point -> float
val distance : point -> point -> float
val area_of_triangle : triangle -> float
val point_in_triangle : point -> triangle -> bool
val stretch : float -> point -> point
val get_point_on_line : line -> float -> point
val point_line_foot_of_perpendicular : point -> line -> point
val normalize : point -> point
val normalize : line -> line
val reflect_on_surface : line -> line -> line
