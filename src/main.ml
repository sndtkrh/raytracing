open Images

let () =
  let width  = int_of_string Sys.argv.(1)
  and length = int_of_string Sys.argv.(2)
  and name   = Sys.argv.(3)
  and black = {r = 0; g=0; b=0; }
  and white = {r = 255; g=255; b=255; } in
  let image = Rgb24.make width length black in
  for i = 0 to width-1 do
    for j = 0 to (length/2) - 1 do
      Rgb24.set image i j white;
    done;
  done;
  Png.save name [] (Images.Rgb24 image)
