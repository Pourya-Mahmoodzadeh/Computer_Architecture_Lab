-- I put quite some effort in this, regarding the time I had available (I almost never have time available!!). Enjoy this synchronous CAM (edit: The effort was not enough, and probably not that much. This CAM has so much conditions to work properly, which will be roublesome for the user. If you don't find a related README.md in this directory, just don't use this CAM, it's not worth the effort.)
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;



entity sync_CAM is 
    generic(
        DATA_WIDTH : positive; -- width of each word in bits
        WORD_NUM : positive -- number of the words
    );
    port(
        clk : in std_logic;
        rddata_in : in std_logic_vector(DATA_WIDTH - 1 downto 0); -- Input data for reading and deleting
        rdata : out std_logic_vector(DATA_WIDTH - 1 downto 0);
        mask : in std_logic_vector(DATA_WIDTH - 1 downto 0);
        read, write, delete : in std_logic; 
        wready, dready, rready : out std_logic;
        hit : out std_logic; -- hit --> 1, miss --> 0 
        other_hits : out std_logic; -- true if there are other hits as well as the ones already queried for with the same mask and data_in
        read_next : in std_logic; -- turn on to get other hits if there are any. Preferably don't use it unless other_hits is already 1 (I haven't thought of its behavior for that case.). Also, This can be used only once to get the next hit, and if you use it again, you will get the previous hit. This odd behavior may be solved later, but for now, sorry, there is no time for a restructure or reconsideration. Again, sorry! (BTW, if you are a professor and you are reading this, please make sure to give your students (the few ones who truly have a burning passion for their decipline) enough time to think, question, solve, and even get stuck, as they want, or else, be sure you are contributing so much to putting off the passion (and as a result, the student's preformance will surely decrease by a lot, surely, and by a lot.). sigh...) Just now I was thinking, having very little chance to be heard may be a situation optimized for opening up, and this long line is an example. I mean, who knows about this repo, among those who know, who cares to actually take a look at it? If anyone does, how much is the chance for him to take a look at this exact file? Even if they do, how much is the probablity for the to read the source code, ,let alone the comments, let alone longer comments, and let alone comments which are long enough to require that preson to scroll right (I just made that combination up. Does it sound weird? If I had access to internet (great country!), I would definitely check for a proper one.). To be honest, if I had any way out, one which I won't lose so much or got so harmed from choosing, I would definetely choose that. Being afraid of this since childhood, I think I am starting to get rigid. They have been saying: "Don't take hard on yourself!", "That's fine, there is no other way.", even I have heard: "You are dramatic" (lol, maybe I am a bit!), but recently, I have been thinking, maybe I have been wrong to try to change myself, to try to reach the point that almost everyone think is the point of balance (everyone includes some articles and studies as well, not just normal people(BTW, when I say normal people, you can safely(!) replace normal with dumb! Yes, this is how I think of most, and most will never read this comment!).). I have started to reclaim those some parts I had banished (BTW again, this is an instance of what I call: "Helix of Progression". No ......(a cures) time for me to talk about it, and even if I do takl about it, who is to listen?). I have started to take as hard(they say, and I don't think the same way.) as I want. After all, the same people having told me those, are the ones failing to ever understand anything deeper than the shallow surface. If this was something like math, I could easily prove them wrong, but probably human interactions and natural language is more complicated, since I have harder time in the domain, compared to well-structured worlds of mathematics I have seen. Again, BTW, have you noticed my "style" of writing (and the same goes with speaking)? I speak about a topic, branches diverge, I talk around them, and then I go back to the main topic after a while, and branches do diverge, but that's not as obvious as the divergence. Branches converge through other branches, in different topics, and this is how beautifully almost everything I can think of now or remember, connect. I think teaching should be done the same way, if any depth is considered, as well as studying and self-learning. It's time consuming, but otherwise, you are sacrificing what for time? A superficial skim or lecture? that would be more of a waste of time, rather than saving time, in my opinion. Probably, unless people acknowledge that proper learning requires time, a lot of time, the neither will be able to understand, nor will be able to to teach. Talking about going back to the main topic, let's go back there. I have started to consider hold myself less, to care for others opinions much less (proven to be almost always of no help, at the very least.), to live more like I want (as much as I can.), and less as other think is the successful way. Unfortunately, in interactions with others, I think it's still best for me to hold myself. Also, I can't usually to my job with the quality I desire, but I will try to. Take this CAM for instance, or the RAM maybe, that would be a better example. The told us to describe SRAM in VHDL with insufficient ports for basic operation. Of course I modified that for myself, afterall, as far as I know, VHDL doesn't give me transitors. The one responsible for the lab, told us that even a RAM with 2 or 4 4-bit words would do, but what you see here, me going through all the trouble from having generic form of a mux, to eventually finishing the design and description of the RAM, is far from what I am asked for, and I won't get extra credit for that, not at all. If this was some kind of a project, I wouldn't accept it, but my opinion doesn't matter to the authority (people opinions not being of worth to higher ups, which are again consists of people, is something normal in this society.). Inspite of that (and even more that I haven't mentioned here), I figured out doing this is what I wanted to do (This is a result of my worldview, which of course I can't sommarize in a page, without being almost 100% sure that a significant misunderstanding will happen, let alone a line.). If I tell them, I suffer when doing things superficially, from understanding and learning to implementing to cleaning my room(Is this some kind of obsession or idealism?), they very probably wouldn't believe, probably because they have been doing things superficially through their whole life. They probably have never have gathered the courage to be honest to themselves, let alone to be able to ever understand nuances, or complicated ideas. People like people who are simillar to them the most, usually (and I am not an exception either. Actually, me being an exception in the matter is more surprising than me not being an exception, but to some people, this sentence itself seems weird or surprising.), and that may be why they are trying, consciously or unconsciously, to make others like themselves, and that's probably the reason they have told those to me. Maybe, when they see someone navigating through complicatedness, through nuance, they feel their identity is threatened, after all, they have never done the that, tricking themselves that the way equals "taking too hard on oneself" and is not right. Unfortunately or not, I still care for my grades, but I think that, my worry and me caring for grades, will decrease even more soon. Previously, I was thinking to just survive this uni with good grades to finally, hopefully, being able to apply for a proper university abroad, where criticism, proper thinking, speaking one's mind, and doing that one believes in, is nourished instead of suppressed, not just in speak, but in action, but right now, I just thought, that academic immigration, is neither a sufficient condition, nor a needed one, for my happiness (another tricky word that can cause so much misunderstanding to most, who are unaware of the way I think, I the worldview.). That amplified when, while reading a math book (Differential equations, Boyce, and two other writers (sorry, I have forgotten their names, and full names of all three.)), I noticed that so many of brilliant people with theories there were actually self-educated. Now that I am keeping on thinking about it more seriously, I am finding more reasons for the choice, to hear less from others (same as getting rigid, probably), to care less for what others, what society, forces as accepted, forces as a value, to follow my own ideas and principles more strictly(!). One may see this as some kind of rebellion, and say that this is normal for people at my age (around 20). They may be right, or may not, but in another perspective, this can be seen as one person, seeing chains, and trying to release him from them, the chains that keep him away from living a ture, clear, and honest life, for himself. Though, this person, is not released yet, and is struggling so much. Whether I am right or wrong (generally tricky words), I hope I gather the courage to go, to try, this way. At worst case scenario, there may be some permanent consequences, after all, being of species whom are tossed into life unprepared, the most I can do, is acknowledging my mistakes, in past, present, and future, probably (acknowledging that even this sentence may be wrong, and I could do more than just acknowledging.). I think I better continue this in another file, for sure, one without ".vhd" extension, but I will let this be here.
        wdata : in std_logic_vector(DATA_WIDTH - 1 downto 0); -- The data you want it to be written
        resetn : in std_logic;
        uset_rready, uset_wready, uset_read_next_ready, uset_dready : std_logic
    );
end entity;



architecture structure of sync_CAM is

    subtype data_sub is std_logic_vector(DATA_WIDTH - 1 downto 0);
    subtype logic_sub is std_logic_vector(WORD_NUM - 1 downto 0);

    type row_type is array(WORD_NUM -1 downto 0) of std_logic_vector(DATA_WIDTH - 1 downto 0);
    type col_type is array(DATA_WIDTH - 1 downto 0) of std_logic_vector(WORD_NUM - 1 downto 0);

    signal S, Sn : logic_sub; -- Simillar: Determines whether or not data stored in each row of the memory is simillar to rddata_in
    signal SaD : logic_sub; -- Simillar and Dirty
    signal SaDaN : logic_sub; -- Simillar and Dirty and Next. Next means we have considered if the user has asked for the next match
    signal PPSaDaN: logic_sub;  -- Priority Picked Simillar and Dirty and Next
    signal PPSaDaNRQ, PPSaDaNRQn, PPSaDaNRD : logic_sub; -- PPSaDaNR: A register taking PPSaDaN as input. Only used for delay management.
    signal PPSaDaNR_resetn, PPSaDaNR_clk : std_logic;

    signal SM11: logic_sub; -- Simillar minus 1 1. Contains 1s equal to number of hits minus 1

    signal AFWO : row_type; -- Asked For Word Only. Only 1 buss, the one corresponding to the word the CAM is asked to read, has data of the word. Other busses have the value zero.

    signal word_grid_D2R, word_grid_D2Rn, word_grid_D2W : row_type;
    signal word_en : logic_sub;
    signal col_D2R : col_type;

    signal DD, DQ, DQn, Dresetn : logic_sub; -- Dirty-FF Data, Dirty-FF Q, and so on
    signal D_clk : std_logic;
    
    signal PPDQn : logic_sub; -- Priority Picked Dirty Q not, used to determine the first empty word

    signal readD, read_resetn, readQ, readQn : std_logic; -- a flip-flop for read. Purpose: edge-sensitivity
    signal writeD, write_resetn, writeQ, writeQn : std_logic; -- a flip-flop for write
    signal deleteD, delete_resetn, deleteQ, deleteQn : std_logic; -- a flip-flop for delete

    signal read_or_delete : std_logic; -- self_explanetory. BTW, NOTE: you can't read and delete, or write and delete, at the same time.

    signal maskRD, maskRQ, maskRQn : data_sub; -- mask register related stuff.
    signal maskR_resetn : std_logic;

    signal rddata_inRQ, rddata_inRD, rddata_inRQn : data_sub; -- read delete input data register related signals
    signal rddata_inR_resetn : std_logic;

    signal wdataR_resetn, wdataR_clk : std_logic;
    signal wdataRQ, wdataRQn, wdataRD : logic_sub;

    -- another regisgter saying which word we should write to
    signal W2WR_resetn, W2WR_clk : std_logic; -- W2W : word to write
    signal W2WRQ, W2WRQn, W2WRD : logic_sub;




    component minimal_D_FF is
	port (
		reset_n, clk, D : in std_logic;
		Q, Q_n : out std_logic
	);
    end component;

    component minimal_reg_nbit 
        generic (
            WIDTH : integer := 8
        );
        port(
            clear_n, clk : in std_logic;
            data : in std_logic_vector((WIDTH - 1) downto 0);
            Q, Q_n : out std_logic_vector((WIDTH - 1) downto 0)
        );
    end component;

    component simillarity_checker is 
    generic(
        DATA_WIDTH : positive
    );
    port(
        mask, data1, data2 : in std_logic_vector(DATA_WIDTH - 1 downto 0);
        simillar : out std_logic
    );
    end component;

    component word is 
    generic(
        word_size : integer := 8;
        reset_to_int_form : integer := 0
    );
    port (
        data2read, data2read_n : out std_logic_vector(word_size - 1 downto 0);
        reset_n, enable : in std_logic;
        data2write : in std_logic_vector(word_size - 1 downto 0)
    );
    end component;

    component priority_picker is 
    generic (
        WIDTH : positive := 4
    );
    port(
        input : in std_logic_vector(WIDTH - 1 downto 0); -- closer to LSB : higher priority
        output : out std_logic_vector(WIDTH - 1 downto 0)
    );
    end component;

    component generic_or is 
    generic(
        WIDTH : positive
    );
    port(
        input : in std_logic_vector(WIDTH - 1 downto 0);
        output : out std_logic
    );
    end component;

begin

    MEMORY_GRID : for i in WORD_NUM - 1 downto 0 generate 
        WORD_INST : component word
         generic map(
            word_size => DATA_WIDTH,
            reset_to_int_form => i
        )
         port map(
            data2read => word_grid_D2R(i),
            data2read_n => word_grid_D2Rn(i),
            reset_n => resetn,
            enable => word_en(i),
            data2write => word_grid_D2W(i)
        );
        word_grid_D2W(i) <= wdataRQ;
        word_en(i) <= W2WRQ(i);
    end generate;

    FIND_SIMILLAR_WORDS : for i in WORD_NUM - 1 downto 0 generate 
        SIMILLARITY_CHECKER_INST: component simillarity_checker
        generic map(
            DATA_WIDTH => DATA_WIDTH
        )
        port map(
            mask => maskRQ,
            data1 => rddata_inRQ,
            data2 => word_grid_D2R(i),
            simillar => S(i)
        );
    end generate;


    

    DIRTY_BITS: for i in WORD_NUM - 1 downto 0 generate 
        MINIMAL_D_FF_INST: minimal_D_FF
         port map(
            reset_n => Dresetn(i),
            clk => D_clk, -- give to FSM
            D => DD(i),
            Q => DQ(i),
            Q_n => DQn(i)
        );
        Dresetn(i) <= resetn;
    end generate; 
    DD <= (Sn and DQ) or W2WRQ;

    SaD <= S and DQ;
    Sn <= not S;

    PRIORITY_PICKER_FOR_SIMILLARITY: component priority_picker
     generic map(
        WIDTH => WORD_NUM
    )
     port map(
        input => SaDaN,
        output => PPSaDaN
    );

    PRIORITY_PICKED_SIMILLAR_AND_DIRTY_AND_NEXT_REGISTER: minimal_reg_nbit -- Now you see why I have been using abbreviations instead of the whole word.
     generic map(
        WIDTH => WORD_NUM
    )
     port map(
        clear_n => PPSADANR_resetn, -- give to FSM
        clk => PPSaDaNR_clk, -- Using this will give us the next match
        data => PPSaDaNRD,
        Q => PPSaDaNRQ,
        Q_n => PPSaDaNRQn
    );

    PPSaDaNRD <= PPSaDaN;
    SaDaN <= PPSaDaNRQn and SaD;

    HIT_OR_MISSNOT: component generic_or
     generic map(
        WIDTH => WORD_NUM
    )
     port map(
        input => SaD,
        output => hit
    );

    SM11 <= (not PPSaDaN) and SaD;

    OTHER_HITS_FINDER: component generic_or
     generic map(
        WIDTH => WORD_NUM
    )
     port map(
        input => SM11,
        output => other_hits
    );

    FIND_AFWO : for i in WORD_NUM - 1 downto 0 generate -- fix here
        CALCULATE_AFWO: for j in DATA_WIDTH - 1 downto 0 generate
            AFWO(i)(j) <= PPSaDaN(i) and word_grid_D2R(i)(j);
        end generate;
    end generate;

    FIND_COL1 : for i in DATA_WIDTH - 1 downto 0 generate 
        FIND_COL2 : for j in WORD_NUM - 1 downto 0 generate
            col_D2R(i)(j) <= AFWO(j)(i);
        end generate;
    end generate;

    FIND_WANTED_WORD : for i in DATA_WIDTH - 1 downto 0 generate
        FIND_THE_WORD: component generic_or
        generic map(
            WIDTH => WORD_NUM
        )
        port map(
            input => col_D2R(i),
            output => rdata(i)
        );
    end generate;

    PRIORITY_PICKER_FOR_WRITE: component priority_picker
     generic map(
        WIDTH => WORD_NUM
    )
     port map(
        input => DQn,
        output => PPDQn
    );

    D_FF_FOR_READ: minimal_D_FF
     port map(
        reset_n => read_resetn, -- give to FSM
        clk => read,
        D => readD,
        Q => readQ,
        Q_n => readQn
    );
    readD <= '1';

    D_FF_FOR_WRITE: component minimal_D_FF
     port map(
        reset_n => write_resetn, -- give to FSM
        clk => write,
        D => writeD,
        Q => writeQ,
        Q_n => writeQn
    );
    writeD <= '1';

    D_FF_FOR_DELETE: component minimal_D_FF
     port map(
        reset_n => delete_resetn, -- give to FSM
        clk => delete,
        D => deleteD,
        Q => deleteQ,
        Q_n => deleteQn
    );
    deleteD <= '1';

    read_or_delete <= read or delete;

    MASK_REG: minimal_reg_nbit
     generic map(
        WIDTH => DATA_WIDTH
    )
     port map(
        clear_n => maskR_resetn,
        clk => read_or_delete,
        data => maskRD,
        Q => maskRQ,
        Q_n => maskRQn
    );
    maskR_resetn <= resetn;
    maskRD <= mask;

    RDDATA_IN_REG: minimal_reg_nbit
     generic map(
        WIDTH => DATA_WIDTH
    )
     port map(
        clear_n => rddata_inR_resetn,
        clk => read_or_delete,
        data => rddata_inRD,
        Q => rddata_inRQ,
        Q_n => rddata_inRQn
    );
    rddata_inR_resetn <= resetn;
    rddata_inRD <= rddata_in;

    WDATA_REG: minimal_reg_nbit
     generic map(
        WIDTH => DATA_WIDTH
    )
     port map(
        clear_n => wdataR_resetn,
        clk => wdataR_clk,
        data => wdataRD,
        Q => wdataRQ,
        Q_n => wdataRQn
    );
    wdataRD <= wdata;
    wdataR_clk <= write;
    wdataR_resetn <= resetn;

    W2W_REGISTER: minimal_reg_nbit
     generic map(
        WIDTH => WORD_NUM
    )
     port map(
        clear_n => W2WR_resetn, -- give to FSM
        clk => W2WR_clk, -- give to FSM
        data => W2WRD,
        Q => W2WRQ,
        Q_n => W2WRQn
    );
    W2WRD <= PPDQn;
    



    


    

    

end architecture;