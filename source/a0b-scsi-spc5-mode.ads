--
--  Copyright (C) 2025-2026, Vadim Godunko <vgodunko@gmail.com>
--

--  SCSI Primary Commands - 5 (SPC-5) Mode parameter data

with System;

with A0B.Types.Big_Endian;

package A0B.SCSI.SPC5.Mode with Pure is

   MODE_6_Header_Length  : constant := 4;
   MODE_10_Header_Length : constant := 8;

   Control_Mode_Page_Length : constant := 12;

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

end A0B.SCSI.SPC5.Mode;
