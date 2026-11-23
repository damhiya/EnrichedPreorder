Require Import
  EnrichedPreorder.Ordinary.Proset
  EnrichedPreorder.Ordinary.MonoidalProset
  EnrichedPreorder.Enriched.Proset.

Open Scope ordinary_proset_scope.

Program Definition Underlying@{v a}
  {V : MonProset@{v}}
  (A : EnrichedProset@{v a} V)
  : Proset@{a} :=
  {|
    Proset_ob := A.(EnrichedProset_ob);
    Proset_hom := fun x y => I{V} ⊑ (x ⊑ y)%ep;
  |}.
Next Obligation.
  simpl. intros V A x. eapply EnrichedProset_refl.
Qed.
Next Obligation.
  simpl. intros V A x y z H1 H2.
  eapply Proset_trans.
  { eapply MonStr_unit_left with (M := V). }
  eapply Proset_trans.
  { eapply MonStr_prod_isBifunctor; [eapply H1| eapply H2]. }
  eapply EnrichedProset_trans.
Qed.
