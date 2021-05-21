; ModuleID = '/home/curt/HeapDataFlow/benchmarkResults/memsafety/test-0219.bc'
source_filename = "/home/curt/HeapDataFlow/sv-benchmarks/c/memsafety/test-0219.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.L1 = type { %struct.L1*, %struct.L2* }
%struct.L2 = type { i8*, %struct.L2* }

@.str = private unnamed_addr constant [2 x i8] c"0\00", align 1
@.str.1 = private unnamed_addr constant [62 x i8] c"/home/curt/HeapDataFlow/sv-benchmarks/c/memsafety/test-0219.c\00", align 1
@__PRETTY_FUNCTION__.reach_error = private unnamed_addr constant [19 x i8] c"void reach_error()\00", align 1
@main.list = internal global %struct.L1* null, align 8

; Function Attrs: noinline nounwind uwtable
define dso_local void @reach_error() #0 {
  call void @__assert_fail(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str, i64 0, i64 0), i8* getelementptr inbounds ([62 x i8], [62 x i8]* @.str.1, i64 0, i64 0), i32 3, i8* getelementptr inbounds ([19 x i8], [19 x i8]* @__PRETTY_FUNCTION__.reach_error, i64 0, i64 0)) #5
  unreachable
}

; Function Attrs: noreturn nounwind
declare dso_local void @__assert_fail(i8*, i8*, i32, i8*) #1

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @main() #0 {
  %1 = alloca i32, align 4
  %2 = alloca %struct.L1*, align 8
  store i32 0, i32* %1, align 4
  br label %3

3:                                                ; preds = %4, %0
  call void @l1_insert(%struct.L1** @main.list)
  br label %4

4:                                                ; preds = %3
  %5 = call i32 @__VERIFIER_nondet_int()
  %6 = icmp ne i32 %5, 0
  br i1 %6, label %3, label %7

7:                                                ; preds = %4
  br label %8

8:                                                ; preds = %18, %7
  %9 = load %struct.L1*, %struct.L1** @main.list, align 8
  %10 = getelementptr inbounds %struct.L1, %struct.L1* %9, i32 0, i32 0
  %11 = load %struct.L1*, %struct.L1** %10, align 8
  store %struct.L1* %11, %struct.L1** %2, align 8
  %12 = load %struct.L1*, %struct.L1** @main.list, align 8
  %13 = getelementptr inbounds %struct.L1, %struct.L1* %12, i32 0, i32 1
  %14 = load %struct.L2*, %struct.L2** %13, align 8
  call void @l2_destroy(%struct.L2* %14)
  %15 = load %struct.L1*, %struct.L1** @main.list, align 8
  %16 = bitcast %struct.L1* %15 to i8*
  call void @free(i8* %16) #6
  %17 = load %struct.L1*, %struct.L1** %2, align 8
  store %struct.L1* %17, %struct.L1** @main.list, align 8
  br label %18

18:                                               ; preds = %8
  %19 = load %struct.L1*, %struct.L1** @main.list, align 8
  %20 = icmp ne %struct.L1* %19, null
  br i1 %20, label %8, label %21

21:                                               ; preds = %18
  %22 = load i32, i32* %1, align 4
  ret i32 %22
}

; Function Attrs: noinline nounwind uwtable
define internal void @l1_insert(%struct.L1** %0) #0 {
  %2 = alloca %struct.L1**, align 8
  %3 = alloca %struct.L1*, align 8
  store %struct.L1** %0, %struct.L1*** %2, align 8
  %4 = call i8* @calloc_model(i64 1, i64 16)
  %5 = bitcast i8* %4 to %struct.L1*
  store %struct.L1* %5, %struct.L1** %3, align 8
  %6 = load %struct.L1*, %struct.L1** %3, align 8
  %7 = icmp ne %struct.L1* %6, null
  br i1 %7, label %9, label %8

8:                                                ; preds = %1
  call void @abort() #5
  unreachable

9:                                                ; preds = %1
  br label %10

10:                                               ; preds = %13, %9
  %11 = load %struct.L1*, %struct.L1** %3, align 8
  %12 = getelementptr inbounds %struct.L1, %struct.L1* %11, i32 0, i32 1
  call void @l2_insert(%struct.L2** %12)
  br label %13

13:                                               ; preds = %10
  %14 = call i32 @__VERIFIER_nondet_int()
  %15 = icmp ne i32 %14, 0
  br i1 %15, label %10, label %16

16:                                               ; preds = %13
  %17 = load %struct.L1**, %struct.L1*** %2, align 8
  %18 = load %struct.L1*, %struct.L1** %17, align 8
  %19 = load %struct.L1*, %struct.L1** %3, align 8
  %20 = getelementptr inbounds %struct.L1, %struct.L1* %19, i32 0, i32 0
  store %struct.L1* %18, %struct.L1** %20, align 8
  %21 = load %struct.L1*, %struct.L1** %3, align 8
  %22 = load %struct.L1**, %struct.L1*** %2, align 8
  store %struct.L1* %21, %struct.L1** %22, align 8
  ret void
}

declare dso_local i32 @__VERIFIER_nondet_int() #2

; Function Attrs: noinline nounwind uwtable
define internal void @l2_destroy(%struct.L2* %0) #0 {
  %2 = alloca %struct.L2*, align 8
  %3 = alloca %struct.L2*, align 8
  store %struct.L2* %0, %struct.L2** %2, align 8
  br label %4

4:                                                ; preds = %14, %1
  %5 = load %struct.L2*, %struct.L2** %2, align 8
  %6 = getelementptr inbounds %struct.L2, %struct.L2* %5, i32 0, i32 1
  %7 = load %struct.L2*, %struct.L2** %6, align 8
  store %struct.L2* %7, %struct.L2** %3, align 8
  %8 = load %struct.L2*, %struct.L2** %2, align 8
  %9 = getelementptr inbounds %struct.L2, %struct.L2* %8, i32 0, i32 0
  %10 = load i8*, i8** %9, align 8
  call void @free(i8* %10) #6
  %11 = load %struct.L2*, %struct.L2** %2, align 8
  %12 = bitcast %struct.L2* %11 to i8*
  call void @free(i8* %12) #6
  %13 = load %struct.L2*, %struct.L2** %3, align 8
  store %struct.L2* %13, %struct.L2** %2, align 8
  br label %14

14:                                               ; preds = %4
  %15 = load %struct.L2*, %struct.L2** %2, align 8
  %16 = icmp ne %struct.L2* %15, null
  br i1 %16, label %4, label %17

17:                                               ; preds = %14
  ret void
}

; Function Attrs: nounwind
declare dso_local void @free(i8*) #3

; Function Attrs: noinline nounwind uwtable
define internal i8* @calloc_model(i64 %0, i64 %1) #0 {
  %3 = alloca i64, align 8
  %4 = alloca i64, align 8
  %5 = alloca i8*, align 8
  store i64 %0, i64* %3, align 8
  store i64 %1, i64* %4, align 8
  %6 = load i64, i64* %3, align 8
  %7 = load i64, i64* %4, align 8
  %8 = mul i64 %6, %7
  %9 = call noalias i8* @malloc(i64 %8) #6
  store i8* %9, i8** %5, align 8
  %10 = load i8*, i8** %5, align 8
  %11 = load i64, i64* %3, align 8
  %12 = load i64, i64* %4, align 8
  %13 = mul i64 %11, %12
  call void @llvm.memset.p0i8.i64(i8* align 1 %10, i8 0, i64 %13, i1 false)
  ret i8* %10
}

; Function Attrs: noreturn nounwind
declare dso_local void @abort() #1

; Function Attrs: noinline nounwind uwtable
define internal void @l2_insert(%struct.L2** %0) #0 {
  %2 = alloca %struct.L2**, align 8
  %3 = alloca %struct.L2*, align 8
  store %struct.L2** %0, %struct.L2*** %2, align 8
  %4 = call i8* @calloc_model(i64 1, i64 16)
  %5 = bitcast i8* %4 to %struct.L2*
  store %struct.L2* %5, %struct.L2** %3, align 8
  %6 = load %struct.L2*, %struct.L2** %3, align 8
  %7 = icmp ne %struct.L2* %6, null
  br i1 %7, label %9, label %8

8:                                                ; preds = %1
  call void @abort() #5
  unreachable

9:                                                ; preds = %1
  %10 = call noalias i8* @malloc(i64 119) #6
  %11 = load %struct.L2*, %struct.L2** %3, align 8
  %12 = getelementptr inbounds %struct.L2, %struct.L2* %11, i32 0, i32 0
  store i8* %10, i8** %12, align 8
  %13 = load %struct.L2*, %struct.L2** %3, align 8
  %14 = getelementptr inbounds %struct.L2, %struct.L2* %13, i32 0, i32 0
  %15 = load i8*, i8** %14, align 8
  %16 = icmp ne i8* %15, null
  br i1 %16, label %18, label %17

17:                                               ; preds = %9
  call void @abort() #5
  unreachable

18:                                               ; preds = %9
  %19 = load %struct.L2**, %struct.L2*** %2, align 8
  %20 = load %struct.L2*, %struct.L2** %19, align 8
  %21 = load %struct.L2*, %struct.L2** %3, align 8
  %22 = getelementptr inbounds %struct.L2, %struct.L2* %21, i32 0, i32 1
  store %struct.L2* %20, %struct.L2** %22, align 8
  %23 = load %struct.L2*, %struct.L2** %3, align 8
  %24 = load %struct.L2**, %struct.L2*** %2, align 8
  store %struct.L2* %23, %struct.L2** %24, align 8
  ret void
}

; Function Attrs: nounwind
declare dso_local noalias i8* @malloc(i64) #3

; Function Attrs: argmemonly nounwind willreturn
declare void @llvm.memset.p0i8.i64(i8* nocapture writeonly, i8, i64, i1 immarg) #4

attributes #0 = { noinline nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { noreturn nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #4 = { argmemonly nounwind willreturn }
attributes #5 = { noreturn nounwind }
attributes #6 = { nounwind }

!llvm.module.flags = !{!0}
!llvm.ident = !{!1}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{!"clang version 10.0.1 "}
