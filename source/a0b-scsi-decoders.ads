--
--  Copyright (C) 2026, Vadim Godunko <vgodunko@gmail.com>
--

with A0B.Types.Arrays;

private with A0B.SCSI.SAM5;

package A0B.SCSI.Decoders with Pure is

   type Field_Pointer_Kind is (None, Byte, Bit);

   type Invalid_Field_In_CDB (Kind : Field_Pointer_Kind := None) is record
      case Kind is
         when None =>
            null;

         when Byte | Bit =>
            Byte : A0B.Types.Unsigned_16;

            case Kind is
               when Bit =>
                  Bit : A0B.Types.Unsigned_3;

               when others =>
                  null;
            end case;
      end case;
   end record;

   type Length_Check_Modes is (Default, USB_MSC_BOOT, iSCSI);
   --  Mode of command descriptor block length check
   --
   --  @enum Default      Default according to SPC/SBC
   --  @enum USB_MSC_BOOT
   --    Command descriptor block of some commands can be 12 bytes length
   --  @enum iSCSI
   --    All command descriptor block has at least 16 bytes length

   type Abstract_CDB_Decoder is limited interface;

   not overriding function Length_Check_Mode
     (Self : Abstract_CDB_Decoder) return Length_Check_Modes is abstract;

   not overriding procedure Set_INVALID_FIELD_IN_CDB
     (Self : in out Abstract_CDB_Decoder;
      Byte : A0B.Types.Unsigned_16) is abstract;

   not overriding procedure Set_INVALID_FIELD_IN_CDB
     (Self : in out Abstract_CDB_Decoder;
      Byte : A0B.Types.Unsigned_16;
      Bit  : A0B.Types.Unsigned_3) is abstract;

   function Check_CDB_Length
     (Self                : in out Abstract_CDB_Decoder'Class;
      Expected_CDB_Length : A0B.Types.Unsigned_32;
      CDB_Storage         : A0B.Types.Arrays.Unsigned_8_Array) return Boolean;

private

   function Check_USB_MSC_BOOT_CDB_Length
     (Self                : in out Abstract_CDB_Decoder'Class;
      Expected_CDB_Length : A0B.Types.Unsigned_32;
      CDB_Storage         : A0B.Types.Arrays.Unsigned_8_Array) return Boolean;

   function Check_CONTROL
     (Self    : in out Abstract_CDB_Decoder'Class;
      CONTROL : A0B.SCSI.SAM5.CONTROL;
      Byte    : A0B.Types.Unsigned_32) return Boolean;

   function Fail_INVALID_FIELD_IN_CDB
     (Self : in out Abstract_CDB_Decoder'Class;
      Byte : A0B.Types.Unsigned_32) return Boolean;

   function Fail_INVALID_FIELD_IN_CDB
     (Self : in out Abstract_CDB_Decoder'Class;
      Byte : A0B.Types.Unsigned_32;
      Bit  : A0B.Types.Unsigned_3) return Boolean;

end A0B.SCSI.Decoders;
