--
--  Copyright (C) 2026, Vadim Godunko <vgodunko@gmail.com>
--

with A0B.SCSI.SPC5.CDB;

package body A0B.SCSI.Decoders.SPC.REQUEST_SENSE is

   --------------------------
   -- Decode_REQUEST_SENSE --
   --------------------------

   function Decode_REQUEST_SENSE
     (Self        : in out REQUEST_SENSE_Decoder'Class;
      CDB_Storage : A0B.Types.Arrays.Unsigned_8_Array;
      Descriptor  : out
        A0B.SCSI.Commands.SPC.REQUEST_SENSE_Command_Descriptor)
      return Boolean
   is
      use type A0B.SCSI.SAM5.OPERATION_CODE;
      use type A0B.Types.Reserved_1;
      use type A0B.Types.Reserved_8;

   begin
      if not Self.Check_CDB_Length
        (A0B.SCSI.SPC5.CDB.REQUEST_SENSE_CDB_Length, CDB_Storage)
      then
         return False;
      end if;

      declare
         CDB : A0B.SCSI.SPC5.CDB.REQUEST_SENSE_CDB
           with Import, Address => CDB_Storage'Address;

      begin
         pragma Assert (CDB.OPERATION_CODE = A0B.SCSI.SPC5.REQUEST_SENSE);

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

         if CDB.Reserved_1_2_2 /= A0B.Types.Zero then
            return Self.Fail_INVALID_FIELD_IN_CDB (1, 2);
         end if;

         if CDB.Reserved_1_1_1 /= A0B.Types.Zero then
            return Self.Fail_INVALID_FIELD_IN_CDB (1, 1);
         end if;

         if CDB.Reserved_2 /= A0B.Types.Zero then
            return Self.Fail_INVALID_FIELD_IN_CDB (2);
         end if;

         if CDB.Reserved_3 /= A0B.Types.Zero then
            return Self.Fail_INVALID_FIELD_IN_CDB (3);
         end if;

         if not Self.Check_CONTROL
           (CDB.CONTROL, A0B.SCSI.SPC5.CDB_6_CONTROL_Byte)
         then
            return False;
         end if;

         Descriptor :=
           (ALLOCATION_LENGTH => A0B.Types.Unsigned_32 (CDB.ALLOCATION_LENGTH),
            DESC              => CDB.DESC);
      end;

      return True;
   end Decode_REQUEST_SENSE;

end A0B.SCSI.Decoders.SPC.REQUEST_SENSE;
