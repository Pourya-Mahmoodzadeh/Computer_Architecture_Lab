# Simillarity checker

## Summary of Use:
takes two DATA_WIDTH-bits ordered set of bits, and a mask determining which bits are valid (we care for them, want them to match) and which bits are not (we don't care if there is a mismatch). returns 1 if the two sets are simillar, and 0 if they are not.

## Mask 
mask should have DATA_WIDTH-bits.
0 -> valid 
1 -> invalid