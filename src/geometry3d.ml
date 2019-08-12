
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

let eps = 1e-8
let zero_vec = {px = 0.0; py = 0.0; pz = 0.0}

let almost_equal a b = (abs_float (a -. b)) < eps

let cross_product u v =
  {px = u.py *. v.pz -. u.pz *. v.py;
   py = u.pz *. v.px -. u.px *. v.pz;
   pz = u.px *. v.py -. u.py *. v.px}

let v_plus u v =
  {px = u.px +. v.px;
   py = u.py +. v.py;
   pz = u.pz +. v.pz}

let v_minus u v =
  {px = u.px -. v.px;
   py = u.py -. v.py;
   pz = u.pz -. v.pz}

let inner_product u v =
  u.px *. v.px +. u.py *. v.py +. u.pz *. v.pz

let norm v = sqrt (inner_product v v)

let distance p0 p1 = norm (v_minus p1 p0)

let area_of_triangle tri =
  norm (cross_product (v_minus tri.tri_pt1 tri.tri_pt0) (v_minus tri.tri_pt2 tri.tri_pt0))

let point_in_triangle pt tri =
  let s = area_of_triangle tri in
  let s0 = area_of_triangle {
               tri_pt0 = pt;
               tri_pt1 = tri.tri_pt1;
               tri_pt2 = tri.tri_pt2} in
  let s1 = area_of_triangle {
               tri_pt0 = tri.tri_pt0;
               tri_pt1 = pt;
               tri_pt2 = tri.tri_pt2} in
  let s2 = area_of_triangle {
               tri_pt0 = tri.tri_pt0;
               tri_pt1 = tri.tri_pt1;
               tri_pt2 = pt} in
  almost_equal s (s0 +. s1 +. s2)


let stretch a v =
  {px = a *. v.px;
   py = a *. v.py;
   pz = a *. v.pz}

let get_point_on_line l a =
  v_plus l.l_pt (stretch a l.l_dir)

let point_line_foot_of_perpendicular p l =
  let a =
    (inner_product l.l_dir (v_minus p l.l_pt))
    /. (inner_product l.l_dir l.l_dir) in
  (get_point_on_line l a, a)

let normalize v =
  let a = distance zero_vec v in
  stretch (1.0 /. a) v

let normalize_line l =
  {l_pt = l.l_pt;
   l_dir = normalize l.l_dir}

let normal_vector_of_triangle tri =
  {l_pt = tri.tri_pt0;
   l_dir = cross_product
             (v_minus tri.tri_pt1 tri.tri_pt0)
             (v_minus tri.tri_pt2 tri.tri_pt0)}

(* surface represented by normal vector reflect ray *)
let reflect_on_surface_n ray n =
  let a = (inner_product (v_minus n.l_pt ray.l_pt) n.l_dir)
          /. (inner_product ray.l_dir n.l_dir) in
  let reflection_pt = get_point_on_line ray a in
  let m = {l_pt = reflection_pt;
           l_dir = n.l_dir} in (* normal vector equivalent to n *)
  let (mid_pt, _) = point_line_foot_of_perpendicular ray.l_pt m in
  let opposit_pt = get_point_on_line
                     {l_pt = ray.l_pt; l_dir = v_minus mid_pt ray.l_pt}
                     2.0 in
  (a, {l_pt = reflection_pt;
       l_dir = v_minus opposit_pt reflection_pt})

type intersection_status =
  | Intersection of float * line
  | NoIntersection

let intersection_ray_triangle ray tri =
  let n = normal_vector_of_triangle tri in
  let (a, r) = reflect_on_surface_n ray n in
  Printf.printf
    "a = %f, point = %f %f %f\n"
    a
    r.l_pt.px
    r.l_pt.py
    r.l_pt.pz;
  if point_in_triangle r.l_pt tri
  then
    Intersection (a, r)
  else
    (Printf.printf "nointersection\n";
     NoIntersection)

let intersection_ray_sphere ray sph =
  let normalized_ray = normalize_line ray in
  let (p, a) = point_line_foot_of_perpendicular
                 sph.s_center
                 normalized_ray in
  let d = distance p sph.s_center in
  if d <= sph.s_rad
  then
    let length_of_internal_section =
      sqrt ((sph.s_rad *. sph.s_rad) -. (d *. d)) in
    let b = a -. length_of_internal_section in
    let reflection_point = get_point_on_line normalized_ray b in
    let normal_vector =
      {l_pt = reflection_point;
       l_dir = v_minus reflection_point sph.s_center} in
    let (c, new_ray) = reflect_on_surface_n ray normal_vector in
    Intersection (c, new_ray)
  else NoIntersection


let reflect_on_surface ray sur =
  match sur with
  | Sphere sph ->
     intersection_ray_sphere ray sph
  | Triangle tri ->
     Printf.printf "reflect on triangle\n";
     intersection_ray_triangle ray tri
