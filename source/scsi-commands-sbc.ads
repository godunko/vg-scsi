--
--  Copyright (C) 2025-2026, Vadim Godunko <vgodunko@gmail.com>
--

--  Decoded SCSI command descriptor blocks of SCSI Block Commands

with A0B.Types;

with SCSI.SAM5;

package SCSI.Commands.SBC with Pure is

   type READ_CAPACITY_Variant is (READ_CAPACITY_10, READ_CAPACITY_16);

   type READ_CAPACITY_Command_Descriptor is record
      Variant           : READ_CAPACITY_Variant;
      ALLOCATION_LENGTH : A0B.Types.Unsigned_32;
      SERVICE_ACTION    : SCSI.SAM5.SERVICE_ACTION;
   end record;

end SCSI.Commands.SBC;
