--
--  Copyright (C) 2025-2026, Vadim Godunko <vgodunko@gmail.com>
--

with System.Storage_Elements;

package body A0B.SCSI.Buffers is

   -------------------
   -- Actual_Length --
   -------------------

   function Actual_Length
     (Self : Data_Buffer'CLass) return A0B.Types.Unsigned_32 is
   begin
      return Self.Length;
   end Actual_Length;

   -------------
   -- Address --
   -------------

   function Address (Self : Data_Buffer'Class) return System.Address is
   begin
      return Self.Address;
   end Address;

   -----------
   -- Align --
   -----------

   procedure Align
     (Self : in out Data_Buffer'Class;
      To   : A0B.Types.Unsigned_32)
   is
      use type A0B.Types.Unsigned_32;

      Aligned_Length : constant A0B.Types.Unsigned_32 :=
        ((Self.Length + To - 1) / To) * To;

   begin
      if Self.Capacity < Aligned_Length then
         raise Constraint_Error;
      end if;

      Self.Length := Aligned_Length;
   end Align;

   --------------
   -- Allocate --
   --------------

   function Allocate
     (Self    : in out Data_Buffer'Class;
      Length  : A0B.Types.Unsigned_32;
      Address : out System.Address) return Boolean
   is
      use type A0B.Types.Unsigned_32;
      use type System.Storage_Elements.Storage_Offset;

      New_Length : constant A0B.Types.Unsigned_32 := Self.Length + Length;

   begin
      if Self.Length >= Self.Allocation then
         Address := System.Null_Address;

         return False;

      elsif New_Length <= Self.Capacity then
         Address     :=
           Self.Address + System.Storage_Elements.Storage_Offset (Self.Length);
         Self.Length := New_Length;

         return True;

      else
         raise Program_Error;
      end if;
   end Allocate;

   -----------------------
   -- Allocation_Length --
   -----------------------

   function Allocation_Length
     (Self : Data_Buffer'CLass) return A0B.Types.Unsigned_32 is
   begin
      return Self.Allocation;
   end Allocation_Length;

   ------------
   -- Append --
   ------------

   procedure Append
     (Self : in out Data_Buffer'Class;
      Data : A0B.Types.Arrays.Unsigned_8_Array)
   is
      use type A0B.Types.Unsigned_32;
      use type System.Storage_Elements.Storage_Offset;

      New_Length : constant A0B.Types.Unsigned_32 :=
        Self.Length + Data'Length;

   begin
      if New_Length <= Self.Capacity then
         declare
            Address : constant System.Address :=
              Self.Address
                + System.Storage_Elements.Storage_Offset (Self.Length);
            Storage : A0B.Types.Arrays.Unsigned_8_Array
              (1 .. Data'Length) with Import, Address => Address;

         begin
            Storage     := Data;
            Self.Length := New_Length;
         end;

      else
         raise Constraint_Error;
      end if;
   end Append;

   --------------
   -- Capacity --
   --------------

   function Capacity (Self : Data_Buffer'Class) return A0B.Types.Unsigned_32 is
   begin
      return Self.Capacity;
   end Capacity;

   ----------------
   -- Initialize --
   ----------------

   procedure Initialize
     (Self     : out Data_Buffer'Class;
      Address  : System.Address;
      Capacity : A0B.Types.Unsigned_32) is
   begin
      Self.Address    := Address;
      Self.Capacity   := Capacity;

      Reset (Self);
   end Initialize;

   ------------
   -- Length --
   ------------

   function Length (Self : Data_Buffer'Class) return A0B.Types.Unsigned_32 is
   begin
      return A0B.Types.Unsigned_32'Min (Self.Length, Self.Allocation);
   end Length;

   -----------
   -- Reset --
   -----------

   procedure Reset (Self : in out Data_Buffer'Class) is
   begin
      Self.Allocation := A0B.Types.Unsigned_32'Last;
      Self.Length     := 0;
   end Reset;

   ---------------------------
   -- Set_Allocation_Length --
   ---------------------------

   procedure Set_Allocation_Length
     (Self : in out Data_Buffer'Class;
      To   : A0B.Types.Unsigned_32)
   is
      use type A0B.Types.Unsigned_32;

   begin
      pragma Assert (To <= Self.Capacity);

      Self.Allocation := To;
   end Set_Allocation_Length;

   ----------------
   -- Set_Length --
   ----------------

   procedure Set_Length
     (Self : in out Data_Buffer'Class;
      To   : A0B.Types.Unsigned_32)
   is
      use type A0B.Types.Unsigned_32;

   begin
      if Self.Capacity < To then
         raise Constraint_Error;
      end if;

      Self.Length := To;
   end Set_Length;

end A0B.SCSI.Buffers;
