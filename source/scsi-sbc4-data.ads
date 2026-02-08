--
--  Copyright (C) 2025-2026, Vadim Godunko <vgodunko@gmail.com>
--

--  SCSI Block Commands - 4 (SBC-4) Command data

with System;

with A0B.Types.Big_Endian;

package SCSI.SBC4.Data with Pure is

   READ_CAPACITY_16_Data_Length : constant := 32;

   --------------------------
   --  READ CAPACITY (16)  --
   --------------------------

   type READ_CAPACITY_16_Data is record
      RETURNED_LOGICAL_BLOCK_ADDRESS : A0B.Types.Big_Endian.Unsigned_64;
      BLOCK_LENGTH_IN_BYTES          : A0B.Types.Big_Endian.Unsigned_32;
      Reserved_12_7_6                : A0B.Types.Reserved_2 := A0B.Types.Zero;
      Restricted_For_ZBC             : A0B.Types.Reserved_2 := A0B.Types.Zero;
      P_TYPE                         : A0B.Types.Unsigned_3;
      PROT_EN                        : Boolean;
      P_I_EXPONENT                   : A0B.Types.Unsigned_4;
      LOGICAL_BLOCKS_PER_PHYSICAL_BLOCK_EXPONENT :
                                       A0B.Types.Unsigned_4;
      --  LBPME                          : Boolean;
      --  LBPRZ                          : Boolean;
      --  LOWEST ALIGNED LOGICAL BLOCK ADDRESS : A0B.Types.Big_Endian.Unsigned_14;
      --  There is no way to declare layout of these components
      LOWEST_ALIGNED_LOGICAL_BLOCK_ADDRESS : A0B.Types.Big_Endian.Unsigned_16;
      Reserved_16                    : A0B.Types.Reserved_8 := A0B.Types.Zero;
      Reserved_17                    : A0B.Types.Reserved_8 := A0B.Types.Zero;
      Reserved_18                    : A0B.Types.Reserved_8 := A0B.Types.Zero;
      Reserved_19                    : A0B.Types.Reserved_8 := A0B.Types.Zero;
      Reserved_20                    : A0B.Types.Reserved_8 := A0B.Types.Zero;
      Reserved_21                    : A0B.Types.Reserved_8 := A0B.Types.Zero;
      Reserved_22                    : A0B.Types.Reserved_8 := A0B.Types.Zero;
      Reserved_23                    : A0B.Types.Reserved_8 := A0B.Types.Zero;
      Reserved_24                    : A0B.Types.Reserved_8 := A0B.Types.Zero;
      Reserved_25                    : A0B.Types.Reserved_8 := A0B.Types.Zero;
      Reserved_26                    : A0B.Types.Reserved_8 := A0B.Types.Zero;
      Reserved_27                    : A0B.Types.Reserved_8 := A0B.Types.Zero;
      Reserved_28                    : A0B.Types.Reserved_8 := A0B.Types.Zero;
      Reserved_29                    : A0B.Types.Reserved_8 := A0B.Types.Zero;
      Reserved_30                    : A0B.Types.Reserved_8 := A0B.Types.Zero;
      Reserved_31                    : A0B.Types.Reserved_8 := A0B.Types.Zero;
   end record
     with Size      => READ_CAPACITY_16_Data_Length * Byte_Size,
          Bit_Order => System.Low_Order_First;

   for READ_CAPACITY_16_Data use record
      RETURNED_LOGICAL_BLOCK_ADDRESS             at 0 range 0 .. 63;
      BLOCK_LENGTH_IN_BYTES                      at 8 range 0 .. 31;
      PROT_EN                                    at 12 range 0 .. 0;
      P_TYPE                                     at 12 range 1 .. 3;
      Restricted_For_ZBC                         at 12 range 4 .. 5;
      Reserved_12_7_6                            at 12 range 6 .. 7;
      LOGICAL_BLOCKS_PER_PHYSICAL_BLOCK_EXPONENT at 13 range 0 .. 3;
      P_I_EXPONENT                               at 13 range 4 .. 7;
      LOWEST_ALIGNED_LOGICAL_BLOCK_ADDRESS       at 14 range 0 .. 15;
      Reserved_16                                at 16 range 0 .. 7;
      Reserved_17                                at 17 range 0 .. 7;
      Reserved_18                                at 18 range 0 .. 7;
      Reserved_19                                at 19 range 0 .. 7;
      Reserved_20                                at 20 range 0 .. 7;
      Reserved_21                                at 21 range 0 .. 7;
      Reserved_22                                at 22 range 0 .. 7;
      Reserved_23                                at 23 range 0 .. 7;
      Reserved_24                                at 24 range 0 .. 7;
      Reserved_25                                at 25 range 0 .. 7;
      Reserved_26                                at 26 range 0 .. 7;
      Reserved_27                                at 27 range 0 .. 7;
      Reserved_28                                at 28 range 0 .. 7;
      Reserved_29                                at 29 range 0 .. 7;
      Reserved_30                                at 30 range 0 .. 7;
      Reserved_31                                at 31 range 0 .. 7;
   end record;

end SCSI.SBC4.Data;
