--
--  Copyright (C) 2026, Vadim Godunko <vgodunko@gmail.com>
--

with A0B.SCSI.Commands.SPC;

package A0B.SCSI.Decoders.SPC.INQUIRY with Pure is

   type INQUIRY_Decoder is
     limited interface and A0B.SCSI.Decoders.Abstract_CDB_Decoder;

   function Decode_INQUIRY
     (Self        : in out INQUIRY_Decoder'Class;
      CDB_Storage : A0B.Types.Arrays.Unsigned_8_Array;
      Descriptor  : out A0B.SCSI.Commands.SPC.INQUIRY_Command_Descriptor)
      return Boolean;

end A0B.SCSI.Decoders.SPC.INQUIRY;
