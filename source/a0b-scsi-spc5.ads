--
--  Copyright (C) 2025-2026, Vadim Godunko <vgodunko@gmail.com>
--

--  SCSI Primary Commands - 5 (SPC-5)

with A0B.Types.Enumerable;

with A0B.SCSI.SAM5;

package A0B.SCSI.SPC5 with Pure is

   INQUIRY              : constant A0B.SCSI.SAM5.OPERATION_CODE := 16#12#;
   MODE_SENSE_6         : constant A0B.SCSI.SAM5.OPERATION_CODE := 16#1A#;
   MODE_SENSE_10        : constant A0B.SCSI.SAM5.OPERATION_CODE := 16#5A#;
   REPORT_LUNS          : constant A0B.SCSI.SAM5.OPERATION_CODE := 16#A0#;
   REQUEST_SENSE        : constant A0B.SCSI.SAM5.OPERATION_CODE := 16#03#;
   SERVICE_ACTION_IN_16 : constant A0B.SCSI.SAM5.OPERATION_CODE := 16#9E#;
   TEST_UNIT_READY      : constant A0B.SCSI.SAM5.OPERATION_CODE := 16#00#;

   --  type Mode_Page_Code is new A0B.Types.Unsigned_6;
   type VPD_Page_Code  is new A0B.Types.Unsigned_8;

   Supported_VPD_Pages_VPD_Page_Code : constant VPD_Page_Code := 16#00#;
   --  Unit_Serial_Number_VPD_Page_Code  : constant VPD_Page_Code := 16#80#;

   type Mode_Page_Code is new A0B.Types.Enumerable.Enumerable_6;
   type Mode_Subpage_Code is new A0B.Types.Enumerable.Enumerable_8;

   All_Pages : constant Mode_Page_Code := 16#3F#;
   Control   : constant Mode_Page_Code := 16#0A#;

   Control_Extension : constant Mode_Subpage_Code := 16#01#;

   ----------------
   -- Sense Data --
   ----------------

   NO_SENSE        : constant A0B.SCSI.SAM5.SENSE_KEY := 16#0#;
   RECOVERED_ERROR : constant A0B.SCSI.SAM5.SENSE_KEY := 16#1#;
   NOT_READY       : constant A0B.SCSI.SAM5.SENSE_KEY := 16#2#;
   MEDIUM_ERROR    : constant A0B.SCSI.SAM5.SENSE_KEY := 16#3#;
   HARDWARE_ERROR  : constant A0B.SCSI.SAM5.SENSE_KEY := 16#4#;
   ILLEGAL_REQUEST : constant A0B.SCSI.SAM5.SENSE_KEY := 16#5#;
   UNIT_ATTENTION  : constant A0B.SCSI.SAM5.SENSE_KEY := 16#6#;
   DATA_PROTECT    : constant A0B.SCSI.SAM5.SENSE_KEY := 16#7#;
   BLANK_CHECK     : constant A0B.SCSI.SAM5.SENSE_KEY := 16#8#;
   VENDOR_SPECIFIC : constant A0B.SCSI.SAM5.SENSE_KEY := 16#9#;
   COPY_ABORTED    : constant A0B.SCSI.SAM5.SENSE_KEY := 16#A#;
   ABORTED_COMMAND : constant A0B.SCSI.SAM5.SENSE_KEY := 16#B#;
   VOLUME_OVERFLOW : constant A0B.SCSI.SAM5.SENSE_KEY := 16#D#;
   MISCOMPARE      : constant A0B.SCSI.SAM5.SENSE_KEY := 16#E#;
   COMPLETED       : constant A0B.SCSI.SAM5.SENSE_KEY := 16#F#;

   NO_ADDITIONAL_SENSE_INFORMATION    : constant A0B.SCSI.SAM5.Sense_Code :=
     (16#00#, 16#00#);
   INVALID_COMMAND_OPERATION_CODE     : constant A0B.SCSI.SAM5.Sense_Code :=
     (16#20#, 16#00#);
   INVALID_FIELD_IN_CDB               : constant A0B.SCSI.SAM5.Sense_Code :=
     (16#24#, 16#00#);
   LOGICAL_BLOCK_ADDRESS_OUT_OF_RANGE : constant A0B.SCSI.SAM5.Sense_Code :=
     (16#21#, 16#00#);
   MEDIUM_NOT_PRESENT                 : constant A0B.SCSI.SAM5.Sense_Code :=
     (16#3A#, 16#00#);
   WRITE_PROTECTED                    : constant A0B.SCSI.SAM5.Sense_Code :=
     (16#27#, 16#00#);
   --  OVERLAPPED_COMMAND_ATTEMPTED   : constant A0B.SCSI.SAM5.Sense_Code :=
   --    (16#B#, 16#4E#, 16#00#);

   CDB_6_CONTROL_Byte  : constant := 5;
   CDB_10_CONTROL_Byte : constant := 9;
   CDB_12_CONTROL_Byte : constant := 11;
   CDB_16_CONTROL_Byte : constant := 15;
   --  Byte number of the CONTROL field for CDB of 6/10/12/16-byte commands.

   type CDB_Field_Byte is new A0B.Types.Unsigned_16;

   type CDB_Field_Byte_Bit is record
      Byte : A0B.Types.Unsigned_16;
      Bit  : A0B.Types.Unsigned_3;
   end record;

end A0B.SCSI.SPC5;
