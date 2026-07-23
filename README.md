# HDLBits Solutions

Verilog solutions to [HDLBits](https://hdlbits.01xz.net/), collected while working through digital design fundamentals toward RTL and accelerator design.

Every file here is my own submission that passed the site's checker. Problem statements are not reproduced, only linked.

## What gets committed

Most HDLBits problems are a one-line answer, and a repo full of those tells you nothing. So the early sections are collapsed into batch files and only the parts that took real work get their own file.

| | Where | How it's stored |
|---|---|---|
| **Batched** | Language basics, vectors, hierarchy, simple combinational | One file per category, one-line header per problem |
| **Tier 2** | Anything I got wrong at least once | Own file + a note on what broke |
| **Tier 3** | Concepts worth keeping | Own file + local testbench + waveform capture |

Sequential logic onward is where the individual files start.

## Layout

```
1_verilog_language/     Batch files: basics, vectors, hierarchy, procedures
2_circuits/
  01_combinational/     Batch files by category
  02_sequential/        Individual files: flip-flops, counters, shift registers, FSMs
3_verification/         Reading simulations, writing testbenches
notes/                  Write-ups on concepts that took effort
tb/                     Local testbenches
waveforms/              GTKWave captures
scripts/                Progress table generator, simulation runner
```

## Header formats

`scripts/gen_readme.py` parses these to build the progress table, so field names matter.

Individual file:

```verilog
//==============================================================
// Problem : Dff8ar
// Section : Circuits / Sequential / Latches and Flip-Flops
// URL     : https://hdlbits.01xz.net/wiki/Dff8ar
// Tier    : 2
// Solved  : 2026-07-23
//--------------------------------------------------------------
// 비동기 리셋은 sensitivity list에 negedge areset을 직접 넣어야 한다.
// posedge clk만 두고 if (areset)로 처리하면 동기 리셋으로 합성된다.
//==============================================================
```

Batch file: a `Section` block at the top, then one line per problem.

```verilog
//-- Wire | https://hdlbits.01xz.net/wiki/Wire
module wire_top (...);
```

HDLBits names every module `top_module`, so batch files use a problem-name suffix to avoid collisions. The logic is unchanged from what was submitted.

## Local verification

Passing the web checker is not the same as knowing the circuit works. Tier 3 problems get re-run locally with Icarus Verilog and inspected in GTKWave.

```bash
python scripts/sim.py dff8ar          # compile, run, dump VCD
python scripts/sim.py dff8ar --wave   # same, then open GTKWave
python scripts/gen_readme.py          # regenerate the table below
```

## Progress

<!-- PROGRESS:START -->
_Run `python scripts/gen_readme.py` to populate this table._
<!-- PROGRESS:END -->

## Notes

The actual learning is recorded in [`notes/`](notes/), not in the solution files.

- [Sequential logic](notes/sequential.md)

## Environment

- Icarus Verilog 12.0
- GTKWave 3.3
- Python 3.11 for the helper scripts
