open Geometry3d
open Raycolor
open Reflection

let _ =
  let sl = [
      ES {e_surface =
            Triangle {tri_pt0 = {px = 0.; py = 0.; pz = 0.};
                      tri_pt1 = {px = 0.1; py = 1.; pz = 0.};
                      tri_pt2 = {px = 0.; py = 0.; pz = 1.}};
          e_color = {r = 1.; g = 1.; b = 1.}};
      ES {e_surface =
            Sphere {s_center = {px = -1.0; py = 0.5; pz = 0.05};
                    s_rad = 1.0};
          e_color = {r = 1.; g = 1.; b = 1.}}
    ] in
  let ray0 = {
      l_pt = {px = 1.; py = 1.; pz = 0.05};
      l_dir = {px = -1.; py = -0.5; pz = 0.}} in
  let tmp = reflect ray0 sl in
  let print_result res = 
    let (a, ray1) = res in
    Printf.printf "a = %f\n" a;
    Printf.printf "l_pt = (%f, %f, %f)\n"
      ray1.l_pt.px ray1.l_pt.py ray1.l_pt.pz;
    Printf.printf "l_dir = (%f, %f, %f)\n\n"
      ray1.l_dir.px ray1.l_dir.py ray1.l_dir.pz in
  List.map print_result tmp
