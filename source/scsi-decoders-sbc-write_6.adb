--
--  Copyright (C) 2026, Vadim Godunko <vgodunko@gmail.com>
--

with SCSI.SBC3.CDB;
with SCSI.SPC5;

package body SCSI.Decoders.SBC.WRITE_6 is

   --------------------
   -- Decode_WRITE_6 --
   --------------------

   function Decode_WRITE_6
     (Self        : in out WRITE_6_Decoder'Class;
      CDB_Storage : A0B.Types.Arrays.Unsigned_8_Array;
      Descriptor  : out SCSI.Commands.SBC.WRITE_Command_Descriptor)
      return Boolean
   is
      use type A0B.Types.Reserved_1;
      use type A0B.Types.Unsigned_8;
      use type SCSI.SAM5.OPERATION_CODE;

   begin
      if not Self.Check_CDB_Length
        (SCSI.SBC3.CDB.WRITE_6_CDB_Length, CDB_Storage)
      then
         return False;
      end if;

     declare
         CDB : SCSI.SBC3.CDB.WRITE_6_CDB
           with Import, Address => CDB_Storage'Address;

      begin
         pragma Assert (CDB.OPERATION_CODE = SCSI.SBC3.WRITE_6);

         if SCSI.SBC3.CDB.Reserved_1_7_7 (CDB) /= A0B.Types.Zero then
            return Self.Fail_INVALID_FIELD_IN_CDB (1, 7);
         end if;

         if SCSI.SBC3.CDB.Reserved_1_6_6 (CDB) /= A0B.Types.Zero then
            return Self.Fail_INVALID_FIELD_IN_CDB (1, 6);
         end if;

         if SCSI.SBC3.CDB.Reserved_1_5_5 (CDB) /= A0B.Types.Zero then
            return Self.Fail_INVALID_FIELD_IN_CDB (1, 5);
         end if;

         if not Self.Check_CONTROL
           (CDB.CONTROL, SCSI.SPC5.CDB_6_CONTROL_Byte)
         then
            return False;
         end if;

         Descriptor :=
           (GROUP_NUMBER          => 0,      --  Not present in WRITE(6)
            LOGICAL_BLOCK_ADDRESS => SCSI.SBC3.CDB.LOGICAL_BLOCK_ADDRESS (CDB),
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

end SCSI.Decoders.SBC.WRITE_6;
