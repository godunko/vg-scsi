--
--  Copyright (C) 2026, Vadim Godunko <vgodunko@gmail.com>
--

with A0B.SCSI.SBC4.CDB;
with A0B.SCSI.SPC5;

package body A0B.SCSI.Decoders.SBC.READ_CAPACITY_16 is

   -----------------------------
   -- Decode_READ_CAPACITY_16 --
   -----------------------------

   function Decode_READ_CAPACITY_16
     (Self        : in out READ_CAPACITY_16_Decoder'Class;
      CDB_Storage : A0B.Types.Arrays.Unsigned_8_Array;
      Descriptor  : out
        A0B.SCSI.Commands.SBC.READ_CAPACITY_Command_Descriptor)
      return Boolean
   is
      use type A0B.SCSI.SAM5.OPERATION_CODE;
      use type A0B.SCSI.SAM5.SERVICE_ACTION;
      use type A0B.Types.Reserved_1;
      use type A0B.Types.Reserved_64;

   begin
      if not Self.Check_CDB_Length
        (A0B.SCSI.SBC4.CDB.READ_CAPACITY_16_CDB_Length, CDB_Storage)
      then
         return False;
      end if;

      declare
         CDB : constant A0B.SCSI.SBC4.CDB.READ_CAPACITY_16_CDB
           with Import, Address => CDB_Storage'Address;

      begin
         pragma Assert
           (CDB.OPERATION_CODE = A0B.SCSI.SPC5.SERVICE_ACTION_IN_16);
         pragma Assert (CDB.SERVICE_ACTION = A0B.SCSI.SBC4.READ_CAPACITY_16);

         if CDB.Reserved_1_7_7 /= A0B.Types.Zero then
            return Self.Fail_INVALID_FIELD_IN_CDB (1, 7);
         end if;

         if CDB.Reserved_1_6_6 /= A0B.Types.Zero then
            return Self.Fail_INVALID_FIELD_IN_CDB (1, 6);
         end if;

         if CDB.Reserved_1_5_5 /= A0B.Types.Zero then
            return Self.Fail_INVALID_FIELD_IN_CDB (1, 5);
         end if;

         if CDB.Obsolete_2_9 /= A0B.Types.Zero then
            return Self.Fail_INVALID_FIELD_IN_CDB (2);
         end if;

         if CDB.Reserved_14_7_7 /= A0B.Types.Zero then
            return Self.Fail_INVALID_FIELD_IN_CDB (14, 7);
         end if;

         if CDB.Reserved_14_6_6 /= A0B.Types.Zero then
            return Self.Fail_INVALID_FIELD_IN_CDB (14, 6);
         end if;

         if CDB.Reserved_14_5_5 /= A0B.Types.Zero then
            return Self.Fail_INVALID_FIELD_IN_CDB (14, 5);
         end if;

         if CDB.Reserved_14_4_4 /= A0B.Types.Zero then
            return Self.Fail_INVALID_FIELD_IN_CDB (14, 4);
         end if;

         if CDB.Reserved_14_3_3 /= A0B.Types.Zero then
            return Self.Fail_INVALID_FIELD_IN_CDB (14, 3);
         end if;

         if CDB.Reserved_14_2_2 /= A0B.Types.Zero then
            return Self.Fail_INVALID_FIELD_IN_CDB (14, 2);
         end if;

         if CDB.Reserved_14_1_1 /= A0B.Types.Zero then
            return Self.Fail_INVALID_FIELD_IN_CDB (14, 1);
         end if;

         if CDB.Obsolete_14_0_0 /= A0B.Types.Zero then
            return Self.Fail_INVALID_FIELD_IN_CDB (14, 0);
         end if;

         if not Self.Check_CONTROL
           (CDB.CONTROL, A0B.SCSI.SPC5.CDB_10_CONTROL_Byte)
         then
            return False;
         end if;

         Descriptor :=
           (Variant           => A0B.SCSI.Commands.SBC.READ_CAPACITY_16,
            ALLOCATION_LENGTH => CDB.ALLOCATION_LENGTH.Value);
      end;

      return True;
   end Decode_READ_CAPACITY_16;

end A0B.SCSI.Decoders.SBC.READ_CAPACITY_16;
