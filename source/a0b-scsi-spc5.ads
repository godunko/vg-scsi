--
--  Copyright (C) 2025-2026, Vadim Godunko <vgodunko@gmail.com>
--

--  SCSI Primary Commands - 5 (SPC-5)

with A0B.Types;

with A0B.SCSI.SAM5;

package A0B.SCSI.SPC5 with Pure is

   INQUIRY         : constant A0B.SCSI.SAM5.OPERATION_CODE := 16#12#;  --  18
   MODE_SENSE_6    : constant A0B.SCSI.SAM5.OPERATION_CODE := 16#1A#;  --  26
   REPORT_LUNS     : constant A0B.SCSI.SAM5.OPERATION_CODE := 16#A0#;  --  160
   REQUEST_SENSE   : constant A0B.SCSI.SAM5.OPERATION_CODE := 16#03#;  --  3
   SERVICE_ACTION_IN_16 :
                     constant A0B.SCSI.SAM5.OPERATION_CODE := 16#9E#;  --  158
   TEST_UNIT_READY : constant A0B.SCSI.SAM5.OPERATION_CODE := 16#00#;  --  0

   --  type Mode_Page_Code is new A0B.Types.Unsigned_6;
   type VPD_Page_Code  is new A0B.Types.Unsigned_8;

   Supported_VPD_Pages_VPD_Page_Code : constant VPD_Page_Code := 16#00#;
   --  Unit_Serial_Number_VPD_Page_Code  : constant VPD_Page_Code := 16#80#;

   type Mode_Page_Code is new A0B.Types.Unsigned_6;

   All_Pages                              : constant Mode_Page_Code := 16#3F#;

   --  REQUEST_SENSE_Command_Block_Length   : constant := 6;

   NO_SENSE                       : constant A0B.SCSI.SAM5.Sense_Data :=
     (16#0#, 16#00#, 16#00#);
   INVALID_COMMAND_OPERATION_CODE : constant A0B.SCSI.SAM5.Sense_Data :=
     (16#5#, 16#20#, 16#00#);
   --  ILLEGAL REQUEST/INVALID COMMAND OPERATION CODE
   INVALID_FIELD_IN_CDB           : constant A0B.SCSI.SAM5.Sense_Data :=
     (16#5#, 16#24#, 16#00#);
   --  ILLEGAL REQUEST/INVALID FIELD IN CDB
   MEDIUM_NOT_PRESENT             : constant A0B.SCSI.SAM5.Sense_Data :=
     (16#2#, 16#3A#, 16#00#);
   --  NOT READY/MEDIUM NOT PRESENT

   --  OVERLAPPED_COMMAND_ATTEMPTED   : constant A0B.SCSI.SAM5.Sense_Data :=
   --    (16#B#, 16#4E#, 16#00#);

   CDB_6_CONTROL_Byte  : constant := 5;
   CDB_10_CONTROL_Byte : constant := 9;
   CDB_12_CONTROL_Byte : constant := 11;
   --  Byte number of the CONTROL field for CDB of 6/10/12-byte commands.

   type CDB_Field_Byte is new A0B.Types.Unsigned_16;

   type CDB_Field_Byte_Bit is record
      Byte : A0B.Types.Unsigned_16;
      Bit  : A0B.Types.Unsigned_3;
   end record;

end A0B.SCSI.SPC5;
