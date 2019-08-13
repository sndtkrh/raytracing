open Images
open Raycolor
open Reflection

let color8bit (c: raycol) =
  {r = int_of_float (255. *. c.cr);
   g = int_of_float (255. *. c.cg);
   b = int_of_float (255. *. c.cb)}

let save img =
  let width = Array.length img in
  let height = Array.length img.(0) in
  let name = "output.png" in
  let black = {r = 0; g = 0; b = 0} in
  let image = Rgb24.make width height black in
  for i = 0 to width - 1 do
    for j = 0 to height - 1 do
      match img.(i).(j) with
      | Collide c -> Rgb24.set image i j (color8bit c)
      | _ -> ()
    done;
  done;
  Png.save name [] (Images.Rgb24 image)
