(* We do not use Reflexive/Transitive typeclass from the corelib
   in order to avoid universe level constraint. *)
Record Proset@{u} : Type@{u+1} :=
  { Proset_ob :> Type@{u}
  ; Proset_hom : Proset_ob -> Proset_ob -> Prop
  ; Proset_iso : Proset_ob -> Proset_ob -> Prop :=
      fun x y => Proset_hom x y /\ Proset_hom y x
  ; Proset_refl : forall x, Proset_hom x x
  ; Proset_trans : forall x y z, Proset_hom x y -> Proset_hom y z -> Proset_hom x z
  } as A.

#[global] Arguments Proset_ob A : assert.
#[global] Arguments Proset_hom {A} x y.
#[global] Arguments Proset_iso {A} x y.
#[global] Arguments Proset_refl A x.
#[global] Arguments Proset_trans A x y z _ _.

Declare Scope ordinary_proset_scope.
Delimit Scope ordinary_proset_scope with op.

#[local] Open Scope ordinary_proset_scope.

Infix "⊑" := Proset_hom (at level 70, no associativity) : ordinary_proset_scope.
Notation "(⊑)" := Proset_hom (only parsing) : ordinary_proset_scope.
Infix "⊑{ A }" := (@Proset_hom A) (at level 70, no associativity, only parsing) : ordinary_proset_scope.
Notation"(⊑{ A } )" := (@Proset_hom A) (only parsing) : ordinary_proset_scope.

Infix "≡" := Proset_iso (at level 70, no associativity) : ordinary_proset_scope.
Notation "(≡)" := Proset_iso (only parsing) : ordinary_proset_scope.
Infix "≡{ A }" := (@Proset_iso A) (at level 70, no associativity, only parsing) : ordinary_proset_scope.
Notation"(≡{ A } )" := (@Proset_iso A) (only parsing) : ordinary_proset_scope.

Record Functor@{u v} (A : Proset@{u}) (B : Proset@{v}) : Type@{max(u,v)} :=
  { Functor_fun :> A -> B
  ; Functor_mono : forall x x', x ⊑ x' -> Functor_fun x ⊑ Functor_fun x'
  } as f.
