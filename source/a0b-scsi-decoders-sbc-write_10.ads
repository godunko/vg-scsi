--
--  Copyright (C) 2026, Vadim Godunko <vgodunko@gmail.com>
--

with A0B.SCSI.Commands.SBC;

package A0B.SCSI.Decoders.SBC.WRITE_10 with Pure is

   type WRITE_10_Decoder is
     limited interface and A0B.SCSI.Decoders.Abstract_CDB_Decoder;

   function Decode_WRITE_10
     (Self        : in out WRITE_10_Decoder'Class;
      CDB_Storage : A0B.Types.Arrays.Unsigned_8_Array;
      Descriptor  : out A0B.SCSI.Commands.SBC.WRITE_Command_Descriptor)
      return Boolean;

end A0B.SCSI.Decoders.SBC.WRITE_10;
