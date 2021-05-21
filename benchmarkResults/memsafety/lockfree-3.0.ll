; ModuleID = '/home/curt/HeapDataFlow/benchmarkResults/memsafety/lockfree-3.0.bc'
source_filename = "/home/curt/HeapDataFlow/sv-benchmarks/c/memsafety/lockfree-3.0.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.cell = type { i32, %struct.cell* }

@.str = private unnamed_addr constant [2 x i8] c"0\00", align 1
@.str.1 = private unnamed_addr constant [65 x i8] c"/home/curt/HeapDataFlow/sv-benchmarks/c/memsafety/lockfree-3.0.c\00", align 1
@__PRETTY_FUNCTION__.reach_error = private unnamed_addr constant [19 x i8] c"void reach_error()\00", align 1
@pc1 = dso_local global i32 1, align 4
@pc4 = dso_local global i32 1, align 4
@push.t1 = internal global %struct.cell* null, align 8
@push.x1 = internal global %struct.cell* null, align 8
@S = common dso_local global %struct.cell* null, align 8
@pop.t4 = internal global %struct.cell* null, align 8
@pop.x4 = internal global %struct.cell* null, align 8
@pop.res4 = internal global i32 0, align 4
@garbage = common dso_local global %struct.cell* null, align 8

; Function Attrs: noinline nounwind uwtable
define dso_local void @reach_error() #0 {
  call void @__assert_fail(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str, i64 0, i64 0), i8* getelementptr inbounds ([65 x i8], [65 x i8]* @.str.1, i64 0, i64 0), i32 3, i8* getelementptr inbounds ([19 x i8], [19 x i8]* @__PRETTY_FUNCTION__.reach_error, i64 0, i64 0)) #4
  unreachable
}

; Function Attrs: noreturn nounwind
declare dso_local void @__assert_fail(i8*, i8*, i32, i8*) #1

; Function Attrs: noinline nounwind uwtable
define dso_local void @push() #0 {
  %1 = load i32, i32* @pc1, align 4
  %2 = add nsw i32 %1, 1
  store i32 %2, i32* @pc1, align 4
  switch i32 %1, label %28 [
    i32 1, label %3
    i32 2, label %10
    i32 3, label %13
    i32 4, label %15
    i32 5, label %19
    i32 6, label %27
  ]

3:                                                ; preds = %0
  %4 = call noalias i8* @malloc(i64 16) #5
  %5 = bitcast i8* %4 to %struct.cell*
  store %struct.cell* %5, %struct.cell** @push.x1, align 8
  %6 = load %struct.cell*, %struct.cell** @push.x1, align 8
  %7 = getelementptr inbounds %struct.cell, %struct.cell* %6, i32 0, i32 0
  store i32 0, i32* %7, align 8
  %8 = load %struct.cell*, %struct.cell** @push.x1, align 8
  %9 = getelementptr inbounds %struct.cell, %struct.cell* %8, i32 0, i32 1
  store %struct.cell* null, %struct.cell** %9, align 8
  br label %28

10:                                               ; preds = %0
  %11 = load %struct.cell*, %struct.cell** @push.x1, align 8
  %12 = getelementptr inbounds %struct.cell, %struct.cell* %11, i32 0, i32 0
  store i32 4, i32* %12, align 8
  br label %28

13:                                               ; preds = %0
  %14 = load %struct.cell*, %struct.cell** @S, align 8
  store %struct.cell* %14, %struct.cell** @push.t1, align 8
  br label %28

15:                                               ; preds = %0
  %16 = load %struct.cell*, %struct.cell** @push.t1, align 8
  %17 = load %struct.cell*, %struct.cell** @push.x1, align 8
  %18 = getelementptr inbounds %struct.cell, %struct.cell* %17, i32 0, i32 1
  store %struct.cell* %16, %struct.cell** %18, align 8
  br label %28

19:                                               ; preds = %0
  %20 = load %struct.cell*, %struct.cell** @S, align 8
  %21 = load %struct.cell*, %struct.cell** @push.t1, align 8
  %22 = icmp eq %struct.cell* %20, %21
  br i1 %22, label %23, label %25

23:                                               ; preds = %19
  %24 = load %struct.cell*, %struct.cell** @push.x1, align 8
  store %struct.cell* %24, %struct.cell** @S, align 8
  br label %26

25:                                               ; preds = %19
  store i32 3, i32* @pc1, align 4
  br label %26

26:                                               ; preds = %25, %23
  br label %28

27:                                               ; preds = %0
  store i32 1, i32* @pc1, align 4
  br label %28

28:                                               ; preds = %3, %10, %13, %15, %26, %27, %0
  ret void
}

; Function Attrs: nounwind
declare dso_local noalias i8* @malloc(i64) #2

; Function Attrs: noinline nounwind uwtable
define dso_local void @pop() #0 {
  %1 = load i32, i32* @pc4, align 4
  %2 = add nsw i32 %1, 1
  store i32 %2, i32* @pc4, align 4
  switch i32 %1, label %30 [
    i32 1, label %3
    i32 2, label %5
    i32 3, label %10
    i32 4, label %14
    i32 5, label %22
  ]

3:                                                ; preds = %0
  %4 = load %struct.cell*, %struct.cell** @S, align 8
  store %struct.cell* %4, %struct.cell** @pop.t4, align 8
  br label %30

5:                                                ; preds = %0
  %6 = load %struct.cell*, %struct.cell** @pop.t4, align 8
  %7 = icmp eq %struct.cell* %6, null
  br i1 %7, label %8, label %9

8:                                                ; preds = %5
  store i32 1, i32* @pc4, align 4
  br label %9

9:                                                ; preds = %8, %5
  br label %30

10:                                               ; preds = %0
  %11 = load %struct.cell*, %struct.cell** @pop.t4, align 8
  %12 = getelementptr inbounds %struct.cell, %struct.cell* %11, i32 0, i32 1
  %13 = load %struct.cell*, %struct.cell** %12, align 8
  store %struct.cell* %13, %struct.cell** @pop.x4, align 8
  br label %30

14:                                               ; preds = %0
  %15 = load %struct.cell*, %struct.cell** @S, align 8
  %16 = load %struct.cell*, %struct.cell** @pop.t4, align 8
  %17 = icmp eq %struct.cell* %15, %16
  br i1 %17, label %18, label %20

18:                                               ; preds = %14
  %19 = load %struct.cell*, %struct.cell** @pop.x4, align 8
  store %struct.cell* %19, %struct.cell** @S, align 8
  br label %21

20:                                               ; preds = %14
  store i32 1, i32* @pc4, align 4
  br label %21

21:                                               ; preds = %20, %18
  br label %30

22:                                               ; preds = %0
  %23 = load %struct.cell*, %struct.cell** @pop.t4, align 8
  %24 = getelementptr inbounds %struct.cell, %struct.cell* %23, i32 0, i32 0
  %25 = load i32, i32* %24, align 8
  store i32 %25, i32* @pop.res4, align 4
  %26 = load %struct.cell*, %struct.cell** @garbage, align 8
  %27 = load %struct.cell*, %struct.cell** @pop.t4, align 8
  %28 = getelementptr inbounds %struct.cell, %struct.cell* %27, i32 0, i32 1
  store %struct.cell* %26, %struct.cell** %28, align 8
  %29 = load %struct.cell*, %struct.cell** @pop.t4, align 8
  store %struct.cell* %29, %struct.cell** @garbage, align 8
  store i32 1, i32* @pc4, align 4
  br label %30

30:                                               ; preds = %3, %9, %10, %21, %22, %0
  ret void
}

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @main() #0 {
  %1 = alloca i32, align 4
  %2 = alloca %struct.cell*, align 8
  store i32 0, i32* %1, align 4
  br label %3

3:                                                ; preds = %22, %0
  %4 = load %struct.cell*, %struct.cell** @S, align 8
  %5 = icmp ne %struct.cell* %4, null
  br i1 %5, label %15, label %6

6:                                                ; preds = %3
  %7 = load i32, i32* @pc1, align 4
  %8 = icmp ne i32 1, %7
  br i1 %8, label %15, label %9

9:                                                ; preds = %6
  %10 = load i32, i32* @pc4, align 4
  %11 = icmp ne i32 1, %10
  br i1 %11, label %15, label %12

12:                                               ; preds = %9
  %13 = call i32 @__VERIFIER_nondet_int()
  %14 = icmp ne i32 %13, 0
  br label %15

15:                                               ; preds = %12, %9, %6, %3
  %16 = phi i1 [ true, %9 ], [ true, %6 ], [ true, %3 ], [ %14, %12 ]
  br i1 %16, label %17, label %23

17:                                               ; preds = %15
  %18 = call i32 @__VERIFIER_nondet_int()
  %19 = icmp ne i32 %18, 0
  br i1 %19, label %20, label %21

20:                                               ; preds = %17
  call void @push()
  br label %22

21:                                               ; preds = %17
  call void @pop()
  br label %22

22:                                               ; preds = %21, %20
  br label %3

23:                                               ; preds = %15
  br label %24

24:                                               ; preds = %27, %23
  %25 = load %struct.cell*, %struct.cell** @garbage, align 8
  %26 = icmp ne %struct.cell* %25, null
  br i1 %26, label %27, label %34

27:                                               ; preds = %24
  %28 = load %struct.cell*, %struct.cell** @garbage, align 8
  %29 = getelementptr inbounds %struct.cell, %struct.cell* %28, i32 0, i32 1
  %30 = load %struct.cell*, %struct.cell** %29, align 8
  store %struct.cell* %30, %struct.cell** %2, align 8
  %31 = load %struct.cell*, %struct.cell** @garbage, align 8
  %32 = bitcast %struct.cell* %31 to i8*
  call void @free(i8* %32) #5
  %33 = load %struct.cell*, %struct.cell** %2, align 8
  store %struct.cell* %33, %struct.cell** @garbage, align 8
  br label %24

34:                                               ; preds = %24
  %35 = load %struct.cell*, %struct.cell** @garbage, align 8
  %36 = icmp ne %struct.cell* %35, null
  %37 = xor i1 %36, true
  %38 = xor i1 %37, true
  %39 = zext i1 %38 to i32
  ret i32 %39
}

declare dso_local i32 @__VERIFIER_nondet_int() #3

; Function Attrs: nounwind
declare dso_local void @free(i8*) #2

attributes #0 = { noinline nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { noreturn nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #4 = { noreturn nounwind }
attributes #5 = { nounwind }

!llvm.module.flags = !{!0}
!llvm.ident = !{!1}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{!"clang version 10.0.1 "}
