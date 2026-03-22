--
--  Copyright (C) 2025-2026, Vadim Godunko <vgodunko@gmail.com>
--

--  Decoded SCSI command descriptor blocks of SCSI Primary Commands

with A0B.Types;

with A0B.SCSI.SPC5;

package A0B.SCSI.Commands.SPC with Pure is

   type INQUIRY_Command_Descriptor is record
      ALLOCATION_LENGTH : A0B.Types.Unsigned_32;
      EVPD              : Boolean;
      PAGE_CODE         : A0B.SCSI.SPC5.VPD_Page_Code;
   end record;

   type MODE_SENSE_Variant is (MODE_SENSE_6, MODE_SENSE_10);

   type MODE_SENSE_Command_Descriptor is record
      Variant           : MODE_SENSE_Variant;
      ALLOCATION_LENGTH : A0B.Types.Unsigned_32;
      LLBAA             : Boolean;
      DBD               : Boolean;
      PC                : A0B.Types.Unsigned_2;
      PAGE_CODE         : A0B.SCSI.SPC5.Mode_Page_Code;
      SUBPAGE_CODE      : A0B.Types.Unsigned_8;
   end record;

   type REPORT_LUNS_Command_Descriptor is record
      ALLOCATION_LENGTH : A0B.Types.Unsigned_32;
      SELECT_REPORT     : A0B.Types.Unsigned_8;
   end record;

   type TEST_UNIT_READY_Command_Descriptor is null record;

end A0B.SCSI.Commands.SPC;
