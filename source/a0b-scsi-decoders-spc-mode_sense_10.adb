--
--  Copyright (C) 2026, Vadim Godunko <vgodunko@gmail.com>
--

with A0B.SCSI.SPC5.CDB;

package body A0B.SCSI.Decoders.SPC.MODE_SENSE_10 is

   --------------------------
   -- Decode_MODE_SENSE_10 --
   --------------------------

   function Decode_MODE_SENSE_10
     (Self        : in out MODE_SENSE_10_Decoder'Class;
      CDB_Storage : A0B.Types.Arrays.Unsigned_8_Array;
      Descriptor  : out A0B.SCSI.Commands.SPC.MODE_SENSE_Command_Descriptor)
      return Boolean
   is
      use type A0B.SCSI.SAM5.OPERATION_CODE;
      use type A0B.Types.Reserved_1;
      use type A0B.Types.Reserved_8;

   begin
      if not Self.Check_USB_MSC_BOOT_CDB_Length
        (A0B.SCSI.SPC5.CDB.MODE_SENSE_10_CDB_Length, CDB_Storage)
      then
         return False;
      end if;

      declare
         CDB : A0B.SCSI.SPC5.CDB.MODE_SENSE_10_CDB
           with Import, Address => CDB_Storage'Address;

      begin
         pragma Assert (CDB.OPERATION_CODE = A0B.SCSI.SPC5.MODE_SENSE_10);

         if CDB.Reserved_1_7_7 /= A0B.Types.Zero then
            return Self.Fail_INVALID_FIELD_IN_CDB (1, 7);
         end if;

         if CDB.Reserved_1_6_6 /= A0B.Types.Zero then
            return Self.Fail_INVALID_FIELD_IN_CDB (1, 6);
         end if;

         if CDB.Reserved_1_5_5 /= A0B.Types.Zero then
            return Self.Fail_INVALID_FIELD_IN_CDB (1, 5);
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

         if CDB.Reserved_4 /= A0B.Types.Zero then
            return Self.Fail_INVALID_FIELD_IN_CDB (4);
         end if;

         if CDB.Reserved_5 /= A0B.Types.Zero then
            return Self.Fail_INVALID_FIELD_IN_CDB (5);
         end if;

         if CDB.Reserved_6 /= A0B.Types.Zero then
            return Self.Fail_INVALID_FIELD_IN_CDB (6);
         end if;

         if not Self.Check_CONTROL
           (CDB.CONTROL, A0B.SCSI.SPC5.CDB_10_CONTROL_Byte)
         then
            return False;
         end if;

         Descriptor :=
           (Variant           => A0B.SCSI.Commands.SPC.MODE_SENSE_10,
            LLBAA             => CDB.LLBAA,
            DBD               => CDB.DBD,
            PC                => CDB.PC,
            PAGE_CODE         => CDB.PAGE_CODE,
            SUBPAGE_CODE      => CDB.SUBPAGE_CODE,
            ALLOCATION_LENGTH =>
              A0B.Types.Unsigned_32 (CDB.ALLOCATION_LENGTH.Value));
      end;

      return True;
   end Decode_MODE_SENSE_10;

end A0B.SCSI.Decoders.SPC.MODE_SENSE_10;
