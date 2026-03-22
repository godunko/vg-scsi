--
--  Copyright (C) 2025-2026, Vadim Godunko <vgodunko@gmail.com>
--

--  SCSI Primary Commands - 5 (SPC-5) Sense data

pragma Ada_2022;

with System;

with A0B.Types.Arrays;
with A0B.Types.Big_Endian;

package A0B.SCSI.SPC5.Sense with Pure is

   Fixed_Format_Length : constant := 18;
   SENSE_KEY_SPECIFIC_INFORMATION_Length : constant := 3;

   subtype SENSE_KEY_SPECIFIC_INFORMATION_Field is
     A0B.Types.Arrays.Unsigned_8_Array
      (1 .. SENSE_KEY_SPECIFIC_INFORMATION_Length)
         with Object_Size => SENSE_KEY_SPECIFIC_INFORMATION_Length * Byte_Size;

   type Fixed_Format is record
      VALID                           : Boolean;
      RESPONSE_CODE                   : A0B.Types.Unsigned_7 := 16#70#;
      Reserved_1                      : A0B.Types.Reserved_8 := A0B.Types.Zero;
      FILEMARK                        : Boolean;
      EOM                             : Boolean;
      ILI                             : Boolean;
      SDAT_OVFL                       : Boolean;
      SENSE_KEY                       : A0B.SCSI.SAM5.SENSE_KEY;
      INFORMATION                     : A0B.Types.Big_Endian.Unsigned_32;
      ADDITIONAL_SENSE_LENGTH         : A0B.Types.Unsigned_8 := 10;
      COMMAND_SPECIFIC_INFORMATION    : A0B.Types.Big_Endian.Unsigned_32;
      ADDITIONAL_SENSE_CODE           : A0B.SCSI.SAM5.ADDITIONAL_SENSE_CODE;
      ADDITIONAL_SENSE_CODE_QUALIFIER :
        A0B.SCSI.SAM5.ADDITIONAL_SENSE_CODE_QUALIFIER;
      FIELD_REPLACEABLE_UNIT_CODE     : A0B.Types.Unsigned_8;
      SENSE_KEY_SPECIFIC_INFORMATION  : SENSE_KEY_SPECIFIC_INFORMATION_Field;
   end record
     with Size      => Fixed_Format_Length * Byte_Size,
          Bit_Order => System.Low_Order_First;

   for Fixed_Format use record
      RESPONSE_CODE                   at 0 range 0 .. 6;
      VALID                           at 0 range 7 .. 7;
      Reserved_1                      at 1 range 0 .. 7;
      SENSE_KEY                       at 2 range 0 .. 3;
      SDAT_OVFL                       at 2 range 4 .. 4;
      ILI                             at 2 range 5 .. 5;
      EOM                             at 2 range 6 .. 6;
      FILEMARK                        at 2 range 7 .. 7;
      INFORMATION                     at 3 range 0 .. 31;
      ADDITIONAL_SENSE_LENGTH         at 7 range 0 .. 7;
      COMMAND_SPECIFIC_INFORMATION    at 8 range 0 .. 31;
      ADDITIONAL_SENSE_CODE           at 12 range 0 .. 7;
      ADDITIONAL_SENSE_CODE_QUALIFIER at 13 range 0 .. 7;
      FIELD_REPLACEABLE_UNIT_CODE     at 14 range 0 .. 7;
      SENSE_KEY_SPECIFIC_INFORMATION  at 15 range 0 .. 23;
   end record;

   type Field_Pointer is record
      SKSV           : Boolean;
      C_D            : Boolean;
      Reserved_0_5_5 : A0B.Types.Reserved_1 := A0B.Types.Zero;
      Reserved_0_4_4 : A0B.Types.Reserved_1 := A0B.Types.Zero;
      BPV            : Boolean;
      Bit_Pointer    : A0B.Types.Unsigned_3;
      Field_Pointer  : A0B.Types.Big_Endian.Unsigned_16;
   end record
     with Size => SENSE_KEY_SPECIFIC_INFORMATION_Length * Byte_Size;

   for Field_Pointer use record
      Bit_Pointer    at 0 range 0 .. 2;
      BPV            at 0 range 3 .. 3;
      Reserved_0_4_4 at 0 range 4 .. 4;
      Reserved_0_5_5 at 0 range 5 .. 5;
      C_D            at 0 range 6 .. 6;
      SKSV           at 0 range 7 .. 7;
      Field_Pointer  at 1 range 0 .. 15;
   end record;

end A0B.SCSI.SPC5.Sense;
