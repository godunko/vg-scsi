--
--  Copyright (C) 2025-2026, Vadim Godunko <vgodunko@gmail.com>
--

--  SCSI Block Commands - 4 (SBC-4)

with A0B.SCSI.SAM5;
with A0B.SCSI.SPC5;

package A0B.SCSI.SBC4 with Pure is

   --  FORMAT_UNIT_Operation_Code      : constant Operation_Code := 16#04#;
   READ_6           : constant A0B.SCSI.SAM5.OPERATION_CODE := 16#08#;
   READ_10          : constant A0B.SCSI.SAM5.OPERATION_CODE := 16#28#;
   READ_12          : constant A0B.SCSI.SAM5.OPERATION_CODE := 16#A8#;
   READ_16          : constant A0B.SCSI.SAM5.OPERATION_CODE := 16#88#;
   READ_CAPACITY_10 : constant A0B.SCSI.SAM5.OPERATION_CODE := 16#25#;
   WRITE_6          : constant A0B.SCSI.SAM5.OPERATION_CODE := 16#0A#;
   WRITE_10         : constant A0B.SCSI.SAM5.OPERATION_CODE := 16#2A#;

   READ_CAPACITY_16 : constant A0B.SCSI.SAM5.SERVICE_ACTION := 16#10#;

   Caching : constant A0B.SCSI.SPC5.Mode_Page_Code := 16#08#;

end A0B.SCSI.SBC4;
