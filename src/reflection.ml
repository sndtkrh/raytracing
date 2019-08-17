open Raycolor
open Geometry3d

type reflection =
  | Emit of raycol
  | Absorb of raycol

type raytrace_res =
  | Collide of raycol
  | Diverge of line
  | Absorbed
    
let reflect' (ray: line) (col_sor: coloredSurface) =
  match col_sor with
  | ES esur ->
     (reflect_on_surface ray esur.e_surface, Emit esur.e_color)
  | AS asur ->
     (reflect_on_surface ray asur.a_surface, Absorb asur.a_color)

let reflect (ray: line) (col_surs: coloredSurface list) =
  let reflection_list =
    List.sort compare
      (List.fold_right
         (fun refl_res ray_list ->
           match refl_res with
           | (Intersection (a, l), refl) ->
              (a, l, refl) :: ray_list
           | (NoIntersection, _) ->
              ray_list)
         (List.map (reflect' ray) col_surs) []) in
  let rec first_positive = function
    | [] -> None
    | (a, new_ray, refl_res) :: l ->
       if a > 0.
       then Some (new_ray, refl_res)
       else first_positive l in
  first_positive reflection_list

let rec raytrace' (ray: line) (col_surs: coloredSurface list)
          (color_conv: raycol -> raycol) (num: int) =
  if num > 20
  then Absorbed
  else
    match reflect ray col_surs with
    | None -> Diverge ray
    | Some (new_ray, refl_res) ->
       match refl_res with
       | Emit col -> Collide (color_conv col)
       | Absorb col -> raytrace' new_ray col_surs
                         (fun c ->
                           color_conv (color_convertor col c))
                         (num + 1)

let raytrace ray col_surs =
  raytrace' ray col_surs (fun c -> c) 0
