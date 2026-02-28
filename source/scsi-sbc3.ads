--
--  Copyright (C) 2025-2026, Vadim Godunko <vgodunko@gmail.com>
--

--  SCSI Block Commands - 3 (SBC-3)
--
--  Only some futures deprecated by SBC-4

with SCSI.SAM5;

package SCSI.SBC3 with Pure is

   READ_6  : constant SCSI.SAM5.OPERATION_CODE := 16#08#;  --  8
   WRITE_6 : constant SCSI.SAM5.OPERATION_CODE := 16#0A#;  --  10

end SCSI.SBC3;
