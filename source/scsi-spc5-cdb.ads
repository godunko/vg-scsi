--
--  Copyright (C) 2025-2026, Vadim Godunko <vgodunko@gmail.com>
--

--  SCSI Primary Commands - 5 (SPC-5) Command Descriptor Block

with System;

with A0B.Types.Big_Endian;

package SCSI.SPC5.CDB with Pure is

   INQUIRY_CDB_Length              : constant := 6;
   MODE_SENSE_6_CDB_Length         : constant := 6;
   REPORT_LUNS_CDB_Length          : constant := 12;
   SERVICE_ACTION_IN_16_CDB_Length : constant := 16;
   TEST_UNIT_READY_CDB_Length      : constant := 6;

   --------------------
   --  INQUIRY [12]  --
   --------------------

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
      OPERATION_CODE    at 0 range 0 .. 7;
      EVPD              at 1 range 0 .. 0;
      Obsolete_1_1_1    at 1 range 1 .. 1;
      Reserved_1_7_2    at 1 range 2 .. 7;
      PAGE_CODE         at 2 range 0 .. 7;
      ALLOCATION_LENGTH at 3 range 0 .. 15;
      CONTROL           at 5 range 0 .. 7;
   end record;

   --------------------------
   --  MODE SENSE(6) [1A]  --
   --------------------------

   type MODE_SENSE_6_CDB is record
      OPERATION_CODE    : SCSI.SAM5.OPERATION_CODE := SCSI.SPC5.MODE_SENSE_6;
      Reserved_1_7_4    : A0B.Types.Reserved_4 := A0B.Types.Zero;
      DBD               : Boolean              := False;
      Reserved_1_0_2    : A0B.Types.Reserved_3;
      PC                : A0B.Types.Unsigned_2;
      PAGE_CODE         : SCSI.SPC5.Mode_Page_Code;
      SUBPAGE_CODE      : A0B.Types.Unsigned_8;
      ALLOCATION_LENGTH : A0B.Types.Unsigned_8;
      CONTROL           : SCSI.SAM5.CONTROL;
   end record
     with Size      => MODE_SENSE_6_CDB_Length * Byte_Size,
          Bit_Order => System.Low_Order_First;

   for MODE_SENSE_6_CDB use record
      OPERATION_CODE    at 0 range 0 .. 7;
      Reserved_1_0_2    at 1 range 0 .. 2;
      DBD               at 1 range 3 .. 3;
      Reserved_1_7_4    at 1 range 4 .. 7;
      PAGE_CODE         at 2 range 0 .. 5;
      PC                at 2 range 6 .. 7;
      SUBPAGE_CODE      at 3 range 0 .. 7;
      ALLOCATION_LENGTH at 4 range 0 .. 7;
      CONTROL           at 5 range 0 .. 7;
   end record;

   ------------------------
   --  REPORT LUNS [A0]  --
   ------------------------

   type REPORT_LUNS_CDB is record
      OPERATION_CODE    : SCSI.SAM5.OPERATION_CODE := SCSI.SPC5.REPORT_LUNS;
      Reserved_1        : A0B.Types.Reserved_8     := A0B.Types.Zero;
      SELECT_REPORT     : A0B.Types.Unsigned_8;
      Reserved_3        : A0B.Types.Reserved_8     := A0B.Types.Zero;
      Reserved_4        : A0B.Types.Reserved_8     := A0B.Types.Zero;
      Reserved_5        : A0B.Types.Reserved_8     := A0B.Types.Zero;
      ALLOCATION_LENGTH : A0B.Types.Big_Endian.Unsigned_32;
      Reserved_10       : A0B.Types.Reserved_8     := A0B.Types.Zero;
      CONTROL           : SCSI.SAM5.CONTROL;
   end record
     with Size      => REPORT_LUNS_CDB_Length * A0B.Types.Unsigned_8'Size,
          Bit_Order => System.Low_Order_First;

   for REPORT_LUNS_CDB use record
      OPERATION_CODE    at 0 range 0 .. 7;
      Reserved_1        at 1 range 0 .. 7;
      SELECT_REPORT     at 2 range 0 .. 7;
      Reserved_3        at 3 range 0 .. 7;
      Reserved_4        at 4 range 0 .. 7;
      Reserved_5        at 5 range 0 .. 7;
      ALLOCATION_LENGTH at 6 range 0 .. 31;
      Reserved_10       at 10 range 0 .. 7;
      CONTROL           at 11 range 0 .. 7;
   end record;

   -----------------------------------
   --  SERVICE ACTION IN (16) [9E]  --
   -----------------------------------

   type SERVICE_ACTION_IN_16_CDB is record
      OPERATION_CODE    : SCSI.SAM5.OPERATION_CODE :=
        SCSI.SPC5.SERVICE_ACTION_IN_16;
      Reserved_1_7_5    : A0B.Types.Reserved_3;
      SERVICE_ACTION    : SCSI.SAM5.SERVICE_ACTION;
      Reserved_2        : A0B.Types.Reserved_8;
      Reserved_3        : A0B.Types.Reserved_8;
      Reserved_4        : A0B.Types.Reserved_8;
      Reserved_5        : A0B.Types.Reserved_8;
      Reserved_6        : A0B.Types.Reserved_8;
      Reserved_7        : A0B.Types.Reserved_8;
      Reserved_8        : A0B.Types.Reserved_8;
      Reserved_9        : A0B.Types.Reserved_8;
      Reserved_10       : A0B.Types.Reserved_8;
      Reserved_11       : A0B.Types.Reserved_8;
      Reserved_12       : A0B.Types.Reserved_8;
      Reserved_13       : A0B.Types.Reserved_8;
      Reserved_14       : A0B.Types.Reserved_8;
      CONTROL           : SCSI.SAM5.CONTROL;
   end record
     with Size      =>
            SERVICE_ACTION_IN_16_CDB_Length * A0B.Types.Unsigned_8'Size,
          Bit_Order => System.Low_Order_First;

   for SERVICE_ACTION_IN_16_CDB use record
      OPERATION_CODE    at 0 range 0 .. 7;
      Reserved_1_7_5    at 1 range 5 .. 7;
      SERVICE_ACTION    at 1 range 0 .. 4;
      Reserved_2        at 2 range 0 .. 7;
      Reserved_3        at 3 range 0 .. 7;
      Reserved_4        at 4 range 0 .. 7;
      Reserved_5        at 5 range 0 .. 7;
      Reserved_6        at 6 range 0 .. 7;
      Reserved_7        at 7 range 0 .. 7;
      Reserved_8        at 8 range 0 .. 7;
      Reserved_9        at 9 range 0 .. 7;
      Reserved_10       at 10 range 0 .. 7;
      Reserved_11       at 11 range 0 .. 7;
      Reserved_12       at 12 range 0 .. 7;
      Reserved_13       at 13 range 0 .. 7;
      Reserved_14       at 14 range 0 .. 7;
      CONTROL           at 15 range 0 .. 7;
   end record;

   ----------------------------
   --  TEST UNIT READY [00]  --
   ----------------------------

   type TEST_UNIT_READY_CDB is record
      OPERATION_CODE : SCSI.SAM5.OPERATION_CODE := SCSI.SPC5.TEST_UNIT_READY;
      Reserved_1     : A0B.Types.Reserved_8     := A0B.Types.Zero;
      Reserved_2     : A0B.Types.Reserved_8     := A0B.Types.Zero;
      Reserved_3     : A0B.Types.Reserved_8     := A0B.Types.Zero;
      Reserved_4     : A0B.Types.Reserved_8     := A0B.Types.Zero;
      CONTROL        : SCSI.SAM5.CONTROL;
   end record
     with Size      => TEST_UNIT_READY_CDB_Length * Byte_Size,
          Bit_Order => System.Low_Order_First;

   for TEST_UNIT_READY_CDB use record
      OPERATION_CODE at 0 range 0 .. 7;
      Reserved_1     at 1 range 0 .. 7;
      Reserved_2     at 2 range 0 .. 7;
      Reserved_3     at 3 range 0 .. 7;
      Reserved_4     at 4 range 0 .. 7;
      CONTROL        at 5 range 0 .. 7;
   end record;

end SCSI.SPC5.CDB;
