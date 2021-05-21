; ModuleID = '/home/curt/HeapDataFlow/benchmarkResults/memsafety/test-0513.bc'
source_filename = "/home/curt/HeapDataFlow/sv-benchmarks/c/memsafety/test-0513.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.TLItem = type { %struct.TLItem*, %struct.DItem* }
%struct.DItem = type { %struct.DItem*, i32 }

@.str = private unnamed_addr constant [2 x i8] c"0\00", align 1
@.str.1 = private unnamed_addr constant [62 x i8] c"/home/curt/HeapDataFlow/sv-benchmarks/c/memsafety/test-0513.c\00", align 1
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
  %2 = alloca %struct.TLItem*, align 8
  %3 = alloca %struct.DItem*, align 8
  %4 = alloca %struct.DItem*, align 8
  %5 = alloca %struct.TLItem*, align 8
  %6 = alloca %struct.DItem**, align 8
  store i32 0, i32* %1, align 4
  store %struct.TLItem* null, %struct.TLItem** %2, align 8
  br label %7

7:                                                ; preds = %40, %0
  %8 = call i32 @__VERIFIER_nondet_int()
  %9 = icmp ne i32 %8, 0
  br i1 %9, label %10, label %44

10:                                               ; preds = %7
  %11 = call noalias i8* @malloc(i64 16) #5
  %12 = bitcast i8* %11 to %struct.DItem*
  store %struct.DItem* %12, %struct.DItem** %3, align 8
  %13 = load %struct.DItem*, %struct.DItem** %3, align 8
  %14 = icmp ne %struct.DItem* %13, null
  br i1 %14, label %16, label %15

15:                                               ; preds = %10
  call void @abort() #4
  unreachable

16:                                               ; preds = %10
  %17 = load %struct.DItem*, %struct.DItem** %3, align 8
  %18 = getelementptr inbounds %struct.DItem, %struct.DItem* %17, i32 0, i32 0
  store %struct.DItem* null, %struct.DItem** %18, align 8
  %19 = call i32 @__VERIFIER_nondet_int()
  %20 = load %struct.DItem*, %struct.DItem** %3, align 8
  %21 = getelementptr inbounds %struct.DItem, %struct.DItem* %20, i32 0, i32 1
  store i32 %19, i32* %21, align 8
  %22 = call noalias i8* @malloc(i64 16) #5
  %23 = bitcast i8* %22 to %struct.TLItem*
  store %struct.TLItem* %23, %struct.TLItem** %5, align 8
  %24 = load %struct.TLItem*, %struct.TLItem** %2, align 8
  %25 = icmp ne %struct.TLItem* %24, null
  br i1 %25, label %26, label %35

26:                                               ; preds = %16
  %27 = load %struct.TLItem*, %struct.TLItem** %2, align 8
  %28 = getelementptr inbounds %struct.TLItem, %struct.TLItem* %27, i32 0, i32 0
  %29 = load %struct.TLItem*, %struct.TLItem** %28, align 8
  %30 = load %struct.TLItem*, %struct.TLItem** %5, align 8
  %31 = getelementptr inbounds %struct.TLItem, %struct.TLItem* %30, i32 0, i32 0
  store %struct.TLItem* %29, %struct.TLItem** %31, align 8
  %32 = load %struct.TLItem*, %struct.TLItem** %5, align 8
  %33 = load %struct.TLItem*, %struct.TLItem** %2, align 8
  %34 = getelementptr inbounds %struct.TLItem, %struct.TLItem* %33, i32 0, i32 0
  store %struct.TLItem* %32, %struct.TLItem** %34, align 8
  br label %40

35:                                               ; preds = %16
  %36 = load %struct.TLItem*, %struct.TLItem** %5, align 8
  %37 = load %struct.TLItem*, %struct.TLItem** %5, align 8
  %38 = getelementptr inbounds %struct.TLItem, %struct.TLItem* %37, i32 0, i32 0
  store %struct.TLItem* %36, %struct.TLItem** %38, align 8
  %39 = load %struct.TLItem*, %struct.TLItem** %5, align 8
  store %struct.TLItem* %39, %struct.TLItem** %2, align 8
  br label %40

40:                                               ; preds = %35, %26
  %41 = load %struct.DItem*, %struct.DItem** %3, align 8
  %42 = load %struct.TLItem*, %struct.TLItem** %5, align 8
  %43 = getelementptr inbounds %struct.TLItem, %struct.TLItem* %42, i32 0, i32 1
  store %struct.DItem* %41, %struct.DItem** %43, align 8
  store %struct.DItem* null, %struct.DItem** %3, align 8
  store %struct.TLItem* null, %struct.TLItem** %5, align 8
  br label %7

44:                                               ; preds = %7
  %45 = load %struct.TLItem*, %struct.TLItem** %2, align 8
  %46 = icmp ne %struct.TLItem* %45, null
  br i1 %46, label %48, label %47

47:                                               ; preds = %44
  store i32 0, i32* %1, align 4
  br label %142

48:                                               ; preds = %44
  br label %49

49:                                               ; preds = %121, %48
  %50 = load %struct.TLItem*, %struct.TLItem** %2, align 8
  %51 = getelementptr inbounds %struct.TLItem, %struct.TLItem* %50, i32 0, i32 0
  %52 = load %struct.TLItem*, %struct.TLItem** %51, align 8
  %53 = load %struct.TLItem*, %struct.TLItem** %2, align 8
  %54 = icmp ne %struct.TLItem* %52, %53
  br i1 %54, label %55, label %125

55:                                               ; preds = %49
  %56 = load %struct.TLItem*, %struct.TLItem** %2, align 8
  %57 = getelementptr inbounds %struct.TLItem, %struct.TLItem* %56, i32 0, i32 1
  %58 = load %struct.DItem*, %struct.DItem** %57, align 8
  store %struct.DItem* %58, %struct.DItem** %3, align 8
  %59 = load %struct.TLItem*, %struct.TLItem** %2, align 8
  %60 = getelementptr inbounds %struct.TLItem, %struct.TLItem* %59, i32 0, i32 0
  %61 = load %struct.TLItem*, %struct.TLItem** %60, align 8
  %62 = getelementptr inbounds %struct.TLItem, %struct.TLItem* %61, i32 0, i32 1
  %63 = load %struct.DItem*, %struct.DItem** %62, align 8
  store %struct.DItem* %63, %struct.DItem** %4, align 8
  %64 = load %struct.TLItem*, %struct.TLItem** %2, align 8
  %65 = getelementptr inbounds %struct.TLItem, %struct.TLItem* %64, i32 0, i32 0
  %66 = load %struct.TLItem*, %struct.TLItem** %65, align 8
  store %struct.TLItem* %66, %struct.TLItem** %5, align 8
  %67 = load %struct.TLItem*, %struct.TLItem** %5, align 8
  %68 = getelementptr inbounds %struct.TLItem, %struct.TLItem* %67, i32 0, i32 0
  %69 = load %struct.TLItem*, %struct.TLItem** %68, align 8
  %70 = load %struct.TLItem*, %struct.TLItem** %2, align 8
  %71 = getelementptr inbounds %struct.TLItem, %struct.TLItem* %70, i32 0, i32 0
  store %struct.TLItem* %69, %struct.TLItem** %71, align 8
  %72 = load %struct.TLItem*, %struct.TLItem** %5, align 8
  %73 = bitcast %struct.TLItem* %72 to i8*
  call void @free(i8* %73) #5
  %74 = load %struct.TLItem*, %struct.TLItem** %2, align 8
  %75 = getelementptr inbounds %struct.TLItem, %struct.TLItem* %74, i32 0, i32 1
  store %struct.DItem** %75, %struct.DItem*** %6, align 8
  br label %76

76:                                               ; preds = %104, %55
  %77 = load %struct.DItem*, %struct.DItem** %3, align 8
  %78 = icmp ne %struct.DItem* %77, null
  br i1 %78, label %79, label %82

79:                                               ; preds = %76
  %80 = load %struct.DItem*, %struct.DItem** %4, align 8
  %81 = icmp ne %struct.DItem* %80, null
  br label %82

82:                                               ; preds = %79, %76
  %83 = phi i1 [ false, %76 ], [ %81, %79 ]
  br i1 %83, label %84, label %108

84:                                               ; preds = %82
  %85 = load %struct.DItem*, %struct.DItem** %3, align 8
  %86 = getelementptr inbounds %struct.DItem, %struct.DItem* %85, i32 0, i32 1
  %87 = load i32, i32* %86, align 8
  %88 = load %struct.DItem*, %struct.DItem** %4, align 8
  %89 = getelementptr inbounds %struct.DItem, %struct.DItem* %88, i32 0, i32 1
  %90 = load i32, i32* %89, align 8
  %91 = icmp slt i32 %87, %90
  br i1 %91, label %92, label %98

92:                                               ; preds = %84
  %93 = load %struct.DItem*, %struct.DItem** %3, align 8
  %94 = load %struct.DItem**, %struct.DItem*** %6, align 8
  store %struct.DItem* %93, %struct.DItem** %94, align 8
  %95 = load %struct.DItem*, %struct.DItem** %3, align 8
  %96 = getelementptr inbounds %struct.DItem, %struct.DItem* %95, i32 0, i32 0
  %97 = load %struct.DItem*, %struct.DItem** %96, align 8
  store %struct.DItem* %97, %struct.DItem** %3, align 8
  br label %104

98:                                               ; preds = %84
  %99 = load %struct.DItem*, %struct.DItem** %4, align 8
  %100 = load %struct.DItem**, %struct.DItem*** %6, align 8
  store %struct.DItem* %99, %struct.DItem** %100, align 8
  %101 = load %struct.DItem*, %struct.DItem** %4, align 8
  %102 = getelementptr inbounds %struct.DItem, %struct.DItem* %101, i32 0, i32 0
  %103 = load %struct.DItem*, %struct.DItem** %102, align 8
  store %struct.DItem* %103, %struct.DItem** %4, align 8
  br label %104

104:                                              ; preds = %98, %92
  %105 = load %struct.DItem**, %struct.DItem*** %6, align 8
  %106 = load %struct.DItem*, %struct.DItem** %105, align 8
  %107 = getelementptr inbounds %struct.DItem, %struct.DItem* %106, i32 0, i32 0
  store %struct.DItem** %107, %struct.DItem*** %6, align 8
  br label %76

108:                                              ; preds = %82
  %109 = load %struct.DItem*, %struct.DItem** %3, align 8
  %110 = icmp ne %struct.DItem* %109, null
  br i1 %110, label %111, label %114

111:                                              ; preds = %108
  %112 = load %struct.DItem*, %struct.DItem** %3, align 8
  %113 = load %struct.DItem**, %struct.DItem*** %6, align 8
  store %struct.DItem* %112, %struct.DItem** %113, align 8
  store %struct.DItem* null, %struct.DItem** %3, align 8
  br label %121

114:                                              ; preds = %108
  %115 = load %struct.DItem*, %struct.DItem** %4, align 8
  %116 = icmp ne %struct.DItem* %115, null
  br i1 %116, label %117, label %120

117:                                              ; preds = %114
  %118 = load %struct.DItem*, %struct.DItem** %4, align 8
  %119 = load %struct.DItem**, %struct.DItem*** %6, align 8
  store %struct.DItem* %118, %struct.DItem** %119, align 8
  store %struct.DItem* null, %struct.DItem** %4, align 8
  br label %120

120:                                              ; preds = %117, %114
  br label %121

121:                                              ; preds = %120, %111
  store %struct.DItem** null, %struct.DItem*** %6, align 8
  %122 = load %struct.TLItem*, %struct.TLItem** %2, align 8
  %123 = getelementptr inbounds %struct.TLItem, %struct.TLItem* %122, i32 0, i32 0
  %124 = load %struct.TLItem*, %struct.TLItem** %123, align 8
  store %struct.TLItem* %124, %struct.TLItem** %2, align 8
  br label %49

125:                                              ; preds = %49
  %126 = load %struct.TLItem*, %struct.TLItem** %2, align 8
  %127 = getelementptr inbounds %struct.TLItem, %struct.TLItem* %126, i32 0, i32 1
  %128 = load %struct.DItem*, %struct.DItem** %127, align 8
  store %struct.DItem* %128, %struct.DItem** %3, align 8
  %129 = load %struct.TLItem*, %struct.TLItem** %2, align 8
  %130 = bitcast %struct.TLItem* %129 to i8*
  call void @free(i8* %130) #5
  br label %131

131:                                              ; preds = %134, %125
  %132 = load %struct.DItem*, %struct.DItem** %3, align 8
  %133 = icmp ne %struct.DItem* %132, null
  br i1 %133, label %134, label %141

134:                                              ; preds = %131
  %135 = load %struct.DItem*, %struct.DItem** %3, align 8
  store %struct.DItem* %135, %struct.DItem** %4, align 8
  %136 = load %struct.DItem*, %struct.DItem** %3, align 8
  %137 = getelementptr inbounds %struct.DItem, %struct.DItem* %136, i32 0, i32 0
  %138 = load %struct.DItem*, %struct.DItem** %137, align 8
  store %struct.DItem* %138, %struct.DItem** %3, align 8
  %139 = load %struct.DItem*, %struct.DItem** %4, align 8
  %140 = bitcast %struct.DItem* %139 to i8*
  call void @free(i8* %140) #5
  br label %131

141:                                              ; preds = %131
  store i32 0, i32* %1, align 4
  br label %142

142:                                              ; preds = %141, %47
  %143 = load i32, i32* %1, align 4
  ret i32 %143
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
