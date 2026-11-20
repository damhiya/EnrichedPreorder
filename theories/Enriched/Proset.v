Require Import
  EnrichedPreorder.Ordinary.Proset
  EnrichedPreorder.Ordinary.MonoidalProset.

#[local] Open Scope ordinary_proset_scope.

Record EnrichedProset@{v a} (V : MonProset@{v}) : Type@{max(v,a+1)} :=
  { EnrichedProset_ob :> Type@{a}
  ; EnrichedProset_hom : EnrichedProset_ob -> EnrichedProset_ob -> V
  ; EnrichedProset_refl : forall x, I{V} ⊑ EnrichedProset_hom x x
  ; EnrichedProset_trans : forall x y z, EnrichedProset_hom x y ⊗{V} EnrichedProset_hom y z ⊑ EnrichedProset_hom x z
  } as A.

#[global] Arguments EnrichedProset_ob {V} A.
#[global] Arguments EnrichedProset_hom {V A} x y.
#[global] Arguments EnrichedProset_refl V A x.
#[global] Arguments EnrichedProset_trans V A x y z.

Declare Scope enriched_proset_scope.
Delimit Scope enriched_proset_scope with ep.

Infix "⊑" := EnrichedProset_hom (at level 70, no associativity) : enriched_proset_scope.
Notation "(⊑)" := EnrichedProset_hom (only parsing) : enriched_proset_scope.
Infix "⊑{ A }" := (@EnrichedProset_hom _ A) (at level 70, no associativity, only parsing) : enriched_proset_scope.
Notation"(⊑{ A } )" := (@EnrichedProset_hom _ A) (only parsing) : enriched_proset_scope.

Record EnrichedFunctor@{v a b}
  {V : MonProset@{v}}
  (A : EnrichedProset@{v a} V)
  (B : EnrichedProset@{v b} V)
  : Type@{max(a,b)} :=
  { EnrichedFunctor_fun :> A -> B
  ; EnrichedFunctor_mono :
    forall x y, (x ⊑ y)%ep ⊑{V} (EnrichedFunctor_fun x ⊑ EnrichedFunctor_fun y)%ep
  } as f.
