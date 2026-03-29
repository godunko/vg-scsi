--
--  Copyright (C) 2025-2026, Vadim Godunko <vgodunko@gmail.com>
--

--  SCSI Block Commands - 4 (SBC-4) Mode parameter data

with System;

with A0B.Types.Big_Endian;

with A0B.SCSI.SPC5.Mode;

package A0B.SCSI.SBC4.Mode with Pure is

   Caching_Mode_Page_Length                          : constant := 20;
   Informational_Exceptions_Control_Mode_Page_Length : constant := 12;
   Read_Write_Error_Recovery_Mode_Page_Length        : constant := 12;

   function To_DEVICE_SPECIFIC_PARAMETER
     (WP     : Boolean;
      DPOFUA : Boolean) return A0B.SCSI.SPC5.Mode.DEVICE_SPECIFIC_PARAMETER;

   ----------------------------
   -- Caching mode page [08] --
   ----------------------------

   type Caching_Mode_Page is record
      PS                                : Boolean;
      SPF                               : Boolean               := False;
      PAGE_CODE                         : A0B.SCSI.SPC5.Mode_Page_Code :=
        A0B.SCSI.SBC4.Caching;
      PAGE_LENGTH                       : A0B.Types.Unsigned_8  := 16#12#;
      IC                                : Boolean;
      --  Initiator control
      ABPF                              : Boolean;
      --  Abort pre-fetch
      CAP                               : Boolean;
      --  Caching analysis permitted
      DISC                              : Boolean;
      --  Discontinuity
      SIZE                              : Boolean;
      --  Size enable
      WCE                               : Boolean;
      --  Writeback cache enable
      MF                                : Boolean;
      --  Multiplication factor
      RCD                               : Boolean;
      --  Read cache disable
      DEMAND_READ_RETENTION_PRIORITY    : A0B.Types.Unsigned_4;
      WRITE_RETENTION_PRIORITY          : A0B.Types.Unsigned_4;
      DISABLE_PRE_FETCH_TRANSFER_LENGTH : A0B.Types.Big_Endian.Unsigned_16;
      MINIMUM_PRE_FETCH                 : A0B.Types.Big_Endian.Unsigned_16;
      MAXIMUM_PRE_FETCH                 : A0B.Types.Big_Endian.Unsigned_16;
      MAXIMUM_PRE_FETCH_CEILING         : A0B.Types.Big_Endian.Unsigned_16;
      FSW                               : Boolean;
      LBCSS                             : Boolean;
      DRA                               : Boolean;
      Vendor_Specific                   : A0B.Types.Reserved_2  := A0B.Types.Zero;
      SYNC_PROG                         : A0B.Types.Unsigned_2;
      NV_DIS                            : Boolean;
      NUMBER_OF_CACHE_SEGMENTS          : A0B.Types.Unsigned_8;
      CACHE_SEGMENT_SIZE                : A0B.Types.Big_Endian.Unsigned_16;
      Reserved_16                       : A0B.Types.Reserved_8  := A0B.Types.Zero;
      Obsolete_17_19                    : A0B.Types.Reserved_24 := A0B.Types.Zero;
   end record
     with Size      => Caching_Mode_Page_Length * Byte_Size,
          Bit_Order => System.Low_Order_First;

   for Caching_Mode_Page use record
      PAGE_CODE                         at 0 range 0 .. 5;
      SPF                               at 0 range 6 .. 6;
      PS                                at 0 range 7 .. 7;
      PAGE_LENGTH                       at 1 range 0 .. 7;
      RCD                               at 2 range 0 .. 0;
      MF                                at 2 range 1 .. 1;
      WCE                               at 2 range 2 .. 2;
      SIZE                              at 2 range 3 .. 3;
      DISC                              at 2 range 4 .. 4;
      CAP                               at 2 range 5 .. 5;
      ABPF                              at 2 range 6 .. 6;
      IC                                at 2 range 7 .. 7;
      WRITE_RETENTION_PRIORITY          at 3 range 0 .. 3;
      DEMAND_READ_RETENTION_PRIORITY    at 3 range 4 .. 7;
      DISABLE_PRE_FETCH_TRANSFER_LENGTH at 4 range 0 .. 15;
      MINIMUM_PRE_FETCH                 at 6 range 0 .. 15;
      MAXIMUM_PRE_FETCH                 at 8 range 0 .. 15;
      MAXIMUM_PRE_FETCH_CEILING         at 10 range 0 .. 15;
      NV_DIS                            at 12 range 0 .. 0;
      SYNC_PROG                         at 12 range 1 .. 2;
      Vendor_Specific                   at 12 range 3 .. 4;
      DRA                               at 12 range 5 .. 5;
      LBCSS                             at 12 range 6 .. 6;
      FSW                               at 12 range 7 .. 7;
      NUMBER_OF_CACHE_SEGMENTS          at 13 range 0 .. 7;
      CACHE_SEGMENT_SIZE                at 14 range 0 .. 15;
      Reserved_16                       at 16 range 0 .. 7;
      Obsolete_17_19                    at 17 range 0 .. 23;
   end record;

   -------------------------------------------
   -- Informational Exceptions Control [1C] --
   -------------------------------------------

   type Informational_Exceptions_Control_Mode_Page is record
      PS             : Boolean;
      SPF            : Boolean                  := False;
      PAGE_CODE      : SCSI.SPC5.Mode_Page_Code :=
        A0B.SCSI.SBC4.Informational_Exceptions_Control;
      PAGE_LENGTH    : A0B.Types.Unsigned_8     := 16#0A#;
      PERF           : Boolean;
      Reserved_2_6_6 : A0B.Types.Reserved_1     := A0B.Types.Zero;
      EBF            : Boolean;
      EWASC          : Boolean;
      DEXCPT         : Boolean;
      TEST           : Boolean;
      EBACKERR       : Boolean;
      LOGERR         : Boolean;
      Reserved_3_7_4 : A0B.Types.Reserved_4 := A0B.Types.Zero;
      MRIE           : A0B.Types.Unsigned_4;
      INTERVAL_TIMER : A0B.Types.Big_Endian.Unsigned_32;
      REPORT_COUNT   : A0B.Types.Big_Endian.Unsigned_32;
   end record
     with Size      =>
            Informational_Exceptions_Control_Mode_Page_Length * Byte_Size,
          Bit_Order => System.Low_Order_First;

   for Informational_Exceptions_Control_Mode_Page use record
      PAGE_CODE      at 0 range 0 .. 5;
      SPF            at 0 range 6 .. 6;
      PS             at 0 range 7 .. 7;
      PAGE_LENGTH    at 1 range 0 .. 7;
      LOGERR         at 2 range 0 .. 0;
      EBACKERR       at 2 range 1 .. 1;
      TEST           at 2 range 2 .. 2;
      DEXCPT         at 2 range 3 .. 3;
      EWASC          at 2 range 4 .. 4;
      EBF            at 2 range 5 .. 5;
      Reserved_2_6_6 at 2 range 6 .. 6;
      PERF           at 2 range 7 .. 7;
      MRIE           at 3 range 0 .. 3;
      Reserved_3_7_4 at 3 range 4 .. 7;
      INTERVAL_TIMER at 4 range 0 .. 31;
      REPORT_COUNT   at 8 range 0 .. 31;
   end record;

   ------------------------------------
   -- Read-Write Error Recovery [01] --
   ------------------------------------

   type Read_Write_Error_Recovery_Mode_Page is record
      PS                   : Boolean;
      SPF                  : Boolean                  := False;
      PAGE_CODE            : SCSI.SPC5.Mode_Page_Code :=
        A0B.SCSI.SBC4.Read_Write_Error_Recovery;
      PAGE_LENGTH          : A0B.Types.Unsigned_8     := 16#0A#;
      AWRE                 : Boolean;
      --  Automatic write reallocation enabled
      ARRE                 : Boolean;
      --  Automatic read reallocation enabled
      TB                   : Boolean;
      --  Transfer block
      RC                   : Boolean;
      --  Read continuous
      Obsolete_2_3_3       : A0B.Types.Reserved_1     := A0B.Types.Zero;
      PER                  : Boolean;
      --  Post error
      DTE                  : Boolean;
      --  Data terminate on error
      Obsolete_2_0_0       : A0B.Types.Reserved_1     := A0B.Types.Zero;
      READ_RETRY_COUNT     : A0B.Types.Unsigned_8;
      Obsolete_4           : A0B.Types.Reserved_8     := A0B.Types.Zero;
      Obsolete_5           : A0B.Types.Reserved_8     := A0B.Types.Zero;
      Obsolete_6           : A0B.Types.Reserved_8     := A0B.Types.Zero;
      LBPERE               : Boolean;
      MWR                  : A0B.Types.Unsigned_2;
      Reserved_7_4_2       : A0B.Types.Reserved_3     := A0B.Types.Zero;
      Restricted_For_MMC_6 : A0B.Types.Reserved_2     := A0B.Types.Zero;
      WRITE_RETRY_COUNT    : A0B.Types.Unsigned_8;
      Reserved_9           : A0B.Types.Reserved_8     := A0B.Types.Zero;
      RECOVERY_TIME_LIMIT  : A0B.Types.Big_Endian.Unsigned_16;
   end record
     with Size      =>
            Read_Write_Error_Recovery_Mode_Page_Length * Byte_Size,
          Bit_Order => System.Low_Order_First;

   for Read_Write_Error_Recovery_Mode_Page use record
      PAGE_CODE            at 0 range 0 .. 5;
      SPF                  at 0 range 6 .. 6;
      PS                   at 0 range 7 .. 7;
      PAGE_LENGTH          at 1 range 0 .. 7;
      Obsolete_2_0_0       at 2 range 0 .. 0;
      DTE                  at 2 range 1 .. 1;
      PER                  at 2 range 2 .. 2;
      Obsolete_2_3_3       at 2 range 3 .. 3;
      RC                   at 2 range 4 .. 4;
      TB                   at 2 range 5 .. 5;
      ARRE                 at 2 range 6 .. 6;
      AWRE                 at 2 range 7 .. 7;
      READ_RETRY_COUNT     at 3 range 0 .. 7;
      Obsolete_4           at 4 range 0 .. 7;
      Obsolete_5           at 5 range 0 .. 7;
      Obsolete_6           at 6 range 0 .. 7;
      Restricted_For_MMC_6 at 7 range 0 .. 1;
      Reserved_7_4_2       at 7 range 2 .. 4;
      MWR                  at 7 range 5 .. 6;
      LBPERE               at 7 range 7 .. 7;
      WRITE_RETRY_COUNT    at 8 range 0 .. 7;
      Reserved_9           at 9 range 0 .. 7;
      RECOVERY_TIME_LIMIT  at 10 range 0 .. 15;
   end record;

end A0B.SCSI.SBC4.Mode;
