--
--  Copyright (C) 2025-2026, Vadim Godunko <vgodunko@gmail.com>
--

--  SCSI Primary Commands - 5 (SPC-5) Command data

pragma Ada_2022;

with System;

with A0B.Types.Arrays;
with A0B.Types.Big_Endian;

package SCSI.SPC5.Data with Pure is

   use type A0B.Types.Unsigned_8;

   INQUIRY_Data_Length            : constant := 96;
   REPORT_LUNS_Data_Header_Length : constant := 8;

   type Vendor_Information_Field is array (0 .. 7) of Character;

   type Product_Identification_Field is array (0 .. 15) of Character;

   type Product_Revision_Level_Field is array (0 .. 3) of Character;

   ---------------
   --  INQUIRY  --
   ---------------

   type INQUIRY_Data is record
      PERIPHERAL_QUALIFIER      : A0B.Types.Unsigned_3;
      PERIPHERAL_DEVICE_TYPE    : A0B.Types.Unsigned_5;
      RMB                       : Boolean;
      LU_CONG                   : Boolean;
      Reserved_1_5_0            : A0B.Types.Reserved_6 := A0B.Types.Zero;
      VERSION                   : A0B.Types.Unsigned_8;
      Reserved_3_7_6            : A0B.Types.Reserved_2 := A0B.Types.Zero;
      NORMACA                   : Boolean;
      HISUP                     : Boolean;
      RESPONSE_DATA_FORMAT      : A0B.Types.Unsigned_4 := 16#02#;
      ADDITIONAL_LENGTH         : A0B.Types.Unsigned_8 :=
        INQUIRY_Data_Length - 1 - 4;
      SCCS                      : Boolean;
      Obsolete_5_6_6            : A0B.Types.Reserved_1 := A0B.Types.Zero;
      TPGS                      : A0B.Types.Unsigned_2;
      T3PC                      : Boolean;
      Reserved_5_2_1            : A0B.Types.Reserved_2 := A0B.Types.Zero;
      PROTECT                   : Boolean;
      Obsolete_6_7_7            : A0B.Types.Reserved_1 := A0B.Types.Zero;
      ENCSERV                   : Boolean;
      VS_6_5_5                  : Boolean;
      MULTIP                    : Boolean;
      Obsolete_6_3_3            : A0B.Types.Reserved_1 := A0B.Types.Zero;
      Reserved_6_2_1            : A0B.Types.Reserved_2 := A0B.Types.Zero;
      Obsolete_6_0_0            : A0B.Types.Reserved_1 := A0B.Types.Zero;
      Obsolete_7_7_7            : A0B.Types.Reserved_1 := A0B.Types.Zero;
      Reserved_7_6_6            : A0B.Types.Reserved_1 := A0B.Types.Zero;
      Obsolete_7_5_4            : A0B.Types.Reserved_2 := A0B.Types.Zero;
      Obsolete_7_3_3            : A0B.Types.Reserved_1 := A0B.Types.Zero;
      Reserved_7_2_2            : A0B.Types.Reserved_1 := A0B.Types.Zero;
      CMDQUE                    : Boolean;
      VS_7_0_0                  : Boolean;
      T10_VENDOR_IDENTIFICATION : Vendor_Information_Field;
      PRODUCT_IDENTIFICATION    : Product_Identification_Field;
      PRODUCT_REVISION_LEVEL    : Product_Revision_Level_Field;
      Vendor_Specific_36_55     : A0B.Types.Arrays.Unsigned_8_Array (36 .. 55) :=
        [others => 16#00#];
      Reserved_56_7_4           : A0B.Types.Reserved_4 := A0B.Types.Zero;
      Obsolete_56_3_0           : A0B.Types.Reserved_4 := A0B.Types.Zero;
      Reserved_57               : A0B.Types.Reserved_8 := A0B.Types.Zero;
      VERSION_DESCRIPTOR_1      : A0B.Types.Big_Endian.Unsigned_16;
      VERSION_DESCRIPTOR_2      : A0B.Types.Big_Endian.Unsigned_16;
      VERSION_DESCRIPTOR_3      : A0B.Types.Big_Endian.Unsigned_16;
      VERSION_DESCRIPTOR_4      : A0B.Types.Big_Endian.Unsigned_16;
      VERSION_DESCRIPTOR_5      : A0B.Types.Big_Endian.Unsigned_16;
      VERSION_DESCRIPTOR_6      : A0B.Types.Big_Endian.Unsigned_16;
      VERSION_DESCRIPTOR_7      : A0B.Types.Big_Endian.Unsigned_16;
      VERSION_DESCRIPTOR_8      : A0B.Types.Big_Endian.Unsigned_16;
      Reserved_74_95            : A0B.Types.Arrays.Unsigned_8_Array (74 .. 95) :=
        [others => 16#00#];
   end record
     with Size      => INQUIRY_Data_Length * Byte_Size,
          Bit_Order => System.Low_Order_First;

   for INQUIRY_Data use record
      PERIPHERAL_DEVICE_TYPE    at 0 range 0 .. 4;
      PERIPHERAL_QUALIFIER      at 0 range 5 .. 7;
      Reserved_1_5_0            at 1 range 0 .. 5;
      LU_CONG                   at 1 range 6 .. 6;
      RMB                       at 1 range 7 .. 7;
      VERSION                   at 2 range 0 .. 7;
      RESPONSE_DATA_FORMAT      at 3 range 0 .. 3;
      HISUP                     at 3 range 4 .. 4;
      NORMACA                   at 3 range 5 .. 5;
      Reserved_3_7_6            at 3 range 6 .. 7;
      ADDITIONAL_LENGTH         at 4 range 0 .. 7;
      PROTECT                   at 5 range 0 .. 0;
      Reserved_5_2_1            at 5 range 1 .. 2;
      T3PC                      at 5 range 3 .. 3;
      TPGS                      at 5 range 4 .. 5;
      Obsolete_5_6_6            at 5 range 6 .. 6;
      SCCS                      at 5 range 7 .. 7;
      Obsolete_6_0_0            at 6 range 0 .. 0;
      Reserved_6_2_1            at 6 range 1 .. 2;
      Obsolete_6_3_3            at 6 range 3 .. 3;
      MULTIP                    at 6 range 4 .. 4;
      VS_6_5_5                  at 6 range 5 .. 5;
      ENCSERV                   at 6 range 6 .. 6;
      Obsolete_6_7_7            at 6 range 7 .. 7;
      VS_7_0_0                  at 7 range 0 .. 0;
      CMDQUE                    at 7 range 1 .. 1;
      Reserved_7_2_2            at 7 range 2 .. 2;
      Obsolete_7_3_3            at 7 range 3 .. 3;
      Obsolete_7_5_4            at 7 range 4 .. 5;
      Reserved_7_6_6            at 7 range 6 .. 6;
      Obsolete_7_7_7            at 7 range 7 .. 7;
      T10_VENDOR_IDENTIFICATION at 8 range 0 .. 8 * 8 - 1;
      PRODUCT_IDENTIFICATION    at 16 range 0 .. 8 * 16 - 1;
      PRODUCT_REVISION_LEVEL    at 32 range 0 .. 8 * 4 - 1;
      Vendor_Specific_36_55     at 36 range 0 .. 159;
      Obsolete_56_3_0           at 56 range 0 .. 3;
      Reserved_56_7_4           at 56 range 4 .. 7;
      Reserved_57               at 57 range 0 .. 7;
      VERSION_DESCRIPTOR_1      at 58 range 0 .. 15;
      VERSION_DESCRIPTOR_2      at 60 range 0 .. 15;
      VERSION_DESCRIPTOR_3      at 62 range 0 .. 15;
      VERSION_DESCRIPTOR_4      at 64 range 0 .. 15;
      VERSION_DESCRIPTOR_5      at 66 range 0 .. 15;
      VERSION_DESCRIPTOR_6      at 68 range 0 .. 15;
      VERSION_DESCRIPTOR_7      at 70 range 0 .. 15;
      VERSION_DESCRIPTOR_8      at 72 range 0 .. 15;
      Reserved_74_95            at 74 range 0 .. 175;
   end record;

   -------------------
   --  REPORT LUNS  --
   -------------------

   type REPORT_LUNS_Data_Header is record
      LUN_LIST_LENGTH : A0B.Types.Big_Endian.Unsigned_32;
      Reserved_4      : A0B.Types.Reserved_8 := A0B.Types.Zero;
      Reserved_5      : A0B.Types.Reserved_8 := A0B.Types.Zero;
      Reserved_6      : A0B.Types.Reserved_8 := A0B.Types.Zero;
      Reserved_7      : A0B.Types.Reserved_8 := A0B.Types.Zero;
   end record
     with Size      => REPORT_LUNS_Data_Header_Length * Byte_Size,
          Bit_Order => System.Low_Order_First;

   for REPORT_LUNS_Data_Header use record
      LUN_LIST_LENGTH at 0 range 0 .. 31;
      Reserved_4      at 4 range 0 .. 7;
      Reserved_5      at 5 range 0 .. 7;
      Reserved_6      at 6 range 0 .. 7;
      Reserved_7      at 7 range 0 .. 7;
   end record;

end SCSI.SPC5.Data;
