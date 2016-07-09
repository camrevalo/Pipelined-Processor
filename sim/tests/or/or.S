###############################################################################
# File         : or.S
# Project      : EE180 Lab 2: MIPS
#
# Standards/Formatting:
#   MIPS gas, soft tab, 80 column
#
# Description:
#   Test the functionality of the 'or' instruction.
#
###############################################################################

    .section .boot, "x"
    .balign 4
    .set    noreorder
    .global boot
    .ent    boot
boot:
    lui     $s0, 0x8002         # Load the base address of the status/test registers
    ori     $s1, $0, 1          # Prepare the 'done' status
    ori     $t0, $0, 0x1
    ori     $t1, $0, 0x0
    or      $s1, $t0, $t1
    ori     $v0, $0, 0x3333
    ori     $v1, $0, 0xcccc
    or      $v0, $v0, $v1
    ori     $t2, $0, 0xfff3
    sub     $v0, $v0, $t2 
    sw      $v0, 4($s0)         # Set the test result
    sw      $s1, 0($s0)         # Set 'done'

$done:
    j       $done
    nop

    .end boot
