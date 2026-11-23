Require Import
  EnrichedPreorder.Ordinary.Proset
  EnrichedPreorder.Ordinary.Instances.Prop
  EnrichedPreorder.Enriched.Proset.

Program Definition PropEnriched@{a}
  (A : Proset@{a})
  : EnrichedProset@{_ a} PropMP :=
  {|
    EnrichedProset_ob := A.(Proset_ob);
    EnrichedProset_hom := A.(Proset_hom);
  |}.
Next Obligation.
  simpl. intros A x _. eapply Proset_refl.
Qed.
Next Obligation.
  simpl. intros A x y z [H1 H2]. eauto using Proset_trans.
Qed.
