--
--  Copyright (C) 2025-2026, Vadim Godunko <vgodunko@gmail.com>
--

--  SCSI Primary Commands - 5 (SPC-5) Mode parameter data

with System;

with A0B.Types.Big_Endian;

package A0B.SCSI.SPC5.Mode with Pure is

   MODE_6_Header_Length  : constant := 4;
   MODE_10_Header_Length : constant := 8;

   ------------------------------------
   --  MODE SENSE(6)/MODE SELECT(6)  --
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

   --------------------------------------
   --  MODE SENSE(10)/MODE SELECT(10)  --
   --------------------------------------

   type MODE_10_Header is record
      MODE_DATA_LENGTH          : A0B.Types.Big_Endian.Unsigned_16 :=
        (Value => 0);
      MEDIUM_TYPE               : A0B.Types.Unsigned_8;
      DEVICE_SPECIFIC_PARAMETER : A0B.Types.Unsigned_8;
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

end A0B.SCSI.SPC5.Mode;
