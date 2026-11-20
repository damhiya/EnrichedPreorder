Require Import EnrichedPreorder.Ordinary.Proset.

#[local] Open Scope ordinary_proset_scope.

Record MonStr@{u} (A : Proset@{u}) : Type@{u} :=
  { MonStr_prod : A -> A -> A
  ; MonStr_unit : A
  ; MonStr_prod_isBifunctor : forall x x' y y', x ⊑ x' -> y ⊑ y' -> MonStr_prod x y ⊑ MonStr_prod x' y'
  ; MonStr_assoc : forall x y z, MonStr_prod (MonStr_prod x y) z ⊑ MonStr_prod x (MonStr_prod y z)
  ; MonStr_assoc_inv : forall x y z, MonStr_prod x (MonStr_prod y z) ⊑ MonStr_prod (MonStr_prod x y) z
  ; MonStr_unit_left : forall x, x ⊑ MonStr_prod MonStr_unit x
  ; MonStr_unit_left_inv : forall x, x ⊑ MonStr_prod MonStr_unit x
  ; MonStr_unit_right : forall x, x ⊑ MonStr_prod x MonStr_unit
  ; MonStr_unit_right_inv : forall x, x ⊑ MonStr_prod x MonStr_unit
  } as M.

#[global] Arguments MonStr_prod {A M} x y.
#[global] Arguments MonStr_unit {A M}.
#[global] Arguments MonStr_prod_isBifunctor A M x x' y y'.
#[global] Arguments MonStr_assoc A M x y z.
#[global] Arguments MonStr_assoc_inv A M x y z.
#[global] Arguments MonStr_unit_left A M x.
#[global] Arguments MonStr_unit_left_inv A M x.
#[global] Arguments MonStr_unit_right A M x.
#[global] Arguments MonStr_unit_right_inv A M x.

Notation "x ⊗{ M } y" := (@MonStr_prod _ M x y) (at level 65, no associativity, format "x  ⊗{ M }  y") : ordinary_proset_scope.
Notation "I{ M }" := (@MonStr_unit _ M) (format "I{ M }") : ordinary_proset_scope.

Record MonProset@{u} : Type@{u+1} :=
  { MonProset_Proset :> Proset@{u}
  ; MonProset_MonStr :> MonStr MonProset_Proset
  } as M.

Class isSymmetric@{u} {A : Proset@{u}} (M : MonStr A) : Prop :=
  { isSymmetric_braid : forall x y, x ⊗{M} y ≡ y ⊗{M} x
  }.
Hint Mode isSymmetric ! ! : typeclass_instances.

Record SymMonProset@{u} : Type@{u+1} :=
  { SymMonProset_MonProset :> MonProset@{u}
  ; SymMonProset_isSymmetric :: isSymmetric SymMonProset_MonProset
  }.

Record LaxMonFunctor@{u v} (A : MonProset@{u}) (B : MonProset@{v}) : Type@{u} :=
  { LaxMonFunctor_Functor :> Functor A B
  ; LaxMonFunctor_unit : I{B} ⊑ LaxMonFunctor_Functor I{A}
  ; LaxMonFunctor_prod : forall x y, LaxMonFunctor_Functor x ⊗{B} LaxMonFunctor_Functor y
                                  ⊑ LaxMonFunctor_Functor (x ⊗{A} y)
  } as f.

Lemma interchange@{v}
  {V : MonProset@{v}} {SYM: isSymmetric V}
  (x y z w : V)
  : (x ⊗{V} y) ⊗{V} (z ⊗{V} w) ⊑ (x ⊗{V} z) ⊗{V} (y ⊗{V} w).
Proof.
  eapply Proset_trans.
  { eapply MonStr_assoc. }
  eapply Proset_trans.
  2:{ eapply MonStr_assoc_inv. }
  eapply MonStr_prod_isBifunctor.
  { eapply Proset_refl. }
  eapply Proset_trans.
  { eapply isSymmetric_braid. }
  eapply Proset_trans.
  { eapply MonStr_assoc. }
  eapply MonStr_prod_isBifunctor.
  { eapply Proset_refl. }
  { eapply isSymmetric_braid. }
Qed.
