# Synchronous Gate Based Random Access Memory

## Brief usage instroction
activates on posedge write and read. Wait for it to say that that wanted process is done by setting rready (read ready) or wready(write ready).For these xready signals to remain to be meaningful, make sure to use uset_rready and uset_wready to unset the two signals respectively. This is capable to do a chaos (you just need to care for those *ready signals) of writing and reading requests.You also can easily pass generics to have a sync_GBRAM of desired capacity (number of address' bits and length of a word (in bits again) can be set.).
#### IMPORTANT NOTE 1: 
If a write request and a read request happen to be at the same time (the same posedge clock), then it prioritizes writing over reading, this is very important to be noted.

#### IMPORTANT NOTE 2: 
Make sure to activate and deactivate the signal "resetn" once before usage. Of course, you can modify the source code (if you are not as lazy as I am) so that the GBRAM have your desired state upon power up. I didn't know how to do it, and thanks to some dear people bombarding us with assignments(!), I didn't have time (rest is also required, isn't it?) to do this. I will welcome a patch from you regarding the problem (If I won't be too lazy to take that to consideration! Right now I even doubted having written that!)!

#### IMPORTANT NOTE 3: 
upon resetting, the words will contain their address (instead of zero, only because university forced it!), so be ware with the "dirty" bit suggested in "Suggestion 1". Modifying this, is very simple and easy. Just go to "word.vhd" and set the related generic integer to '0' in the for-generate loop. It is now set to 'i'. (Sorry for the trouble. Blame uni!)

#### IMPORTANT NOTE 4: 
to use test.sh script. Make sure to edit the start of each path till "Computer_Architecture_Lab". Again, sorry for the trouble. (I myself would probably prefer to not use such a troublesome(!) repo! Hopefully, you are not like me!)
test.sh is written naively, but it's probably useful for you to not rewrite everything from the scratch and just do some minor(!) modifications instead.

## Generics 
DATA_WIDTH: length of each word
ADDR_WIDTH: bits of address buss 

###### Suggestion 1: 
If you want your words to be of N bits, set DATA_WIDTH to be (N + 1). 1 bit for "dirty" bit, so you will be able to determine whether a word is occupied or not.


#### Final word
Thanks for reading my bull..... that were mixed with the instruction.
Have fun!