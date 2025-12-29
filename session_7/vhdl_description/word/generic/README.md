## A latch based word module
A generic word to be later used for our LBRAM (latch based RAM), accepting the following options:
1. word_size:
    The size of the word in bits.
    Defaults to 8.
2. reset_to_in_form:
    when reseted, it will contain the unsigned value of the integer provided here.
    Defaults to 0.