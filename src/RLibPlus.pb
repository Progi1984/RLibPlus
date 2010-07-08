;- Remerciements : DrDri : RLibPlus_Editor_IsDigit

CompilerIf #PB_Compiler_Thread = #True
  Import "C:\Program Files\PureBasic\Compilers\ObjectManagerThread.lib"
CompilerElse
  Import "C:\Program Files\PureBasic\Compilers\ObjectManager.lib"
CompilerEndIf
  Object_GetOrAllocateID (Objects, Object.l) As "_PB_Object_GetOrAllocateID@8"
  Object_GetObject       (Objects, Object.l) As "_PB_Object_GetObject@8"
  Object_IsObject        (Objects, Object.l) As "_PB_Object_IsObject@8"
  Object_EnumerateAll    (Objects, ObjectEnumerateAllCallback, *VoidData) As "_PB_Object_EnumerateAll@12"
  Object_EnumerateStart  (Objects) As "_PB_Object_EnumerateStart@4"
  Object_EnumerateNext   (Objects, *object.Long) As "_PB_Object_EnumerateNext@8"
  Object_EnumerateAbort  (Objects) As "_PB_Object_EnumerateAbort@4"
  Object_FreeID          (Objects, Object.l) As "_PB_Object_FreeID@8"
  Object_Init            (StructureSize.l, IncrementStep.l, ObjectFreeFunction) As "_PB_Object_Init@12"
  Object_GetThreadMemory (MemoryID.l) As "_PB_Object_GetThreadMemory@4"
  Object_InitThreadMemory(Size.l, InitFunction, EndFunction) As "_PB_Object_InitThreadMemory@12"
EndImport ;}
