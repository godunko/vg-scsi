--
--  Copyright (C) 2025-2026, Vadim Godunko <vgodunko@gmail.com>
--

--  Decoded SCSI command descriptor blocks of SCSI Primary Commands

with A0B.Types;

package SCSI.Commands.SPC with Pure is

   type INQUIRY_Command_Descriptor is record
      EVPD              : Boolean;
      PAGE_CODE         : A0B.Types.Unsigned_8;
      ALLOCATION_LENGTH : A0B.Types.Unsigned_32;
   end record;

end SCSI.Commands.SPC;
