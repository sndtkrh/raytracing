open Geometry3d
open Raycolor
open Camera
open Saveimg

let _ =
  let wall_color = {cr = 0.2; cg = 0.2; cb = 0.2} in
  let sl = [
      (* bottom *)
      AS {a_surface =
            Triangle {tri_pt0 = {px = 0.; py = 0.; pz = 0.};
                      tri_pt1 = {px = 0.; py = 1.; pz = 0.};
                      tri_pt2 = {px = 1.; py = 1.; pz = 0.}};
          a_color = wall_color};
      AS {a_surface =
            Triangle {tri_pt0 = {px = 1.; py = 1.; pz = 0.};
                      tri_pt1 = {px = 0.; py = 0.; pz = 0.};
                      tri_pt2 = {px = 1.; py = 0.; pz = 0.}};
          a_color = wall_color};
      (* top *)
      AS {a_surface =
            Triangle {tri_pt0 = {px = 0.; py = 0.; pz = 1.};
                      tri_pt1 = {px = 0.; py = 1.; pz = 1.};
                      tri_pt2 = {px = 1.; py = 1.; pz = 1.}};
          a_color = wall_color};
      AS {a_surface =
            Triangle {tri_pt0 = {px = 1.; py = 1.; pz = 1.};
                      tri_pt1 = {px = 0.; py = 0.; pz = 1.};
                      tri_pt2 = {px = 1.; py = 0.; pz = 1.}};
          a_color = wall_color};
      (* left *)
      AS {a_surface =
            Triangle {tri_pt0 = {px = 0.; py = 0.; pz = 0.};
                      tri_pt1 = {px = 0.; py = 0.; pz = 1.};
                      tri_pt2 = {px = 1.; py = 0.; pz = 0.}};
          a_color = wall_color};
      AS {a_surface =
            Triangle {tri_pt0 = {px = 0.; py = 0.; pz = 1.};
                      tri_pt1 = {px = 1.; py = 0.; pz = 1.};
                      tri_pt2 = {px = 1.; py = 0.; pz = 0.}};
          a_color = wall_color};
      (* right *)
      AS {a_surface =
            Triangle {tri_pt0 = {px = 0.; py = 1.; pz = 0.};
                      tri_pt1 = {px = 1.; py = 1.; pz = 0.};
                      tri_pt2 = {px = 0.; py = 1.; pz = 1.}};
          a_color = wall_color};
      AS {a_surface =
            Triangle {tri_pt0 = {px = 0.; py = 1.; pz = 1.};
                      tri_pt1 = {px = 1.; py = 1.; pz = 1.};
                      tri_pt2 = {px = 1.; py = 1.; pz = 0.}};
          a_color = wall_color};
      (* back *)
      AS {a_surface =
            Triangle {tri_pt0 = {px = 1.; py = 0.; pz = 0.};
                      tri_pt1 = {px = 1.; py = 1.; pz = 0.};
                      tri_pt2 = {px = 1.; py = 0.; pz = 1.}};
          a_color = wall_color};
      AS {a_surface =
            Triangle {tri_pt0 = {px = 1.; py = 1.; pz = 1.};
                      tri_pt1 = {px = 1.; py = 1.; pz = 0.};
                      tri_pt2 = {px = 1.; py = 0.; pz = 1.}};
          a_color = wall_color};
      (* front *)
      AS {a_surface =
            Triangle {tri_pt0 = {px = 0.; py = 0.; pz = 0.};
                      tri_pt1 = {px = 0.; py = 1.; pz = 0.};
                      tri_pt2 = {px = 0.; py = 0.; pz = 1.}};
          a_color = wall_color};
      AS {a_surface =
            Triangle {tri_pt0 = {px = 0.; py = 1.; pz = 1.};
                      tri_pt1 = {px = 0.; py = 1.; pz = 0.};
                      tri_pt2 = {px = 0.; py = 0.; pz = 1.}};
          a_color = wall_color};
      (* objects *)
      (* ceiling light *)
      ES {e_surface =
            Triangle {tri_pt0 = {px = 0.; py = 0.; pz = 0.95};
                      tri_pt1 = {px = 0.; py = 1.; pz = 0.95};
                      tri_pt2 = {px = 1.; py = 1.; pz = 0.95}};
          e_color = {cr = 0.8; cg = 0.5; cb = 0.8}};
      ES {e_surface =
            Triangle {tri_pt0 = {px = 0.; py = 0.; pz = 0.95};
                      tri_pt1 = {px = 1.; py = 0.; pz = 0.95};
                      tri_pt2 = {px = 1.; py = 1.; pz = 0.95}};
          e_color = {cr = 0.5; cg = 0.5; cb = 0.8}};
      (* right light *)
      ES {e_surface =
            Triangle {tri_pt0 = {px = 0.; py = 0.95; pz = 0.};
                      tri_pt1 = {px = 1.; py = 0.95; pz = 0.};
                      tri_pt2 = {px = 0.; py = 0.95; pz = 1.}};
          e_color = {cr = 0.5; cg = 0.8; cb = 0.5}};
      ES {e_surface =
            Triangle {tri_pt0 = {px = 0.; py = 0.95; pz = 1.};
                      tri_pt1 = {px = 1.; py = 0.95; pz = 1.};
                      tri_pt2 = {px = 1.; py = 0.95; pz = 0.}};
          e_color = {cr = 0.8; cg = 0.8; cb = 0.5}};
      (* others *)
      ES {e_surface =
            Sphere {s_center = {px = 0.5; py = 0.7; pz = 0.1};
                    s_rad = 0.05};
          e_color = {cr = 1.; cg = 1.; cb = 1.}};
      ES {e_surface =
            Sphere {s_center = {px = 0.2; py = 0.05; pz = 0.1};
                    s_rad = 0.03};
          e_color = {cr = 1.; cg = 0.7; cb = 1.}};
      ES {e_surface =
            Sphere {s_center = {px = 0.5; py = 0.3; pz = 0.04};
                    s_rad = 0.03};
          e_color = {cr = 0.7; cg = 0.8; cb = 1.}};
      AS {a_surface =
            Sphere {s_center = {px = 0.3; py = 0.5; pz = 0.3};
                    s_rad = 0.1};
          a_color = {cr = 1.0; cg = 0.7; cb = 0.7}};
      AS {a_surface =
            Sphere {s_center = {px = 0.5; py = 0.5; pz = 0.1};
                    s_rad = 0.07};
          a_color = {cr = 0.7; cg = 0.8; cb = 0.98}};
      AS {a_surface =
            Sphere {s_center = {px = 0.5; py = 0.3; pz = 0.2};
                    s_rad = 0.03};
          a_color = {cr = 0.9; cg = 1.0; cb = 0.9}};
      AS {a_surface =
            Sphere {s_center = {px = 0.6; py = 0.45; pz = 0.03};
                    s_rad = 0.02};
          a_color = {cr = 0.5; cg = 1.0; cb = 0.5}}
    ] in
  let scr =
    {distance_screen_camera = 0.15;
     bottom_left = {px = 0.8; py = 0.4; pz = 0.1};
     bottom_right = {px = 0.8; py = 0.6; pz = 0.1};
     up_left = {px = 0.8; py = 0.4; pz = 0.3}} in
  if is_valid scr
  then
    let img = shoot scr 1000 1000 sl in
    save img
  else
    Printf.printf "bad screen\n"
               
