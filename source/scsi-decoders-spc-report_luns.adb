--
--  Copyright (C) 2026, Vadim Godunko <vgodunko@gmail.com>
--

with SCSI.SPC5.CDB;

package body SCSI.Decoders.SPC.REPORT_LUNS is

   ------------------------
   -- Decode_REPORT_LUNS --
   ------------------------

   function Decode_REPORT_LUNS
     (Self        : in out REPORT_LUNS_Decoder'Class;
      CDB_Storage : A0B.Types.Arrays.Unsigned_8_Array;
      Descriptor  : out SCSI.Commands.SPC.REPORT_LUNS_Command_Descriptor)
      return Boolean
   is
      use type A0B.Types.Reserved_8;
      use type SCSI.SAM5.OPERATION_CODE;

   begin
      if not Self.Check_CDB_Length
        (SCSI.SPC5.CDB.REPORT_LUNS_CDB_Length, CDB_Storage)
      then
         return False;
      end if;

      declare
         CDB : constant SCSI.SPC5.CDB.REPORT_LUNS_CDB
           with Import, Address => CDB_Storage'Address;

      begin
         pragma Assert (CDB.OPERATION_CODE = SCSI.SPC5.REPORT_LUNS);

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
           (CDB.CONTROL, SCSI.SPC5.CDB_10_CONTROL_Byte)
         then
            return False;
         end if;

         Descriptor :=
           (ALLOCATION_LENGTH => CDB.ALLOCATION_LENGTH.Value,
            SELECT_REPORT     => CDB.SELECT_REPORT);
      end;

      return True;
   end Decode_REPORT_LUNS;

end SCSI.Decoders.SPC.REPORT_LUNS;
