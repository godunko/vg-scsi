--
--  Copyright (C) 2026, Vadim Godunko <vgodunko@gmail.com>
--

with SCSI.Commands.SBC;

package SCSI.Decoders.SBC.WRITE_6 with Pure is

   type WRITE_6_Decoder is
     limited interface and SCSI.Decoders.Abstract_CDB_Decoder;

   function Decode_WRITE_6
     (Self        : in out WRITE_6_Decoder'Class;
      CDB_Storage : A0B.Types.Arrays.Unsigned_8_Array;
      Descriptor  : out SCSI.Commands.SBC.WRITE_Command_Descriptor)
      return Boolean;

end SCSI.Decoders.SBC.WRITE_6;
