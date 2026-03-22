--
--  Copyright (C) 2025-2026, Vadim Godunko <vgodunko@gmail.com>
--

--  SCSI Primary Commands - 5 (SPC-5) Vital Product Data

with System;

with A0B.Types.Big_Endian;

package A0B.SCSI.SPC5.VPD with Pure is

   VPD_Page_Header_Length : constant := 4;

   type VPD_Page_Header is record
      PERIPHERAL_QUALIFIER   : A0B.Types.Unsigned_3;
      PERIPHERAL_DEVICE_TYPE : A0B.Types.Unsigned_5;
      PAGE_CODE              : A0B.SCSI.SPC5.VPD_Page_Code;
      PAGE_LENGTH            : A0B.Types.Big_Endian.Unsigned_16;
   end record
     with Size      => VPD_Page_Header_Length * Byte_Size,
          Bit_Order => System.Low_Order_First;

   for VPD_Page_Header use record
      PERIPHERAL_DEVICE_TYPE at 0 range 0 .. 4;
      PERIPHERAL_QUALIFIER   at 0 range 5 .. 7;
      PAGE_CODE              at 1 range 0 .. 7;
      PAGE_LENGTH            at 2 range 0 .. 15;
   end record;

end A0B.SCSI.SPC5.VPD;
