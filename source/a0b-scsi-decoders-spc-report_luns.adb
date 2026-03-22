--
--  Copyright (C) 2026, Vadim Godunko <vgodunko@gmail.com>
--

with A0B.SCSI.SPC5.CDB;

package body A0B.SCSI.Decoders.SPC.REPORT_LUNS is

   ------------------------
   -- Decode_REPORT_LUNS --
   ------------------------

   function Decode_REPORT_LUNS
     (Self        : in out REPORT_LUNS_Decoder'Class;
      CDB_Storage : A0B.Types.Arrays.Unsigned_8_Array;
      Descriptor  : out A0B.SCSI.Commands.SPC.REPORT_LUNS_Command_Descriptor)
      return Boolean
   is
      use type A0B.SCSI.SAM5.OPERATION_CODE;
      use type A0B.Types.Reserved_8;

   begin
      if not Self.Check_CDB_Length
        (A0B.SCSI.SPC5.CDB.REPORT_LUNS_CDB_Length, CDB_Storage)
      then
         return False;
      end if;

      declare
         CDB : constant A0B.SCSI.SPC5.CDB.REPORT_LUNS_CDB
           with Import, Address => CDB_Storage'Address;

      begin
         pragma Assert (CDB.OPERATION_CODE = A0B.SCSI.SPC5.REPORT_LUNS);

         if CDB.Reserved_1 /= A0B.Types.Zero then
            return Self.Fail_INVALID_FIELD_IN_CDB (1);
         end if;

         if CDB.Reserved_3 /= A0B.Types.Zero then
            return Self.Fail_INVALID_FIELD_IN_CDB (3);
         end if;

         if CDB.Reserved_4 /= A0B.Types.Zero then
            return Self.Fail_INVALID_FIELD_IN_CDB (4);
         end if;

         if CDB.Reserved_5 /= A0B.Types.Zero then
            return Self.Fail_INVALID_FIELD_IN_CDB (5);
         end if;

         if CDB.Reserved_10 /= A0B.Types.Zero then
            return Self.Fail_INVALID_FIELD_IN_CDB (10);
         end if;

         if not Self.Check_CONTROL
           (CDB.CONTROL, A0B.SCSI.SPC5.CDB_12_CONTROL_Byte)
         then
            return False;
         end if;

         Descriptor :=
           (ALLOCATION_LENGTH => CDB.ALLOCATION_LENGTH.Value,
            SELECT_REPORT     => CDB.SELECT_REPORT);
      end;

      return True;
   end Decode_REPORT_LUNS;

end A0B.SCSI.Decoders.SPC.REPORT_LUNS;
