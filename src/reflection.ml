open Raycolor
open Geometry3d

let reflect' ray col_sor =
  match col_sor with
  | ES esur ->
     reflect_on_surface ray esur.e_surface
  | AS asur ->
     reflect_on_surface ray asur.a_surface

let reflect ray col_surs =
  List.sort compare
    (List.fold_right
       (fun i ray_list ->
         match i with
         | Intersection (a, l) -> (a, l) :: ray_list
         | NoIntersection -> ray_list)
       (List.map (reflect' ray) col_surs) [])

