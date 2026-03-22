--
--  Copyright (C) 2026, Vadim Godunko <vgodunko@gmail.com>
--

with A0B.SCSI.Commands.SPC;

package A0B.SCSI.Decoders.SPC.REQUEST_SENSE with Pure is

   type REQUEST_SENSE_Decoder is
     limited interface and A0B.SCSI.Decoders.Abstract_CDB_Decoder;

   function Decode_REQUEST_SENSE
     (Self        : in out REQUEST_SENSE_Decoder'Class;
      CDB_Storage : A0B.Types.Arrays.Unsigned_8_Array;
      Descriptor  : out
        A0B.SCSI.Commands.SPC.REQUEST_SENSE_Command_Descriptor)
      return Boolean;

end A0B.SCSI.Decoders.SPC.REQUEST_SENSE;
