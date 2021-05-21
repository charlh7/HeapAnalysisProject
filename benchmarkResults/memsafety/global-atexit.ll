; ModuleID = '/home/curt/HeapDataFlow/benchmarkResults/memsafety/global-atexit.bc'
source_filename = "/home/curt/HeapDataFlow/sv-benchmarks/c/memsafety/global-atexit.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@g = dso_local global i32** null, align 8

; Function Attrs: noinline nounwind uwtable
define dso_local void @free_g1() #0 {
  %1 = load i32**, i32*** @g, align 8
  %2 = bitcast i32** %1 to i8*
  call void @free(i8* %2) #4
  store i32** null, i32*** @g, align 8
  ret void
}

; Function Attrs: nounwind
declare dso_local void @free(i8*) #1

; Function Attrs: noinline nounwind uwtable
define dso_local void @free_g2() #0 {
  %1 = load i32**, i32*** @g, align 8
  %2 = icmp ne i32** %1, null
  br i1 %2, label %3, label %7

3:                                                ; preds = %0
  %4 = load i32**, i32*** @g, align 8
  %5 = load i32*, i32** %4, align 8
  %6 = bitcast i32* %5 to i8*
  call void @free(i8* %6) #4
  br label %7

7:                                                ; preds = %3, %0
  ret void
}

; Function Attrs: noinline nounwind uwtable
define dso_local void @h() #0 {
  %1 = call zeroext i1 (...) @__VERIFIER_nondet_bool()
  br i1 %1, label %2, label %3

2:                                                ; preds = %0
  call void @exit(i32 1) #5
  unreachable

3:                                                ; preds = %0
  ret void
}

declare dso_local zeroext i1 @__VERIFIER_nondet_bool(...) #2

; Function Attrs: noreturn nounwind
declare dso_local void @exit(i32) #3

; Function Attrs: noinline nounwind uwtable
define dso_local void @f() #0 {
  %1 = call noalias i8* @malloc(i64 4) #4
  %2 = bitcast i8* %1 to i32*
  %3 = load i32**, i32*** @g, align 8
  store i32* %2, i32** %3, align 8
  %4 = call i32 @atexit(void ()* @free_g2) #4
  call void @h()
  ret void
}

; Function Attrs: nounwind
declare dso_local noalias i8* @malloc(i64) #1

; Function Attrs: nounwind
declare dso_local i32 @atexit(void ()*) #1

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @main() #0 {
  %1 = alloca i32, align 4
  store i32 0, i32* %1, align 4
  %2 = call noalias i8* @malloc(i64 8) #4
  %3 = bitcast i8* %2 to i32**
  store i32** %3, i32*** @g, align 8
  %4 = call i32 @atexit(void ()* @free_g1) #4
  %5 = call zeroext i1 (...) @__VERIFIER_nondet_bool()
  br i1 %5, label %6, label %7

6:                                                ; preds = %0
  call void @exit(i32 1) #5
  unreachable

7:                                                ; preds = %0
  call void @f()
  ret i32 0
}

attributes #0 = { noinline nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { noreturn nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #4 = { nounwind }
attributes #5 = { noreturn nounwind }

!llvm.module.flags = !{!0}
!llvm.ident = !{!1}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{!"clang version 10.0.1 "}
