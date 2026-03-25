--
--  Copyright (C) 2026, Vadim Godunko <vgodunko@gmail.com>
--

with A0B.SCSI.SBC4.CDB;
with A0B.SCSI.SPC5;

package body A0B.SCSI.Decoders.SBC.WRITE_16 is

   ---------------------
   -- Decode_WRITE_16 --
   ---------------------

   function Decode_WRITE_16
     (Self        : in out WRITE_16_Decoder'Class;
      CDB_Storage : A0B.Types.Arrays.Unsigned_8_Array;
      Descriptor  : out A0B.SCSI.Commands.SBC.WRITE_Command_Descriptor)
      return Boolean
   is
      use type A0B.SCSI.SAM5.OPERATION_CODE;
      use type A0B.Types.Reserved_1;

   begin
      if not Self.Check_CDB_Length
        (A0B.SCSI.SBC4.CDB.WRITE_16_CDB_Length, CDB_Storage)
      then
         return False;
      end if;

      declare
         CDB : constant A0B.SCSI.SBC4.CDB.WRITE_16_CDB
           with Import, Address => CDB_Storage'Address;

      begin
         pragma Assert (CDB.OPERATION_CODE = A0B.SCSI.SBC4.WRITE_16);

         if CDB.Reserved_1_2_2 /= A0B.Types.Zero then
            return Self.Fail_INVALID_FIELD_IN_CDB (1, 2);
         end if;

         if CDB.Obsolete_1_1_1 /= A0B.Types.Zero then
            return Self.Fail_INVALID_FIELD_IN_CDB (1, 1);
         end if;

         if not Self.Check_CONTROL
           (CDB.CONTROL, A0B.SCSI.SPC5.CDB_16_CONTROL_Byte)
         then
            return False;
         end if;

         Descriptor :=
           (Variant               => A0B.SCSI.Commands.SBC.WRITE_16,
            GROUP_NUMBER          => CDB.GROUP_NUMBER,
            LOGICAL_BLOCK_ADDRESS => CDB.LOGICAL_BLOCK_ADDRESS.Value,
            TRANSFER_LENGTH       => CDB.TRANSFER_LENGTH.Value,
            WRPROTECT             => CDB.WRPROTECT,
            DPO                   => CDB.DPO,
            FUA                   => CDB.FUA,
            DLD                   => A0B.SCSI.SBC4.CDB.Get_DLD (CDB));
      end;

      return True;
   end Decode_WRITE_16;

end A0B.SCSI.Decoders.SBC.WRITE_16;
