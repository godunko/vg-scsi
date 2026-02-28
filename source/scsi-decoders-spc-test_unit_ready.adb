--
--  Copyright (C) 2026, Vadim Godunko <vgodunko@gmail.com>
--

with SCSI.SPC5.CDB;

package body SCSI.Decoders.SPC.TEST_UNIT_READY with Pure is

   ----------------------------
   -- Decode_TEST_UNIT_READY --
   ----------------------------

   function Decode_TEST_UNIT_READY
     (Self        : in out TEST_UNIT_READY_Decoder'Class;
      CDB_Storage : A0B.Types.Arrays.Unsigned_8_Array;
      Descriptor  : out SCSI.Commands.SPC.TEST_UNIT_READY_Command_Descriptor)
      return Boolean
   is
      use type A0B.Types.Reserved_8;
      use type SCSI.SAM5.OPERATION_CODE;

   begin
      if not Self.Check_USB_MSC_BOOT_CDB_Length
        (SCSI.SPC5.CDB.TEST_UNIT_READY_CDB_Length, CDB_Storage)
      then
         return False;
      end if;

      declare
         CDB : constant SCSI.SPC5.CDB.TEST_UNIT_READY_CDB
           with Import, Address => CDB_Storage'Address;

      begin
         pragma Assert (CDB.OPERATION_CODE = SCSI.SPC5.TEST_UNIT_READY);

         if CDB.Reserved_1 /= A0B.Types.Zero then
            return Self.Fail_INVALID_FIELD_IN_CDB (1);
         end if;

         if CDB.Reserved_2 /= A0B.Types.Zero then
            return Self.Fail_INVALID_FIELD_IN_CDB (2);
         end if;

         if CDB.Reserved_3 /= A0B.Types.Zero then
            return Self.Fail_INVALID_FIELD_IN_CDB (3);
         end if;

         if CDB.Reserved_4 /= A0B.Types.Zero then
            return Self.Fail_INVALID_FIELD_IN_CDB (4);
         end if;

         if not Self.Check_CONTROL
           (CDB.CONTROL, SCSI.SPC5.CDB_6_CONTROL_Byte)
         then
            return False;
         end if;

         Descriptor := (null record);
      end;

      return True;
   end Decode_TEST_UNIT_READY;

end SCSI.Decoders.SPC.TEST_UNIT_READY;
