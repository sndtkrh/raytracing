open Geometry3d
open Raycolor
open Reflection

let _ =
  let sl = [
      ES {e_surface =
            Triangle {tri_pt0 = {px = 0.; py = 0.; pz = 0.};
                      tri_pt1 = {px = 0.1; py = 1.; pz = 0.};
                      tri_pt2 = {px = 0.; py = 0.; pz = 1.}};
          e_color = {cr = 1.; cg = 1.; cb = 1.}};
      ES {e_surface =
            Sphere {s_center = {px = -0.8; py = 0.5; pz = 0.05};
                    s_rad = 1.0};
          e_color = {cr = 1.; cg = 0.; cb = 1.}}
    ] in
  let ray0 = {
      l_pt = {px = 1.; py = 1.; pz = 0.05};
      l_dir = {px = -1.; py = -0.5; pz = 0.}} in
  let tmp = raytrace ray0 sl in
  let print_result = function
    | Collide c ->
       Printf.printf "c=(%f, %f, %f)\n" c.cr c.cg c.cb
    | _ ->
       Printf.printf "black\n" in
  print_result tmp
