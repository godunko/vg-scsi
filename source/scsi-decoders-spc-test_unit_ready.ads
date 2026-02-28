--
--  Copyright (C) 2026, Vadim Godunko <vgodunko@gmail.com>
--

with SCSI.Commands.SPC;

package SCSI.Decoders.SPC.TEST_UNIT_READY with Pure is

   type TEST_UNIT_READY_Decoder is
     limited interface and SCSI.Decoders.Abstract_CDB_Decoder;

   function Decode_TEST_UNIT_READY
     (Self        : in out TEST_UNIT_READY_Decoder'Class;
      CDB_Storage : A0B.Types.Arrays.Unsigned_8_Array;
      Descriptor  : out SCSI.Commands.SPC.TEST_UNIT_READY_Command_Descriptor)
      return Boolean;

end SCSI.Decoders.SPC.TEST_UNIT_READY;
