; ModuleID = '/home/curt/HeapDataFlow/benchmarkResults/memsafety/test-0504.bc'
source_filename = "/home/curt/HeapDataFlow/sv-benchmarks/c/memsafety/test-0504.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.T2 = type { %struct.T, %struct.T2*, %struct.T2* }
%struct.T = type { %struct.T*, %struct.T*, i32 }

@.str = private unnamed_addr constant [2 x i8] c"0\00", align 1
@.str.1 = private unnamed_addr constant [62 x i8] c"/home/curt/HeapDataFlow/sv-benchmarks/c/memsafety/test-0504.c\00", align 1
@__PRETTY_FUNCTION__.reach_error = private unnamed_addr constant [19 x i8] c"void reach_error()\00", align 1

; Function Attrs: noinline nounwind uwtable
define dso_local void @reach_error() #0 {
  call void @__assert_fail(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str, i64 0, i64 0), i8* getelementptr inbounds ([62 x i8], [62 x i8]* @.str.1, i64 0, i64 0), i32 3, i8* getelementptr inbounds ([19 x i8], [19 x i8]* @__PRETTY_FUNCTION__.reach_error, i64 0, i64 0)) #4
  unreachable
}

; Function Attrs: noreturn nounwind
declare dso_local void @__assert_fail(i8*, i8*, i32, i8*) #1

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @main() #0 {
  %1 = alloca i32, align 4
  %2 = alloca %struct.T2*, align 8
  %3 = alloca %struct.T2*, align 8
  %4 = alloca %struct.T2*, align 8
  %5 = alloca %struct.T*, align 8
  %6 = alloca %struct.T2*, align 8
  %7 = alloca %struct.T*, align 8
  %8 = alloca %struct.T*, align 8
  store i32 0, i32* %1, align 4
  store %struct.T2* null, %struct.T2** %2, align 8
  store %struct.T2* null, %struct.T2** %3, align 8
  br label %9

9:                                                ; preds = %81, %0
  %10 = call i32 @__VERIFIER_nondet_int()
  %11 = icmp ne i32 %10, 0
  br i1 %11, label %12, label %82

12:                                               ; preds = %9
  %13 = call noalias i8* @malloc(i64 40) #5
  %14 = bitcast i8* %13 to %struct.T2*
  store %struct.T2* %14, %struct.T2** %4, align 8
  %15 = load %struct.T2*, %struct.T2** %4, align 8
  %16 = icmp ne %struct.T2* %15, null
  br i1 %16, label %18, label %17

17:                                               ; preds = %12
  call void @abort() #4
  unreachable

18:                                               ; preds = %12
  %19 = load %struct.T2*, %struct.T2** %4, align 8
  %20 = getelementptr inbounds %struct.T2, %struct.T2* %19, i32 0, i32 1
  store %struct.T2* null, %struct.T2** %20, align 8
  %21 = load %struct.T2*, %struct.T2** %4, align 8
  %22 = getelementptr inbounds %struct.T2, %struct.T2* %21, i32 0, i32 2
  store %struct.T2* null, %struct.T2** %22, align 8
  %23 = load %struct.T2*, %struct.T2** %4, align 8
  %24 = getelementptr inbounds %struct.T2, %struct.T2* %23, i32 0, i32 0
  %25 = load %struct.T2*, %struct.T2** %4, align 8
  %26 = getelementptr inbounds %struct.T2, %struct.T2* %25, i32 0, i32 0
  %27 = getelementptr inbounds %struct.T, %struct.T* %26, i32 0, i32 0
  store %struct.T* %24, %struct.T** %27, align 8
  %28 = load %struct.T2*, %struct.T2** %4, align 8
  %29 = getelementptr inbounds %struct.T2, %struct.T2* %28, i32 0, i32 0
  %30 = load %struct.T2*, %struct.T2** %4, align 8
  %31 = getelementptr inbounds %struct.T2, %struct.T2* %30, i32 0, i32 0
  %32 = getelementptr inbounds %struct.T, %struct.T* %31, i32 0, i32 1
  store %struct.T* %29, %struct.T** %32, align 8
  %33 = load %struct.T2*, %struct.T2** %4, align 8
  %34 = getelementptr inbounds %struct.T2, %struct.T2* %33, i32 0, i32 0
  %35 = getelementptr inbounds %struct.T, %struct.T* %34, i32 0, i32 2
  store i32 0, i32* %35, align 8
  store %struct.T* null, %struct.T** %5, align 8
  br label %36

36:                                               ; preds = %45, %18
  %37 = call i32 @__VERIFIER_nondet_int()
  %38 = icmp ne i32 %37, 0
  br i1 %38, label %39, label %67

39:                                               ; preds = %36
  %40 = call noalias i8* @malloc(i64 24) #5
  %41 = bitcast i8* %40 to %struct.T*
  store %struct.T* %41, %struct.T** %5, align 8
  %42 = load %struct.T*, %struct.T** %5, align 8
  %43 = icmp ne %struct.T* %42, null
  br i1 %43, label %45, label %44

44:                                               ; preds = %39
  call void @abort() #4
  unreachable

45:                                               ; preds = %39
  %46 = load %struct.T2*, %struct.T2** %4, align 8
  %47 = getelementptr inbounds %struct.T2, %struct.T2* %46, i32 0, i32 0
  %48 = getelementptr inbounds %struct.T, %struct.T* %47, i32 0, i32 0
  %49 = load %struct.T*, %struct.T** %48, align 8
  %50 = load %struct.T*, %struct.T** %5, align 8
  %51 = getelementptr inbounds %struct.T, %struct.T* %50, i32 0, i32 0
  store %struct.T* %49, %struct.T** %51, align 8
  %52 = load %struct.T*, %struct.T** %5, align 8
  %53 = load %struct.T*, %struct.T** %5, align 8
  %54 = getelementptr inbounds %struct.T, %struct.T* %53, i32 0, i32 0
  %55 = load %struct.T*, %struct.T** %54, align 8
  %56 = getelementptr inbounds %struct.T, %struct.T* %55, i32 0, i32 1
  store %struct.T* %52, %struct.T** %56, align 8
  %57 = load %struct.T2*, %struct.T2** %4, align 8
  %58 = getelementptr inbounds %struct.T2, %struct.T2* %57, i32 0, i32 0
  %59 = load %struct.T*, %struct.T** %5, align 8
  %60 = getelementptr inbounds %struct.T, %struct.T* %59, i32 0, i32 1
  store %struct.T* %58, %struct.T** %60, align 8
  %61 = load %struct.T*, %struct.T** %5, align 8
  %62 = getelementptr inbounds %struct.T, %struct.T* %61, i32 0, i32 2
  store i32 0, i32* %62, align 8
  %63 = load %struct.T*, %struct.T** %5, align 8
  %64 = load %struct.T2*, %struct.T2** %4, align 8
  %65 = getelementptr inbounds %struct.T2, %struct.T2* %64, i32 0, i32 0
  %66 = getelementptr inbounds %struct.T, %struct.T* %65, i32 0, i32 0
  store %struct.T* %63, %struct.T** %66, align 8
  store %struct.T* null, %struct.T** %5, align 8
  br label %36

67:                                               ; preds = %36
  %68 = load %struct.T2*, %struct.T2** %2, align 8
  %69 = icmp ne %struct.T2* %68, null
  br i1 %69, label %73, label %70

70:                                               ; preds = %67
  %71 = load %struct.T2*, %struct.T2** %4, align 8
  store %struct.T2* %71, %struct.T2** %2, align 8
  %72 = load %struct.T2*, %struct.T2** %4, align 8
  store %struct.T2* %72, %struct.T2** %3, align 8
  br label %81

73:                                               ; preds = %67
  %74 = load %struct.T2*, %struct.T2** %4, align 8
  %75 = load %struct.T2*, %struct.T2** %3, align 8
  %76 = getelementptr inbounds %struct.T2, %struct.T2* %75, i32 0, i32 1
  store %struct.T2* %74, %struct.T2** %76, align 8
  %77 = load %struct.T2*, %struct.T2** %3, align 8
  %78 = load %struct.T2*, %struct.T2** %4, align 8
  %79 = getelementptr inbounds %struct.T2, %struct.T2* %78, i32 0, i32 2
  store %struct.T2* %77, %struct.T2** %79, align 8
  %80 = load %struct.T2*, %struct.T2** %4, align 8
  store %struct.T2* %80, %struct.T2** %3, align 8
  br label %81

81:                                               ; preds = %73, %70
  br label %9

82:                                               ; preds = %9
  br label %83

83:                                               ; preds = %107, %82
  %84 = load %struct.T2*, %struct.T2** %2, align 8
  %85 = icmp ne %struct.T2* %84, null
  br i1 %85, label %86, label %110

86:                                               ; preds = %83
  %87 = load %struct.T2*, %struct.T2** %2, align 8
  store %struct.T2* %87, %struct.T2** %6, align 8
  %88 = load %struct.T2*, %struct.T2** %2, align 8
  %89 = getelementptr inbounds %struct.T2, %struct.T2* %88, i32 0, i32 1
  %90 = load %struct.T2*, %struct.T2** %89, align 8
  store %struct.T2* %90, %struct.T2** %2, align 8
  %91 = load %struct.T2*, %struct.T2** %6, align 8
  %92 = getelementptr inbounds %struct.T2, %struct.T2* %91, i32 0, i32 0
  %93 = getelementptr inbounds %struct.T, %struct.T* %92, i32 0, i32 0
  %94 = load %struct.T*, %struct.T** %93, align 8
  store %struct.T* %94, %struct.T** %7, align 8
  br label %95

95:                                               ; preds = %100, %86
  %96 = load %struct.T*, %struct.T** %7, align 8
  %97 = load %struct.T2*, %struct.T2** %6, align 8
  %98 = getelementptr inbounds %struct.T2, %struct.T2* %97, i32 0, i32 0
  %99 = icmp ne %struct.T* %96, %98
  br i1 %99, label %100, label %107

100:                                              ; preds = %95
  %101 = load %struct.T*, %struct.T** %7, align 8
  store %struct.T* %101, %struct.T** %8, align 8
  %102 = load %struct.T*, %struct.T** %7, align 8
  %103 = getelementptr inbounds %struct.T, %struct.T* %102, i32 0, i32 0
  %104 = load %struct.T*, %struct.T** %103, align 8
  store %struct.T* %104, %struct.T** %7, align 8
  %105 = load %struct.T*, %struct.T** %8, align 8
  %106 = bitcast %struct.T* %105 to i8*
  call void @free(i8* %106) #5
  br label %95

107:                                              ; preds = %95
  %108 = load %struct.T2*, %struct.T2** %6, align 8
  %109 = bitcast %struct.T2* %108 to i8*
  call void @free(i8* %109) #5
  br label %83

110:                                              ; preds = %83
  ret i32 0
}

declare dso_local i32 @__VERIFIER_nondet_int() #2

; Function Attrs: nounwind
declare dso_local noalias i8* @malloc(i64) #3

; Function Attrs: noreturn nounwind
declare dso_local void @abort() #1

; Function Attrs: nounwind
declare dso_local void @free(i8*) #3

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
