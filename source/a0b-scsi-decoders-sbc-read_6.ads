--
--  Copyright (C) 2026, Vadim Godunko <vgodunko@gmail.com>
--

with A0B.SCSI.Commands.SBC;

package A0B.SCSI.Decoders.SBC.READ_6 with Pure is

   type READ_6_Decoder is
     limited interface and A0B.SCSI.Decoders.Abstract_CDB_Decoder;

   function Decode_READ_6
     (Self        : in out READ_6_Decoder'Class;
      CDB_Storage : A0B.Types.Arrays.Unsigned_8_Array;
      Descriptor  : out A0B.SCSI.Commands.SBC.READ_Command_Descriptor)
      return Boolean;

end A0B.SCSI.Decoders.SBC.READ_6;
