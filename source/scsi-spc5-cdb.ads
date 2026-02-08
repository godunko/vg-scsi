--
--  Copyright (C) 2025-2026, Vadim Godunko <vgodunko@gmail.com>
--

--  SCSI Primary Commands - 5 (SPC-5) Command Descriptor Block

with System;

with A0B.Types.Big_Endian;

package SCSI.SPC5.CDB with Pure is

   INQUIRY_CDB_Length         : constant := 6;

   --  INQUIRY (12)

   type INQUIRY_CDB is record
      OPERATION_CODE    : SCSI.SAM5.OPERATION_CODE := SCSI.SPC5.INQUIRY;
      Reserved_1_7_2    : A0B.Types.Reserved_6     := A0B.Types.Zero;
      Obsolete_1_1_1    : A0B.Types.Reserved_1     := A0B.Types.Zero;
      EVPD              : Boolean                  := False;
      PAGE_CODE         : SCSI.SPC5.VPD_Page_Code  := 0;
      ALLOCATION_LENGTH : A0B.Types.Big_Endian.Unsigned_16;
      CONTROL           : SCSI.SAM5.CONTROL;
   end record
     with Size      => INQUIRY_CDB_Length * A0B.Types.Unsigned_8'Size,
          Bit_Order => System.Low_Order_First;

   for INQUIRY_CDB use record
      OPERATION_CODE            at 0 range 0 .. 7;
      EVPD                      at 1 range 0 .. 0;
      Obsolete_1_1_1            at 1 range 1 .. 1;
      Reserved_1_7_2            at 1 range 2 .. 7;
      PAGE_CODE                 at 2 range 0 .. 7;
      ALLOCATION_LENGTH         at 3 range 0 .. 15;
      CONTROL                   at 5 range 0 .. 7;
   end record;

end SCSI.SPC5.CDB;
