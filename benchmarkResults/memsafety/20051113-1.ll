; ModuleID = '/home/curt/HeapDataFlow/benchmarkResults/memsafety/20051113-1.bc'
source_filename = "/home/curt/HeapDataFlow/sv-benchmarks/c/memsafety/20051113-1.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.Struct3 = type { i32, [0 x %union.Union] }
%union.Union = type { %struct.Struct2 }
%struct.Struct2 = type <{ i16, i16, i16, i64, i64, i64 }>
%struct.Struct1 = type <{ i16, i16, i16, i64, i64 }>

@.str = private unnamed_addr constant [2 x i8] c"0\00", align 1
@.str.1 = private unnamed_addr constant [63 x i8] c"/home/curt/HeapDataFlow/sv-benchmarks/c/memsafety/20051113-1.c\00", align 1
@__PRETTY_FUNCTION__.reach_error = private unnamed_addr constant [19 x i8] c"void reach_error()\00", align 1

; Function Attrs: noinline nounwind uwtable
define dso_local void @reach_error() #0 {
  call void @__assert_fail(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str, i64 0, i64 0), i8* getelementptr inbounds ([63 x i8], [63 x i8]* @.str.1, i64 0, i64 0), i32 3, i8* getelementptr inbounds ([19 x i8], [19 x i8]* @__PRETTY_FUNCTION__.reach_error, i64 0, i64 0)) #4
  unreachable
}

; Function Attrs: noreturn nounwind
declare dso_local void @__assert_fail(i8*, i8*, i32, i8*) #1

; Function Attrs: noinline nounwind uwtable
define dso_local i64 @Sum(%struct.Struct3* %0) #0 {
  %2 = alloca %struct.Struct3*, align 8
  %3 = alloca i64, align 8
  %4 = alloca i32, align 4
  store %struct.Struct3* %0, %struct.Struct3** %2, align 8
  store i64 0, i64* %3, align 8
  store i32 0, i32* %4, align 4
  br label %5

5:                                                ; preds = %22, %1
  %6 = load i32, i32* %4, align 4
  %7 = load %struct.Struct3*, %struct.Struct3** %2, align 8
  %8 = getelementptr inbounds %struct.Struct3, %struct.Struct3* %7, i32 0, i32 0
  %9 = load i32, i32* %8, align 1
  %10 = icmp slt i32 %6, %9
  br i1 %10, label %11, label %25

11:                                               ; preds = %5
  %12 = load %struct.Struct3*, %struct.Struct3** %2, align 8
  %13 = getelementptr inbounds %struct.Struct3, %struct.Struct3* %12, i32 0, i32 1
  %14 = load i32, i32* %4, align 4
  %15 = sext i32 %14 to i64
  %16 = getelementptr inbounds [0 x %union.Union], [0 x %union.Union]* %13, i64 0, i64 %15
  %17 = bitcast %union.Union* %16 to %struct.Struct1*
  %18 = getelementptr inbounds %struct.Struct1, %struct.Struct1* %17, i32 0, i32 3
  %19 = load i64, i64* %18, align 1
  %20 = load i64, i64* %3, align 8
  %21 = add i64 %20, %19
  store i64 %21, i64* %3, align 8
  br label %22

22:                                               ; preds = %11
  %23 = load i32, i32* %4, align 4
  %24 = add nsw i32 %23, 1
  store i32 %24, i32* %4, align 4
  br label %5

25:                                               ; preds = %5
  %26 = load i64, i64* %3, align 8
  ret i64 %26
}

; Function Attrs: noinline nounwind uwtable
define dso_local i64 @Sum2(%struct.Struct3* %0) #0 {
  %2 = alloca %struct.Struct3*, align 8
  %3 = alloca i64, align 8
  %4 = alloca i32, align 4
  store %struct.Struct3* %0, %struct.Struct3** %2, align 8
  store i64 0, i64* %3, align 8
  store i32 0, i32* %4, align 4
  br label %5

5:                                                ; preds = %22, %1
  %6 = load i32, i32* %4, align 4
  %7 = load %struct.Struct3*, %struct.Struct3** %2, align 8
  %8 = getelementptr inbounds %struct.Struct3, %struct.Struct3* %7, i32 0, i32 0
  %9 = load i32, i32* %8, align 1
  %10 = icmp slt i32 %6, %9
  br i1 %10, label %11, label %25

11:                                               ; preds = %5
  %12 = load %struct.Struct3*, %struct.Struct3** %2, align 8
  %13 = getelementptr inbounds %struct.Struct3, %struct.Struct3* %12, i32 0, i32 1
  %14 = load i32, i32* %4, align 4
  %15 = sext i32 %14 to i64
  %16 = getelementptr inbounds [0 x %union.Union], [0 x %union.Union]* %13, i64 0, i64 %15
  %17 = bitcast %union.Union* %16 to %struct.Struct1*
  %18 = getelementptr inbounds %struct.Struct1, %struct.Struct1* %17, i32 0, i32 4
  %19 = load i64, i64* %18, align 1
  %20 = load i64, i64* %3, align 8
  %21 = add nsw i64 %20, %19
  store i64 %21, i64* %3, align 8
  br label %22

22:                                               ; preds = %11
  %23 = load i32, i32* %4, align 4
  %24 = add nsw i32 %23, 1
  store i32 %24, i32* %4, align 4
  br label %5

25:                                               ; preds = %5
  %26 = load i64, i64* %3, align 8
  ret i64 %26
}

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @main() #0 {
  %1 = alloca i32, align 4
  %2 = alloca %struct.Struct3*, align 8
  store i32 0, i32* %1, align 4
  %3 = call noalias i8* @malloc(i64 94) #5
  %4 = bitcast i8* %3 to %struct.Struct3*
  store %struct.Struct3* %4, %struct.Struct3** %2, align 8
  %5 = load %struct.Struct3*, %struct.Struct3** %2, align 8
  %6 = bitcast %struct.Struct3* %5 to i8*
  call void @llvm.memset.p0i8.i64(i8* align 1 %6, i8 0, i64 94, i1 false)
  %7 = load %struct.Struct3*, %struct.Struct3** %2, align 8
  %8 = getelementptr inbounds %struct.Struct3, %struct.Struct3* %7, i32 0, i32 0
  store i32 3, i32* %8, align 1
  %9 = load %struct.Struct3*, %struct.Struct3** %2, align 8
  %10 = getelementptr inbounds %struct.Struct3, %struct.Struct3* %9, i32 0, i32 1
  %11 = getelementptr inbounds [0 x %union.Union], [0 x %union.Union]* %10, i64 0, i64 0
  %12 = bitcast %union.Union* %11 to %struct.Struct1*
  %13 = getelementptr inbounds %struct.Struct1, %struct.Struct1* %12, i32 0, i32 3
  store i64 555, i64* %13, align 1
  %14 = load %struct.Struct3*, %struct.Struct3** %2, align 8
  %15 = getelementptr inbounds %struct.Struct3, %struct.Struct3* %14, i32 0, i32 1
  %16 = getelementptr inbounds [0 x %union.Union], [0 x %union.Union]* %15, i64 0, i64 1
  %17 = bitcast %union.Union* %16 to %struct.Struct1*
  %18 = getelementptr inbounds %struct.Struct1, %struct.Struct1* %17, i32 0, i32 3
  store i64 999, i64* %18, align 1
  %19 = load %struct.Struct3*, %struct.Struct3** %2, align 8
  %20 = getelementptr inbounds %struct.Struct3, %struct.Struct3* %19, i32 0, i32 1
  %21 = getelementptr inbounds [0 x %union.Union], [0 x %union.Union]* %20, i64 0, i64 2
  %22 = bitcast %union.Union* %21 to %struct.Struct1*
  %23 = getelementptr inbounds %struct.Struct1, %struct.Struct1* %22, i32 0, i32 3
  store i64 4311810305, i64* %23, align 1
  %24 = load %struct.Struct3*, %struct.Struct3** %2, align 8
  %25 = getelementptr inbounds %struct.Struct3, %struct.Struct3* %24, i32 0, i32 1
  %26 = getelementptr inbounds [0 x %union.Union], [0 x %union.Union]* %25, i64 0, i64 0
  %27 = bitcast %union.Union* %26 to %struct.Struct1*
  %28 = getelementptr inbounds %struct.Struct1, %struct.Struct1* %27, i32 0, i32 4
  store i64 555, i64* %28, align 1
  %29 = load %struct.Struct3*, %struct.Struct3** %2, align 8
  %30 = getelementptr inbounds %struct.Struct3, %struct.Struct3* %29, i32 0, i32 1
  %31 = getelementptr inbounds [0 x %union.Union], [0 x %union.Union]* %30, i64 0, i64 1
  %32 = bitcast %union.Union* %31 to %struct.Struct1*
  %33 = getelementptr inbounds %struct.Struct1, %struct.Struct1* %32, i32 0, i32 4
  store i64 999, i64* %33, align 1
  %34 = load %struct.Struct3*, %struct.Struct3** %2, align 8
  %35 = getelementptr inbounds %struct.Struct3, %struct.Struct3* %34, i32 0, i32 1
  %36 = getelementptr inbounds [0 x %union.Union], [0 x %union.Union]* %35, i64 0, i64 2
  %37 = bitcast %union.Union* %36 to %struct.Struct1*
  %38 = getelementptr inbounds %struct.Struct1, %struct.Struct1* %37, i32 0, i32 4
  store i64 4311810305, i64* %38, align 1
  %39 = load %struct.Struct3*, %struct.Struct3** %2, align 8
  %40 = call i64 @Sum(%struct.Struct3* %39)
  %41 = icmp ne i64 %40, 4311811859
  br i1 %41, label %42, label %43

42:                                               ; preds = %0
  call void @dummy_abort()
  br label %43

43:                                               ; preds = %42, %0
  %44 = load %struct.Struct3*, %struct.Struct3** %2, align 8
  %45 = call i64 @Sum2(%struct.Struct3* %44)
  %46 = icmp ne i64 %45, 4311811859
  br i1 %46, label %47, label %48

47:                                               ; preds = %43
  call void @dummy_abort()
  br label %48

48:                                               ; preds = %47, %43
  store %struct.Struct3* null, %struct.Struct3** %2, align 8
  ret i32 0
}

; Function Attrs: nounwind
declare dso_local noalias i8* @malloc(i64) #2

; Function Attrs: argmemonly nounwind willreturn
declare void @llvm.memset.p0i8.i64(i8* nocapture writeonly, i8, i64, i1 immarg) #3

; Function Attrs: noinline nounwind uwtable
define internal void @dummy_abort() #0 {
  ret void
}

attributes #0 = { noinline nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { noreturn nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { argmemonly nounwind willreturn }
attributes #4 = { noreturn nounwind }
attributes #5 = { nounwind }

!llvm.module.flags = !{!0}
!llvm.ident = !{!1}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{!"clang version 10.0.1 "}
