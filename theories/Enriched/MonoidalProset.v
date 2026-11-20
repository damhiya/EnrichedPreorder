Require Import
  EnrichedPreorder.Ordinary.Proset
  EnrichedPreorder.Ordinary.MonoidalProset
  EnrichedPreorder.Enriched.Proset.

#[local] Open Scope ordinary_proset_scope.

Record EnrichedMonStr@{v a}
  (V : SymMonProset@{v})
  (A : EnrichedProset@{v a} V)
  : Type@{a} :=
  { EnrichedMonStr_prod : A -> A -> A
  ; EnrichedMonStr_unit : A
  ; EnrichedMonStr_prod_isEnrichedBifunctor : forall x x' y y', (x ⊑ x')%ep ⊗{V} (y ⊑ y')%ep
                                                             ⊑ (EnrichedMonStr_prod x y ⊑ EnrichedMonStr_prod x' y')%ep
  ; EnrichedMonStr_assoc : forall x y z, I{V} ⊑ ( EnrichedMonStr_prod (EnrichedMonStr_prod x y) z
                                               ⊑ EnrichedMonStr_prod x (EnrichedMonStr_prod y z))%ep
  ; EnrichedMonStr_assoc_inv : forall x y z, I{V} ⊑ (EnrichedMonStr_prod x (EnrichedMonStr_prod y z)
                                                  ⊑ EnrichedMonStr_prod (EnrichedMonStr_prod x y) z)%ep
  ; EnrichedMonStr_unit_left : forall x, I{V} ⊑ (EnrichedMonStr_prod EnrichedMonStr_unit x ⊑ x)%ep
  ; EnrichedMonStr_unit_left_inv : forall x, I{V} ⊑ (x ⊑ EnrichedMonStr_prod EnrichedMonStr_unit x)%ep
  ; EnrichedMonStr_unit_right : forall x, I{V} ⊑ (EnrichedMonStr_prod x EnrichedMonStr_unit ⊑ x)%ep
  ; EnrichedMonStr_unit_right_inv : forall x, I{V} ⊑ (x ⊑ EnrichedMonStr_prod x EnrichedMonStr_unit)%ep
  } as M.

#[global] Arguments EnrichedMonStr_prod {V A M} x y.
#[global] Arguments EnrichedMonStr_unit {V A M}.
#[global] Arguments EnrichedMonStr_prod_isEnrichedBifunctor V A M x x' y y'.
#[global] Arguments EnrichedMonStr_assoc V A M x y z.
#[global] Arguments EnrichedMonStr_assoc_inv V A M x y z.
#[global] Arguments EnrichedMonStr_unit_left V A M x.
#[global] Arguments EnrichedMonStr_unit_left_inv V A M x.
#[global] Arguments EnrichedMonStr_unit_right V A M x.
#[global] Arguments EnrichedMonStr_unit_right_inv V A M x.

Notation "x ⊗{ M } y" := (@EnrichedMonStr_prod _ _ M x y) (at level 65, no associativity, format "x  ⊗{ M }  y") : enriched_proset_scope.
Notation "I{ M }" := (@EnrichedMonStr_unit _ _ M) (format "I{ M }") : enriched_proset_scope.

Record EnrichedMonProset@{v a} (V : SymMonProset@{v}) : Type@{max(v,a+1)} :=
  { EnrichedMonProset_EnrichedProset :> EnrichedProset@{v a} V
  ; EnrichedMonProset_EnrichedMonStr :> EnrichedMonStr V EnrichedMonProset_EnrichedProset
  } as M.
