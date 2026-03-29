--
--  Copyright (C) 2025-2026, Vadim Godunko <vgodunko@gmail.com>
--

--  SCSI Primary Commands - 5 (SPC-5) Mode parameter data

with System;

with A0B.Types.Big_Endian;

package A0B.SCSI.SPC5.Mode with Pure is

   MODE_6_Header_Length  : constant := 4;
   MODE_10_Header_Length : constant := 8;

   Control_Mode_Page_Length           : constant := 12;
   Control_Extension_Mode_Page_Length : constant := 32;

   type DEVICE_SPECIFIC_PARAMETER is new A0B.Types.Unsigned_8;

   ------------------------------------
   --  MODE SENSE(6)/MODE SELECT(6)  --
   ------------------------------------

   type MODE_6_Header is record
      MODE_DATA_LENGTH          : A0B.Types.Unsigned_8 := 0;
      MEDIUM_TYPE               : A0B.Types.Unsigned_8;
      DEVICE_SPECIFIC_PARAMETER : A0B.SCSI.SPC5.Mode.DEVICE_SPECIFIC_PARAMETER;
      BLOCK_DESCRIPTOR_LENGTH   : A0B.Types.Unsigned_8;
   end record
     with Size      => MODE_6_Header_Length * Byte_Size,
          Bit_Order => System.Low_Order_First;

   for MODE_6_Header use record
      MODE_DATA_LENGTH          at 0 range 0 .. 7;
      MEDIUM_TYPE               at 1 range 0 .. 7;
      DEVICE_SPECIFIC_PARAMETER at 2 range 0 .. 7;
      BLOCK_DESCRIPTOR_LENGTH   at 3 range 0 .. 7;
   end record;

   --------------------------------------
   --  MODE SENSE(10)/MODE SELECT(10)  --
   --------------------------------------

   type MODE_10_Header is record
      MODE_DATA_LENGTH          : A0B.Types.Big_Endian.Unsigned_16 :=
        (Value => 0);
      MEDIUM_TYPE               : A0B.Types.Unsigned_8;
      DEVICE_SPECIFIC_PARAMETER : A0B.SCSI.SPC5.Mode.DEVICE_SPECIFIC_PARAMETER;
      Reserve_4_7_1             : A0B.Types.Reserved_7 := A0B.Types.Zero;
      LONGLBA                   : Boolean := False;
      Reserve_5                 : A0B.Types.Reserved_8 := A0B.Types.Zero;
      BLOCK_DESCRIPTOR_LENGTH   : A0B.Types.Big_Endian.Unsigned_16;
   end record
     with Size      => MODE_10_Header_Length * Byte_Size,
          Bit_Order => System.Low_Order_First;

   for MODE_10_Header use record
      MODE_DATA_LENGTH          at 0 range 0 .. 15;
      MEDIUM_TYPE               at 2 range 0 .. 7;
      DEVICE_SPECIFIC_PARAMETER at 3 range 0 .. 7;
      LONGLBA                   at 4 range 0 .. 0;
      Reserve_4_7_1             at 4 range 1 .. 7;
      Reserve_5                 at 5 range 0 .. 7;
      BLOCK_DESCRIPTOR_LENGTH   at 6 range 0 .. 15;
   end record;

   ------------------
   -- Control [0A] --
   ------------------

   type Control_Mode_Page is record
      PS                       : Boolean;
      SPF                      : Boolean              := False;
      PAGE_CODE                : A0B.SCSI.SPC5.Mode_Page_Code :=
        A0B.SCSI.SPC5.Control;
      PAGE_LENGTH              : A0B.Types.Unsigned_8 := 16#0A#;
      TST                      : A0B.Types.Unsigned_3;
      TMF_ONLY                 : Boolean;
      DPICZ                    : Boolean;
      D_SENSE                  : Boolean;
      GLTSD                    : Boolean;
      RLEC                     : Boolean;
      QUEUE_ALGORITHM_MODIFIER : A0B.Types.Unsigned_4;
      NUAR                     : Boolean;
      QERR                     : A0B.Types.Unsigned_2;
      Obsolete_3_0_0           : A0B.Types.Reserved_1 := A0B.Types.Zero;
      VS                       : Boolean;
      RAC                      : Boolean;
      UA_INTLCK_CTRL           : A0B.Types.Unsigned_2;
      SWP                      : Boolean;
      Obsolete_4_2_0           : A0B.Types.Reserved_3 := A0B.Types.Zero;
      ATO                      : Boolean;
      TAS                      : Boolean;
      ATMPE                    : Boolean;
      RWWP                     : Boolean;
      SBLP                     : Boolean;
      AUTOLOAD_MODE            : A0B.Types.Unsigned_3;
      Obsolete_6               : A0B.Types.Reserved_8 := A0B.Types.Zero;
      Obsolete_7               : A0B.Types.Reserved_8 := A0B.Types.Zero;
      BUSY_TIMEOUT_PERIOD      : A0B.Types.Big_Endian.Unsigned_16;
      EXTENDED_SELF_TEST_COMPLETION_TIME : A0B.Types.Big_Endian.Unsigned_16;
   end record
     with Size      => Control_Mode_Page_Length * Byte_Size,
          Bit_Order => System.Low_Order_First;

   for Control_Mode_Page use record
      PAGE_CODE                          at 0 range 0 .. 5;
      SPF                                at 0 range 6 .. 6;
      PS                                 at 0 range 7 .. 7;
      PAGE_LENGTH                        at 1 range 0 .. 7;
      RLEC                               at 2 range 0 .. 0;
      GLTSD                              at 2 range 1 .. 1;
      D_SENSE                            at 2 range 2 .. 2;
      DPICZ                              at 2 range 3 .. 3;
      TMF_ONLY                           at 2 range 4 .. 4;
      TST                                at 2 range 5 .. 7;
      Obsolete_3_0_0                     at 3 range 0 .. 0;
      QERR                               at 3 range 1 .. 2;
      NUAR                               at 3 range 3 .. 3;
      QUEUE_ALGORITHM_MODIFIER           at 3 range 4 .. 7;
      Obsolete_4_2_0                     at 4 range 0 .. 2;
      SWP                                at 4 range 3 .. 3;
      UA_INTLCK_CTRL                     at 4 range 4 .. 5;
      RAC                                at 4 range 6 .. 6;
      VS                                 at 4 range 7 .. 7;
      AUTOLOAD_MODE                      at 5 range 0 .. 2;
      SBLP                               at 5 range 3 .. 3;
      RWWP                               at 5 range 4 .. 4;
      ATMPE                              at 5 range 5 .. 5;
      TAS                                at 5 range 6 .. 6;
      ATO                                at 5 range 7 .. 7;
      Obsolete_6                         at 6 range 0 .. 7;
      Obsolete_7                         at 7 range 0 .. 7;
      BUSY_TIMEOUT_PERIOD                at 8 range 0 .. 15;
      EXTENDED_SELF_TEST_COMPLETION_TIME at 10 range 0 .. 15;
   end record;

   -------------------------------
   -- Control Extension [0A/01] --
   -------------------------------

   type Control_Extension_Mode_Page is record
      PS                        : Boolean;
      SPF                       : Boolean              := True;
      PAGE_CODE                 : A0B.SCSI.SPC5.Mode_Page_Code :=
        A0B.SCSI.SPC5.Control;
      SUBPAGE_CODE              : A0B.SCSI.SPC5.Mode_Subpage_Code :=
        A0B.SCSI.SPC5.Control_Extension;
      PAGE_LENGTH               : A0B.Types.Big_Endian.Unsigned_16 :=
        (Value => 16#1C#);
      Reserved_4_7_4            : A0B.Types.Reserved_4 := A0B.Types.Zero;
      DLC                       : Boolean;
      TCMOS                     : Boolean;
      SCSIP                     : Boolean;
      IALUAE                    : Boolean;
      Reserved_5_7_4            : A0B.Types.Reserved_4 := A0B.Types.Zero;
      INITIAL_COMMAND_PRIORITY  : A0B.Types.Unsigned_4;
      MAXIMUM_SENSE_DATA_LENGTH : A0B.Types.Unsigned_8;
      Reserved_7                : A0B.Types.Reserved_8 := A0B.Types.Zero;
      Reserved_8                : A0B.Types.Reserved_8 := A0B.Types.Zero;
      Reserved_9                : A0B.Types.Reserved_8 := A0B.Types.Zero;
      Reserved_10               : A0B.Types.Reserved_8 := A0B.Types.Zero;
      Reserved_11               : A0B.Types.Reserved_8 := A0B.Types.Zero;
      Reserved_12               : A0B.Types.Reserved_8 := A0B.Types.Zero;
      Reserved_13               : A0B.Types.Reserved_8 := A0B.Types.Zero;
      Reserved_14               : A0B.Types.Reserved_8 := A0B.Types.Zero;
      Reserved_15               : A0B.Types.Reserved_8 := A0B.Types.Zero;
      Reserved_16               : A0B.Types.Reserved_8 := A0B.Types.Zero;
      Reserved_17               : A0B.Types.Reserved_8 := A0B.Types.Zero;
      Reserved_18               : A0B.Types.Reserved_8 := A0B.Types.Zero;
      Reserved_19               : A0B.Types.Reserved_8 := A0B.Types.Zero;
      Reserved_20               : A0B.Types.Reserved_8 := A0B.Types.Zero;
      Reserved_21               : A0B.Types.Reserved_8 := A0B.Types.Zero;
      Reserved_22               : A0B.Types.Reserved_8 := A0B.Types.Zero;
      Reserved_23               : A0B.Types.Reserved_8 := A0B.Types.Zero;
      Reserved_24               : A0B.Types.Reserved_8 := A0B.Types.Zero;
      Reserved_25               : A0B.Types.Reserved_8 := A0B.Types.Zero;
      Reserved_26               : A0B.Types.Reserved_8 := A0B.Types.Zero;
      Reserved_27               : A0B.Types.Reserved_8 := A0B.Types.Zero;
      Reserved_28               : A0B.Types.Reserved_8 := A0B.Types.Zero;
      Reserved_29               : A0B.Types.Reserved_8 := A0B.Types.Zero;
      Reserved_30               : A0B.Types.Reserved_8 := A0B.Types.Zero;
      Reserved_31               : A0B.Types.Reserved_8 := A0B.Types.Zero;
   end record
     with Size      => Control_Extension_Mode_Page_Length * Byte_Size,
          Bit_Order => System.Low_Order_First;

   for Control_Extension_Mode_Page use record
      PAGE_CODE                 at 0 range 0 .. 5;
      SPF                       at 0 range 6 .. 6;
      PS                        at 0 range 7 .. 7;
      SUBPAGE_CODE              at 1 range 0 .. 7;
      PAGE_LENGTH               at 2 range 0 .. 15;
      IALUAE                    at 4 range 0 .. 0;
      SCSIP                     at 4 range 1 .. 1;
      TCMOS                     at 4 range 2 .. 2;
      DLC                       at 4 range 3 .. 3;
      Reserved_4_7_4            at 4 range 4 .. 7;
      INITIAL_COMMAND_PRIORITY  at 5 range 0 .. 3;
      Reserved_5_7_4            at 5 range 4 .. 7;
      MAXIMUM_SENSE_DATA_LENGTH at 6 range 0 .. 7;
      Reserved_7                at 7 range 0 .. 7;
      Reserved_8                at 8 range 0 .. 7;
      Reserved_9                at 9 range 0 .. 7;
      Reserved_10               at 10 range 0 .. 7;
      Reserved_11               at 11 range 0 .. 7;
      Reserved_12               at 12 range 0 .. 7;
      Reserved_13               at 13 range 0 .. 7;
      Reserved_14               at 14 range 0 .. 7;
      Reserved_15               at 15 range 0 .. 7;
      Reserved_16               at 16 range 0 .. 7;
      Reserved_17               at 17 range 0 .. 7;
      Reserved_18               at 18 range 0 .. 7;
      Reserved_19               at 19 range 0 .. 7;
      Reserved_20               at 20 range 0 .. 7;
      Reserved_21               at 21 range 0 .. 7;
      Reserved_22               at 22 range 0 .. 7;
      Reserved_23               at 23 range 0 .. 7;
      Reserved_24               at 24 range 0 .. 7;
      Reserved_25               at 25 range 0 .. 7;
      Reserved_26               at 26 range 0 .. 7;
      Reserved_27               at 27 range 0 .. 7;
      Reserved_28               at 28 range 0 .. 7;
      Reserved_29               at 29 range 0 .. 7;
      Reserved_30               at 30 range 0 .. 7;
      Reserved_31               at 31 range 0 .. 7;
   end record;

end A0B.SCSI.SPC5.Mode;
