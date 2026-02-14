--
--  Copyright (C) 2025-2026, Vadim Godunko <vgodunko@gmail.com>
--

with Ada.Unchecked_Conversion;

package body SCSI.SBC4.CDB with Pure is

   ---------------------------
   -- LOGICAL_BLOCK_ADDRESS --
   ---------------------------

   function LOGICAL_BLOCK_ADDRESS
     (CDB : READ_6_CDB) return A0B.Types.Unsigned_64
   is
      use type A0B.Types.Unsigned_64;

      pragma Warnings (Off, "overlay changes scalar storage order");
      Component : constant A0B.Types.Big_Endian.Unsigned_24
        with Import, Address => CDB.Reserved_LOGICAL_BLOCK_ADDRESS'Address;
      pragma Warnings (On, "overlay changes scalar storage order");

   begin
      return A0B.Types.Unsigned_64 (Component.Value) and 16#1F_FF_FF#;
   end LOGICAL_BLOCK_ADDRESS;

   --------------------
   -- Reserved_1_7_5 --
   --------------------

   function Reserved_1_7_5 (CDB : READ_6_CDB) return A0B.Types.Reserved_3 is

      function To_Reserved_3 is
        new Ada.Unchecked_Conversion
              (A0B.Types.Unsigned_3, A0B.Types.Reserved_3);

      pragma Warnings (Off, "overlay changes scalar storage order");
      Component : constant A0B.Types.Big_Endian.Unsigned_24
        with Import, Address => CDB.Reserved_LOGICAL_BLOCK_ADDRESS'Address;
      pragma Warnings (On, "overlay changes scalar storage order");

   begin
      return
        To_Reserved_3
          (A0B.Types.Unsigned_3
             (A0B.Types.Shift_Right
                (A0B.Types.Unsigned_32 (Component.Value), 21)));
   end Reserved_1_7_5;

end SCSI.SBC4.CDB;
