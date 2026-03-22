--
--  Copyright (C) 2025-2026, Vadim Godunko <vgodunko@gmail.com>
--

with System;

with A0B.Types;

package A0B.SCSI.Buffers with Pure is

   type Data_Buffer is tagged limited private;

   procedure Initialize
     (Self     : out Data_Buffer'Class;
      Address  : System.Address;
      Capacity : A0B.Types.Unsigned_32);

   procedure Reset (Self : in out Data_Buffer'Class);

   function Address (Self : Data_Buffer'Class) return System.Address;

   function Capacity (Self : Data_Buffer'Class) return A0B.Types.Unsigned_32;

   function Allocation_Length
     (Self : Data_Buffer'CLass) return A0B.Types.Unsigned_32;

   function Length (Self : Data_Buffer'CLass) return A0B.Types.Unsigned_32;

   procedure Set_Allocation_Length
     (Self : in out Data_Buffer'Class;
      To   : A0B.Types.Unsigned_32);

   procedure Set_Length
     (Self : in out Data_Buffer'Class;
      To   : A0B.Types.Unsigned_32);

   function Allocate
     (Self    : in out Data_Buffer'Class;
      Length  : A0B.Types.Unsigned_32;
      Address : out System.Address) return Boolean;

   procedure Align
     (Self : in out Data_Buffer'Class;
      To   : A0B.Types.Unsigned_32);

private

   type Data_Buffer is tagged limited record
      Address    : System.Address;
      Capacity   : A0B.Types.Unsigned_32;
      Allocation : A0B.Types.Unsigned_32;
      Length     : A0B.Types.Unsigned_32;
   end record;

end A0B.SCSI.Buffers;
