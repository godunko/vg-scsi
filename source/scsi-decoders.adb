--
--  Copyright (C) 2026, Vadim Godunko <vgodunko@gmail.com>
--

package body SCSI.Decoders with Pure is

   USB_MSC_BOOT_CDB_Length  : constant := 12;
   iSCSI_CDB_Minumum_Length : constant := 16;

   ----------------------
   -- Check_CDB_Length --
   ----------------------

   function Check_CDB_Length
     (Self                : in out Abstract_CDB_Decoder'Class;
      Expected_CDB_Length : A0B.Types.Unsigned_32;
      CDB_Storage         : A0B.Types.Arrays.Unsigned_8_Array) return Boolean
   is
      use type A0B.Types.Unsigned_32;

   begin
      case Self.Length_Check_Mode is
         when Default | USB_MSC_BOOT =>
            if CDB_Storage'Length /= Expected_CDB_Length then
               return
                 Self.Fail_INVALID_FIELD_IN_CDB
                   (Byte =>
                      A0B.Types.Unsigned_32'Min
                        (Expected_CDB_Length,
                         CDB_Storage'Last - CDB_Storage'First));
            end if;

         when iSCSI =>
            if CDB_Storage'Length /= iSCSI_CDB_Minumum_Length then
               return
                 Self.Fail_INVALID_FIELD_IN_CDB
                   (Byte =>
                      A0B.Types.Unsigned_32'Min
                        (iSCSI_CDB_Minumum_Length,
                         CDB_Storage'Last - CDB_Storage'First));
            end if;
      end case;

      return True;
   end Check_CDB_Length;

   -------------------
   -- Check_CONTROL --
   -------------------

   function Check_CONTROL
     (Self    : in out Abstract_CDB_Decoder'Class;
      CONTROL : SCSI.SAM5.CONTROL;
      Byte    : A0B.Types.Unsigned_32) return Boolean
   is
      use type A0B.Types.Reserved_1;
      use type A0B.Types.Reserved_2;

   begin
      if CONTROL.VS_0_7_6 /= A0B.Types.Zero then
         return Self.Fail_INVALID_FIELD_IN_CDB (Byte, 7);
      end if;

      if CONTROL.Reserved_0_5_5 /= A0B.Types.Zero then
         return Self.Fail_INVALID_FIELD_IN_CDB (Byte, 5);
      end if;

      if CONTROL.Reserved_0_4_4 /= A0B.Types.Zero then
         return Self.Fail_INVALID_FIELD_IN_CDB (Byte, 4);
      end if;

      if CONTROL.Reserved_0_3_3 /= A0B.Types.Zero then
         return Self.Fail_INVALID_FIELD_IN_CDB (Byte, 3);
      end if;

      if CONTROL.NACA then
         return Self.Fail_INVALID_FIELD_IN_CDB (Byte, 2);
      end if;

      if CONTROL.Obsolete_0_1_1 /= A0B.Types.Zero then
         return Self.Fail_INVALID_FIELD_IN_CDB (Byte, 1);
      end if;

      if CONTROL.Obsolete_0_0_0 /= A0B.Types.Zero then
         return Self.Fail_INVALID_FIELD_IN_CDB (Byte, 0);
      end if;

      return True;
   end Check_CONTROL;

   -----------------------------------
   -- Check_USB_MSC_BOOT_CDB_Length --
   -----------------------------------

   function Check_USB_MSC_BOOT_CDB_Length
     (Self                : in out Abstract_CDB_Decoder'Class;
      Expected_CDB_Length : A0B.Types.Unsigned_32;
      CDB_Storage         : A0B.Types.Arrays.Unsigned_8_Array) return Boolean
   is
      use type A0B.Types.Unsigned_32;

   begin
      pragma Assert (Expected_CDB_Length <= USB_MSC_BOOT_CDB_Length);

      case Self.Length_Check_Mode is
         when Default =>
            if CDB_Storage'Length /= Expected_CDB_Length then
               return
                 Self.Fail_INVALID_FIELD_IN_CDB
                   (Byte =>
                      A0B.Types.Unsigned_32'Min
                        (Expected_CDB_Length,
                         CDB_Storage'Last - CDB_Storage'First + 1));
            end if;

         when USB_MSC_BOOT =>
            if CDB_Storage'Length /= Expected_CDB_Length
              and CDB_Storage'Length /= USB_MSC_BOOT_CDB_Length
            then
               return
                 Self.Fail_INVALID_FIELD_IN_CDB
                   (Byte =>
                      A0B.Types.Unsigned_32'Min
                        (Expected_CDB_Length,
                         CDB_Storage'Last - CDB_Storage'First + 1));
            end if;

         when iSCSI =>
            if CDB_Storage'Length /= iSCSI_CDB_Minumum_Length then
               return
                 Self.Fail_INVALID_FIELD_IN_CDB
                   (Byte =>
                      A0B.Types.Unsigned_32'Min
                        (iSCSI_CDB_Minumum_Length,
                         CDB_Storage'Last - CDB_Storage'First + 1));
            end if;
      end case;

      return True;
   end Check_USB_MSC_BOOT_CDB_Length;

   -------------------------------
   -- Fail_INVALID_FIELD_IN_CDB --
   -------------------------------

   function Fail_INVALID_FIELD_IN_CDB
     (Self : in out Abstract_CDB_Decoder'Class;
      Byte : A0B.Types.Unsigned_32) return Boolean is
   begin
      Self.Set_INVALID_FIELD_IN_CDB (Byte => A0B.Types.Unsigned_16 (Byte));

      return False;
   end Fail_INVALID_FIELD_IN_CDB;

   -------------------------------
   -- Fail_INVALID_FIELD_IN_CDB --
   -------------------------------

   function Fail_INVALID_FIELD_IN_CDB
     (Self : in out Abstract_CDB_Decoder'Class;
      Byte : A0B.Types.Unsigned_32;
      Bit  : A0B.Types.Unsigned_3) return Boolean is
   begin
      Self.Set_INVALID_FIELD_IN_CDB
        (Byte => A0B.Types.Unsigned_16 (Byte),
         Bit  => Bit);

      return False;
   end Fail_INVALID_FIELD_IN_CDB;

end SCSI.Decoders;
