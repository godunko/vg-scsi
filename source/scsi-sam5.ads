--
--  Copyright (C) 2025-2026, Vadim Godunko <vgodunko@gmail.com>
--

--  SCSI Architecture Model - 5 (SAM-5)

with A0B.Types;

package SCSI.SAM5 with Pure is

   --  SAM-3 definition of OPERATION_CODE
   --
   --  type OPERATION_CODE_View is (Group_Command, Operation);
   --
   --  type OPERATION_CODE (View : OPERATION_CODE_View := Operation) is record
   --     case View is
   --        when Group_Command =>
   --           GROUP_CODE   : A0B.Types.Unsigned_3;
   --           COMMAND_CODE : A0B.Types.Unsigned_5;
   --
   --        when Operation =>
   --           OPERATION_CODE : A0B.Types.Unsigned_8;
   --     end case;
   --  end record with Unchecked_Union, Size => 8;
   --
   --  for OPERATION_CODE use record
   --     COMMAND_CODE   at 0 range 0 .. 4;
   --     GROUP_CODE     at 0 range 5 .. 7;
   --     OPERATION_CODE at 0 range 0 .. 7;
   --  end record;

   type OPERATION_CODE is new A0B.Types.Unsigned_8;
   type SERVICE_ACTION is new A0B.Types.Unsigned_5;

   type CONTROL is record
      VS_0_7_6       : A0B.Types.Reserved_2 := A0B.Types.Zero;
      Reserved_0_5_3 : A0B.Types.Reserved_3 := A0B.Types.Zero;
      NACA           : Boolean;
      Obsolete_0_1_1 : A0B.Types.Reserved_1 := A0B.Types.Zero;
      Obsolete_0_0_0 : A0B.Types.Reserved_1 := A0B.Types.Zero;
      --  SAM-3: LINK
   end record with Size => Byte_Size;

   for CONTROL use record
      Obsolete_0_0_0 at 0 range 0 .. 0;
      Obsolete_0_1_1 at 0 range 1 .. 1;
      NACA           at 0 range 2 .. 2;
      Reserved_0_5_3 at 0 range 3 .. 5;
      VS_0_7_6       at 0 range 6 .. 7;
   end record;

end SCSI.SAM5;
