open Geometry3d
open Raycolor
open Camera
open Saveimg

let _ =
  let sl = [
      ES {e_surface =
            Triangle {tri_pt0 = {px = 0.; py = 0.; pz = 0.};
                      tri_pt1 = {px = 0.1; py = 1.; pz = 0.};
                      tri_pt2 = {px = 0.; py = 0.; pz = 1.}};
          e_color = {cr = 0.5; cg = 1.; cb = 0.5}};
      ES {e_surface =
            Sphere {s_center = {px = -0.8; py = 0.5; pz = 0.05};
                    s_rad = 1.0};
          e_color = {cr = 1.; cg = 0.; cb = 1.}}
    ] in
  let scr =
    {distance_screen_camera = 1.0;
     bottom_left = {px = 1.; py = 0.; pz = 0.};
     bottom_right = {px = 1.; py = 1.; pz = 0.};
     up_left = {px = 1.; py = 0.; pz = 1.}} in
  if is_valid scr
  then
    let img = shoot scr 100 100 sl in
    save img
  else
    Printf.printf "bad screen\n"
               
