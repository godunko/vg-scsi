--
--  Copyright (C) 2025-2026, Vadim Godunko <vgodunko@gmail.com>
--

--  SCSI Block Commands - 4 (SBC-4) Mode parameter data

with System;

with A0B.Types.Big_Endian;

with A0B.SCSI.SPC5.Mode;

package A0B.SCSI.SBC4.Mode with Pure is

   Caching_Mode_Page_Length : constant := 20;

   function To_DEVICE_SPECIFIC_PARAMETER
     (WP     : Boolean;
      DPOFUA : Boolean) return A0B.SCSI.SPC5.Mode.DEVICE_SPECIFIC_PARAMETER;

   -------------------------
   --  Caching mode page  --
   -------------------------

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

end A0B.SCSI.SBC4.Mode;
