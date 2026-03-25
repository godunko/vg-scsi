--
--  Copyright (C) 2025-2026, Vadim Godunko <vgodunko@gmail.com>
--

package body A0B.SCSI.SBC4.CDB is

   type DLD_Field (As_Bits : Boolean := True) is record
      case As_Bits is
         when False =>
            DLD : A0B.Types.Unsigned_3;

         when True =>
            DLD2 : A0B.Types.Unsigned_1;
            DLD1 : A0B.Types.Unsigned_1;
            DLD0 : A0B.Types.Unsigned_1;
      end case;
   end record with Unchecked_Union, Size => 3;

   for DLD_Field use record
      DLD  at 0 range 0 .. 2;
      DLD0 at 0 range 0 .. 0;
      DLD1 at 0 range 1 .. 1;
      DLD2 at 0 range 2 .. 2;
   end record;

   -------------
   -- As_DLD0 --
   -------------

   function As_DLD0
     (DLD : A0B.Types.Unsigned_3) return A0B.Types.Unsigned_1
   is
      Aux : constant DLD_Field := (As_Bits => False, DLD => DLD);

   begin
      return Aux.DLD0;
   end As_DLD0;

   -------------
   -- As_DLD1 --
   -------------

   function As_DLD1
     (DLD : A0B.Types.Unsigned_3) return A0B.Types.Unsigned_1
   is
      Aux : constant DLD_Field := (As_Bits => False, DLD => DLD);

   begin
      return Aux.DLD1;
   end As_DLD1;

   -------------
   -- As_DLD2 --
   -------------

   function As_DLD2
     (DLD : A0B.Types.Unsigned_3) return A0B.Types.Unsigned_1
   is
      Aux : constant DLD_Field := (As_Bits => False, DLD => DLD);

   begin
      return Aux.DLD2;
   end As_DLD2;

   -------------
   -- Get_DLD --
   -------------

   function Get_DLD (CDB : READ_16_CDB) return A0B.Types.Unsigned_3 is
      Aux : constant DLD_Field :=
        (As_Bits => True,
         DLD2    => CDB.DLD2,
         DLD1    => CDB.DLD1,
         DLD0    => CDB.DLD0);

   begin
      return Aux.DLD;
   end Get_DLD;

   -------------
   -- Set_DLD --
   -------------

   procedure Set_DLD (CDB : in out READ_16_CDB; DLD : A0B.Types.Unsigned_3) is
      Aux : constant DLD_Field := (As_Bits => False, DLD => DLD);

   begin
      CDB.DLD0 := Aux.DLD0;
      CDB.DLD1 := Aux.DLD1;
      CDB.DLD2 := Aux.DLD2;
   end Set_DLD;

end A0B.SCSI.SBC4.CDB;
