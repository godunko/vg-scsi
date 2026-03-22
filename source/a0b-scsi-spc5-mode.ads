--
--  Copyright (C) 2025-2026, Vadim Godunko <vgodunko@gmail.com>
--

--  SCSI Primary Commands - 5 (SPC-5) Mode parameter data

with System;

package A0B.SCSI.SPC5.Mode with Pure is

   MODE_6_Header_Length : constant := 4;

   ------------------------------------
   --  MODE SENCE(6)/MODE SELECT(6)  --
   ------------------------------------

   type MODE_6_Header is record
      MODE_DATA_LENGTH          : A0B.Types.Unsigned_8 := 0;
      MEDIUM_TYPE               : A0B.Types.Unsigned_8;
      DEVICE_SPECIFIC_PARAMETER : A0B.Types.Unsigned_8;
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

end A0B.SCSI.SPC5.Mode;
