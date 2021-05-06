KCPSM3  v1.30.      Ken Chapman (Xilinx-UK) 2005

The assembler for KCPSM3 Programmable State Machine

PASS 1 - Reading input PSM file

; KCPSM3 Program - Practice Picoblaze on Spartan-3A Starter Kit.
;
;
;
;
; The 8 LEDs provide a simple 'heart beat' counter driven by interrupts generated at
; one second intervals.
;
;
;**************************************************************************************
; Port definitions
;**************************************************************************************
;
;
;
CONSTANT LED_port, 80               ;8 simple LEDs. Is an OUTPUT port.
CONSTANT DATA_IN_PORT, 00         ;input data port. this is an INPUT port.
CONSTANT SSEG_PORT0, 40
CONSTANT SSEG_PORT1, 20
CONSTANT SSEG_PORT2, 10
;//////define the port for the LED[0]
CONSTANT LED_heartbeat, 08
;**************************************************************************************
; Special Register usage
;**************************************************************************************
;
; No registers are given special names in this program.
;
;**************************************************************************************
; Scratch Pad Memory Locations
;**************************************************************************************
;
;
CONSTANT ISR_preserve_s0, 00        ;Preserve s0 contents during ISR
CONSTANT ISR_preserve_s1, 01        ;Preserve s1 contents during ISR
CONSTANT ISR_preserve_s2, 02        ;Preserve s2 contents during ISR
CONSTANT ISR_preserve_s3, 03        ;Preserve s3 contents during ISR
;
CONSTANT LED_pattern, 04            ;remember state of LEDs (8-bit counter in this case)
;
;**************************************************************************************
; Useful data constants
;**************************************************************************************
;
;
; Constant to define a software delay of 1us. This must be adjusted to reflect the
; clock applied to KCPSM3. Every instruction executes in 2 clock cycles making the
; calculation highly predictable. The '6' in the following equation even allows for
; 'CALL delay_1us' instruction in the initiating code.
;
; delay_1us_constant =  (clock_rate - 6)/4       Where 'clock_rate' is in MHz
;
; Example: For a 50MHz clock the constant value is (50-6)/4 = 11  (0B Hex).
; For clock rates below 10MHz the value of 1 must be used and the operation will
; become lower than intended. Interrupts may effect the timing of software based
; delays.
;
CONSTANT delay_1us_constant, 0B
;
;
;
; ASCII table
;
CONSTANT character_a, 61
CONSTANT character_b, 62
CONSTANT character_c, 63
CONSTANT character_d, 64
CONSTANT character_e, 65
CONSTANT character_f, 66
CONSTANT character_g, 67
CONSTANT character_h, 68
CONSTANT character_i, 69
CONSTANT character_j, 6A
CONSTANT character_k, 6B
CONSTANT character_l, 6C
CONSTANT character_m, 6D
CONSTANT character_n, 6E
CONSTANT character_o, 6F
CONSTANT character_p, 70
CONSTANT character_q, 71
CONSTANT character_r, 72
CONSTANT character_s, 73
CONSTANT character_t, 74
CONSTANT character_u, 75
CONSTANT character_v, 76
CONSTANT character_w, 77
CONSTANT character_x, 78
CONSTANT character_y, 79
CONSTANT character_z, 7A
CONSTANT character_A, 41
CONSTANT character_B, 42
CONSTANT character_C, 43
CONSTANT character_D, 44
CONSTANT character_E, 45
CONSTANT character_F, 46
CONSTANT character_G, 47
CONSTANT character_H, 48
CONSTANT character_I, 49
CONSTANT character_J, 4A
CONSTANT character_K, 4B
CONSTANT character_L, 4C
CONSTANT character_M, 4D
CONSTANT character_N, 4E
CONSTANT character_O, 4F
CONSTANT character_P, 50
CONSTANT character_Q, 51
CONSTANT character_R, 52
CONSTANT character_S, 53
CONSTANT character_T, 54
CONSTANT character_U, 55
CONSTANT character_V, 56
CONSTANT character_W, 57
CONSTANT character_X, 58
CONSTANT character_Y, 59
CONSTANT character_Z, 5A
CONSTANT character_0, 30
CONSTANT character_1, 31
CONSTANT character_2, 32
CONSTANT character_3, 33
CONSTANT character_4, 34
CONSTANT character_5, 35
CONSTANT character_6, 36
CONSTANT character_7, 37
CONSTANT character_8, 38
CONSTANT character_9, 39
CONSTANT character_colon, 3A
CONSTANT character_stop, 2E
CONSTANT character_semi_colon, 3B
CONSTANT character_minus, 2D
CONSTANT character_divide, 2F       ;'/'
CONSTANT character_plus, 2B
CONSTANT character_comma, 2C
CONSTANT character_less_than, 3C
CONSTANT character_greater_than, 3E
CONSTANT character_equals, 3D
CONSTANT character_space, 20
CONSTANT character_CR, 0D           ;carriage return
CONSTANT character_question, 3F     ;'?'
CONSTANT character_dollar, 24
CONSTANT character_exclaim, 21      ;'!'
CONSTANT character_BS, 08           ;Back Space command character
;
;
;
;
;
;**************************************************************************************
; Initialise the system
;**************************************************************************************
;
cold_start: LOAD s0, 00                         ;clear 1 second counter and clear LEDs
STORE s0, LED_pattern
OUTPUT s0, LED_port
;
ENABLE INTERRUPT                    ;enable one second heart beat
;**************************************************************************************
; Main program
;**************************************************************************************
;
; Display welcome message for design
;
main_program: CALL delay_1s;
;////Lab 3
;Make the heart-beat on LED[0]
LOAD s0, 01
OUTPUT s0, LED_heartbeat
CALL delay_1s
LOAD s0, 00
OUTPUT s0, LED_heartbeat
JUMP main_program
;   check_switches: INPUT s0,DATA_IN_PORT               ;get status of switches
;           TEST s0, 01                 ;test to see if switch 0 is 1
;           JUMP NZ, just_clear_the_display          ;if switch 0 is 1display
;
;                   ;my code///////////This is for in-class activity/////////////////////
;                  ;INPUT s1,DATA_IN_PORT
;                 ;TEST s1, 02
;                ;JUMP NZ, decrease_the_counter
;               ;/////////////////////////////////////////
;
;          CALL add_1_to_counter                   ;if the switches are not 0, then shift the display left
;display_the_counter: CALL update_seven_segments
;            CALL delay_1s;
;            JUMP check_switches;
;just_clear_the_display:   load s8, 00;
;        load s9, 00;
;        load sA, 00;
;           CALL update_seven_segments
;        JUMP main_program;
;add_1_to_counter:         add s8, 01
;        addcy s9, 00
;        addcy sA, 00
;        RETURN
;update_seven_segments : output s8, SSEG_PORT0
;                       output s9, SSEG_PORT1
;                      output sA, SSEG_PORT2
;     RETURN
; my code//////////This is for in-class activity////////////////////////
;decrease_the_counter: sub s8, 01
;                  subcy s9, 00
;                   subcy sA, 00
;                   CALL display_the_counter
;//////////////////////////////////////
;**************************************************************************************
; Routines to display hexadecimal values
;**************************************************************************************
;
;
; Convert hexadecimal value provided in register s0 into ASCII characters
;
; The value provided must can be any value in the range 00 to FF and will be converted into
; two ASCII characters.
;     The upper nibble will be represented by an ASCII character returned in register s3.
;     The lower nibble will be represented by an ASCII character returned in register s2.
;
; The ASCII representations of '0' to '9' are 30 to 39 hexadecimal which is simply 30 hex
; added to the actual decimal value. The ASCII representations of 'A' to 'F' are 41 to 46
; hexadecimal requiring a further addition of 07 to the 30 already added.
;
; Registers used s0, s2 and s3.
;
hex_byte_to_ASCII: LOAD s2, s0                         ;remember value supplied
SR0 s0                              ;isolate upper nibble
SR0 s0
SR0 s0
SR0 s0
CALL hex_to_ASCII                   ;convert
LOAD s3, s0                         ;upper nibble value in s3
LOAD s0, s2                         ;restore complete value
AND s0, 0F                          ;isolate lower nibble
CALL hex_to_ASCII                   ;convert
LOAD s2, s0                         ;lower nibble value in s2
RETURN
;
; Convert hexadecimal value provided in register s0 into ASCII character
;
;Register used s0
;
hex_to_ASCII: SUB s0, 0A                          ;test if value is in range 0 to 9
JUMP C, number_char
ADD s0, 07                          ;ASCII char A to F in range 41 to 46
number_char: ADD s0, 3A                          ;ASCII char 0 to 9 in range 30 to 40
RETURN
;**************************************************************************************
; Software delay routines
;**************************************************************************************
;
; Delay of 1us.
;
; Constant value 'delay_1us_constant' reflects the clock applied to KCPSM3. Every
; instruction executes in 2 clock cycles making the calculation highly predictable.
; The '6' in the following equation allows for the 'CALL delay_1us' instruction used
; in the initiating code. Interrupts may effect software derived delays.
;
; delay_1us_constant =  (clock_rate - 6)/4       Where 'clock_rate' is in MHz
;
; Registers used s0
;
delay_1us: LOAD s0, delay_1us_constant
wait_1us: SUB s0, 01
JUMP NZ, wait_1us
RETURN
;
; Delay of 40us.
;
; Registers used s0, s1
;
delay_40us: LOAD s1, 28                         ;40 x 1us = 40us
wait_40us: CALL delay_1us
SUB s1, 01
JUMP NZ, wait_40us
RETURN
;
;
; Delay of 1ms.
;
; Registers used s0, s1, s2
;
delay_1ms: LOAD s2, 19                         ;25 x 40us = 1ms
wait_1ms: CALL delay_40us
SUB s2, 01
JUMP NZ, wait_1ms
RETURN
;
; Delay of 20ms.
;
; Delay of 20ms used during initialisation.
;
; Registers used s0, s1, s2, s3
;
delay_20ms: LOAD s3, 14                         ;20 x 1ms = 20ms
wait_20ms: CALL delay_1ms
SUB s3, 01
JUMP NZ, wait_20ms
RETURN
delay_100ms: LOAD s3, 64                         ;100 x 1ms = 20ms
wait_100ms: CALL delay_1ms
SUB s3, 01
JUMP NZ, wait_100ms
RETURN
;
; Delay of approximately 1 second.
;
; Registers used s0, s1, s2, s3, s4
;
delay_1s: LOAD s4, 32                         ;50 x 20ms = 1000ms
wait_1s: CALL delay_20ms
SUB s4, 01
JUMP NZ, wait_1s
RETURN
;
;
;
;**************************************************************************************
; Interrupt Service Routine (ISR)
;**************************************************************************************
;
; The interrupt is used purely to provide a 1 second heart beat binary counter pattern
; on the 8 LEDs.
;
ISR: STORE s0, ISR_preserve_s0           ;preserve register
;FETCH s0, LED_pattern               ;read current counter value
FETCH s0, DATA_IN_PORT       ;read audio_data
LOAD s5, 00                  ;Set the initial counter to 0.
;LOAD s0, FF                         ;test the 9:2 LEDs
while: COMPARE s5, FF               ;check if counter is d'256
display_leds:  STORE s0, LED_pattern               ;store new counter value
OUTPUT s0, LED_port                 ;display counter value on LEDs
FETCH s0, ISR_preserve_s0           ;restore register
RETURNI ENABLE
;
;
;**************************************************************************************
; Interrupt Vector
;**************************************************************************************
;
ADDRESS 3FF
JUMP ISR
;
;

PASS 2 - Testing Instructions

; KCPSM3 Program - Practice Picoblaze on Spartan-3A Starter Kit.
;
;
;
;
; The 8 LEDs provide a simple 'heart beat' counter driven by interrupts generated at
; one second intervals.
;
;
;**************************************************************************************
; Port definitions
;**************************************************************************************
;
;
;
CONSTANT LED_port, 80;8 simple LEDs. Is an OUTPUT port.
CONSTANT DATA_IN_PORT, 00;input data port. this is an INPUT port.
CONSTANT SSEG_PORT0, 40
CONSTANT SSEG_PORT1, 20
CONSTANT SSEG_PORT2, 10
;//////define the port for the LED[0]
CONSTANT LED_heartbeat, 08
;**************************************************************************************
; Special Register usage
;**************************************************************************************
;
; No registers are given special names in this program.
;
;**************************************************************************************
; Scratch Pad Memory Locations
;**************************************************************************************
;
;
CONSTANT ISR_preserve_s0, 00;Preserve s0 contents during ISR
CONSTANT ISR_preserve_s1, 01;Preserve s1 contents during ISR
CONSTANT ISR_preserve_s2, 02;Preserve s2 contents during ISR
CONSTANT ISR_preserve_s3, 03;Preserve s3 contents during ISR
;
CONSTANT LED_pattern, 04;remember state of LEDs (8-bit counter in this case)
;
;**************************************************************************************
; Useful data constants
;**************************************************************************************
;
;
; Constant to define a software delay of 1us. This must be adjusted to reflect the
; clock applied to KCPSM3. Every instruction executes in 2 clock cycles making the
; calculation highly predictable. The '6' in the following equation even allows for
; 'CALL delay_1us' instruction in the initiating code.
;
; delay_1us_constant =  (clock_rate - 6)/4       Where 'clock_rate' is in MHz
;
; Example: For a 50MHz clock the constant value is (50-6)/4 = 11  (0B Hex).
; For clock rates below 10MHz the value of 1 must be used and the operation will
; become lower than intended. Interrupts may effect the timing of software based
; delays.
;
CONSTANT delay_1us_constant, 0B
;
;
;
; ASCII table
;
CONSTANT character_a, 61
CONSTANT character_b, 62
CONSTANT character_c, 63
CONSTANT character_d, 64
CONSTANT character_e, 65
CONSTANT character_f, 66
CONSTANT character_g, 67
CONSTANT character_h, 68
CONSTANT character_i, 69
CONSTANT character_j, 6A
CONSTANT character_k, 6B
CONSTANT character_l, 6C
CONSTANT character_m, 6D
CONSTANT character_n, 6E
CONSTANT character_o, 6F
CONSTANT character_p, 70
CONSTANT character_q, 71
CONSTANT character_r, 72
CONSTANT character_s, 73
CONSTANT character_t, 74
CONSTANT character_u, 75
CONSTANT character_v, 76
CONSTANT character_w, 77
CONSTANT character_x, 78
CONSTANT character_y, 79
CONSTANT character_z, 7A
CONSTANT character_A, 41
CONSTANT character_B, 42
CONSTANT character_C, 43
CONSTANT character_D, 44
CONSTANT character_E, 45
CONSTANT character_F, 46
CONSTANT character_G, 47
CONSTANT character_H, 48
CONSTANT character_I, 49
CONSTANT character_J, 4A
CONSTANT character_K, 4B
CONSTANT character_L, 4C
CONSTANT character_M, 4D
CONSTANT character_N, 4E
CONSTANT character_O, 4F
CONSTANT character_P, 50
CONSTANT character_Q, 51
CONSTANT character_R, 52
CONSTANT character_S, 53
CONSTANT character_T, 54
CONSTANT character_U, 55
CONSTANT character_V, 56
CONSTANT character_W, 57
CONSTANT character_X, 58
CONSTANT character_Y, 59
CONSTANT character_Z, 5A
CONSTANT character_0, 30
CONSTANT character_1, 31
CONSTANT character_2, 32
CONSTANT character_3, 33
CONSTANT character_4, 34
CONSTANT character_5, 35
CONSTANT character_6, 36
CONSTANT character_7, 37
CONSTANT character_8, 38
CONSTANT character_9, 39
CONSTANT character_colon, 3A
CONSTANT character_stop, 2E
CONSTANT character_semi_colon, 3B
CONSTANT character_minus, 2D
CONSTANT character_divide, 2F;'/'
CONSTANT character_plus, 2B
CONSTANT character_comma, 2C
CONSTANT character_less_than, 3C
CONSTANT character_greater_than, 3E
CONSTANT character_equals, 3D
CONSTANT character_space, 20
CONSTANT character_CR, 0D;carriage return
CONSTANT character_question, 3F;'?'
CONSTANT character_dollar, 24
CONSTANT character_exclaim, 21;'!'
CONSTANT character_BS, 08;Back Space command character
;
;
;
;
;
;**************************************************************************************
; Initialise the system
;**************************************************************************************
;
cold_start: LOAD s0, 00;clear 1 second counter and clear LEDs
STORE s0, LED_pattern
OUTPUT s0, LED_port
;
ENABLE INTERRUPT;enable one second heart beat
;**************************************************************************************
; Main program
;**************************************************************************************
;
; Display welcome message for design
;
main_program: CALL delay_1s;
;////Lab 3
;Make the heart-beat on LED[0]
LOAD s0, 01
OUTPUT s0, LED_heartbeat
CALL delay_1s
LOAD s0, 00
OUTPUT s0, LED_heartbeat
JUMP main_program
;   check_switches: INPUT s0,DATA_IN_PORT               ;get status of switches
;           TEST s0, 01                 ;test to see if switch 0 is 1
;           JUMP NZ, just_clear_the_display          ;if switch 0 is 1display
;
;                   ;my code///////////This is for in-class activity/////////////////////
;                  ;INPUT s1,DATA_IN_PORT
;                 ;TEST s1, 02
;                ;JUMP NZ, decrease_the_counter
;               ;/////////////////////////////////////////
;
;          CALL add_1_to_counter                   ;if the switches are not 0, then shift the display left
;display_the_counter: CALL update_seven_segments
;            CALL delay_1s;
;            JUMP check_switches;
;just_clear_the_display:   load s8, 00;
;        load s9, 00;
;        load sA, 00;
;           CALL update_seven_segments
;        JUMP main_program;
;add_1_to_counter:         add s8, 01
;        addcy s9, 00
;        addcy sA, 00
;        RETURN
;update_seven_segments : output s8, SSEG_PORT0
;                       output s9, SSEG_PORT1
;                      output sA, SSEG_PORT2
;     RETURN
; my code//////////This is for in-class activity////////////////////////
;decrease_the_counter: sub s8, 01
;                  subcy s9, 00
;                   subcy sA, 00
;                   CALL display_the_counter
;//////////////////////////////////////
;**************************************************************************************
; Routines to display hexadecimal values
;**************************************************************************************
;
;
; Convert hexadecimal value provided in register s0 into ASCII characters
;
; The value provided must can be any value in the range 00 to FF and will be converted into
; two ASCII characters.
;     The upper nibble will be represented by an ASCII character returned in register s3.
;     The lower nibble will be represented by an ASCII character returned in register s2.
;
; The ASCII representations of '0' to '9' are 30 to 39 hexadecimal which is simply 30 hex
; added to the actual decimal value. The ASCII representations of 'A' to 'F' are 41 to 46
; hexadecimal requiring a further addition of 07 to the 30 already added.
;
; Registers used s0, s2 and s3.
;
hex_byte_to_ASCII: LOAD s2, s0;remember value supplied
SR0 s0;isolate upper nibble
SR0 s0
SR0 s0
SR0 s0
CALL hex_to_ASCII;convert
LOAD s3, s0;upper nibble value in s3
LOAD s0, s2;restore complete value
AND s0, 0F;isolate lower nibble
CALL hex_to_ASCII;convert
LOAD s2, s0;lower nibble value in s2
RETURN
;
; Convert hexadecimal value provided in register s0 into ASCII character
;
;Register used s0
;
hex_to_ASCII: SUB s0, 0A;test if value is in range 0 to 9
JUMP C, number_char
ADD s0, 07;ASCII char A to F in range 41 to 46
number_char: ADD s0, 3A;ASCII char 0 to 9 in range 30 to 40
RETURN
;**************************************************************************************
; Software delay routines
;**************************************************************************************
;
; Delay of 1us.
;
; Constant value 'delay_1us_constant' reflects the clock applied to KCPSM3. Every
; instruction executes in 2 clock cycles making the calculation highly predictable.
; The '6' in the following equation allows for the 'CALL delay_1us' instruction used
; in the initiating code. Interrupts may effect software derived delays.
;
; delay_1us_constant =  (clock_rate - 6)/4       Where 'clock_rate' is in MHz
;
; Registers used s0
;
delay_1us: LOAD s0, delay_1us_constant
wait_1us: SUB s0, 01
JUMP NZ, wait_1us
RETURN
;
; Delay of 40us.
;
; Registers used s0, s1
;
delay_40us: LOAD s1, 28;40 x 1us = 40us
wait_40us: CALL delay_1us
SUB s1, 01
JUMP NZ, wait_40us
RETURN
;
;
; Delay of 1ms.
;
; Registers used s0, s1, s2
;
delay_1ms: LOAD s2, 19;25 x 40us = 1ms
wait_1ms: CALL delay_40us
SUB s2, 01
JUMP NZ, wait_1ms
RETURN
;
; Delay of 20ms.
;
; Delay of 20ms used during initialisation.
;
; Registers used s0, s1, s2, s3
;
delay_20ms: LOAD s3, 14;20 x 1ms = 20ms
wait_20ms: CALL delay_1ms
SUB s3, 01
JUMP NZ, wait_20ms
RETURN
delay_100ms: LOAD s3, 64;100 x 1ms = 20ms
wait_100ms: CALL delay_1ms
SUB s3, 01
JUMP NZ, wait_100ms
RETURN
;
; Delay of approximately 1 second.
;
; Registers used s0, s1, s2, s3, s4
;
delay_1s: LOAD s4, 32;50 x 20ms = 1000ms
wait_1s: CALL delay_20ms
SUB s4, 01
JUMP NZ, wait_1s
RETURN
;
;
;
;**************************************************************************************
; Interrupt Service Routine (ISR)
;**************************************************************************************
;
; The interrupt is used purely to provide a 1 second heart beat binary counter pattern
; on the 8 LEDs.
;
ISR: STORE s0, ISR_preserve_s0;preserve register
;FETCH s0, LED_pattern               ;read current counter value
FETCH s0, DATA_IN_PORT;read audio_data
LOAD s5, 00;Set the initial counter to 0.
;LOAD s0, FF                         ;test the 9:2 LEDs
while: COMPARE s5, FF;check if counter is d'256
display_leds: STORE s0, LED_pattern;store new counter value
OUTPUT s0, LED_port;display counter value on LEDs
FETCH s0, ISR_preserve_s0;restore register
RETURNI ENABLE
;
;
;**************************************************************************************
; Interrupt Vector
;**************************************************************************************
;
ADDRESS 3FF
JUMP ISR
;
;

PASS 3 - Resolving addresses and line labels

000 ; KCPSM3 Program - Practice Picoblaze on Spartan-3A Starter Kit.
000 ;
000 ;
000 ;
000 ;
000 
; The 8 LEDs provide a simple 'heart beat' counter driven by interrupts generated at
000 ; one second intervals.
000 ;
000 ;
000 
;**************************************************************************************
000 ; Port definitions
000 
;**************************************************************************************
000 ;
000 ;
000 ;
000 CONSTANT LED_port, 80;8 simple LEDs. Is an OUTPUT port.
000 CONSTANT DATA_IN_PORT, 00;input data port. this is an INPUT port.
000 CONSTANT SSEG_PORT0, 40
000 CONSTANT SSEG_PORT1, 20
000 CONSTANT SSEG_PORT2, 10
000 ;//////define the port for the LED[0]
000 CONSTANT LED_heartbeat, 08
000 
;**************************************************************************************
000 ; Special Register usage
000 
;**************************************************************************************
000 ;
000 ; No registers are given special names in this program.
000 ;
000 
;**************************************************************************************
000 ; Scratch Pad Memory Locations
000 
;**************************************************************************************
000 ;
000 ;
000 CONSTANT ISR_preserve_s0, 00;Preserve s0 contents during ISR
000 CONSTANT ISR_preserve_s1, 01;Preserve s1 contents during ISR
000 CONSTANT ISR_preserve_s2, 02;Preserve s2 contents during ISR
000 CONSTANT ISR_preserve_s3, 03;Preserve s3 contents during ISR
000 ;
000 CONSTANT LED_pattern, 04;remember state of LEDs (8-bit counter in this case)
000 ;
000 
;**************************************************************************************
000 ; Useful data constants
000 
;**************************************************************************************
000 ;
000 ;
000 
; Constant to define a software delay of 1us. This must be adjusted to reflect the
000 
; clock applied to KCPSM3. Every instruction executes in 2 clock cycles making the
000 
; calculation highly predictable. The '6' in the following equation even allows for
000 ; 'CALL delay_1us' instruction in the initiating code.
000 ;
000 
; delay_1us_constant =  (clock_rate - 6)/4       Where 'clock_rate' is in MHz
000 ;
000 ; Example: For a 50MHz clock the constant value is (50-6)/4 = 11  (0B Hex).
000 
; For clock rates below 10MHz the value of 1 must be used and the operation will
000 
; become lower than intended. Interrupts may effect the timing of software based
000 ; delays.
000 ;
000 CONSTANT delay_1us_constant, 0B
000 ;
000 ;
000 ;
000 ; ASCII table
000 ;
000 CONSTANT character_a, 61
000 CONSTANT character_b, 62
000 CONSTANT character_c, 63
000 CONSTANT character_d, 64
000 CONSTANT character_e, 65
000 CONSTANT character_f, 66
000 CONSTANT character_g, 67
000 CONSTANT character_h, 68
000 CONSTANT character_i, 69
000 CONSTANT character_j, 6A
000 CONSTANT character_k, 6B
000 CONSTANT character_l, 6C
000 CONSTANT character_m, 6D
000 CONSTANT character_n, 6E
000 CONSTANT character_o, 6F
000 CONSTANT character_p, 70
000 CONSTANT character_q, 71
000 CONSTANT character_r, 72
000 CONSTANT character_s, 73
000 CONSTANT character_t, 74
000 CONSTANT character_u, 75
000 CONSTANT character_v, 76
000 CONSTANT character_w, 77
000 CONSTANT character_x, 78
000 CONSTANT character_y, 79
000 CONSTANT character_z, 7A
000 CONSTANT character_A, 41
000 CONSTANT character_B, 42
000 CONSTANT character_C, 43
000 CONSTANT character_D, 44
000 CONSTANT character_E, 45
000 CONSTANT character_F, 46
000 CONSTANT character_G, 47
000 CONSTANT character_H, 48
000 CONSTANT character_I, 49
000 CONSTANT character_J, 4A
000 CONSTANT character_K, 4B
000 CONSTANT character_L, 4C
000 CONSTANT character_M, 4D
000 CONSTANT character_N, 4E
000 CONSTANT character_O, 4F
000 CONSTANT character_P, 50
000 CONSTANT character_Q, 51
000 CONSTANT character_R, 52
000 CONSTANT character_S, 53
000 CONSTANT character_T, 54
000 CONSTANT character_U, 55
000 CONSTANT character_V, 56
000 CONSTANT character_W, 57
000 CONSTANT character_X, 58
000 CONSTANT character_Y, 59
000 CONSTANT character_Z, 5A
000 CONSTANT character_0, 30
000 CONSTANT character_1, 31
000 CONSTANT character_2, 32
000 CONSTANT character_3, 33
000 CONSTANT character_4, 34
000 CONSTANT character_5, 35
000 CONSTANT character_6, 36
000 CONSTANT character_7, 37
000 CONSTANT character_8, 38
000 CONSTANT character_9, 39
000 CONSTANT character_colon, 3A
000 CONSTANT character_stop, 2E
000 CONSTANT character_semi_colon, 3B
000 CONSTANT character_minus, 2D
000 CONSTANT character_divide, 2F;'/'
000 CONSTANT character_plus, 2B
000 CONSTANT character_comma, 2C
000 CONSTANT character_less_than, 3C
000 CONSTANT character_greater_than, 3E
000 CONSTANT character_equals, 3D
000 CONSTANT character_space, 20
000 CONSTANT character_CR, 0D;carriage return
000 CONSTANT character_question, 3F;'?'
000 CONSTANT character_dollar, 24
000 CONSTANT character_exclaim, 21;'!'
000 CONSTANT character_BS, 08;Back Space command character
000 ;
000 ;
000 ;
000 ;
000 ;
000 
;**************************************************************************************
000 ; Initialise the system
000 
;**************************************************************************************
000 ;
000 cold_start: LOAD s0, 00;clear 1 second counter and clear LEDs
001 STORE s0, LED_pattern
002 OUTPUT s0, LED_port
003 ;
003 ENABLE INTERRUPT;enable one second heart beat
004 
;**************************************************************************************
004 ; Main program
004 
;**************************************************************************************
004 ;
004 ; Display welcome message for design
004 ;
004 main_program: CALL delay_1s;
005 ;////Lab 3
005 ;Make the heart-beat on LED[0]
005 LOAD s0, 01
006 OUTPUT s0, LED_heartbeat
007 CALL delay_1s
008 LOAD s0, 00
009 OUTPUT s0, LED_heartbeat
00A JUMP main_program
00B 
;   check_switches: INPUT s0,DATA_IN_PORT               ;get status of switches
00B ;           TEST s0, 01                 ;test to see if switch 0 is 1
00B 
;           JUMP NZ, just_clear_the_display          ;if switch 0 is 1display
00B ;
00B 
;                   ;my code///////////This is for in-class activity/////////////////////
00B ;                  ;INPUT s1,DATA_IN_PORT
00B ;                 ;TEST s1, 02
00B ;                ;JUMP NZ, decrease_the_counter
00B ;               ;/////////////////////////////////////////
00B ;
00B 
;          CALL add_1_to_counter                   ;if the switches are not 0, then shift the display left
00B ;display_the_counter: CALL update_seven_segments
00B ;            CALL delay_1s;
00B ;            JUMP check_switches;
00B ;just_clear_the_display:   load s8, 00;
00B ;        load s9, 00;
00B ;        load sA, 00;
00B ;           CALL update_seven_segments
00B ;        JUMP main_program;
00B ;add_1_to_counter:         add s8, 01
00B ;        addcy s9, 00
00B ;        addcy sA, 00
00B ;        RETURN
00B ;update_seven_segments : output s8, SSEG_PORT0
00B ;                       output s9, SSEG_PORT1
00B ;                      output sA, SSEG_PORT2
00B ;     RETURN
00B ; my code//////////This is for in-class activity////////////////////////
00B ;decrease_the_counter: sub s8, 01
00B ;                  subcy s9, 00
00B ;                   subcy sA, 00
00B ;                   CALL display_the_counter
00B ;//////////////////////////////////////
00B 
;**************************************************************************************
00B ; Routines to display hexadecimal values
00B 
;**************************************************************************************
00B ;
00B ;
00B ; Convert hexadecimal value provided in register s0 into ASCII characters
00B ;
00B 
; The value provided must can be any value in the range 00 to FF and will be converted into
00B ; two ASCII characters.
00B 
;     The upper nibble will be represented by an ASCII character returned in register s3.
00B 
;     The lower nibble will be represented by an ASCII character returned in register s2.
00B ;
00B 
; The ASCII representations of '0' to '9' are 30 to 39 hexadecimal which is simply 30 hex
00B 
; added to the actual decimal value. The ASCII representations of 'A' to 'F' are 41 to 46
00B ; hexadecimal requiring a further addition of 07 to the 30 already added.
00B ;
00B ; Registers used s0, s2 and s3.
00B ;
00B hex_byte_to_ASCII: LOAD s2, s0;remember value supplied
00C SR0 s0;isolate upper nibble
00D SR0 s0
00E SR0 s0
00F SR0 s0
010 CALL hex_to_ASCII;convert
011 LOAD s3, s0;upper nibble value in s3
012 LOAD s0, s2;restore complete value
013 AND s0, 0F;isolate lower nibble
014 CALL hex_to_ASCII;convert
015 LOAD s2, s0;lower nibble value in s2
016 RETURN
017 ;
017 ; Convert hexadecimal value provided in register s0 into ASCII character
017 ;
017 ;Register used s0
017 ;
017 hex_to_ASCII: SUB s0, 0A;test if value is in range 0 to 9
018 JUMP C, number_char
019 ADD s0, 07;ASCII char A to F in range 41 to 46
01A number_char: ADD s0, 3A;ASCII char 0 to 9 in range 30 to 40
01B RETURN
01C 
;**************************************************************************************
01C ; Software delay routines
01C 
;**************************************************************************************
01C ;
01C ; Delay of 1us.
01C ;
01C 
; Constant value 'delay_1us_constant' reflects the clock applied to KCPSM3. Every
01C 
; instruction executes in 2 clock cycles making the calculation highly predictable.
01C 
; The '6' in the following equation allows for the 'CALL delay_1us' instruction used
01C ; in the initiating code. Interrupts may effect software derived delays.
01C ;
01C 
; delay_1us_constant =  (clock_rate - 6)/4       Where 'clock_rate' is in MHz
01C ;
01C ; Registers used s0
01C ;
01C delay_1us: LOAD s0, delay_1us_constant
01D wait_1us: SUB s0, 01
01E JUMP NZ, wait_1us
01F RETURN
020 ;
020 ; Delay of 40us.
020 ;
020 ; Registers used s0, s1
020 ;
020 delay_40us: LOAD s1, 28;40 x 1us = 40us
021 wait_40us: CALL delay_1us
022 SUB s1, 01
023 JUMP NZ, wait_40us
024 RETURN
025 ;
025 ;
025 ; Delay of 1ms.
025 ;
025 ; Registers used s0, s1, s2
025 ;
025 delay_1ms: LOAD s2, 19;25 x 40us = 1ms
026 wait_1ms: CALL delay_40us
027 SUB s2, 01
028 JUMP NZ, wait_1ms
029 RETURN
02A ;
02A ; Delay of 20ms.
02A ;
02A ; Delay of 20ms used during initialisation.
02A ;
02A ; Registers used s0, s1, s2, s3
02A ;
02A delay_20ms: LOAD s3, 14;20 x 1ms = 20ms
02B wait_20ms: CALL delay_1ms
02C SUB s3, 01
02D JUMP NZ, wait_20ms
02E RETURN
02F delay_100ms: LOAD s3, 64;100 x 1ms = 20ms
030 wait_100ms: CALL delay_1ms
031 SUB s3, 01
032 JUMP NZ, wait_100ms
033 RETURN
034 ;
034 ; Delay of approximately 1 second.
034 ;
034 ; Registers used s0, s1, s2, s3, s4
034 ;
034 delay_1s: LOAD s4, 32;50 x 20ms = 1000ms
035 wait_1s: CALL delay_20ms
036 SUB s4, 01
037 JUMP NZ, wait_1s
038 RETURN
039 ;
039 ;
039 ;
039 
;**************************************************************************************
039 ; Interrupt Service Routine (ISR)
039 
;**************************************************************************************
039 ;
039 
; The interrupt is used purely to provide a 1 second heart beat binary counter pattern
039 ; on the 8 LEDs.
039 ;
039 ISR: STORE s0, ISR_preserve_s0;preserve register
03A ;FETCH s0, LED_pattern               ;read current counter value
03A FETCH s0, DATA_IN_PORT;read audio_data
03B LOAD s5, 00;Set the initial counter to 0.
03C ;LOAD s0, FF                         ;test the 9:2 LEDs
03C while: COMPARE s5, FF;check if counter is d'256
03D display_leds: STORE s0, LED_pattern;store new counter value
03E OUTPUT s0, LED_port;display counter value on LEDs
03F FETCH s0, ISR_preserve_s0;restore register
040 RETURNI ENABLE
041 ;
041 ;
041 
;**************************************************************************************
041 ; Interrupt Vector
041 
;**************************************************************************************
041 ;
041 ADDRESS 3FF
3FF JUMP ISR
3FF ;
3FF ;

PASS 4 - Resolving Operands

000 ; KCPSM3 Program - Practice Picoblaze on Spartan-3A Starter Kit.
000 ;
000 ;
000 ;
000 ;
000 
; The 8 LEDs provide a simple 'heart beat' counter driven by interrupts generated at
000 ; one second intervals.
000 ;
000 ;
000 
;**************************************************************************************
000 ; Port definitions
000 
;**************************************************************************************
000 ;
000 ;
000 ;
000 CONSTANT LED_port, 80;8 simple LEDs. Is an OUTPUT port.
000 CONSTANT DATA_IN_PORT, 00;input data port. this is an INPUT port.
000 CONSTANT SSEG_PORT0, 40
000 CONSTANT SSEG_PORT1, 20
000 CONSTANT SSEG_PORT2, 10
000 ;//////define the port for the LED[0]
000 CONSTANT LED_heartbeat, 08
000 
;**************************************************************************************
000 ; Special Register usage
000 
;**************************************************************************************
000 ;
000 ; No registers are given special names in this program.
000 ;
000 
;**************************************************************************************
000 ; Scratch Pad Memory Locations
000 
;**************************************************************************************
000 ;
000 ;
000 CONSTANT ISR_preserve_s0, 00;Preserve s0 contents during ISR
000 CONSTANT ISR_preserve_s1, 01;Preserve s1 contents during ISR
000 CONSTANT ISR_preserve_s2, 02;Preserve s2 contents during ISR
000 CONSTANT ISR_preserve_s3, 03;Preserve s3 contents during ISR
000 ;
000 CONSTANT LED_pattern, 04;remember state of LEDs (8-bit counter in this case)
000 ;
000 
;**************************************************************************************
000 ; Useful data constants
000 
;**************************************************************************************
000 ;
000 ;
000 
; Constant to define a software delay of 1us. This must be adjusted to reflect the
000 
; clock applied to KCPSM3. Every instruction executes in 2 clock cycles making the
000 
; calculation highly predictable. The '6' in the following equation even allows for
000 ; 'CALL delay_1us' instruction in the initiating code.
000 ;
000 
; delay_1us_constant =  (clock_rate - 6)/4       Where 'clock_rate' is in MHz
000 ;
000 ; Example: For a 50MHz clock the constant value is (50-6)/4 = 11  (0B Hex).
000 
; For clock rates below 10MHz the value of 1 must be used and the operation will
000 
; become lower than intended. Interrupts may effect the timing of software based
000 ; delays.
000 ;
000 CONSTANT delay_1us_constant, 0B
000 ;
000 ;
000 ;
000 ; ASCII table
000 ;
000 CONSTANT character_a, 61
000 CONSTANT character_b, 62
000 CONSTANT character_c, 63
000 CONSTANT character_d, 64
000 CONSTANT character_e, 65
000 CONSTANT character_f, 66
000 CONSTANT character_g, 67
000 CONSTANT character_h, 68
000 CONSTANT character_i, 69
000 CONSTANT character_j, 6A
000 CONSTANT character_k, 6B
000 CONSTANT character_l, 6C
000 CONSTANT character_m, 6D
000 CONSTANT character_n, 6E
000 CONSTANT character_o, 6F
000 CONSTANT character_p, 70
000 CONSTANT character_q, 71
000 CONSTANT character_r, 72
000 CONSTANT character_s, 73
000 CONSTANT character_t, 74
000 CONSTANT character_u, 75
000 CONSTANT character_v, 76
000 CONSTANT character_w, 77
000 CONSTANT character_x, 78
000 CONSTANT character_y, 79
000 CONSTANT character_z, 7A
000 CONSTANT character_A, 41
000 CONSTANT character_B, 42
000 CONSTANT character_C, 43
000 CONSTANT character_D, 44
000 CONSTANT character_E, 45
000 CONSTANT character_F, 46
000 CONSTANT character_G, 47
000 CONSTANT character_H, 48
000 CONSTANT character_I, 49
000 CONSTANT character_J, 4A
000 CONSTANT character_K, 4B
000 CONSTANT character_L, 4C
000 CONSTANT character_M, 4D
000 CONSTANT character_N, 4E
000 CONSTANT character_O, 4F
000 CONSTANT character_P, 50
000 CONSTANT character_Q, 51
000 CONSTANT character_R, 52
000 CONSTANT character_S, 53
000 CONSTANT character_T, 54
000 CONSTANT character_U, 55
000 CONSTANT character_V, 56
000 CONSTANT character_W, 57
000 CONSTANT character_X, 58
000 CONSTANT character_Y, 59
000 CONSTANT character_Z, 5A
000 CONSTANT character_0, 30
000 CONSTANT character_1, 31
000 CONSTANT character_2, 32
000 CONSTANT character_3, 33
000 CONSTANT character_4, 34
000 CONSTANT character_5, 35
000 CONSTANT character_6, 36
000 CONSTANT character_7, 37
000 CONSTANT character_8, 38
000 CONSTANT character_9, 39
000 CONSTANT character_colon, 3A
000 CONSTANT character_stop, 2E
000 CONSTANT character_semi_colon, 3B
000 CONSTANT character_minus, 2D
000 CONSTANT character_divide, 2F;'/'
000 CONSTANT character_plus, 2B
000 CONSTANT character_comma, 2C
000 CONSTANT character_less_than, 3C
000 CONSTANT character_greater_than, 3E
000 CONSTANT character_equals, 3D
000 CONSTANT character_space, 20
000 CONSTANT character_CR, 0D;carriage return
000 CONSTANT character_question, 3F;'?'
000 CONSTANT character_dollar, 24
000 CONSTANT character_exclaim, 21;'!'
000 CONSTANT character_BS, 08;Back Space command character
000 ;
000 ;
000 ;
000 ;
000 ;
000 
;**************************************************************************************
000 ; Initialise the system
000 
;**************************************************************************************
000 ;
000 cold_start: LOAD s0, 00;clear 1 second counter and clear LEDs
001 STORE s0, LED_pattern
002 OUTPUT s0, LED_port
003 ;
003 ENABLE INTERRUPT;enable one second heart beat
004 
;**************************************************************************************
004 ; Main program
004 
;**************************************************************************************
004 ;
004 ; Display welcome message for design
004 ;
004 main_program: CALL delay_1s;
005 ;////Lab 3
005 ;Make the heart-beat on LED[0]
005 LOAD s0, 01
006 OUTPUT s0, LED_heartbeat
007 CALL delay_1s
008 LOAD s0, 00
009 OUTPUT s0, LED_heartbeat
00A JUMP main_program
00B 
;   check_switches: INPUT s0,DATA_IN_PORT               ;get status of switches
00B ;           TEST s0, 01                 ;test to see if switch 0 is 1
00B 
;           JUMP NZ, just_clear_the_display          ;if switch 0 is 1display
00B ;
00B 
;                   ;my code///////////This is for in-class activity/////////////////////
00B ;                  ;INPUT s1,DATA_IN_PORT
00B ;                 ;TEST s1, 02
00B ;                ;JUMP NZ, decrease_the_counter
00B ;               ;/////////////////////////////////////////
00B ;
00B 
;          CALL add_1_to_counter                   ;if the switches are not 0, then shift the display left
00B ;display_the_counter: CALL update_seven_segments
00B ;            CALL delay_1s;
00B ;            JUMP check_switches;
00B ;just_clear_the_display:   load s8, 00;
00B ;        load s9, 00;
00B ;        load sA, 00;
00B ;           CALL update_seven_segments
00B ;        JUMP main_program;
00B ;add_1_to_counter:         add s8, 01
00B ;        addcy s9, 00
00B ;        addcy sA, 00
00B ;        RETURN
00B ;update_seven_segments : output s8, SSEG_PORT0
00B ;                       output s9, SSEG_PORT1
00B ;                      output sA, SSEG_PORT2
00B ;     RETURN
00B ; my code//////////This is for in-class activity////////////////////////
00B ;decrease_the_counter: sub s8, 01
00B ;                  subcy s9, 00
00B ;                   subcy sA, 00
00B ;                   CALL display_the_counter
00B ;//////////////////////////////////////
00B 
;**************************************************************************************
00B ; Routines to display hexadecimal values
00B 
;**************************************************************************************
00B ;
00B ;
00B ; Convert hexadecimal value provided in register s0 into ASCII characters
00B ;
00B 
; The value provided must can be any value in the range 00 to FF and will be converted into
00B ; two ASCII characters.
00B 
;     The upper nibble will be represented by an ASCII character returned in register s3.
00B 
;     The lower nibble will be represented by an ASCII character returned in register s2.
00B ;
00B 
; The ASCII representations of '0' to '9' are 30 to 39 hexadecimal which is simply 30 hex
00B 
; added to the actual decimal value. The ASCII representations of 'A' to 'F' are 41 to 46
00B ; hexadecimal requiring a further addition of 07 to the 30 already added.
00B ;
00B ; Registers used s0, s2 and s3.
00B ;
00B hex_byte_to_ASCII: LOAD s2, s0;remember value supplied
00C SR0 s0;isolate upper nibble
00D SR0 s0
00E SR0 s0
00F SR0 s0
010 CALL hex_to_ASCII;convert
011 LOAD s3, s0;upper nibble value in s3
012 LOAD s0, s2;restore complete value
013 AND s0, 0F;isolate lower nibble
014 CALL hex_to_ASCII;convert
015 LOAD s2, s0;lower nibble value in s2
016 RETURN
017 ;
017 ; Convert hexadecimal value provided in register s0 into ASCII character
017 ;
017 ;Register used s0
017 ;
017 hex_to_ASCII: SUB s0, 0A;test if value is in range 0 to 9
018 JUMP C, number_char
019 ADD s0, 07;ASCII char A to F in range 41 to 46
01A number_char: ADD s0, 3A;ASCII char 0 to 9 in range 30 to 40
01B RETURN
01C 
;**************************************************************************************
01C ; Software delay routines
01C 
;**************************************************************************************
01C ;
01C ; Delay of 1us.
01C ;
01C 
; Constant value 'delay_1us_constant' reflects the clock applied to KCPSM3. Every
01C 
; instruction executes in 2 clock cycles making the calculation highly predictable.
01C 
; The '6' in the following equation allows for the 'CALL delay_1us' instruction used
01C ; in the initiating code. Interrupts may effect software derived delays.
01C ;
01C 
; delay_1us_constant =  (clock_rate - 6)/4       Where 'clock_rate' is in MHz
01C ;
01C ; Registers used s0
01C ;
01C delay_1us: LOAD s0, delay_1us_constant
01D wait_1us: SUB s0, 01
01E JUMP NZ, wait_1us
01F RETURN
020 ;
020 ; Delay of 40us.
020 ;
020 ; Registers used s0, s1
020 ;
020 delay_40us: LOAD s1, 28;40 x 1us = 40us
021 wait_40us: CALL delay_1us
022 SUB s1, 01
023 JUMP NZ, wait_40us
024 RETURN
025 ;
025 ;
025 ; Delay of 1ms.
025 ;
025 ; Registers used s0, s1, s2
025 ;
025 delay_1ms: LOAD s2, 19;25 x 40us = 1ms
026 wait_1ms: CALL delay_40us
027 SUB s2, 01
028 JUMP NZ, wait_1ms
029 RETURN
02A ;
02A ; Delay of 20ms.
02A ;
02A ; Delay of 20ms used during initialisation.
02A ;
02A ; Registers used s0, s1, s2, s3
02A ;
02A delay_20ms: LOAD s3, 14;20 x 1ms = 20ms
02B wait_20ms: CALL delay_1ms
02C SUB s3, 01
02D JUMP NZ, wait_20ms
02E RETURN
02F delay_100ms: LOAD s3, 64;100 x 1ms = 20ms
030 wait_100ms: CALL delay_1ms
031 SUB s3, 01
032 JUMP NZ, wait_100ms
033 RETURN
034 ;
034 ; Delay of approximately 1 second.
034 ;
034 ; Registers used s0, s1, s2, s3, s4
034 ;
034 delay_1s: LOAD s4, 32;50 x 20ms = 1000ms
035 wait_1s: CALL delay_20ms
036 SUB s4, 01
037 JUMP NZ, wait_1s
038 RETURN
039 ;
039 ;
039 ;
039 
;**************************************************************************************
039 ; Interrupt Service Routine (ISR)
039 
;**************************************************************************************
039 ;
039 
; The interrupt is used purely to provide a 1 second heart beat binary counter pattern
039 ; on the 8 LEDs.
039 ;
039 ISR: STORE s0, ISR_preserve_s0;preserve register
03A ;FETCH s0, LED_pattern               ;read current counter value
03A FETCH s0, DATA_IN_PORT;read audio_data
03B LOAD s5, 00;Set the initial counter to 0.
03C ;LOAD s0, FF                         ;test the 9:2 LEDs
03C while: COMPARE s5, FF;check if counter is d'256
03D display_leds: STORE s0, LED_pattern;store new counter value
03E OUTPUT s0, LED_port;display counter value on LEDs
03F FETCH s0, ISR_preserve_s0;restore register
040 RETURNI ENABLE
041 ;
041 ;
041 
;**************************************************************************************
041 ; Interrupt Vector
041 
;**************************************************************************************
041 ;
3FF ADDRESS 3FF
3FF JUMP ISR
3FF ;
3FF ;

PASS 5 - Writing reformatted PSM file
           pracpico.fmt

PASS 6 - Writing assembler log file
           pracpico.log

PASS 7 - Writing coefficient file
           pracpico.coe

PASS 8 - Writing VHDL memory definition file
           pracpico.vhd

PASS 9 - Writing Verilog memory definition file
           pracpico.v

PASS 10 - Writing System Generator memory definition file
           pracpico.m

PASS 11 - Writing memory definition files
           pracpico.hex
           pracpico.dec
           pracpico.mem


KCPSM3 successful.

KCPSM3 complete.

