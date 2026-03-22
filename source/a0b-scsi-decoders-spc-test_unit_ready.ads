--
--  Copyright (C) 2026, Vadim Godunko <vgodunko@gmail.com>
--

with A0B.SCSI.Commands.SPC;

package A0B.SCSI.Decoders.SPC.TEST_UNIT_READY with Pure is

   type TEST_UNIT_READY_Decoder is
     limited interface and A0B.SCSI.Decoders.Abstract_CDB_Decoder;

   function Decode_TEST_UNIT_READY
     (Self        : in out TEST_UNIT_READY_Decoder'Class;
      CDB_Storage : A0B.Types.Arrays.Unsigned_8_Array;
      Descriptor  : out
        A0B.SCSI.Commands.SPC.TEST_UNIT_READY_Command_Descriptor)
      return Boolean;

end A0B.SCSI.Decoders.SPC.TEST_UNIT_READY;
