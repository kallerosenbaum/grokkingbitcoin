# Ch12 (Taproot) — illustrator brief

All SVGs in this folder are placeholders. They are clearly marked
PLACEHOLDER in the file itself and are dashed-bordered yellow boxes
when rendered. The brief below describes what the real artwork should
depict, so an illustrator can produce final SVGs in Inkscape using
the book's existing fonts (Humanst521 Cn BT, Arial, FreeMono) and
the visual conventions established in Ch10 (`images/ch10/10-*.svg`)
and Ch11 (`images/ch11/11-*.svg`).

The same `u`-prefixed marginalia / recap convention from Ch10 and
Ch11 is followed here.

## Numbered figures

### 12-01 — p2wpkh vs p2wsh witness sizes
Side-by-side comparison. Left: a p2wpkh single-sig spend with a
small witness (one signature, one pubkey). Right: a p2wsh 2-of-3
multisig spend with a much larger witness (two signatures, the
witness script with three pubkeys). Annotate witness byte counts.
Reuse the visual language of figure 10-32 / 10-33 in Ch10. Aspect
roughly 800×300.

### 12-02 — p2wsh "all branches must be revealed"
A p2wsh witness script with two branches: a 2-of-3 cooperative path
and an emergency-single-key-after-timelock path. Highlight (e.g.
shaded box) that BOTH branches are committed and present in the
witness even when only one is used to spend. The point of the figure
is the wasted-bytes problem. Aspect 800×350.

### 12-03 — Schnorr vs ECDSA signing flows
Two flow diagrams side by side. Same outer shape: private key +
message hash → signature. Inside, the Schnorr box has a different
internal structure (k·G, R, s = k + H(R, P, m)·d) but kept abstract.
Annotate Schnorr signature as 64 bytes fixed; ECDSA as 70-72 bytes
variable (DER-encoded). Style match figure 02-19 (signing diagram in
Ch02). Aspect 800×320.

### 12-04 — p2tr output anatomy
A single-row layout showing the bytes of a p2tr output: witness
version byte `01`, length byte `20`, 32-byte x-only public key.
Contrast underneath with the equivalent layouts of p2wpkh and p2wsh
outputs from Ch10's recap-of-payment-types figures. Aspect 800×200.

### 12-05 — John's p2tr spend
John's transaction spending a p2tr output. The transaction has one
input (whose witness contains exactly one item: a 64-byte Schnorr
signature) and one or two outputs. Annotate "witness = one signature,
nothing else" prominently. Style match figure 10-14. Aspect 800×280.

### 12-06 — Taproot script tree, two leaves
A small merkle tree with two leaves. Show the actual leaf scripts
(now spelled out in the text):
* leaf~1~ = `<1 may 2027> OP_CHECKLOCKTIMEVERIFY OP_DROP <K_daughter> OP_CHECKSIG`
* leaf~2~ = `<K_spouse> OP_CHECKSIGVERIFY <K_attorney> OP_CHECKSIG`
Then show:
* each leaf hashed into a leaf hash (A and B),
* A and B sorted + concatenated + hashed into the merkle root,
* the internal key P,
* the output key Q as the tweak of P with H(P, root) — describe it as
  a tweak, do NOT print the elliptic-curve formula (the book treats
  that as advanced/optional; the text deliberately avoids it).

Use the merkle-tree visual language already established in Ch06.
Aspect 800×360.

### 12-07 — Script-path spend revealing leaf 1
The same tree as 12-06, but now showing what gets revealed when
leaf 1 is used to spend. The witness contains:
* the values consumed by leaf 1 (your daughter's signature),
* the leaf 1 script itself,
* a control block, shown as its byte layout: 1 byte (leaf version +
  parity), 32 bytes (internal key P), 32 bytes (leaf 2's hash B).

Show the verifier rebuilding the merkle root from leaf 1's hash (A)
and the sibling hash (B) in the control block. Leaf 2's script is
greyed out / boxed off — emphasize that only its hash B is revealed,
not the script. Aspect 800×360.

### 12-08 — p2tr address format
Match the visual language of figures 10-30 through 10-35
(recap-of-payment-types). Show the `bc1p<58 base32m characters>`
address, the encoding of witness version 1 and the 32-byte program,
the bech32m checksum, and a callout that the difference from `bc1q`
is purely the encoding constant. Aspect 800×220.

### 12-09 — MuSig2 on-chain footprint
A spending transaction whose witness is exactly one 64-byte Schnorr
signature. Annotate that this is what Faiza/Ellen/John's 2-of-3
charity spend now looks like, and side-by-side with 12-05 (John's
single-sig spend) to show that they are visually identical on chain.
Aspect 800×280.

## Marginalia and recap (u-prefixed)

### u12-01 — John walks to the cafe with his Taproot wallet
Marginalia/sidebar image. Style match `u10-01.svg`. Used near the
key-path-spending section. Aspect roughly 200×300.

### u12-02 — A 100-of-100 federation
Marginalia/sidebar image showing many small figures gathered around
a single signature. Used near the "Beyond the 15-of-15 ceiling"
section. Style match `u10-04.svg`. Aspect 200×300.

### u12-03 — Recap of Taproot output shape
Recap image embedded in the chapter Recap section. Style match
`u10-03.svg`. Aspect 600×280.

### u12-04 — Recap of script-path spend
Recap image showing only-the-used-leaf-is-revealed for the script
path. Style match `u10-04.svg`. Aspect 600×280.
