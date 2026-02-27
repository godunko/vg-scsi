--
--  Copyright (C) 2026, Vadim Godunko <vgodunko@gmail.com>
--

with SCSI.Commands.SBC;

package SCSI.Decoders.SBC.READ_10 with Pure is

   type READ_10_Decoder is
     limited interface and SCSI.Decoders.Abstract_CDB_Decoder;

   function Decode_READ_10
     (Self        : in out READ_10_Decoder'Class;
      CDB_Storage : A0B.Types.Arrays.Unsigned_8_Array;
      Descriptor  : out SCSI.Commands.SBC.READ_Command_Descriptor)
      return Boolean;

end SCSI.Decoders.SBC.READ_10;
