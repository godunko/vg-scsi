--
--  Copyright (C) 2026, Vadim Godunko <vgodunko@gmail.com>
--

with SCSI.SPC5.CDB;

package body SCSI.Decoders.SPC.MODE_SENSE_6 with Pure is

   -------------------------
   -- Decode_MODE_SENSE_6 --
   -------------------------

   function Decode_MODE_SENSE_6
     (Self        : in out MODE_SENSE_6_Decoder'Class;
      CDB_Storage : A0B.Types.Arrays.Unsigned_8_Array;
      Descriptor  : out SCSI.Commands.SPC.MODE_SENSE_Command_Descriptor)
      return Boolean
   is
      use type A0B.Types.Reserved_1;
      use type SCSI.SAM5.OPERATION_CODE;

   begin
      if not Self.Check_CDB_Length
        (SCSI.SPC5.CDB.MODE_SENSE_6_CDB_Length, CDB_Storage)
      then
         return False;
      end if;

      declare
         CDB : SCSI.SPC5.CDB.MODE_SENSE_6_CDB
           with Import, Address => CDB_Storage'Address;

      begin
         pragma Assert (CDB.OPERATION_CODE = SCSI.SPC5.MODE_SENSE_6);

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

         if CDB.Reserved_1_0_0 /= A0B.Types.Zero then
            return Self.Fail_INVALID_FIELD_IN_CDB (1, 0);
         end if;

         if not Self.Check_CONTROL
           (CDB.CONTROL, SCSI.SPC5.CDB_6_CONTROL_Byte)
         then
            return False;
         end if;

         Descriptor :=
           (Variant           => SCSI.Commands.SPC.MODE_SENSE_6,
            LLBAA             => False,
            DBD               => CDB.DBD,
            PC                => CDB.PC,
            PAGE_CODE         => CDB.PAGE_CODE,
            SUBPAGE_CODE      => CDB.SUBPAGE_CODE,
            ALLOCATION_LENGTH =>
              A0B.Types.Unsigned_32 (CDB.ALLOCATION_LENGTH));
      end;

      return True;
   end Decode_MODE_SENSE_6;

end SCSI.Decoders.SPC.MODE_SENSE_6;
