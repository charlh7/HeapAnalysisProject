; ModuleID = '/home/curt/HeapDataFlow/benchmarkResults/memsafety/cmp-freed-ptr.bc'
source_filename = "/home/curt/HeapDataFlow/sv-benchmarks/c/memsafety/cmp-freed-ptr.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.T = type { %struct.T* }

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @main() #0 {
  %1 = alloca i32, align 4
  %2 = alloca %struct.T*, align 8
  %3 = alloca %struct.T*, align 8
  %4 = alloca i64, align 8
  %5 = alloca i64, align 8
  store i32 0, i32* %1, align 4
  store %struct.T* null, %struct.T** %2, align 8
  store %struct.T* null, %struct.T** %3, align 8
  %6 = call noalias i8* @malloc(i64 8) #2
  %7 = bitcast i8* %6 to %struct.T*
  store %struct.T* %7, %struct.T** %3, align 8
  %8 = load %struct.T*, %struct.T** %3, align 8
  %9 = ptrtoint %struct.T* %8 to i64
  store i64 %9, i64* %4, align 8
  %10 = load %struct.T*, %struct.T** %3, align 8
  %11 = bitcast %struct.T* %10 to i8*
  call void @free(i8* %11) #2
  %12 = call noalias i8* @malloc(i64 8) #2
  %13 = bitcast i8* %12 to %struct.T*
  store %struct.T* %13, %struct.T** %2, align 8
  %14 = load %struct.T*, %struct.T** %2, align 8
  %15 = ptrtoint %struct.T* %14 to i64
  store i64 %15, i64* %5, align 8
  %16 = load i64, i64* %5, align 8
  %17 = load i64, i64* %4, align 8
  %18 = icmp eq i64 %16, %17
  br i1 %18, label %19, label %22

19:                                               ; preds = %0
  %20 = load %struct.T*, %struct.T** %2, align 8
  %21 = bitcast %struct.T* %20 to i8*
  call void @free(i8* %21) #2
  br label %22

22:                                               ; preds = %19, %0
  %23 = load %struct.T*, %struct.T** %2, align 8
  %24 = bitcast %struct.T* %23 to i8*
  call void @free(i8* %24) #2
  ret i32 0
}

; Function Attrs: nounwind
declare dso_local noalias i8* @malloc(i64) #1

; Function Attrs: nounwind
declare dso_local void @free(i8*) #1

attributes #0 = { noinline nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind }

!llvm.module.flags = !{!0}
!llvm.ident = !{!1}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{!"clang version 10.0.1 "}
