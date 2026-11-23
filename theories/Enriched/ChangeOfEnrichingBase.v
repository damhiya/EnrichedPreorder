Require Import
  EnrichedPreorder.Ordinary.Proset
  EnrichedPreorder.Ordinary.MonoidalProset
  EnrichedPreorder.Enriched.Proset.

Open Scope ordinary_proset_scope.

Program Definition Change@{v1 v2 a}
  {V1 : MonProset@{v1}}
  {V2 : MonProset@{v2}}
  (f : LaxMonFunctor V1 V2)
  (A : EnrichedProset@{v1 a} V1)
  : EnrichedProset@{v2 a} V2 :=
  {|
    EnrichedProset_ob := A.(EnrichedProset_ob);
    EnrichedProset_hom := fun x y => f (x ⊑ y)%ep;
  |}.
Next Obligation.
  simpl. intros V1 V2 f A x.
  eapply Proset_trans.
  { eapply LaxMonFunctor_unit with (f := f). }
  eapply Functor_mono.
  eapply EnrichedProset_refl.
Qed.
Next Obligation.
  simpl. intros V1 V2 f A x y z.
  eapply Proset_trans.
  { eapply LaxMonFunctor_prod. }
  eapply Functor_mono.
  eapply EnrichedProset_trans.
Qed.
