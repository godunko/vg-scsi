--
--  Copyright (C) 2025-2026, Vadim Godunko <vgodunko@gmail.com>
--

--  Decoded SCSI command descriptor blocks of SCSI Block Commands

with A0B.Types;

package A0B.SCSI.Commands.SBC with Pure is

   type READ_Command_Descriptor is record
      GROUP_NUMBER          : A0B.Types.Unsigned_6;
      LOGICAL_BLOCK_ADDRESS : A0B.Types.Unsigned_64;
      TRANSFER_LENGTH       : A0B.Types.Unsigned_32;
      RDPROTECT             : A0B.Types.Unsigned_3;
      DPO                   : Boolean;
      FUA                   : Boolean;
      RARC                  : Boolean;
      DLD                   : A0B.Types.Unsigned_3;
   end record;

   type READ_CAPACITY_Variant is (READ_CAPACITY_10, READ_CAPACITY_16);

   type READ_CAPACITY_Command_Descriptor is record
      Variant           : READ_CAPACITY_Variant;
      ALLOCATION_LENGTH : A0B.Types.Unsigned_32;
   end record;

   type WRITE_Command_Descriptor is record
      GROUP_NUMBER          : A0B.Types.Unsigned_6;
      LOGICAL_BLOCK_ADDRESS : A0B.Types.Unsigned_64;
      TRANSFER_LENGTH       : A0B.Types.Unsigned_32;
      WRPROTECT             : A0B.Types.Unsigned_3;
      DPO                   : Boolean;
      FUA                   : Boolean;
      DLD                   : A0B.Types.Unsigned_3;
   end record;

end A0B.SCSI.Commands.SBC;
