open Geometry3d
open Reflection

type screen = {
    distance_screen_camera: float;
    bottom_left: point;
    bottom_right: point;
    up_left: point
  }

let vectors scr =
  (v_minus scr.bottom_right scr.bottom_left,
   v_minus scr.up_left scr.bottom_left)

let is_valid scr =
  let (v, u) = vectors scr in
  almost_equal 0. (inner_product v u)

let camera_position scr =
  let (v, u) = vectors scr in
  let w = stretch
            scr.distance_screen_camera
            (normalize (cross_product v u)) in
  let v' = stretch 0.5 v in
  let u' = stretch 0.5 u in
  v_plus
    scr.bottom_left
    (v_plus (v_plus v' u') w)

let screen_position scr x y =
  let (v, u) = vectors scr in
  v_plus
    scr.bottom_left
    (v_plus (stretch x v) (stretch y u))

let shoot scr xres yres col_surs =
  let (v, u) = vectors scr in
  let xunit = 1. /. float_of_int xres in
  let yunit = 1. /. float_of_int yres in
  let cam = camera_position scr in
  Array.init yres (fun yn ->
      let u' = stretch (yunit *. float_of_int yn) u in
      Array.init xres (fun xn ->
          let v' = stretch (xunit *. float_of_int xn) v in
          let pos_on_scr =
            v_plus scr.bottom_left (v_plus v' u') in
          let ray =
            {l_pt = cam;
             l_dir = v_minus pos_on_scr cam} in
          raytrace ray col_surs
    ))
    
