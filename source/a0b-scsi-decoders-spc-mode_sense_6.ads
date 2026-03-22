--
--  Copyright (C) 2026, Vadim Godunko <vgodunko@gmail.com>
--

with A0B.SCSI.Commands.SPC;

package A0B.SCSI.Decoders.SPC.MODE_SENSE_6 with Pure is

   type MODE_SENSE_6_Decoder is
     limited interface and A0B.SCSI.Decoders.Abstract_CDB_Decoder;

   function Decode_MODE_SENSE_6
     (Self        : in out MODE_SENSE_6_Decoder'Class;
      CDB_Storage : A0B.Types.Arrays.Unsigned_8_Array;
      Descriptor  : out A0B.SCSI.Commands.SPC.MODE_SENSE_Command_Descriptor)
      return Boolean;

end A0B.SCSI.Decoders.SPC.MODE_SENSE_6;
