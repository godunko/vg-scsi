--
--  Copyright (C) 2025-2026, Vadim Godunko <vgodunko@gmail.com>
--

--  SCSI Block Commands - 4 (SBC-4)

with A0B.SCSI.SAM5;
with A0B.SCSI.SPC5;

package A0B.SCSI.SBC4 with Pure is

   --  FORMAT_UNIT_Operation_Code      : constant Operation_Code := 16#04#;  --  4
   READ_6           : constant A0B.SCSI.SAM5.OPERATION_CODE := 16#08#;  --  8
   READ_10          : constant A0B.SCSI.SAM5.OPERATION_CODE := 16#28#;  --  40
   --  READ_CAPACITY_10_Operation_Code : constant Operation_Code := 16#25#;  --  37
   WRITE_6          : constant A0B.SCSI.SAM5.OPERATION_CODE := 16#0A#;  --  10
   WRITE_10         : constant A0B.SCSI.SAM5.OPERATION_CODE := 16#2A#;  --  42

   READ_CAPACITY_16 : constant A0B.SCSI.SAM5.SERVICE_ACTION := 16#10#;  --  16

   Caching : constant A0B.SCSI.SPC5.Mode_Page_Code := 16#08#;  --  08

end A0B.SCSI.SBC4;
