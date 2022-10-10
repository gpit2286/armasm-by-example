---
title: "Program 9: Factorials"
weight: 6
type: programs

description: >
    The two "standard" recursion formulas used in programming are the Fibonacci series 
    and factorials. Write a program that calculates 9! and prints the number to stdout. 

source: https://github.com/gpit2286/armasm-by-example/tree/master/09-factorial
youtube_id: "" 
input: https://github.com/gpit2286/armasm-by-example/tree/master/09-factorial/template
output: "362880"
---

<style>
.stack-grid {
  display: grid; 
  grid-template-columns: [fn] 1fr [frame] 1fr [label] 1fr [end]; 
  border: 2px solid black;
}

.stack-fn {
    padding-left: 4px; 
    grid-column: fn / frame; 
}

.frame {
  grid-column: frame / label;
  height: 32px; 
  border-width: 0px 2px 2px 2px;
  border-color: black; 
  border-style: solid;
  padding-left: 4px;
  line-height: 32px;
}
.stack-label {
    grid-column: label / end; 
    padding-lect: 4px; 
}

.frame:last-of-type {
  border-bottom-width: 0px; 
}
</style>
 
## Including Other Files, Pt. 2

In addition to using macros, we can use instructions in compile object files. In this 
template, you can see the itoa.s file has been moved here with all of the code. When we 
assemble the source into an object file, we are making a primitive static library. 

To expose code, you need to tell the linker what functions it can use. This is similar to exporting 
or marking code as public in other languages. In ARM assembly, you just specify `.global label`. This 
is why we need to put the `.global _start` in our main file -- so the linker cna find it. To include 
the code, it's as simple as giving both files to the linker. The makefile will do this for you automatically 
for this program. 

```bash 
$ ld -o main main.o itoa.o 
``` 

## Stack Frame

One very common way of managing the stack is by using "frames" to outline data "packages" on the stack. 
Although this is a somewhat more theoretical discussion of how to use the stack, we will use it for our 
next program. The idea is that every procedure or function will have it's own little space in the stack 
where it can keep its information in an ordered way. If we had the following code: (non-sensical)

```rust 
fn main() {
    let res = a(1, 2); 
}

fn a(param1: i32, param2: i32) -> i32 {
    b(param2) + 3
}

fn b(param1: i32) -> i32 {
    param1 + 1
}
```

This is what the stack may possibly look like right before the point of adding 1 to param1 in `b()`. 
<div class="stack-grid">
    <div class="stack-fn">OS ENV params</div>
    <div class="frame"> ... </div>
    <div class="stack-label">⬅️ Base pointer addr for main()</div>
    <div class="stack-fn" style="background-color:#97F9F9; grid-row: span 5">main()</div> 
    <div class="frame">Space for local param `res`</div>
    <div class="frame">Param 2 for a()</div>
    <div class="frame">Param 1 for a()</div>
    <div class="frame">Return to main() address</div>
    <div class="frame">Address for main() base pointer</div>
    <div class="stack-label">⬅️ Base pointer addr for a()</div>
    <div class="stack-fn" style="background-color:#C1E0F7; grid-row: span 5">a()</div> 
    <div class="frame">Saved registers</div>
    <div class="frame">Local var if needed</div>
    <div class="frame">Param 1 for b()</div>
    <div class="frame">Return to a() address</div>
    <div class="frame">Address for a() base pointer</div>
    <div class="stack-label">⬅️ Base pointer addr for b()</div>
    <div class="stack-fn" style="background-color:#C59FC9; grid-row: span 2">b()</div> 
    <div class="frame">Saved registers</div>
    <div class="frame">Local var if needed</div>
    <div class="stack-label">⬅️ Stack pointer</div>
</div>

Generally the caller function will push the params to the callee in reverse order. After that, the 
branch is made. When the callee recieves control, the callee will save both the return address as 
well as the old frame base address. It will then move the frame base to the same value as the stack pointer 
and we have our new frame. 


### Frame Base Pointer 

Why do we use a frame base? It seems like information that we can just get rid of, right? We already have 
a stack pointer. A frame pointer allows us to refer to values without regard of tracking exactly where the 
stack pointer is located. If you look at the above chart again, notice that the old base pointer address 
is always in the same place in relation the the current base pointer. The return address is always in the 
same place in relation the current base pointer. The parameters for the called functions are always in the same 
place in relation to the base pointer. 


## BL and BX operations 

One of those other registers that I said never to touch is the link register or r14. When 
using the branch-and-link (BL) opcode, the next instruction address is stored in r14 and 
branches to the address the opcode specifies. At the end of the routine you then use 
the branch-and-exchange opcode (BX) to go back to where you left off.  

### Example using BL and BX

#### add.s 
```armasm 
.global add

add:
    add     r0, #2      @ add 2 to register 0 
    bx      lr          @ branch and exchange to where you jumped from 
```

#### main.s
```armasm
.global _start 

_start: 
    mov     r0, #3      @ move 3 into r0 
    bl      add         @ jump to add 
    @ here r0 = 5 (3 + 2)
    @ ... code continues 
```

### Recursive functions 

If you combine these two ideas, you can start writing recursive functions! In addition 
to pushing the values you want to save, push `lr` (link register)  after the `bl` as well. 
When the string of recursive calls terminates, because you are pushing `lr`, 
you would be able to `pop {lr}` before `bx lr` and get back to wherever you started. 
If you didn't push the return address, you would get into a loop as the `bl` 
overwrites the link register every time. 
