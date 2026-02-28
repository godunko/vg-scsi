--
--  Copyright (C) 2026, Vadim Godunko <vgodunko@gmail.com>
--

with SCSI.SPC5.CDB;

package body SCSI.Decoders.SPC.INQUIRY is

   --------------------
   -- Decode_INQUIRY --
   --------------------

   function Decode_INQUIRY
     (Self        : in out INQUIRY_Decoder'Class;
      CDB_Storage : A0B.Types.Arrays.Unsigned_8_Array;
      Descriptor  : out SCSI.Commands.SPC.INQUIRY_Command_Descriptor)
      return Boolean
   is
      use type A0B.Types.Reserved_1;
      use type SCSI.SAM5.OPERATION_CODE;
      use type SCSI.SPC5.VPD_Page_Code;

   begin
      if not Self.Check_USB_MSC_BOOT_CDB_Length
        (SCSI.SPC5.CDB.INQUIRY_CDB_Length, CDB_Storage)
      then
         return False;
      end if;

      declare
         CDB : constant SCSI.SPC5.CDB.INQUIRY_CDB
           with Import, Address => CDB_Storage'Address;

      begin
         pragma Assert (CDB.OPERATION_CODE = SCSI.SPC5.INQUIRY);

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

         if CDB.Reserved_1_3_3 /= A0B.Types.Zero then
            return Self.Fail_INVALID_FIELD_IN_CDB (1, 3);
         end if;

         if CDB.Reserved_1_2_2 /= A0B.Types.Zero then
            return Self.Fail_INVALID_FIELD_IN_CDB (1, 2);
         end if;

         if CDB.Obsolete_1_1_1 /= A0B.Types.Zero then
            return Self.Fail_INVALID_FIELD_IN_CDB (1, 1);
         end if;

         --  PAGE_CODE can be specified for EVPD only

         if CDB.PAGE_CODE /= 0 and CDB.EVPD = False then
            return Self.Fail_INVALID_FIELD_IN_CDB (1, 0);
         end if;

         if not Self.Check_CONTROL
           (CDB.CONTROL, SCSI.SPC5.CDB_10_CONTROL_Byte)
         then
            return False;
         end if;

         Descriptor :=
           (EVPD              => CDB.EVPD,
            PAGE_CODE         => CDB.PAGE_CODE,
            ALLOCATION_LENGTH =>
              A0B.Types.Unsigned_32 (CDB.ALLOCATION_LENGTH.Value));
      end;

      return True;
   end Decode_INQUIRY;

end SCSI.Decoders.SPC.INQUIRY;
