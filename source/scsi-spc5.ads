--
--  Copyright (C) 2025-2026, Vadim Godunko <vgodunko@gmail.com>
--

--  SCSI Primary Commands - 5 (SPC-5)

with A0B.Types;

with SCSI.SAM5;

package SCSI.SPC5 with Pure is

   INQUIRY              : constant SCSI.SAM5.OPERATION_CODE := 16#12#;  --  18
   MODE_SENSE_6         : constant SCSI.SAM5.OPERATION_CODE := 16#1A#;  --  26
   REPORT_LUNS          : constant SCSI.SAM5.OPERATION_CODE := 16#A0#;  --  160
   --  REQUEST_SENSE_Operation_Code    : constant Operation_Code := 16#03#;  --  3
   SERVICE_ACTION_IN_16 : constant SCSI.SAM5.OPERATION_CODE := 16#9E#;  --  158
   TEST_UNIT_READY      : constant SCSI.SAM5.OPERATION_CODE := 16#00#;  --  0

   --  type Mode_Page_Code is new A0B.Types.Unsigned_6;
   type VPD_Page_Code  is new A0B.Types.Unsigned_8;

   Supported_VPD_Pages_VPD_Page_Code : constant VPD_Page_Code := 16#00#;
   --  Unit_Serial_Number_VPD_Page_Code  : constant VPD_Page_Code := 16#80#;

   type Mode_Page_Code is new A0B.Types.Unsigned_6;

   All_Pages                              : constant Mode_Page_Code := 16#3F#;

   --  REQUEST_SENSE_Command_Block_Length   : constant := 6;

   NO_SENSE                       : constant SCSI.SAM5.Sense_Data :=
     (16#0#, 16#00#, 16#00#);
   INVALID_COMMAND_OPERATION_CODE : constant SCSI.SAM5.Sense_Data :=
     (16#5#, 16#20#, 16#00#);
   INVALID_FIELD_IN_CDB           : constant SCSI.SAM5.Sense_Data :=
     (16#5#, 16#24#, 16#00#);
   --  OVERLAPPED_COMMAND_ATTEMPTED   : constant SCSI.SAM5.Sense_Data :=
   --    (16#B#, 16#4E#, 16#00#);

   --  --  REQUEST SENSE (03)
   --
   --  type REQUEST_SENSE_Command_Block is record
   --     OPERATION_CODE      : SCSI.Operation_Code :=
   --       REQUEST_SENSE_Operation_Code;
   --     Reserved_1_7_1      : A0B.Types.Reserved_7;
   --     DESC                : Boolean;
   --     Reserved_2          : A0B.Types.Reserved_8;
   --     Reserved_3          : A0B.Types.Reserved_8;
   --     ALLOCATION_LENGTH   : A0B.Types.Unsigned_8;
   --     CONTROL             : A0B.Types.Reserved_8;
   --  end record
   --    with Size      => REQUEST_SENSE_Command_Block_Length * Byte_Size,
   --         Bit_Order => System.Low_Order_First;
   --
   --  for REQUEST_SENSE_Command_Block use record
   --     OPERATION_CODE      at 0 range 0 .. 7;
   --     DESC                at 1 range 0 .. 0;
   --     Reserved_1_7_1      at 1 range 1 .. 7;
   --     Reserved_2          at 2 range 0 .. 7;
   --     Reserved_3          at 3 range 0 .. 7;
   --     ALLOCATION_LENGTH   at 4 range 0 .. 7;
   --     CONTROL             at 5 range 0 .. 7;
   --  end record;
   --
   --  Fixed_Format_Sense_Data_Block_Length : constant := 18;
   --
   --  type Fixed_Format_Sense_Data_Block is record
   --     VALID                           : Boolean;
   --     RESPONSE_CODE                   : A0B.Types.Unsigned_7 := 16#70#;
   --     Reserved_1                      : A0B.Types.Reserved_8 := A0B.Types.Zero;
   --     FILEMARK                        : Boolean;
   --     EOM                             : Boolean;
   --     ILI                             : Boolean;
   --     SDAT_OVFL                       : Boolean;
   --     SENSE_KEY                       : A0B.Types.Unsigned_4;
   --     INFORMATION                     : A0B.Types.Big_Endian.Unsigned_32;
   --     ADDITIONAL_SENSE_LENGTH         : A0B.Types.Unsigned_8 := 16#10#;
   --     COMMAND_SPECIFIC_INFORMATION    : A0B.Types.Big_Endian.Unsigned_32;
   --     ADDITIONAL_SENSE_CODE           : A0B.Types.Unsigned_8;
   --     ADDITIONAL_SENSE_CODE_QUALIFIER : A0B.Types.Unsigned_8;
   --     FIELD_REPLACEABLE_UNIT_CODE     : A0B.Types.Unsigned_8;
   --     Reserved_15                     : A0B.Types.Reserved_8 := A0B.Types.Zero;
   --     Reserved_16                     : A0B.Types.Reserved_8 := A0B.Types.Zero;
   --     Reserved_17                     : A0B.Types.Reserved_8 := A0B.Types.Zero;
   --  end record
   --    with Size      =>
   --           Fixed_Format_Sense_Data_Block_Length * Byte_Size,
   --         Bit_Order => System.Low_Order_First;
   --
   --  for Fixed_Format_Sense_Data_Block use record
   --     RESPONSE_CODE                   at 0 range 0 .. 6;
   --     VALID                           at 0 range 7 .. 7;
   --     Reserved_1                      at 1 range 0 .. 7;
   --     SENSE_KEY                       at 2 range 0 .. 3;
   --     SDAT_OVFL                       at 2 range 4 .. 4;
   --     ILI                             at 2 range 5 .. 5;
   --     EOM                             at 2 range 6 .. 6;
   --     FILEMARK                        at 2 range 7 .. 7;
   --     INFORMATION                     at 3 range 0 .. 31;
   --     ADDITIONAL_SENSE_LENGTH         at 7 range 0 .. 7;
   --     COMMAND_SPECIFIC_INFORMATION    at 8 range 0 .. 31;
   --     ADDITIONAL_SENSE_CODE           at 12 range 0 .. 7;
   --     ADDITIONAL_SENSE_CODE_QUALIFIER at 13 range 0 .. 7;
   --     FIELD_REPLACEABLE_UNIT_CODE     at 14 range 0 .. 7;
   --     Reserved_15                     at 15 range 0 .. 7;
   --     Reserved_16                     at 16 range 0 .. 7;
   --     Reserved_17                     at 17 range 0 .. 7;
   --  end record;

end SCSI.SPC5;
