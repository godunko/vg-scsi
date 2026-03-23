--
--  Copyright (C) 2026, Vadim Godunko <vgodunko@gmail.com>
--

package body A0B.SCSI.SBC4.Data is

   type READ_CAPACITY_16_14 is record
      LBPME                                    : Boolean;
      LBPRZ                                    : Boolean;
      LOWEST_ALIGNED_LOGICAL_BLOCK_ADDRESS_MSB : A0B.Types.Unsigned_6;
   end record with Size => 1 * Byte_Size;

   for READ_CAPACITY_16_14 use record
      LBPME                                    at 0 range 7 .. 7;
      LBPRZ                                    at 0 range 6 .. 6;
      LOWEST_ALIGNED_LOGICAL_BLOCK_ADDRESS_MSB at 0 range 0 .. 5;
   end record;

   type READ_CAPACITY_16_14_15 is record
      LBPME_LBPRZ_MSB                          : READ_CAPACITY_16_14;
      LOWEST_ALIGNED_LOGICAL_BLOCK_ADDRESS_LSB : A0B.Types.Unsigned_8;
   end record with Size => 2 * Byte_Size;

   ----------------------
   -- As_Private_14_15 --
   ----------------------

   function As_Private_14_15
     (LBPME                                : Boolean;
      LBPRZ                                : Boolean;
      LOWEST_ALIGNED_LOGICAL_BLOCK_ADDRESS : A0B.Types.Unsigned_14)
      return A0B.Types.Reserved_16
   is
      use type A0B.Types.Unsigned_14;

      MSB : constant A0B.Types.Unsigned_6 :=
        A0B.Types.Unsigned_6 (LOWEST_ALIGNED_LOGICAL_BLOCK_ADDRESS / 256);
      LSB : constant A0B.Types.Unsigned_8 :=
        A0B.Types.Unsigned_8 (LOWEST_ALIGNED_LOGICAL_BLOCK_ADDRESS mod 256);

   begin
      return Result : A0B.Types.Reserved_16 do
         declare
            Value : READ_CAPACITY_16_14_15 :=
              (LBPME_LBPRZ_MSB =>
                 (LBPME => LBPME,
                  LBPRZ => LBPRZ,
                  LOWEST_ALIGNED_LOGICAL_BLOCK_ADDRESS_MSB => MSB),
               LOWEST_ALIGNED_LOGICAL_BLOCK_ADDRESS_LSB => LSB)
                 with Address => Result'Address;

         begin
            null;
         end;
      end return;
   end As_Private_14_15;

   ---------------
   -- Get_LBPME --
   ---------------

   function Get_LBPME (Data : READ_CAPACITY_16_Data) return Boolean is
      Flags : constant READ_CAPACITY_16_14
        with Import, Address => Data.Private_14_15'Address;

   begin
      return Flags.LBPME;
   end Get_LBPME;

   ---------------
   -- Get_LBPRZ --
   ---------------

   function Get_LBPRZ (Data : READ_CAPACITY_16_Data) return Boolean is
      Flags : constant READ_CAPACITY_16_14
        with Import, Address => Data.Private_14_15'Address;

   begin
      return Flags.LBPRZ;
   end Get_LBPRZ;

   ----------------------------------------------
   -- Get_LOWEST_ALIGNED_LOGICAL_BLOCK_ADDRESS --
   ----------------------------------------------

   function Get_LOWEST_ALIGNED_LOGICAL_BLOCK_ADDRESS
     (Data : READ_CAPACITY_16_Data) return A0B.Types.Unsigned_14
   is
      use type A0B.Types.Unsigned_14;

      Value : constant READ_CAPACITY_16_14_15
        with Import, Address => Data.Private_14_15'Address;

      MSB   : constant A0B.Types.Unsigned_14 :=
        A0B.Types.Unsigned_14
          (Value.LBPME_LBPRZ_MSB.LOWEST_ALIGNED_LOGICAL_BLOCK_ADDRESS_MSB);
      LSB   : constant A0B.Types.Unsigned_14 :=
        A0B.Types.Unsigned_14
          (Value.LOWEST_ALIGNED_LOGICAL_BLOCK_ADDRESS_LSB);

   begin
      return MSB * 256 + LSB;
   end Get_LOWEST_ALIGNED_LOGICAL_BLOCK_ADDRESS;

   ---------------
   -- Set_LBPME --
   ---------------

   procedure Set_LBPME (Data : in out READ_CAPACITY_16_Data; To : Boolean) is
      Flags : READ_CAPACITY_16_14
        with Import, Address => Data.Private_14_15'Address;

   begin
      Flags.LBPME := To;
   end Set_LBPME;

   ---------------
   -- Set_LBPRZ --
   ---------------

   procedure Set_LBPRZ (Data : in out READ_CAPACITY_16_Data; To : Boolean) is
      Flags : READ_CAPACITY_16_14
        with Import, Address => Data.Private_14_15'Address;

   begin
      Flags.LBPRZ := To;
   end Set_LBPRZ;

   ----------------------------------------------
   -- Set_LOWEST_ALIGNED_LOGICAL_BLOCK_ADDRESS --
   ----------------------------------------------

   procedure Set_LOWEST_ALIGNED_LOGICAL_BLOCK_ADDRESS
     (Data : in out READ_CAPACITY_16_Data; To : A0B.Types.Unsigned_14)
   is
      use type A0B.Types.Unsigned_14;

      Value : READ_CAPACITY_16_14_15
        with Import, Address => Data.Private_14_15'Address;

      MSB : constant A0B.Types.Unsigned_6 := A0B.Types.Unsigned_6 (To / 256);
      LSB : constant A0B.Types.Unsigned_8 :=
        A0B.Types.Unsigned_8 (To mod 256);

   begin
      Value.LBPME_LBPRZ_MSB.LOWEST_ALIGNED_LOGICAL_BLOCK_ADDRESS_MSB := MSB;
      Value.LOWEST_ALIGNED_LOGICAL_BLOCK_ADDRESS_LSB := LSB;
   end Set_LOWEST_ALIGNED_LOGICAL_BLOCK_ADDRESS;

end A0B.SCSI.SBC4.Data;
