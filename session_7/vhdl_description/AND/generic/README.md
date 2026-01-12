# AND 
A generic AND gate! The reason for this was simple, I wanted to be able to easily AND(!) arbitrary number (but provided) of bits.

## Generics 
WIDTH : how many bits do you want to and? type the amount. The value is an integer >= 1 (VHDL (ieee designers) calls this "positive"), but please make sure that the provided input has at least of WIDTH 2, or else the behavior is undefined. Also logically (and preferable) don't use this for WIDTH = 2 case, either.

## Generics 
DATA_WIDTH: Number of bits of each input buss