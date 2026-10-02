# Booth Multiplier (Radix-2, Signed)

A parameterized, sequential signed multiplier in Verilog using the radix-2 Booth algorithm. The design is split into a **datapath** and an **FSM controller**, with a top-level wrapper and a self-checking testbench.

Built during the Summer Training Program on VLSI Design (STPVD) at IIIT Allahabad, June-July 2026.

## Files

| File | Module | Description |
|------|--------|-------------|
| `booth.v` | `booth_top` | Top level. Connects the datapath and controller and registers the final result. |
| `datapath.v` | `datapath` | Registers (`A`, `Qmul`, `Mult`, `qn`, `count`), add/subtract, arithmetic right shift, iteration counter. |
| `controlpath.v` | `controlpath` | 7-state FSM that sequences the algorithm. |
| `testbench.v` | `tb_booth_top` | Self-checking testbench with 14 directed tests. |

## Interface (`booth_top`)

| Port | Direction | Width | Description |
|------|-----------|-------|-------------|
| `clk` | in | 1 | Clock |
| `rst` | in | 1 | Synchronous reset |
| `start` | in | 1 | Starts a multiplication when the FSM is idle |
| `m` | in | N (signed) | Multiplicand |
| `q` | in | N (signed) | Multiplier |
| `result` | out | 2N | Signed product, latched when the operation completes |
| `done` | out | 1 | High for one cycle when the product is ready |

`N` is a parameter (default 8).

## How it works

The multiplier bits are examined in pairs (`Q0`, `Q-1`) once per iteration:

| Q0 | Q-1 | Action |
|----|-----|--------|
| 1 | 0 | `A = A - M` |
| 0 | 1 | `A = A + M` |
| 0 | 0 | none |
| 1 | 1 | none |

After each step, `{A, Q, Q-1}` is shifted right arithmetically. After N iterations, `{A, Q}` holds the 2N-bit product.

### FSM states

`IDLE` -> `INIT` (load operands, set count to N) -> `CHECK` (inspect Q0, Q-1) -> `ADD` or `SUB` (if needed) -> `SHIFT` -> back to `CHECK` until the count runs out -> `DONE` -> `IDLE`.

Each iteration takes 2 or 3 clock cycles (CHECK, an optional ADD/SUB, then SHIFT).

### Design note: overflow on the most negative input

The accumulator `A` is `N+1` bits wide and the multiplicand is sign-extended before every add or subtract. This matters when the multiplicand is `-2^(N-1)` (for example `-128` at N = 8): its negation, `+128`, does not fit in N bits, so an N-bit accumulator gives wrong results for inputs such as `(-128, 1)` and `(-128, -128)`. The extra bit removes that overflow. The 2N-bit output is taken from `{A[N-1:0], Qmul}`.

## Testbench

`testbench.v` runs 14 (multiplicand, multiplier) pairs and compares each result against Verilog's built-in signed product, held in a 2N-bit variable:

`(0,0)`, `(1,1)`, `(6,7)`, `(-6,7)`, `(6,-7)`, `(-6,-7)`, `(15,15)`, `(-15,-15)`, `(64,-64)`, `(-128,1)`, `(127,127)`, `(-128,-128)`, `(100,-1)`, `(-1,100)`

`result` is latched on the clock edge that ends the `DONE` state, so the testbench samples it one cycle after `done` is seen.

### Expected output

```
PASS: M=0 Q=0 -> RESULT=0 (expected=0)
PASS: M=1 Q=1 -> RESULT=1 (expected=1)
PASS: M=6 Q=7 -> RESULT=42 (expected=42)
PASS: M=-6 Q=7 -> RESULT=-42 (expected=-42)
PASS: M=6 Q=-7 -> RESULT=-42 (expected=-42)
PASS: M=-6 Q=-7 -> RESULT=42 (expected=42)
PASS: M=15 Q=15 -> RESULT=225 (expected=225)
PASS: M=-15 Q=-15 -> RESULT=225 (expected=225)
PASS: M=64 Q=-64 -> RESULT=-4096 (expected=-4096)
PASS: M=-128 Q=1 -> RESULT=-128 (expected=-128)
PASS: M=127 Q=127 -> RESULT=16129 (expected=16129)
PASS: M=-128 Q=-128 -> RESULT=16384 (expected=16384)
PASS: M=100 Q=-1 -> RESULT=-100 (expected=-100)
PASS: M=-1 Q=100 -> RESULT=-100 (expected=-100)
```

All 14 directed tests pass.

## Running the simulation

**Icarus Verilog**

```bash
iverilog -o sim booth.v datapath.v controlpath.v testbench.v
vvp sim
```

**Vivado**: add the four files as sources (set `tb_booth_top` as the simulation top) and run behavioral simulation.

## Tools

Verilog, Xilinx Vivado. Also simulates with Icarus Verilog.
