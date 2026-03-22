--
--  Copyright (C) 2026, Vadim Godunko <vgodunko@gmail.com>
--

with A0B.SCSI.SBC4.CDB;
with A0B.SCSI.SBC4.Data;
with A0B.SCSI.SPC5;

package body A0B.SCSI.Decoders.SBC.READ_CAPACITY_10 is

   -----------------------------
   -- Decode_READ_CAPACITY_10 --
   -----------------------------

   function Decode_READ_CAPACITY_10
     (Self        : in out READ_CAPACITY_10_Decoder'Class;
      CDB_Storage : A0B.Types.Arrays.Unsigned_8_Array;
      Descriptor  : out
        A0B.SCSI.Commands.SBC.READ_CAPACITY_Command_Descriptor)
      return Boolean
   is
      use type A0B.SCSI.SAM5.OPERATION_CODE;
      use type A0B.Types.Reserved_1;
      use type A0B.Types.Reserved_8;
      use type A0B.Types.Reserved_32;

   begin
      if not Self.Check_USB_MSC_BOOT_CDB_Length
        (A0B.SCSI.SBC4.CDB.READ_CAPACITY_10_CDB_Length, CDB_Storage)
      then
         return False;
      end if;

      declare
         CDB : constant A0B.SCSI.SBC4.CDB.READ_CAPACITY_10_CDB
           with Import, Address => CDB_Storage'Address;

      begin
         pragma Assert (CDB.OPERATION_CODE = A0B.SCSI.SBC4.READ_CAPACITY_10);

         if CDB.Reserved_1_7_7 /= A0B.Types.Zero then
            return Self.Fail_INVALID_FIELD_IN_CDB (1, 7);
         end if;

         if CDB.Reserved_1_6_6 /= A0B.Types.Zero then
            return Self.Fail_INVALID_FIELD_IN_CDB (1, 6);
         end if;

         if CDB.Reserved_1_5_5 /= A0B.Types.Zero then
            return Self.Fail_INVALID_FIELD_IN_CDB (1, 5);
         end if;

         if CDB.Reserved_1_4_4 /= A0B.Types.Zero then
            return Self.Fail_INVALID_FIELD_IN_CDB (1, 4);
         end if;

         if CDB.Reserved_1_3_3 /= A0B.Types.Zero then
            return Self.Fail_INVALID_FIELD_IN_CDB (1, 3);
         end if;

         if CDB.Reserved_1_2_2 /= A0B.Types.Zero then
            return Self.Fail_INVALID_FIELD_IN_CDB (1, 2);
         end if;

         if CDB.Reserved_1_1_1 /= A0B.Types.Zero then
            return Self.Fail_INVALID_FIELD_IN_CDB (1, 1);
         end if;

         if CDB.Obsolete_1_0_0 /= A0B.Types.Zero then
            return Self.Fail_INVALID_FIELD_IN_CDB (1, 0);
         end if;

         if CDB.Obsolete_2_5 /= A0B.Types.Zero then
            return Self.Fail_INVALID_FIELD_IN_CDB (2);
         end if;

         if CDB.Reserved_6 /= A0B.Types.Zero then
            return Self.Fail_INVALID_FIELD_IN_CDB (6);
         end if;

         if CDB.Reserved_7 /= A0B.Types.Zero then
            return Self.Fail_INVALID_FIELD_IN_CDB (7);
         end if;

         if CDB.Reserved_8_7_7 /= A0B.Types.Zero then
            return Self.Fail_INVALID_FIELD_IN_CDB (8, 7);
         end if;

         if CDB.Reserved_8_6_6 /= A0B.Types.Zero then
            return Self.Fail_INVALID_FIELD_IN_CDB (8, 6);
         end if;

         if CDB.Reserved_8_5_5 /= A0B.Types.Zero then
            return Self.Fail_INVALID_FIELD_IN_CDB (8, 5);
         end if;

         if CDB.Reserved_8_4_4 /= A0B.Types.Zero then
            return Self.Fail_INVALID_FIELD_IN_CDB (8, 4);
         end if;

         if CDB.Reserved_8_3_3 /= A0B.Types.Zero then
            return Self.Fail_INVALID_FIELD_IN_CDB (8, 3);
         end if;

         if CDB.Reserved_8_2_2 /= A0B.Types.Zero then
            return Self.Fail_INVALID_FIELD_IN_CDB (8, 2);
         end if;

         if CDB.Reserved_8_1_1 /= A0B.Types.Zero then
            return Self.Fail_INVALID_FIELD_IN_CDB (8, 1);
         end if;

         if CDB.Obsolete_8_0_0 /= A0B.Types.Zero then
            return Self.Fail_INVALID_FIELD_IN_CDB (8, 0);
         end if;

         if not Self.Check_CONTROL
           (CDB.CONTROL, A0B.SCSI.SPC5.CDB_10_CONTROL_Byte)
         then
            return False;
         end if;

         Descriptor :=
           (Variant           => A0B.SCSI.Commands.SBC.READ_CAPACITY_10,
            ALLOCATION_LENGTH =>
              A0B.SCSI.SBC4.Data.READ_CAPACITY_10_Data_Length);
            --  Fixed for READ CAPACITY(10)
      end;

      return True;
   end Decode_READ_CAPACITY_10;

end A0B.SCSI.Decoders.SBC.READ_CAPACITY_10;
