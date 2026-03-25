--
--  Copyright (C) 2025-2026, Vadim Godunko <vgodunko@gmail.com>
--

--  SCSI Block Commands - 4 (SBC-4) Command Descriptor Block

with System;

with A0B.Types.Big_Endian;

with A0B.SCSI.SPC5;

package A0B.SCSI.SBC4.CDB with Pure is

   READ_10_CDB_Length          : constant := 10;
   READ_16_CDB_Length          : constant := 16;
   READ_CAPACITY_10_CDB_Length : constant := 10;
   READ_CAPACITY_16_CDB_Length : constant := 16;
   WRITE_10_CDB_Length         : constant := 10;

   -------------------
   -- READ(10) [28] --
   -------------------

   type READ_10_CDB is record
      OPERATION_CODE        : A0B.SCSI.SAM5.OPERATION_CODE :=
        A0B.SCSI.SBC4.READ_10;
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
      CONTROL               : A0B.SCSI.SAM5.CONTROL;
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

   READ_10_LOGICAL_BLOCK_ADDRESS : constant A0B.SCSI.SPC5.CDB_Field_Byte := 2;
   READ_10_TRANSFER_LENGTH       : constant A0B.SCSI.SPC5.CDB_Field_Byte := 7;

   -------------------
   -- READ(16) [88] --
   -------------------

   type READ_16_CDB is record
      OPERATION_CODE        : A0B.SCSI.SAM5.OPERATION_CODE :=
        A0B.SCSI.SBC4.READ_16;
      RDPROTECT             : A0B.Types.Unsigned_3;
      DPO                   : Boolean;
      FUA                   : Boolean;
      RARC                  : Boolean;
      Obsolete_1_1_1        : A0B.Types.Reserved_1     := A0B.Types.Zero;
      DLD2                  : A0B.Types.Unsigned_1;
      LOGICAL_BLOCK_ADDRESS : A0B.Types.Big_Endian.Unsigned_64;
      TRANSFER_LENGTH       : A0B.Types.Big_Endian.Unsigned_32;
      DLD1                  : A0B.Types.Unsigned_1;
      DLD0                  : A0B.Types.Unsigned_1;
      GROUP_NUMBER          : A0B.Types.Unsigned_6;
      CONTROL               : A0B.SCSI.SAM5.CONTROL;
   end record
     with Size      => READ_16_CDB_Length * Byte_Size,
          Bit_Order => System.Low_Order_First;

   for READ_16_CDB use record
      OPERATION_CODE        at 0 range 0 .. 7;
      DLD2                  at 1 range 0 .. 0;
      Obsolete_1_1_1        at 1 range 1 .. 1;
      RARC                  at 1 range 2 .. 2;
      FUA                   at 1 range 3 .. 3;
      DPO                   at 1 range 4 .. 4;
      RDPROTECT             at 1 range 5 .. 7;
      LOGICAL_BLOCK_ADDRESS at 2 range 0 .. 63;
      TRANSFER_LENGTH       at 10 range 0 .. 31;
      GROUP_NUMBER          at 14 range 0 .. 5;
      DLD0                  at 14 range 6 .. 6;
      DLD1                  at 14 range 7 .. 7;
      CONTROL               at 15 range 0 .. 7;
   end record;

   READ_16_LOGICAL_BLOCK_ADDRESS : constant A0B.SCSI.SPC5.CDB_Field_Byte := 2;
   READ_16_TRANSFER_LENGTH       : constant A0B.SCSI.SPC5.CDB_Field_Byte := 10;

   function Get_DLD (CDB : READ_16_CDB) return A0B.Types.Unsigned_3;

   procedure Set_DLD (CDB : in out READ_16_CDB; DLD : A0B.Types.Unsigned_3);

   function As_DLD0 (DLD : A0B.Types.Unsigned_3) return A0B.Types.Unsigned_1;

   function As_DLD1 (DLD : A0B.Types.Unsigned_3) return A0B.Types.Unsigned_1;

   function As_DLD2 (DLD : A0B.Types.Unsigned_3) return A0B.Types.Unsigned_1;

   ----------------------------
   -- READ CAPACITY(10) [25] --
   ----------------------------

   type READ_CAPACITY_10_CDB is record
      OPERATION_CODE : A0B.SCSI.SAM5.OPERATION_CODE :=
        A0B.SCSI.SBC4.READ_CAPACITY_10;
      Reserved_1_7_7 : A0B.Types.Reserved_1  := A0B.Types.Zero;
      Reserved_1_6_6 : A0B.Types.Reserved_1  := A0B.Types.Zero;
      Reserved_1_5_5 : A0B.Types.Reserved_1  := A0B.Types.Zero;
      Reserved_1_4_4 : A0B.Types.Reserved_1  := A0B.Types.Zero;
      Reserved_1_3_3 : A0B.Types.Reserved_1  := A0B.Types.Zero;
      Reserved_1_2_2 : A0B.Types.Reserved_1  := A0B.Types.Zero;
      Reserved_1_1_1 : A0B.Types.Reserved_1  := A0B.Types.Zero;
      Obsolete_1_0_0 : A0B.Types.Reserved_1  := A0B.Types.Zero;
      Obsolete_2_5   : A0B.Types.Reserved_32 := A0B.Types.Zero;
      Reserved_6     : A0B.Types.Reserved_8  := A0B.Types.Zero;
      Reserved_7     : A0B.Types.Reserved_8  := A0B.Types.Zero;
      Reserved_8_7_7 : A0B.Types.Reserved_1  := A0B.Types.Zero;
      Reserved_8_6_6 : A0B.Types.Reserved_1  := A0B.Types.Zero;
      Reserved_8_5_5 : A0B.Types.Reserved_1  := A0B.Types.Zero;
      Reserved_8_4_4 : A0B.Types.Reserved_1  := A0B.Types.Zero;
      Reserved_8_3_3 : A0B.Types.Reserved_1  := A0B.Types.Zero;
      Reserved_8_2_2 : A0B.Types.Reserved_1  := A0B.Types.Zero;
      Reserved_8_1_1 : A0B.Types.Reserved_1  := A0B.Types.Zero;
      Obsolete_8_0_0 : A0B.Types.Reserved_1  := A0B.Types.Zero;
      CONTROL        : A0B.SCSI.SAM5.CONTROL;
   end record
     with Size      => READ_CAPACITY_10_CDB_Length * Byte_Size,
          Bit_Order => System.Low_Order_First;

   for READ_CAPACITY_10_CDB use record
      OPERATION_CODE at 0 range 0 .. 7;
      Obsolete_1_0_0 at 1 range 0 .. 0;
      Reserved_1_1_1 at 1 range 1 .. 1;
      Reserved_1_2_2 at 1 range 2 .. 2;
      Reserved_1_3_3 at 1 range 3 .. 3;
      Reserved_1_4_4 at 1 range 4 .. 4;
      Reserved_1_5_5 at 1 range 5 .. 5;
      Reserved_1_6_6 at 1 range 6 .. 6;
      Reserved_1_7_7 at 1 range 7 .. 7;
      Obsolete_2_5   at 2 range 0 .. 31;
      Reserved_6     at 6 range 0 .. 7;
      Reserved_7     at 7 range 0 .. 7;
      Obsolete_8_0_0 at 8 range 0 .. 0;
      Reserved_8_1_1 at 8 range 1 .. 1;
      Reserved_8_2_2 at 8 range 2 .. 2;
      Reserved_8_3_3 at 8 range 3 .. 3;
      Reserved_8_4_4 at 8 range 4 .. 4;
      Reserved_8_5_5 at 8 range 5 .. 5;
      Reserved_8_6_6 at 8 range 6 .. 6;
      Reserved_8_7_7 at 8 range 7 .. 7;
      CONTROL        at 9 range 0 .. 7;
   end record;

   -------------------------------
   -- READ CAPACITY(16) [9E:10] --
   -------------------------------

   type READ_CAPACITY_16_CDB is record
      OPERATION_CODE    : A0B.SCSI.SAM5.OPERATION_CODE  :=
        A0B.SCSI.SPC5.SERVICE_ACTION_IN_16;
      Reserved_1_7_7    : A0B.Types.Reserved_1  := A0B.Types.Zero;
      Reserved_1_6_6    : A0B.Types.Reserved_1  := A0B.Types.Zero;
      Reserved_1_5_5    : A0B.Types.Reserved_1  := A0B.Types.Zero;
      SERVICE_ACTION    : A0B.SCSI.SAM5.SERVICE_ACTION  :=
        A0B.SCSI.SBC4.READ_CAPACITY_16;
      Obsolete_2_9      : A0B.Types.Reserved_64 := A0B.Types.Zero;
      ALLOCATION_LENGTH : A0B.Types.Big_Endian.Unsigned_32;
      Reserved_14_7_7   : A0B.Types.Reserved_1  := A0B.Types.Zero;
      Reserved_14_6_6   : A0B.Types.Reserved_1  := A0B.Types.Zero;
      Reserved_14_5_5   : A0B.Types.Reserved_1  := A0B.Types.Zero;
      Reserved_14_4_4   : A0B.Types.Reserved_1  := A0B.Types.Zero;
      Reserved_14_3_3   : A0B.Types.Reserved_1  := A0B.Types.Zero;
      Reserved_14_2_2   : A0B.Types.Reserved_1  := A0B.Types.Zero;
      Reserved_14_1_1   : A0B.Types.Reserved_1  := A0B.Types.Zero;
      Obsolete_14_0_0   : A0B.Types.Reserved_1  := A0B.Types.Zero;
      CONTROL           : A0B.SCSI.SAM5.CONTROL;
   end record
     with Size      => READ_CAPACITY_16_CDB_Length * Byte_Size,
          Bit_Order => System.Low_Order_First;

   for READ_CAPACITY_16_CDB use record
      OPERATION_CODE    at 0 range 0 .. 7;
      SERVICE_ACTION    at 1 range 0 .. 4;
      Reserved_1_5_5    at 1 range 5 .. 5;
      Reserved_1_6_6    at 1 range 6 .. 6;
      Reserved_1_7_7    at 1 range 7 .. 7;
      Obsolete_2_9      at 2 range 0 .. 63;
      ALLOCATION_LENGTH at 10 range 0 .. 31;
      Obsolete_14_0_0   at 14 range 0 .. 0;
      Reserved_14_1_1   at 14 range 1 .. 1;
      Reserved_14_2_2   at 14 range 2 .. 2;
      Reserved_14_3_3   at 14 range 3 .. 3;
      Reserved_14_4_4   at 14 range 4 .. 4;
      Reserved_14_5_5   at 14 range 5 .. 5;
      Reserved_14_6_6   at 14 range 6 .. 6;
      Reserved_14_7_7   at 14 range 7 .. 7;
      CONTROL           at 15 range 0 .. 7;
   end record;

   --------------------
   -- WRITE(10) [2A] --
   --------------------

   type WRITE_10_CDB is record
      OPERATION_CODE        : A0B.SCSI.SAM5.OPERATION_CODE :=
        A0B.SCSI.SBC4.WRITE_10;
      WRPROTECT             : A0B.Types.Unsigned_3;
      DPO                   : Boolean;
      FUA                   : Boolean;
      Reserved_1_2_2        : A0B.Types.Reserved_1 := A0B.Types.Zero;
      Obsolete_1_1_1        : A0B.Types.Reserved_1 := A0B.Types.Zero;
      Obsolete_1_0_0        : A0B.Types.Reserved_1 := A0B.Types.Zero;
      LOGICAL_BLOCK_ADDRESS : A0B.Types.Big_Endian.Unsigned_32;
      Reserved_6_7_7        : A0B.Types.Reserved_1 := A0B.Types.Zero;
      Reserved_6_6_6        : A0B.Types.Reserved_1 := A0B.Types.Zero;
      GROUP_NUMBER          : A0B.Types.Unsigned_6;
      TRANSFER_LENGTH       : A0B.Types.Big_Endian.Unsigned_16;
      CONTROL               : A0B.SCSI.SAM5.CONTROL;
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
      Reserved_6_6_6        at 6 range 6 .. 6;
      Reserved_6_7_7        at 6 range 7 .. 7;
      TRANSFER_LENGTH       at 7 range 0 .. 15;
      CONTROL               at 9 range 0 .. 7;
   end record;

end A0B.SCSI.SBC4.CDB;
