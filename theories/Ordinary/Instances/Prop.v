Require Import
  EnrichedPreorder.Ordinary.Proset
  EnrichedPreorder.Ordinary.MonoidalProset.

#[universes(polymorphic=no)]
Program Canonical PropP : Proset :=
  {|
    Proset_ob := Prop;
    Proset_hom := fun x y => x -> y;
  |}.
Next Obligation. firstorder. Qed.
Next Obligation. firstorder. Qed.

Program Canonical PropMS: MonStr PropP :=
  {|
    MonStr_prod := fun x y => x /\ y;
    MonStr_unit := True;
  |}.
Next Obligation. firstorder. Qed.
Next Obligation. firstorder. Qed.
Next Obligation. firstorder. Qed.
Next Obligation. firstorder. Qed.
Next Obligation. firstorder. Qed.
Next Obligation. firstorder. Qed.
Next Obligation. firstorder. Qed.

Canonical PropMP : MonProset :=
  {|
    MonProset_Proset := PropP;
    MonProset_MonStr := PropMS;
  |}.

#[global] Instance PropMP_isSymmetric : isSymmetric PropMP.
Proof. firstorder. Qed.

Canonical PropSMP : SymMonProset :=
  {|
    SymMonProset_MonProset := PropMP;
    SymMonProset_isSymmetric := PropMP_isSymmetric
  |}.
