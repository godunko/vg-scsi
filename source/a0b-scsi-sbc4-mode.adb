--
--  Copyright (C) 2025-2026, Vadim Godunko <vgodunko@gmail.com>
--

package body A0B.SCSI.SBC4.Mode is

   type Block_DEVICE_SPECIFIC_PARAMETER is record
      WP           : Boolean;
      Reserved_6_5 : A0B.Types.Reserved_2 := A0B.Types.Zero;
      DPOFUA       : Boolean;
      Reserved_3_0 : A0B.Types.Reserved_4 := A0B.Types.Zero;
   end record with Size => Byte_Size;

   for Block_DEVICE_SPECIFIC_PARAMETER use record
      Reserved_3_0 at 0 range 0 .. 3;
      DPOFUA       at 0 range 4 .. 4;
      Reserved_6_5 at 0 range 5 .. 6;
      WP           at 0 range 7 .. 7;
   end record;

   ----------------------------------
   -- To_DEVICE_SPECIFIC_PARAMETER --
   ----------------------------------

   function To_DEVICE_SPECIFIC_PARAMETER
     (WP     : Boolean;
      DPOFUA : Boolean) return A0B.SCSI.SPC5.Mode.DEVICE_SPECIFIC_PARAMETER is
   begin
      return Result : A0B.SCSI.SPC5.Mode.DEVICE_SPECIFIC_PARAMETER do
         declare
            Overlay : Block_DEVICE_SPECIFIC_PARAMETER
              with Import, Address => Result'Address;

         begin
            Overlay :=
              (WP     => WP,
               DPOFUA => DPOFUA,
               others => <>);
         end;
      end return;
   end To_DEVICE_SPECIFIC_PARAMETER;

end A0B.SCSI.SBC4.Mode;