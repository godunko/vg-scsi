--
--  Copyright (C) 2025-2026, Vadim Godunko <vgodunko@gmail.com>
--

--  Decoded SCSI command descriptor blocks of SCSI Primary Commands

with A0B.Types;

with SCSI.SPC5;

package SCSI.Commands.SPC with Pure is

   type INQUIRY_Command_Descriptor is record
      ALLOCATION_LENGTH : A0B.Types.Unsigned_32;
      EVPD              : Boolean;
      PAGE_CODE         : SCSI.SPC5.VPD_Page_Code;
   end record;

   type REPORT_LUNS_Command_Descriptor is record
      ALLOCATION_LENGTH : A0B.Types.Unsigned_32;
      SELECT_REPORT     : A0B.Types.Unsigned_8;
   end record;

   type TEST_UNIT_READY_Command_Descriptor is null record;

end SCSI.Commands.SPC;
