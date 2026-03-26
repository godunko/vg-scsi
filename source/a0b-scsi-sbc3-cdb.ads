--
--  Copyright (C) 2025-2026, Vadim Godunko <vgodunko@gmail.com>
--

--  SCSI Block Commands - 3 (SBC-3) Command Descriptor Block

with System;

with A0B.SCSI.SPC5;
with A0B.Types;

package A0B.SCSI.SBC3.CDB with Pure is

   READ_6_CDB_Length  : constant := 6;
   WRITE_6_CDB_Length : constant := 6;

   ------------------
   -- READ(6) [08] --
   ------------------

   type READ_6_CDB is record
      OPERATION_CODE                 : A0B.SCSI.SAM5.OPERATION_CODE :=
        A0B.SCSI.SBC3.READ_6;
      Reserved_LOGICAL_BLOCK_ADDRESS : A0B.Types.Reserved_24;
      --  Can't be represented
      --  Reserved_1_7_7        : A0B.Types.Reserved_1;
      --  Reserved_1_6_6        : A0B.Types.Reserved_1;
      --  Reserved_1_5_5        : A0B.Types.Reserved_1;
      --  LOGICAL BLOCK ADDRESS : A0B.Types.Big_Endian.Unsugned_21;
      TRANSFER_LENGTH                : A0B.Types.Unsigned_8;
      CONTROL                        : A0B.SCSI.SAM5.CONTROL;
   end record
     with Size      => READ_6_CDB_Length * Byte_Size,
          Bit_Order => System.Low_Order_First;

   for READ_6_CDB use record
      OPERATION_CODE                 at 0 range 0 .. 7;
      Reserved_LOGICAL_BLOCK_ADDRESS at 1 range 0 .. 23;
      TRANSFER_LENGTH                at 4 range 0 .. 7;
      CONTROL                        at 5 range 0 .. 7;
   end record;

   READ_6_LOGICAL_BLOCK_ADDRESS : constant A0B.SCSI.SPC5.CDB_Field_Byte_Bit :=
     (1, 4);
   READ_6_TRANSFER_LENGTH       : constant A0B.SCSI.SPC5.CDB_Field_Byte := 4;

   function LOGICAL_BLOCK_ADDRESS
     (CDB : READ_6_CDB) return A0B.Types.Unsigned_64 with Inline;
   --  Returns value of `LOGICAL BLOCK ADDRESS` component of READ(6) command
   --  descriptor.

   function Reserved_1_7_7 (CDB : READ_6_CDB) return A0B.Types.Reserved_1;
   --  Returns value of `Reserved_1_7_7` component of READ(6) command
   --  descriptor.

   function Reserved_1_6_6 (CDB : READ_6_CDB) return A0B.Types.Reserved_1;
   --  Returns value of `Reserved_1_6_6` component of READ(6) command
   --  descriptor.

   function Reserved_1_5_5 (CDB : READ_6_CDB) return A0B.Types.Reserved_1;
   --  Returns value of `Reserved_1_5_5` component of READ(6) command
   --  descriptor.

   -------------------
   -- WRITE(6) [0A] --
   -------------------

   type WRITE_6_CDB is record
      OPERATION_CODE                 : A0B.SCSI.SAM5.OPERATION_CODE :=
        A0B.SCSI.SBC3.WRITE_6;
      Reserved_LOGICAL_BLOCK_ADDRESS : A0B.Types.Reserved_24;
      --  Can't be represented
      --  Reserved_1_7_7        : A0B.Types.Reserved_1;
      --  Reserved_1_6_6        : A0B.Types.Reserved_1;
      --  Reserved_1_5_5        : A0B.Types.Reserved_1;
      --  LOGICAL BLOCK ADDRESS : A0B.Types.Big_Endian.Unsugned_21;
      TRANSFER_LENGTH                : A0B.Types.Unsigned_8;
      CONTROL                        : A0B.SCSI.SAM5.CONTROL;
   end record
     with Size      => WRITE_6_CDB_Length * Byte_Size,
          Bit_Order => System.Low_Order_First;

   for WRITE_6_CDB use record
      OPERATION_CODE                 at 0 range 0 .. 7;
      Reserved_LOGICAL_BLOCK_ADDRESS at 1 range 0 .. 23;
      TRANSFER_LENGTH                at 4 range 0 .. 7;
      CONTROL                        at 5 range 0 .. 7;
   end record;

   WRITE_6_LOGICAL_BLOCK_ADDRESS : constant A0B.SCSI.SPC5.CDB_Field_Byte_Bit :=
     (1, 4);
   WRITE_6_TRANSFER_LENGTH       : constant A0B.SCSI.SPC5.CDB_Field_Byte := 4;

   function LOGICAL_BLOCK_ADDRESS
     (CDB : WRITE_6_CDB) return A0B.Types.Unsigned_64 with Inline;
   --  Returns value of `LOGICAL BLOCK ADDRESS` component of WRITE(6) command
   --  descriptor.

   function Reserved_1_7_7 (CDB : WRITE_6_CDB) return A0B.Types.Reserved_1;
   --  Returns value of `Reserved_1_7_7` component of WRITE(6) command
   --  descriptor.

   function Reserved_1_6_6 (CDB : WRITE_6_CDB) return A0B.Types.Reserved_1;
   --  Returns value of `Reserved_1_6_6` component of WRITE(6) command
   --  descriptor.

   function Reserved_1_5_5 (CDB : WRITE_6_CDB) return A0B.Types.Reserved_1;
   --  Returns value of `Reserved_1_5_5` component of WRITE(6) command
   --  descriptor.

end A0B.SCSI.SBC3.CDB;
