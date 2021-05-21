; ModuleID = '/home/curt/HeapDataFlow/benchmarkResults/memsafety/test-0019-2.bc'
source_filename = "/home/curt/HeapDataFlow/sv-benchmarks/c/memsafety/test-0019-2.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.TData = type { i8*, i8* }

@.str = private unnamed_addr constant [2 x i8] c"0\00", align 1
@.str.1 = private unnamed_addr constant [64 x i8] c"/home/curt/HeapDataFlow/sv-benchmarks/c/memsafety/test-0019-2.c\00", align 1
@__PRETTY_FUNCTION__.reach_error = private unnamed_addr constant [19 x i8] c"void reach_error()\00", align 1

; Function Attrs: noinline nounwind uwtable
define dso_local void @reach_error() #0 {
  call void @__assert_fail(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str, i64 0, i64 0), i8* getelementptr inbounds ([64 x i8], [64 x i8]* @.str.1, i64 0, i64 0), i32 3, i8* getelementptr inbounds ([19 x i8], [19 x i8]* @__PRETTY_FUNCTION__.reach_error, i64 0, i64 0)) #3
  unreachable
}

; Function Attrs: noreturn nounwind
declare dso_local void @__assert_fail(i8*, i8*, i32, i8*) #1

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @main() #0 {
  %1 = alloca i32, align 4
  %2 = alloca %struct.TData, align 8
  store i32 0, i32* %1, align 4
  call void @alloc_data(%struct.TData* %2)
  call void @free_data(%struct.TData* %2)
  ret i32 0
}

; Function Attrs: noinline nounwind uwtable
define internal void @alloc_data(%struct.TData* %0) #0 {
  %2 = alloca %struct.TData*, align 8
  store %struct.TData* %0, %struct.TData** %2, align 8
  %3 = call noalias i8* @malloc(i64 16) #4
  %4 = load %struct.TData*, %struct.TData** %2, align 8
  %5 = getelementptr inbounds %struct.TData, %struct.TData* %4, i32 0, i32 0
  store i8* %3, i8** %5, align 8
  %6 = call noalias i8* @malloc(i64 24) #4
  %7 = load %struct.TData*, %struct.TData** %2, align 8
  %8 = getelementptr inbounds %struct.TData, %struct.TData* %7, i32 0, i32 1
  store i8* %6, i8** %8, align 8
  ret void
}

; Function Attrs: noinline nounwind uwtable
define internal void @free_data(%struct.TData* %0) #0 {
  %2 = alloca %struct.TData*, align 8
  %3 = alloca i8*, align 8
  %4 = alloca i8*, align 8
  store %struct.TData* %0, %struct.TData** %2, align 8
  %5 = load %struct.TData*, %struct.TData** %2, align 8
  %6 = getelementptr inbounds %struct.TData, %struct.TData* %5, i32 0, i32 0
  %7 = load i8*, i8** %6, align 8
  store i8* %7, i8** %3, align 8
  %8 = load %struct.TData*, %struct.TData** %2, align 8
  %9 = getelementptr inbounds %struct.TData, %struct.TData* %8, i32 0, i32 1
  %10 = load i8*, i8** %9, align 8
  store i8* %10, i8** %4, align 8
  %11 = load i8*, i8** %3, align 8
  %12 = load i8*, i8** %4, align 8
  %13 = icmp eq i8* %11, %12
  br i1 %13, label %14, label %17

14:                                               ; preds = %1
  %15 = load i8*, i8** %3, align 8
  call void @free(i8* %15) #4
  %16 = load i8*, i8** %4, align 8
  call void @free(i8* %16) #4
  br label %17

17:                                               ; preds = %14, %1
  %18 = load %struct.TData*, %struct.TData** %2, align 8
  %19 = getelementptr inbounds %struct.TData, %struct.TData* %18, i32 0, i32 0
  store i8* null, i8** %19, align 8
  %20 = load %struct.TData*, %struct.TData** %2, align 8
  %21 = getelementptr inbounds %struct.TData, %struct.TData* %20, i32 0, i32 1
  store i8* null, i8** %21, align 8
  ret void
}

; Function Attrs: nounwind
declare dso_local noalias i8* @malloc(i64) #2

; Function Attrs: nounwind
declare dso_local void @free(i8*) #2

attributes #0 = { noinline nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { noreturn nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { noreturn nounwind }
attributes #4 = { nounwind }

!llvm.module.flags = !{!0}
!llvm.ident = !{!1}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{!"clang version 10.0.1 "}
