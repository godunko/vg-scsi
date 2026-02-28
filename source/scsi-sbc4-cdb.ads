--
--  Copyright (C) 2025-2026, Vadim Godunko <vgodunko@gmail.com>
--

--  SCSI Block Commands - 4 (SBC-4) Command Descriptor Block

with System;

with A0B.Types.Big_Endian;

with SCSI.SPC5;

package SCSI.SBC4.CDB with Pure is

   READ_10_CDB_Length          : constant := 10;
   READ_CAPACITY_16_CDB_Length : constant := 16;
   WRITE_10_CDB_Length         : constant := 10;

   -------------------
   -- READ(10) [28] --
   -------------------

   type READ_10_CDB is record
      OPERATION_CODE        : SCSI.SAM5.OPERATION_CODE := SCSI.SBC4.READ_10;
      RDPROTECT             : A0B.Types.Unsigned_3;
      DPO                   : Boolean;
      FUA                   : Boolean;
      RARC                  : Boolean;
      Obsolete_1_1_1        : A0B.Types.Reserved_1     := A0B.Types.Zero;
      Obsolete_1_0_0        : A0B.Types.Reserved_1     := A0B.Types.Zero;
      LOGICAL_BLOCK_ADDRESS : A0B.Types.Big_Endian.Unsigned_32;
      Reserved_6_7_7        : A0B.Types.Reserved_1     := A0B.Types.Zero;
      Reserved_6_6_6        : A0B.Types.Reserved_1     := A0B.Types.Zero;
      GROUP_NUMBER          : A0B.Types.Unsigned_6;
      TRANSFER_LENGTH       : A0B.Types.Big_Endian.Unsigned_16;
      CONTROL               : SCSI.SAM5.CONTROL;
   end record
     with Size      => READ_10_CDB_Length * Byte_Size,
          Bit_Order => System.Low_Order_First;

   for READ_10_CDB use record
      OPERATION_CODE        at 0 range 0 .. 7;
      Obsolete_1_0_0        at 1 range 0 .. 0;
      Obsolete_1_1_1        at 1 range 1 .. 1;
      RARC                  at 1 range 2 .. 2;
      FUA                   at 1 range 3 .. 3;
      DPO                   at 1 range 4 .. 4;
      RDPROTECT             at 1 range 5 .. 7;
      LOGICAL_BLOCK_ADDRESS at 2 range 0 .. 31;
      GROUP_NUMBER          at 6 range 0 .. 5;
      Reserved_6_6_6        at 6 range 6 .. 6;
      Reserved_6_7_7        at 6 range 7 .. 7;
      TRANSFER_LENGTH       at 7 range 0 .. 15;
      CONTROL               at 9 range 0 .. 7;
   end record;

   -------------------------------
   -- READ CAPACITY(16) [9E:10] --
   -------------------------------

   type READ_CAPACITY_16_CDB is record
      OPERATION_CODE    : SCSI.SAM5.OPERATION_CODE  :=
        SCSI.SPC5.SERVICE_ACTION_IN_16;
      Reserved_1_7_5    : A0B.Types.Reserved_3 := A0B.Types.Zero;
      SERVICE_ACTION    : SCSI.SAM5.SERVICE_ACTION  :=
        SCSI.SBC4.READ_CAPACITY_16;
      Obsolete_2        : A0B.Types.Reserved_8 := A0B.Types.Zero;
      Obsolete_3        : A0B.Types.Reserved_8 := A0B.Types.Zero;
      Obsolete_4        : A0B.Types.Reserved_8 := A0B.Types.Zero;
      Obsolete_5        : A0B.Types.Reserved_8 := A0B.Types.Zero;
      Obsolete_6        : A0B.Types.Reserved_8 := A0B.Types.Zero;
      Obsolete_7        : A0B.Types.Reserved_8 := A0B.Types.Zero;
      Obsolete_8        : A0B.Types.Reserved_8 := A0B.Types.Zero;
      Obsolete_9        : A0B.Types.Reserved_8 := A0B.Types.Zero;
      ALLOCATION_LENGTH : A0B.Types.Big_Endian.Unsigned_32;
      Reserved_14_7_1   : A0B.Types.Reserved_7 := A0B.Types.Zero;
      Obsolete_14_0_0   : A0B.Types.Reserved_1 := A0B.Types.Zero;
      CONTROL           : SCSI.SAM5.CONTROL;
   end record
     with Size      => READ_CAPACITY_16_CDB_Length * Byte_Size,
          Bit_Order => System.Low_Order_First;

   for READ_CAPACITY_16_CDB use record
      OPERATION_CODE    at 0 range 0 .. 7;
      Reserved_1_7_5    at 1 range 5 .. 7;
      SERVICE_ACTION    at 1 range 0 .. 4;
      Obsolete_2        at 2 range 0 .. 7;
      Obsolete_3        at 3 range 0 .. 7;
      Obsolete_4        at 4 range 0 .. 7;
      Obsolete_5        at 5 range 0 .. 7;
      Obsolete_6        at 6 range 0 .. 7;
      Obsolete_7        at 7 range 0 .. 7;
      Obsolete_8        at 8 range 0 .. 7;
      Obsolete_9        at 9 range 0 .. 7;
      ALLOCATION_LENGTH at 10 range 0 .. 31;
      Obsolete_14_0_0   at 14 range 0 .. 0;
      Reserved_14_7_1   at 14 range 1 .. 7;
      CONTROL           at 15 range 0 .. 7;
   end record;

   --------------------
   -- WRITE(10) [2A] --
   --------------------

   type WRITE_10_CDB is record
      OPERATION_CODE        : SCSI.SAM5.OPERATION_CODE :=
        SCSI.SBC4.WRITE_10;
      WRPROTECT             : A0B.Types.Unsigned_3;
      DPO                   : Boolean;
      FUA                   : Boolean;
      Reserved_1_2_2        : A0B.Types.Reserved_1 := A0B.Types.Zero;
      Obsolete_1_1_1        : A0B.Types.Reserved_1 := A0B.Types.Zero;
      Obsolete_1_0_0        : A0B.Types.Reserved_1 := A0B.Types.Zero;
      LOGICAL_BLOCK_ADDRESS : A0B.Types.Big_Endian.Unsigned_32;
      Reserved_6_7_6        : A0B.Types.Reserved_2 := A0B.Types.Zero;
      GROUP_NUMBER          : A0B.Types.Unsigned_6;
      TRANSFER_LENGTH       : A0B.Types.Big_Endian.Unsigned_16;
      CONTROL               : A0B.Types.Reserved_8;
   end record
     with Size      => WRITE_10_CDB_Length * Byte_Size,
          Bit_Order => System.Low_Order_First;

   for WRITE_10_CDB use record
      OPERATION_CODE        at 0 range 0 .. 7;
      Obsolete_1_0_0        at 1 range 0 .. 0;
      Obsolete_1_1_1        at 1 range 1 .. 1;
      Reserved_1_2_2        at 1 range 2 .. 2;
      FUA                   at 1 range 3 .. 3;
      DPO                   at 1 range 4 .. 4;
      WRPROTECT             at 1 range 5 .. 7;
      LOGICAL_BLOCK_ADDRESS at 2 range 0 .. 31;
      GROUP_NUMBER          at 6 range 0 .. 5;
      Reserved_6_7_6        at 6 range 6 .. 7;
      TRANSFER_LENGTH       at 7 range 0 .. 15;
      CONTROL               at 9 range 0 .. 7;
   end record;

end SCSI.SBC4.CDB;
