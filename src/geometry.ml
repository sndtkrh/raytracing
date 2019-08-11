
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

let zero_vec = {px = 0.0; py = 0.0; pz = 0.0}

let v_plus u v =
  {px = u.px +. v.px;
   py = u.py +. v.py;
   pz = u.pz +. v.pz}

let v_minus u v =
  {px = u.px -. v.px;
   py = u.py -. v.py;
   pz = u.pz -. v.pz}
     
let distance p0 p1 =
  let dx = p0.px -. p1.px in
  let dy = p0.py -. p1.py in
  let dz = p0.pz -. p1.pz in
  sqrt ((dx *. dx) +. (dy *. dy) +. (dz *. dz))

let inner_product u v =
  u.px *. v.px +. u.py *. v.py +. u.pz *. v.pz

let stretch a v =
  {px = a *. v.px;
   py = a *. v.py;
   pz = a *. v.pz}

let get_point_on_line l a =
  v_plus l.l_pt (stretch a l.l_dir)

let point_line_foot_of_perpendicular p l =
  let a = (inner_product l.l_dir (v_minus p l.l_pt)) /. (inner_product l.l_dir l.l_dir) in
  get_point_on_line l a

let normalize v =
  let a = distance zero_vec v in
  stretch (1.0 /. a) v

let normalize_line l =
  {l_pt = l.l_pt;
   l_dir = normalize l.l_dir}
  
(* surface represented by normal vector reflect ray *)
let reflect_on_surface ray n =
  let a = (inner_product (v_minus ray.l_pt n.l_pt) n) / (inner_product ray.l_dir n) in
  let reflection_pt = get_point_on_line ray a in
  let m = {l_pt = reflection_pt, l_dir = n.l_dir} in (* normal vector equivalent to n *)
  let mid_pt = point_line_foot_of_perpendicular ray.l_pt m in
  let opposit_pt = get_point_on_line
                     {l_pt = ray.l_pt; l_dir = v_minus mid_pt ray.l_pt}
                     2.0 in
  {l_pt = reflection_pt;
   l_dir = v_minus opposit_pt reflection_pt}

