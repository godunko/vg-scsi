--
--  Copyright (C) 2026, Vadim Godunko <vgodunko@gmail.com>
--

with A0B.SCSI.Commands.SPC;

package A0B.SCSI.Decoders.SPC.REPORT_LUNS with Pure is

   type REPORT_LUNS_Decoder is
     limited interface and A0B.SCSI.Decoders.Abstract_CDB_Decoder;

   function Decode_REPORT_LUNS
     (Self        : in out REPORT_LUNS_Decoder'Class;
      CDB_Storage : A0B.Types.Arrays.Unsigned_8_Array;
      Descriptor  : out A0B.SCSI.Commands.SPC.REPORT_LUNS_Command_Descriptor)
      return Boolean;

end A0B.SCSI.Decoders.SPC.REPORT_LUNS;
