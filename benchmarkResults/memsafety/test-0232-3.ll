; ModuleID = '/home/curt/HeapDataFlow/benchmarkResults/memsafety/test-0232-3.bc'
source_filename = "/home/curt/HeapDataFlow/sv-benchmarks/c/memsafety/test-0232-3.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.item = type { %struct.item*, %struct.item* }

@.str = private unnamed_addr constant [2 x i8] c"0\00", align 1
@.str.1 = private unnamed_addr constant [64 x i8] c"/home/curt/HeapDataFlow/sv-benchmarks/c/memsafety/test-0232-3.c\00", align 1
@__PRETTY_FUNCTION__.reach_error = private unnamed_addr constant [19 x i8] c"void reach_error()\00", align 1

; Function Attrs: noinline nounwind uwtable
define dso_local void @reach_error() #0 {
  call void @__assert_fail(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str, i64 0, i64 0), i8* getelementptr inbounds ([64 x i8], [64 x i8]* @.str.1, i64 0, i64 0), i32 3, i8* getelementptr inbounds ([19 x i8], [19 x i8]* @__PRETTY_FUNCTION__.reach_error, i64 0, i64 0)) #4
  unreachable
}

; Function Attrs: noreturn nounwind
declare dso_local void @__assert_fail(i8*, i8*, i32, i8*) #1

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @main() #0 {
  %1 = alloca i32, align 4
  %2 = alloca %struct.item*, align 8
  %3 = alloca %struct.item*, align 8
  %4 = alloca %struct.item*, align 8
  store i32 0, i32* %1, align 4
  store %struct.item* null, %struct.item** %2, align 8
  br label %5

5:                                                ; preds = %6, %0
  call void @append(%struct.item** %2)
  br label %6

6:                                                ; preds = %5
  %7 = call i32 @__VERIFIER_nondet_int()
  %8 = icmp ne i32 %7, 0
  br i1 %8, label %5, label %9

9:                                                ; preds = %6
  %10 = load %struct.item*, %struct.item** %2, align 8
  %11 = icmp ne %struct.item* %10, null
  br i1 %11, label %12, label %23

12:                                               ; preds = %9
  %13 = load %struct.item*, %struct.item** %2, align 8
  %14 = getelementptr inbounds %struct.item, %struct.item* %13, i32 0, i32 0
  %15 = load %struct.item*, %struct.item** %14, align 8
  store %struct.item* %15, %struct.item** %3, align 8
  %16 = load %struct.item*, %struct.item** %2, align 8
  %17 = getelementptr inbounds %struct.item, %struct.item* %16, i32 0, i32 1
  %18 = load %struct.item*, %struct.item** %17, align 8
  %19 = bitcast %struct.item* %18 to i8*
  call void @free(i8* %19) #5
  %20 = load %struct.item*, %struct.item** %2, align 8
  %21 = bitcast %struct.item* %20 to i8*
  call void @free(i8* %21) #5
  %22 = load %struct.item*, %struct.item** %3, align 8
  store %struct.item* %22, %struct.item** %2, align 8
  br label %23

23:                                               ; preds = %12, %9
  br label %24

24:                                               ; preds = %38, %23
  %25 = load %struct.item*, %struct.item** %2, align 8
  %26 = icmp ne %struct.item* %25, null
  br i1 %26, label %27, label %42

27:                                               ; preds = %24
  %28 = load %struct.item*, %struct.item** %2, align 8
  %29 = getelementptr inbounds %struct.item, %struct.item* %28, i32 0, i32 0
  %30 = load %struct.item*, %struct.item** %29, align 8
  store %struct.item* %30, %struct.item** %4, align 8
  %31 = load %struct.item*, %struct.item** %4, align 8
  %32 = icmp ne %struct.item* %31, null
  br i1 %32, label %38, label %33

33:                                               ; preds = %27
  %34 = load %struct.item*, %struct.item** %2, align 8
  %35 = getelementptr inbounds %struct.item, %struct.item* %34, i32 0, i32 1
  %36 = load %struct.item*, %struct.item** %35, align 8
  %37 = bitcast %struct.item* %36 to i8*
  call void @free(i8* %37) #5
  br label %38

38:                                               ; preds = %33, %27
  %39 = load %struct.item*, %struct.item** %2, align 8
  %40 = bitcast %struct.item* %39 to i8*
  call void @free(i8* %40) #5
  %41 = load %struct.item*, %struct.item** %4, align 8
  store %struct.item* %41, %struct.item** %2, align 8
  br label %24

42:                                               ; preds = %24
  ret i32 0
}

; Function Attrs: noinline nounwind uwtable
define internal void @append(%struct.item** %0) #0 {
  %2 = alloca %struct.item**, align 8
  %3 = alloca %struct.item*, align 8
  store %struct.item** %0, %struct.item*** %2, align 8
  %4 = call noalias i8* @malloc(i64 16) #5
  %5 = bitcast i8* %4 to %struct.item*
  store %struct.item* %5, %struct.item** %3, align 8
  %6 = load %struct.item**, %struct.item*** %2, align 8
  %7 = load %struct.item*, %struct.item** %6, align 8
  %8 = load %struct.item*, %struct.item** %3, align 8
  %9 = getelementptr inbounds %struct.item, %struct.item* %8, i32 0, i32 0
  store %struct.item* %7, %struct.item** %9, align 8
  %10 = load %struct.item*, %struct.item** %3, align 8
  %11 = getelementptr inbounds %struct.item, %struct.item* %10, i32 0, i32 0
  %12 = load %struct.item*, %struct.item** %11, align 8
  %13 = icmp ne %struct.item* %12, null
  br i1 %13, label %14, label %21

14:                                               ; preds = %1
  %15 = load %struct.item*, %struct.item** %3, align 8
  %16 = getelementptr inbounds %struct.item, %struct.item* %15, i32 0, i32 0
  %17 = load %struct.item*, %struct.item** %16, align 8
  %18 = getelementptr inbounds %struct.item, %struct.item* %17, i32 0, i32 1
  %19 = load %struct.item*, %struct.item** %18, align 8
  %20 = bitcast %struct.item* %19 to i8*
  br label %23

21:                                               ; preds = %1
  %22 = call noalias i8* @malloc(i64 16) #5
  br label %23

23:                                               ; preds = %21, %14
  %24 = phi i8* [ %20, %14 ], [ %22, %21 ]
  %25 = bitcast i8* %24 to %struct.item*
  %26 = load %struct.item*, %struct.item** %3, align 8
  %27 = getelementptr inbounds %struct.item, %struct.item* %26, i32 0, i32 1
  store %struct.item* %25, %struct.item** %27, align 8
  %28 = load %struct.item*, %struct.item** %3, align 8
  %29 = load %struct.item**, %struct.item*** %2, align 8
  store %struct.item* %28, %struct.item** %29, align 8
  ret void
}

declare dso_local i32 @__VERIFIER_nondet_int() #2

; Function Attrs: nounwind
declare dso_local void @free(i8*) #3

; Function Attrs: nounwind
declare dso_local noalias i8* @malloc(i64) #3

attributes #0 = { noinline nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { noreturn nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #4 = { noreturn nounwind }
attributes #5 = { nounwind }

!llvm.module.flags = !{!0}
!llvm.ident = !{!1}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{!"clang version 10.0.1 "}
