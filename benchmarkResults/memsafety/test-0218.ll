; ModuleID = '/home/curt/HeapDataFlow/benchmarkResults/memsafety/test-0218.bc'
source_filename = "/home/curt/HeapDataFlow/sv-benchmarks/c/memsafety/test-0218.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@.str = private unnamed_addr constant [2 x i8] c"0\00", align 1
@.str.1 = private unnamed_addr constant [62 x i8] c"/home/curt/HeapDataFlow/sv-benchmarks/c/memsafety/test-0218.c\00", align 1
@__PRETTY_FUNCTION__.reach_error = private unnamed_addr constant [19 x i8] c"void reach_error()\00", align 1
@main.list = internal global [2 x i8*] zeroinitializer, align 16

; Function Attrs: noinline nounwind uwtable
define dso_local void @reach_error() #0 {
  call void @__assert_fail(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str, i64 0, i64 0), i8* getelementptr inbounds ([62 x i8], [62 x i8]* @.str.1, i64 0, i64 0), i32 3, i8* getelementptr inbounds ([19 x i8], [19 x i8]* @__PRETTY_FUNCTION__.reach_error, i64 0, i64 0)) #5
  unreachable
}

; Function Attrs: noreturn nounwind
declare dso_local void @__assert_fail(i8*, i8*, i32, i8*) #1

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @is_empty([2 x i8*]* %0) #0 {
  %2 = alloca [2 x i8*]*, align 8
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  store [2 x i8*]* %0, [2 x i8*]** %2, align 8
  %5 = load [2 x i8*]*, [2 x i8*]** %2, align 8
  %6 = getelementptr inbounds [2 x i8*], [2 x i8*]* %5, i64 0, i64 0
  %7 = load i8*, i8** %6, align 8
  %8 = icmp ne i8* %7, null
  %9 = xor i1 %8, true
  %10 = zext i1 %9 to i32
  store i32 %10, i32* %3, align 4
  %11 = load [2 x i8*]*, [2 x i8*]** %2, align 8
  %12 = getelementptr inbounds [2 x i8*], [2 x i8*]* %11, i64 0, i64 1
  %13 = load i8*, i8** %12, align 8
  %14 = icmp ne i8* %13, null
  %15 = xor i1 %14, true
  %16 = zext i1 %15 to i32
  store i32 %16, i32* %4, align 4
  %17 = load i32, i32* %3, align 4
  %18 = load i32, i32* %4, align 4
  %19 = icmp ne i32 %17, %18
  br i1 %19, label %20, label %23

20:                                               ; preds = %1
  %21 = load [2 x i8*]*, [2 x i8*]** %2, align 8
  %22 = bitcast [2 x i8*]* %21 to i8*
  call void @free(i8* %22) #6
  br label %23

23:                                               ; preds = %20, %1
  %24 = load i32, i32* %3, align 4
  ret i32 %24
}

; Function Attrs: nounwind
declare dso_local void @free(i8*) #2

; Function Attrs: noinline nounwind uwtable
define dso_local [2 x i8*]* @create_item(i32 %0, [2 x i8*]** %1) #0 {
  %3 = alloca i32, align 4
  %4 = alloca [2 x i8*]**, align 8
  %5 = alloca [2 x i8*]*, align 8
  %6 = alloca i32, align 4
  %7 = alloca i32, align 4
  %8 = alloca [2 x i8*]*, align 8
  store i32 %0, i32* %3, align 4
  store [2 x i8*]** %1, [2 x i8*]*** %4, align 8
  %9 = call noalias i8* @malloc(i64 16) #6
  %10 = bitcast i8* %9 to [2 x i8*]*
  store [2 x i8*]* %10, [2 x i8*]** %5, align 8
  %11 = load [2 x i8*]*, [2 x i8*]** %5, align 8
  %12 = icmp ne [2 x i8*]* %11, null
  br i1 %12, label %14, label %13

13:                                               ; preds = %2
  call void @abort() #5
  unreachable

14:                                               ; preds = %2
  %15 = load i32, i32* %3, align 4
  switch i32 %15, label %18 [
    i32 0, label %16
    i32 1, label %17
  ]

16:                                               ; preds = %14
  store i32 1, i32* %7, align 4
  store i32 0, i32* %6, align 4
  br label %18

17:                                               ; preds = %14
  store i32 0, i32* %7, align 4
  store i32 1, i32* %6, align 4
  br label %18

18:                                               ; preds = %14, %17, %16
  br label %19

19:                                               ; preds = %36, %18
  %20 = load [2 x i8*]**, [2 x i8*]*** %4, align 8
  %21 = load [2 x i8*]*, [2 x i8*]** %20, align 8
  %22 = icmp ne [2 x i8*]* %21, null
  br i1 %22, label %23, label %34

23:                                               ; preds = %19
  %24 = load [2 x i8*]**, [2 x i8*]*** %4, align 8
  %25 = load [2 x i8*]*, [2 x i8*]** %24, align 8
  %26 = load i32, i32* %7, align 4
  %27 = zext i32 %26 to i64
  %28 = getelementptr inbounds [2 x i8*], [2 x i8*]* %25, i64 0, i64 %27
  %29 = load i8*, i8** %28, align 8
  %30 = icmp ne i8* %29, null
  br i1 %30, label %31, label %34

31:                                               ; preds = %23
  %32 = call i32 @__VERIFIER_nondet_int()
  %33 = icmp ne i32 %32, 0
  br label %34

34:                                               ; preds = %31, %23, %19
  %35 = phi i1 [ false, %23 ], [ false, %19 ], [ %33, %31 ]
  br i1 %35, label %36, label %43

36:                                               ; preds = %34
  %37 = load [2 x i8*]**, [2 x i8*]*** %4, align 8
  %38 = load [2 x i8*]*, [2 x i8*]** %37, align 8
  %39 = load i32, i32* %7, align 4
  %40 = zext i32 %39 to i64
  %41 = getelementptr inbounds [2 x i8*], [2 x i8*]* %38, i64 0, i64 %40
  %42 = bitcast i8** %41 to [2 x i8*]**
  store [2 x i8*]** %42, [2 x i8*]*** %4, align 8
  br label %19

43:                                               ; preds = %34
  %44 = load [2 x i8*]**, [2 x i8*]*** %4, align 8
  %45 = load [2 x i8*]*, [2 x i8*]** %44, align 8
  store [2 x i8*]* %45, [2 x i8*]** %8, align 8
  %46 = load [2 x i8*]*, [2 x i8*]** %8, align 8
  %47 = bitcast [2 x i8*]* %46 to i8*
  %48 = load [2 x i8*]*, [2 x i8*]** %5, align 8
  %49 = load i32, i32* %7, align 4
  %50 = zext i32 %49 to i64
  %51 = getelementptr inbounds [2 x i8*], [2 x i8*]* %48, i64 0, i64 %50
  store i8* %47, i8** %51, align 8
  %52 = load [2 x i8*]*, [2 x i8*]** %8, align 8
  %53 = icmp ne [2 x i8*]* %52, null
  br i1 %53, label %54, label %60

54:                                               ; preds = %43
  %55 = load [2 x i8*]*, [2 x i8*]** %8, align 8
  %56 = load i32, i32* %6, align 4
  %57 = zext i32 %56 to i64
  %58 = getelementptr inbounds [2 x i8*], [2 x i8*]* %55, i64 0, i64 %57
  %59 = load i8*, i8** %58, align 8
  br label %61

60:                                               ; preds = %43
  br label %61

61:                                               ; preds = %60, %54
  %62 = phi i8* [ %59, %54 ], [ null, %60 ]
  %63 = load [2 x i8*]*, [2 x i8*]** %5, align 8
  %64 = load i32, i32* %6, align 4
  %65 = zext i32 %64 to i64
  %66 = getelementptr inbounds [2 x i8*], [2 x i8*]* %63, i64 0, i64 %65
  store i8* %62, i8** %66, align 8
  %67 = load [2 x i8*]*, [2 x i8*]** %8, align 8
  %68 = icmp ne [2 x i8*]* %67, null
  br i1 %68, label %69, label %76

69:                                               ; preds = %61
  %70 = load [2 x i8*]*, [2 x i8*]** %5, align 8
  %71 = bitcast [2 x i8*]* %70 to i8*
  %72 = load [2 x i8*]*, [2 x i8*]** %8, align 8
  %73 = load i32, i32* %6, align 4
  %74 = zext i32 %73 to i64
  %75 = getelementptr inbounds [2 x i8*], [2 x i8*]* %72, i64 0, i64 %74
  store i8* %71, i8** %75, align 8
  br label %76

76:                                               ; preds = %69, %61
  %77 = load [2 x i8*]*, [2 x i8*]** %5, align 8
  %78 = load [2 x i8*]**, [2 x i8*]*** %4, align 8
  store [2 x i8*]* %77, [2 x i8*]** %78, align 8
  %79 = load [2 x i8*]*, [2 x i8*]** %5, align 8
  ret [2 x i8*]* %79
}

; Function Attrs: nounwind
declare dso_local noalias i8* @malloc(i64) #2

; Function Attrs: noreturn nounwind
declare dso_local void @abort() #1

declare dso_local i32 @__VERIFIER_nondet_int() #3

; Function Attrs: noinline nounwind uwtable
define dso_local void @append_one([2 x i8*]* %0, i32 %1) #0 {
  %3 = alloca [2 x i8*]*, align 8
  %4 = alloca i32, align 4
  %5 = alloca [2 x i8*]**, align 8
  %6 = alloca [2 x i8*]*, align 8
  store [2 x i8*]* %0, [2 x i8*]** %3, align 8
  store i32 %1, i32* %4, align 4
  %7 = load [2 x i8*]*, [2 x i8*]** %3, align 8
  %8 = load i32, i32* %4, align 4
  %9 = zext i32 %8 to i64
  %10 = getelementptr inbounds [2 x i8*], [2 x i8*]* %7, i64 0, i64 %9
  %11 = bitcast i8** %10 to [2 x i8*]**
  store [2 x i8*]** %11, [2 x i8*]*** %5, align 8
  %12 = load i32, i32* %4, align 4
  %13 = load [2 x i8*]**, [2 x i8*]*** %5, align 8
  %14 = call [2 x i8*]* @create_item(i32 %12, [2 x i8*]** %13)
  store [2 x i8*]* %14, [2 x i8*]** %6, align 8
  %15 = load [2 x i8*]*, [2 x i8*]** %6, align 8
  %16 = getelementptr inbounds [2 x i8*], [2 x i8*]* %15, i64 0, i64 0
  %17 = load i8*, i8** %16, align 8
  %18 = icmp eq i8* null, %17
  br i1 %18, label %19, label %24

19:                                               ; preds = %2
  %20 = load [2 x i8*]*, [2 x i8*]** %6, align 8
  %21 = bitcast [2 x i8*]* %20 to i8*
  %22 = load [2 x i8*]*, [2 x i8*]** %3, align 8
  %23 = getelementptr inbounds [2 x i8*], [2 x i8*]* %22, i64 0, i64 0
  store i8* %21, i8** %23, align 8
  br label %24

24:                                               ; preds = %19, %2
  %25 = load [2 x i8*]*, [2 x i8*]** %3, align 8
  %26 = getelementptr inbounds [2 x i8*], [2 x i8*]* %25, i64 0, i64 1
  %27 = load i8*, i8** %26, align 8
  %28 = icmp eq i8* null, %27
  br i1 %28, label %29, label %34

29:                                               ; preds = %24
  %30 = load [2 x i8*]*, [2 x i8*]** %6, align 8
  %31 = bitcast [2 x i8*]* %30 to i8*
  %32 = load [2 x i8*]*, [2 x i8*]** %3, align 8
  %33 = getelementptr inbounds [2 x i8*], [2 x i8*]* %32, i64 0, i64 1
  store i8* %31, i8** %33, align 8
  br label %34

34:                                               ; preds = %29, %24
  ret void
}

; Function Attrs: noinline nounwind uwtable
define dso_local void @remove_one([2 x i8*]* %0, i32 %1) #0 {
  %3 = alloca [2 x i8*]*, align 8
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  %7 = alloca [2 x i8*]*, align 8
  %8 = alloca [2 x i8*]*, align 8
  store [2 x i8*]* %0, [2 x i8*]** %3, align 8
  store i32 %1, i32* %4, align 4
  %9 = load [2 x i8*]*, [2 x i8*]** %3, align 8
  %10 = call i32 @is_empty([2 x i8*]* %9)
  %11 = icmp ne i32 %10, 0
  br i1 %11, label %12, label %13

12:                                               ; preds = %2
  br label %61

13:                                               ; preds = %2
  %14 = load [2 x i8*]*, [2 x i8*]** %3, align 8
  %15 = getelementptr inbounds [2 x i8*], [2 x i8*]* %14, i64 0, i64 0
  %16 = load i8*, i8** %15, align 8
  %17 = load [2 x i8*]*, [2 x i8*]** %3, align 8
  %18 = getelementptr inbounds [2 x i8*], [2 x i8*]* %17, i64 0, i64 1
  %19 = load i8*, i8** %18, align 8
  %20 = icmp eq i8* %16, %19
  br i1 %20, label %21, label %28

21:                                               ; preds = %13
  %22 = load [2 x i8*]*, [2 x i8*]** %3, align 8
  %23 = getelementptr inbounds [2 x i8*], [2 x i8*]* %22, i64 0, i64 0
  %24 = load i8*, i8** %23, align 8
  call void @free(i8* %24) #6
  %25 = load [2 x i8*]*, [2 x i8*]** %3, align 8
  %26 = getelementptr inbounds [2 x i8*], [2 x i8*]* %25, i64 0, i64 0
  %27 = bitcast i8** %26 to i8*
  call void @llvm.memset.p0i8.i64(i8* align 8 %27, i8 0, i64 16, i1 false)
  br label %61

28:                                               ; preds = %13
  %29 = load i32, i32* %4, align 4
  %30 = icmp eq i32 0, %29
  %31 = zext i1 %30 to i64
  %32 = select i1 %30, i32 1, i32 0
  store i32 %32, i32* %5, align 4
  %33 = load i32, i32* %4, align 4
  %34 = icmp eq i32 1, %33
  %35 = zext i1 %34 to i64
  %36 = select i1 %34, i32 1, i32 0
  store i32 %36, i32* %6, align 4
  %37 = load [2 x i8*]*, [2 x i8*]** %3, align 8
  %38 = load i32, i32* %4, align 4
  %39 = zext i32 %38 to i64
  %40 = getelementptr inbounds [2 x i8*], [2 x i8*]* %37, i64 0, i64 %39
  %41 = load i8*, i8** %40, align 8
  %42 = bitcast i8* %41 to [2 x i8*]*
  store [2 x i8*]* %42, [2 x i8*]** %7, align 8
  %43 = load [2 x i8*]*, [2 x i8*]** %7, align 8
  %44 = load i32, i32* %5, align 4
  %45 = zext i32 %44 to i64
  %46 = getelementptr inbounds [2 x i8*], [2 x i8*]* %43, i64 0, i64 %45
  %47 = load i8*, i8** %46, align 8
  %48 = bitcast i8* %47 to [2 x i8*]*
  store [2 x i8*]* %48, [2 x i8*]** %8, align 8
  %49 = load [2 x i8*]*, [2 x i8*]** %8, align 8
  %50 = load i32, i32* %6, align 4
  %51 = zext i32 %50 to i64
  %52 = getelementptr inbounds [2 x i8*], [2 x i8*]* %49, i64 0, i64 %51
  store i8* null, i8** %52, align 8
  %53 = load [2 x i8*]*, [2 x i8*]** %8, align 8
  %54 = bitcast [2 x i8*]* %53 to i8*
  %55 = load [2 x i8*]*, [2 x i8*]** %3, align 8
  %56 = load i32, i32* %4, align 4
  %57 = zext i32 %56 to i64
  %58 = getelementptr inbounds [2 x i8*], [2 x i8*]* %55, i64 0, i64 %57
  store i8* %54, i8** %58, align 8
  %59 = load [2 x i8*]*, [2 x i8*]** %7, align 8
  %60 = bitcast [2 x i8*]* %59 to i8*
  call void @free(i8* %60) #6
  br label %61

61:                                               ; preds = %28, %21, %12
  ret void
}

; Function Attrs: argmemonly nounwind willreturn
declare void @llvm.memset.p0i8.i64(i8* nocapture writeonly, i8, i64, i1 immarg) #4

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @rand_end_point() #0 {
  %1 = alloca i32, align 4
  %2 = call i32 @__VERIFIER_nondet_int()
  %3 = icmp ne i32 %2, 0
  br i1 %3, label %4, label %5

4:                                                ; preds = %0
  store i32 0, i32* %1, align 4
  br label %6

5:                                                ; preds = %0
  store i32 1, i32* %1, align 4
  br label %6

6:                                                ; preds = %5, %4
  %7 = load i32, i32* %1, align 4
  ret i32 %7
}

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @main() #0 {
  %1 = alloca i32, align 4
  %2 = alloca i32, align 4
  %3 = alloca i32, align 4
  %4 = alloca [2 x i8*]*, align 8
  %5 = alloca [2 x i8*]*, align 8
  store i32 0, i32* %1, align 4
  br label %6

6:                                                ; preds = %21, %0
  %7 = call i32 @__VERIFIER_nondet_int()
  %8 = icmp ne i32 %7, 0
  br i1 %8, label %9, label %22

9:                                                ; preds = %6
  br label %10

10:                                               ; preds = %13, %9
  %11 = call i32 @__VERIFIER_nondet_int()
  %12 = icmp ne i32 %11, 0
  br i1 %12, label %13, label %15

13:                                               ; preds = %10
  %14 = call i32 @rand_end_point()
  call void @append_one([2 x i8*]* @main.list, i32 %14)
  br label %10

15:                                               ; preds = %10
  br label %16

16:                                               ; preds = %19, %15
  %17 = call i32 @__VERIFIER_nondet_int()
  %18 = icmp ne i32 %17, 0
  br i1 %18, label %19, label %21

19:                                               ; preds = %16
  %20 = call i32 @rand_end_point()
  call void @remove_one([2 x i8*]* @main.list, i32 %20)
  br label %16

21:                                               ; preds = %16
  br label %6

22:                                               ; preds = %6
  %23 = call i32 @__VERIFIER_nondet_int()
  %24 = icmp ne i32 %23, 0
  br i1 %24, label %25, label %26

25:                                               ; preds = %22
  store i32 0, i32* %2, align 4
  store i32 1, i32* %3, align 4
  br label %27

26:                                               ; preds = %22
  store i32 1, i32* %2, align 4
  store i32 0, i32* %3, align 4
  br label %27

27:                                               ; preds = %26, %25
  %28 = load i32, i32* %2, align 4
  %29 = zext i32 %28 to i64
  %30 = getelementptr inbounds [2 x i8*], [2 x i8*]* @main.list, i64 0, i64 %29
  %31 = load i8*, i8** %30, align 8
  %32 = bitcast i8* %31 to [2 x i8*]*
  store [2 x i8*]* %32, [2 x i8*]** %4, align 8
  br label %33

33:                                               ; preds = %36, %27
  %34 = load [2 x i8*]*, [2 x i8*]** %4, align 8
  %35 = icmp ne [2 x i8*]* %34, null
  br i1 %35, label %36, label %46

36:                                               ; preds = %33
  %37 = load [2 x i8*]*, [2 x i8*]** %4, align 8
  %38 = load i32, i32* %3, align 4
  %39 = zext i32 %38 to i64
  %40 = getelementptr inbounds [2 x i8*], [2 x i8*]* %37, i64 0, i64 %39
  %41 = load i8*, i8** %40, align 8
  %42 = bitcast i8* %41 to [2 x i8*]*
  store [2 x i8*]* %42, [2 x i8*]** %5, align 8
  %43 = load [2 x i8*]*, [2 x i8*]** %4, align 8
  %44 = bitcast [2 x i8*]* %43 to i8*
  call void @free(i8* %44) #6
  %45 = load [2 x i8*]*, [2 x i8*]** %5, align 8
  store [2 x i8*]* %45, [2 x i8*]** %4, align 8
  br label %33

46:                                               ; preds = %33
  ret i32 0
}

attributes #0 = { noinline nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { noreturn nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #4 = { argmemonly nounwind willreturn }
attributes #5 = { noreturn nounwind }
attributes #6 = { nounwind }

!llvm.module.flags = !{!0}
!llvm.ident = !{!1}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{!"clang version 10.0.1 "}
