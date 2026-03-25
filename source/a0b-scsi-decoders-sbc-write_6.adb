--
--  Copyright (C) 2026, Vadim Godunko <vgodunko@gmail.com>
--

with A0B.SCSI.SBC3.CDB;
with A0B.SCSI.SPC5;

package body A0B.SCSI.Decoders.SBC.WRITE_6 is

   --------------------
   -- Decode_WRITE_6 --
   --------------------

   function Decode_WRITE_6
     (Self        : in out WRITE_6_Decoder'Class;
      CDB_Storage : A0B.Types.Arrays.Unsigned_8_Array;
      Descriptor  : out A0B.SCSI.Commands.SBC.WRITE_Command_Descriptor)
      return Boolean
   is
      use type A0B.SCSI.SAM5.OPERATION_CODE;
      use type A0B.Types.Reserved_1;
      use type A0B.Types.Unsigned_8;

   begin
      if not Self.Check_CDB_Length
        (A0B.SCSI.SBC3.CDB.WRITE_6_CDB_Length, CDB_Storage)
      then
         return False;
      end if;

     declare
         CDB : A0B.SCSI.SBC3.CDB.WRITE_6_CDB
           with Import, Address => CDB_Storage'Address;

      begin
         pragma Assert (CDB.OPERATION_CODE = A0B.SCSI.SBC3.WRITE_6);

         if A0B.SCSI.SBC3.CDB.Reserved_1_7_7 (CDB) /= A0B.Types.Zero then
            return Self.Fail_INVALID_FIELD_IN_CDB (1, 7);
         end if;

         if A0B.SCSI.SBC3.CDB.Reserved_1_6_6 (CDB) /= A0B.Types.Zero then
            return Self.Fail_INVALID_FIELD_IN_CDB (1, 6);
         end if;

         if A0B.SCSI.SBC3.CDB.Reserved_1_5_5 (CDB) /= A0B.Types.Zero then
            return Self.Fail_INVALID_FIELD_IN_CDB (1, 5);
         end if;

         if not Self.Check_CONTROL
           (CDB.CONTROL, A0B.SCSI.SPC5.CDB_6_CONTROL_Byte)
         then
            return False;
         end if;

         Descriptor :=
           (Variant               => A0B.SCSI.Commands.SBC.WRITE_6,
            GROUP_NUMBER          => 0,      --  Not present in WRITE(6)
            LOGICAL_BLOCK_ADDRESS =>
              A0B.SCSI.SBC3.CDB.LOGICAL_BLOCK_ADDRESS (CDB),
            TRANSFER_LENGTH =>
              (if CDB.TRANSFER_LENGTH = 0
                 then 256
                 else A0B.Types.Unsigned_32 (CDB.TRANSFER_LENGTH)),
            WRPROTECT             => 0,      --  Not present in WRITE(6)
            DPO                   => False,  --  Not present in WRITE(6)
            FUA                   => False,  --  Not present in WRITE(6)
            DLD                   => 0);     --  Not present in WRITE(6)
      end;

      return True;
   end Decode_WRITE_6;

end A0B.SCSI.Decoders.SBC.WRITE_6;
