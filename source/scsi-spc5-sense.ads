--
--  Copyright (C) 2025-2026, Vadim Godunko <vgodunko@gmail.com>
--

--  SCSI Primary Commands - 5 (SPC-5) Sense data

pragma Ada_2022;

with System;

with A0B.Types.Big_Endian;

package SCSI.SPC5.Sense with Pure is

   Fixed_Format_Length : constant := 18;

   type Fixed_Format is record
      VALID                           : Boolean;
      RESPONSE_CODE                   : A0B.Types.Unsigned_7 := 16#70#;
      Reserved_1                      : A0B.Types.Reserved_8 := A0B.Types.Zero;
      FILEMARK                        : Boolean;
      EOM                             : Boolean;
      ILI                             : Boolean;
      SDAT_OVFL                       : Boolean;
      SENSE_KEY                       : SCSI.SAM5.SENSE_KEY;
      INFORMATION                     : A0B.Types.Big_Endian.Unsigned_32;
      ADDITIONAL_SENSE_LENGTH         : A0B.Types.Unsigned_8 := 10;
      COMMAND_SPECIFIC_INFORMATION    : A0B.Types.Big_Endian.Unsigned_32;
      ADDITIONAL_SENSE_CODE           : SCSI.SAM5.ADDITIONAL_SENSE_CODE;
      ADDITIONAL_SENSE_CODE_QUALIFIER :
        SCSI.SAM5.ADDITIONAL_SENSE_CODE_QUALIFIER;
      FIELD_REPLACEABLE_UNIT_CODE     : A0B.Types.Unsigned_8;
      Reserved_15                     : A0B.Types.Reserved_8 := A0B.Types.Zero;
      Reserved_16                     : A0B.Types.Reserved_8 := A0B.Types.Zero;
      Reserved_17                     : A0B.Types.Reserved_8 := A0B.Types.Zero;
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
      Reserved_15                     at 15 range 0 .. 7;
      Reserved_16                     at 16 range 0 .. 7;
      Reserved_17                     at 17 range 0 .. 7;
   end record;

end SCSI.SPC5.Sense;
