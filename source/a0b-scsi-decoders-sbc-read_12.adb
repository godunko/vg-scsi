--
--  Copyright (C) 2026, Vadim Godunko <vgodunko@gmail.com>
--

with A0B.SCSI.SBC4.CDB;
with A0B.SCSI.SPC5;

package body A0B.SCSI.Decoders.SBC.READ_12 is

   --------------------
   -- Decode_READ_12 --
   --------------------

   function Decode_READ_12
     (Self        : in out READ_12_Decoder'Class;
      CDB_Storage : A0B.Types.Arrays.Unsigned_8_Array;
      Descriptor  : out A0B.SCSI.Commands.SBC.READ_Command_Descriptor)
      return Boolean
   is
      use type A0B.SCSI.SAM5.OPERATION_CODE;
      use type A0B.Types.Reserved_1;

   begin
      if not Self.Check_USB_MSC_BOOT_CDB_Length
        (A0B.SCSI.SBC4.CDB.READ_12_CDB_Length, CDB_Storage)
      then
         return False;
      end if;

      declare
         CDB : constant A0B.SCSI.SBC4.CDB.READ_12_CDB
           with Import, Address => CDB_Storage'Address;

      begin
         pragma Assert (CDB.OPERATION_CODE = A0B.SCSI.SBC4.READ_12);

         if CDB.Obsolete_1_1_1 /= A0B.Types.Zero then
            return Self.Fail_INVALID_FIELD_IN_CDB (1, 1);
         end if;

         if CDB.Obsolete_1_0_0 /= A0B.Types.Zero then
            return Self.Fail_INVALID_FIELD_IN_CDB (1, 0);
         end if;

         if CDB.Restricted_For_MMC_6 /= A0B.Types.Zero then
            return Self.Fail_INVALID_FIELD_IN_CDB (10, 7);
         end if;

         if CDB.Reserved_10_6_6 /= A0B.Types.Zero then
            return Self.Fail_INVALID_FIELD_IN_CDB (10, 6);
         end if;

         if not Self.Check_CONTROL
           (CDB.CONTROL, A0B.SCSI.SPC5.CDB_12_CONTROL_Byte)
         then
            return False;
         end if;

         Descriptor :=
           (Variant               => A0B.SCSI.Commands.SBC.READ_12,
            GROUP_NUMBER          => CDB.GROUP_NUMBER,
            LOGICAL_BLOCK_ADDRESS =>
              A0B.Types.Unsigned_64 (CDB.LOGICAL_BLOCK_ADDRESS.Value),
            TRANSFER_LENGTH       => CDB.TRANSFER_LENGTH.Value,
            RDPROTECT             => CDB.RDPROTECT,
            DPO                   => CDB.DPO,
            FUA                   => CDB.FUA,
            RARC                  => CDB.RARC,
            DLD                   => 0);  --  Not present in READ(12)
      end;

      return True;
   end Decode_READ_12;

end A0B.SCSI.Decoders.SBC.READ_12;
