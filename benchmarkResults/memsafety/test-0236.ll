; ModuleID = '/home/curt/HeapDataFlow/benchmarkResults/memsafety/test-0236.bc'
source_filename = "/home/curt/HeapDataFlow/sv-benchmarks/c/memsafety/test-0236.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.L0 = type { %struct.L0**, %struct.L0*, %struct.L1* }
%struct.L1 = type { %struct.L2*, %struct.L1*, %struct.L1** }
%struct.L2 = type { %struct.L2**, %struct.L2*, %struct.L3* }
%struct.L3 = type { %struct.L4*, %struct.L3*, %struct.L3** }
%struct.L4 = type { %struct.L4**, %struct.L4*, %struct.L5* }
%struct.L5 = type opaque

@.str = private unnamed_addr constant [2 x i8] c"0\00", align 1
@.str.1 = private unnamed_addr constant [62 x i8] c"/home/curt/HeapDataFlow/sv-benchmarks/c/memsafety/test-0236.c\00", align 1
@__PRETTY_FUNCTION__.reach_error = private unnamed_addr constant [19 x i8] c"void reach_error()\00", align 1
@main.list = internal global %struct.L0* null, align 8

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
  store i32 0, i32* %1, align 4
  br label %2

2:                                                ; preds = %3, %0
  call void @l0_insert(%struct.L0** @main.list)
  br label %3

3:                                                ; preds = %2
  %4 = call i32 @__VERIFIER_nondet_int()
  %5 = icmp ne i32 %4, 0
  br i1 %5, label %2, label %6

6:                                                ; preds = %3
  %7 = load %struct.L0*, %struct.L0** @main.list, align 8
  call void @l0_destroy(%struct.L0* %7)
  %8 = load i32, i32* %1, align 4
  ret i32 %8
}

; Function Attrs: noinline nounwind uwtable
define internal void @l0_insert(%struct.L0** %0) #0 {
  %2 = alloca %struct.L0**, align 8
  %3 = alloca %struct.L0*, align 8
  store %struct.L0** %0, %struct.L0*** %2, align 8
  %4 = call i8* @zalloc_or_die(i32 24)
  %5 = bitcast i8* %4 to %struct.L0*
  store %struct.L0* %5, %struct.L0** %3, align 8
  br label %6

6:                                                ; preds = %9, %1
  %7 = load %struct.L0*, %struct.L0** %3, align 8
  %8 = getelementptr inbounds %struct.L0, %struct.L0* %7, i32 0, i32 2
  call void @l1_insert(%struct.L1** %8)
  br label %9

9:                                                ; preds = %6
  %10 = call i32 @__VERIFIER_nondet_int()
  %11 = icmp ne i32 %10, 0
  br i1 %11, label %6, label %12

12:                                               ; preds = %9
  %13 = load %struct.L0**, %struct.L0*** %2, align 8
  %14 = load %struct.L0*, %struct.L0** %3, align 8
  %15 = getelementptr inbounds %struct.L0, %struct.L0* %14, i32 0, i32 0
  store %struct.L0** %13, %struct.L0*** %15, align 8
  %16 = load %struct.L0**, %struct.L0*** %2, align 8
  %17 = load %struct.L0*, %struct.L0** %16, align 8
  %18 = load %struct.L0*, %struct.L0** %3, align 8
  %19 = getelementptr inbounds %struct.L0, %struct.L0* %18, i32 0, i32 1
  store %struct.L0* %17, %struct.L0** %19, align 8
  %20 = load %struct.L0*, %struct.L0** %3, align 8
  %21 = load %struct.L0**, %struct.L0*** %2, align 8
  store %struct.L0* %20, %struct.L0** %21, align 8
  ret void
}

declare dso_local i32 @__VERIFIER_nondet_int() #2

; Function Attrs: noinline nounwind uwtable
define internal void @l0_destroy(%struct.L0* %0) #0 {
  %2 = alloca %struct.L0*, align 8
  %3 = alloca %struct.L0*, align 8
  store %struct.L0* %0, %struct.L0** %2, align 8
  br label %4

4:                                                ; preds = %14, %1
  %5 = load %struct.L0*, %struct.L0** %2, align 8
  %6 = getelementptr inbounds %struct.L0, %struct.L0* %5, i32 0, i32 2
  %7 = load %struct.L1*, %struct.L1** %6, align 8
  call void @l1_destroy(%struct.L1* %7)
  %8 = load %struct.L0*, %struct.L0** %2, align 8
  %9 = getelementptr inbounds %struct.L0, %struct.L0* %8, i32 0, i32 1
  %10 = load %struct.L0*, %struct.L0** %9, align 8
  store %struct.L0* %10, %struct.L0** %3, align 8
  %11 = load %struct.L0*, %struct.L0** %2, align 8
  %12 = bitcast %struct.L0* %11 to i8*
  call void @free(i8* %12) #6
  %13 = load %struct.L0*, %struct.L0** %3, align 8
  store %struct.L0* %13, %struct.L0** %2, align 8
  br label %14

14:                                               ; preds = %4
  %15 = load %struct.L0*, %struct.L0** %2, align 8
  %16 = icmp ne %struct.L0* %15, null
  br i1 %16, label %4, label %17

17:                                               ; preds = %14
  ret void
}

; Function Attrs: noinline nounwind uwtable
define internal i8* @zalloc_or_die(i32 %0) #0 {
  %2 = alloca i32, align 4
  %3 = alloca i8*, align 8
  store i32 %0, i32* %2, align 4
  %4 = load i32, i32* %2, align 4
  %5 = zext i32 %4 to i64
  %6 = call i8* @calloc_model(i64 1, i64 %5)
  store i8* %6, i8** %3, align 8
  %7 = load i8*, i8** %3, align 8
  %8 = icmp ne i8* %7, null
  br i1 %8, label %9, label %11

9:                                                ; preds = %1
  %10 = load i8*, i8** %3, align 8
  ret i8* %10

11:                                               ; preds = %1
  call void @abort() #5
  unreachable
}

; Function Attrs: noinline nounwind uwtable
define internal void @l1_insert(%struct.L1** %0) #0 {
  %2 = alloca %struct.L1**, align 8
  %3 = alloca %struct.L1*, align 8
  store %struct.L1** %0, %struct.L1*** %2, align 8
  %4 = call i8* @zalloc_or_die(i32 24)
  %5 = bitcast i8* %4 to %struct.L1*
  store %struct.L1* %5, %struct.L1** %3, align 8
  br label %6

6:                                                ; preds = %9, %1
  %7 = load %struct.L1*, %struct.L1** %3, align 8
  %8 = getelementptr inbounds %struct.L1, %struct.L1* %7, i32 0, i32 0
  call void @l2_insert(%struct.L2** %8)
  br label %9

9:                                                ; preds = %6
  %10 = call i32 @__VERIFIER_nondet_int()
  %11 = icmp ne i32 %10, 0
  br i1 %11, label %6, label %12

12:                                               ; preds = %9
  %13 = load %struct.L1**, %struct.L1*** %2, align 8
  %14 = load %struct.L1*, %struct.L1** %3, align 8
  %15 = getelementptr inbounds %struct.L1, %struct.L1* %14, i32 0, i32 2
  store %struct.L1** %13, %struct.L1*** %15, align 8
  %16 = load %struct.L1**, %struct.L1*** %2, align 8
  %17 = load %struct.L1*, %struct.L1** %16, align 8
  %18 = load %struct.L1*, %struct.L1** %3, align 8
  %19 = getelementptr inbounds %struct.L1, %struct.L1* %18, i32 0, i32 1
  store %struct.L1* %17, %struct.L1** %19, align 8
  %20 = load %struct.L1*, %struct.L1** %3, align 8
  %21 = load %struct.L1**, %struct.L1*** %2, align 8
  store %struct.L1* %20, %struct.L1** %21, align 8
  ret void
}

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

; Function Attrs: nounwind
declare dso_local noalias i8* @malloc(i64) #3

; Function Attrs: argmemonly nounwind willreturn
declare void @llvm.memset.p0i8.i64(i8* nocapture writeonly, i8, i64, i1 immarg) #4

; Function Attrs: noinline nounwind uwtable
define internal void @l2_insert(%struct.L2** %0) #0 {
  %2 = alloca %struct.L2**, align 8
  %3 = alloca %struct.L2*, align 8
  store %struct.L2** %0, %struct.L2*** %2, align 8
  %4 = call i8* @zalloc_or_die(i32 24)
  %5 = bitcast i8* %4 to %struct.L2*
  store %struct.L2* %5, %struct.L2** %3, align 8
  br label %6

6:                                                ; preds = %9, %1
  %7 = load %struct.L2*, %struct.L2** %3, align 8
  %8 = getelementptr inbounds %struct.L2, %struct.L2* %7, i32 0, i32 2
  call void @l3_insert(%struct.L3** %8)
  br label %9

9:                                                ; preds = %6
  %10 = call i32 @__VERIFIER_nondet_int()
  %11 = icmp ne i32 %10, 0
  br i1 %11, label %6, label %12

12:                                               ; preds = %9
  %13 = load %struct.L2**, %struct.L2*** %2, align 8
  %14 = load %struct.L2*, %struct.L2** %3, align 8
  %15 = getelementptr inbounds %struct.L2, %struct.L2* %14, i32 0, i32 0
  store %struct.L2** %13, %struct.L2*** %15, align 8
  %16 = load %struct.L2**, %struct.L2*** %2, align 8
  %17 = load %struct.L2*, %struct.L2** %16, align 8
  %18 = load %struct.L2*, %struct.L2** %3, align 8
  %19 = getelementptr inbounds %struct.L2, %struct.L2* %18, i32 0, i32 1
  store %struct.L2* %17, %struct.L2** %19, align 8
  %20 = load %struct.L2*, %struct.L2** %3, align 8
  %21 = load %struct.L2**, %struct.L2*** %2, align 8
  store %struct.L2* %20, %struct.L2** %21, align 8
  ret void
}

; Function Attrs: noinline nounwind uwtable
define internal void @l3_insert(%struct.L3** %0) #0 {
  %2 = alloca %struct.L3**, align 8
  %3 = alloca %struct.L3*, align 8
  store %struct.L3** %0, %struct.L3*** %2, align 8
  %4 = call i8* @zalloc_or_die(i32 24)
  %5 = bitcast i8* %4 to %struct.L3*
  store %struct.L3* %5, %struct.L3** %3, align 8
  br label %6

6:                                                ; preds = %9, %1
  %7 = load %struct.L3*, %struct.L3** %3, align 8
  %8 = getelementptr inbounds %struct.L3, %struct.L3* %7, i32 0, i32 0
  call void @l4_insert(%struct.L4** %8)
  br label %9

9:                                                ; preds = %6
  %10 = call i32 @__VERIFIER_nondet_int()
  %11 = icmp ne i32 %10, 0
  br i1 %11, label %6, label %12

12:                                               ; preds = %9
  %13 = load %struct.L3**, %struct.L3*** %2, align 8
  %14 = load %struct.L3*, %struct.L3** %3, align 8
  %15 = getelementptr inbounds %struct.L3, %struct.L3* %14, i32 0, i32 2
  store %struct.L3** %13, %struct.L3*** %15, align 8
  %16 = load %struct.L3**, %struct.L3*** %2, align 8
  %17 = load %struct.L3*, %struct.L3** %16, align 8
  %18 = load %struct.L3*, %struct.L3** %3, align 8
  %19 = getelementptr inbounds %struct.L3, %struct.L3* %18, i32 0, i32 1
  store %struct.L3* %17, %struct.L3** %19, align 8
  %20 = load %struct.L3*, %struct.L3** %3, align 8
  %21 = load %struct.L3**, %struct.L3*** %2, align 8
  store %struct.L3* %20, %struct.L3** %21, align 8
  ret void
}

; Function Attrs: noinline nounwind uwtable
define internal void @l4_insert(%struct.L4** %0) #0 {
  %2 = alloca %struct.L4**, align 8
  %3 = alloca %struct.L4*, align 8
  store %struct.L4** %0, %struct.L4*** %2, align 8
  %4 = call i8* @zalloc_or_die(i32 24)
  %5 = bitcast i8* %4 to %struct.L4*
  store %struct.L4* %5, %struct.L4** %3, align 8
  %6 = call i8* @zalloc_or_die(i32 119)
  %7 = bitcast i8* %6 to %struct.L5*
  %8 = load %struct.L4*, %struct.L4** %3, align 8
  %9 = getelementptr inbounds %struct.L4, %struct.L4* %8, i32 0, i32 2
  store %struct.L5* %7, %struct.L5** %9, align 8
  %10 = load %struct.L4*, %struct.L4** %3, align 8
  %11 = bitcast %struct.L4* %10 to i8*
  %12 = load %struct.L4*, %struct.L4** %3, align 8
  %13 = getelementptr inbounds %struct.L4, %struct.L4* %12, i32 0, i32 2
  %14 = load %struct.L5*, %struct.L5** %13, align 8
  %15 = bitcast %struct.L5* %14 to i8**
  store i8* %11, i8** %15, align 8
  %16 = load %struct.L4**, %struct.L4*** %2, align 8
  %17 = load %struct.L4*, %struct.L4** %3, align 8
  %18 = getelementptr inbounds %struct.L4, %struct.L4* %17, i32 0, i32 0
  store %struct.L4** %16, %struct.L4*** %18, align 8
  %19 = load %struct.L4**, %struct.L4*** %2, align 8
  %20 = load %struct.L4*, %struct.L4** %19, align 8
  %21 = load %struct.L4*, %struct.L4** %3, align 8
  %22 = getelementptr inbounds %struct.L4, %struct.L4* %21, i32 0, i32 1
  store %struct.L4* %20, %struct.L4** %22, align 8
  %23 = load %struct.L4*, %struct.L4** %3, align 8
  %24 = load %struct.L4**, %struct.L4*** %2, align 8
  store %struct.L4* %23, %struct.L4** %24, align 8
  ret void
}

; Function Attrs: noinline nounwind uwtable
define internal void @l1_destroy(%struct.L1* %0) #0 {
  %2 = alloca %struct.L1*, align 8
  %3 = alloca %struct.L1*, align 8
  store %struct.L1* %0, %struct.L1** %2, align 8
  br label %4

4:                                                ; preds = %14, %1
  %5 = load %struct.L1*, %struct.L1** %2, align 8
  %6 = getelementptr inbounds %struct.L1, %struct.L1* %5, i32 0, i32 0
  %7 = load %struct.L2*, %struct.L2** %6, align 8
  call void @l2_destroy(%struct.L2* %7)
  %8 = load %struct.L1*, %struct.L1** %2, align 8
  %9 = getelementptr inbounds %struct.L1, %struct.L1* %8, i32 0, i32 1
  %10 = load %struct.L1*, %struct.L1** %9, align 8
  store %struct.L1* %10, %struct.L1** %3, align 8
  %11 = load %struct.L1*, %struct.L1** %2, align 8
  %12 = bitcast %struct.L1* %11 to i8*
  call void @free(i8* %12) #6
  %13 = load %struct.L1*, %struct.L1** %3, align 8
  store %struct.L1* %13, %struct.L1** %2, align 8
  br label %14

14:                                               ; preds = %4
  %15 = load %struct.L1*, %struct.L1** %2, align 8
  %16 = icmp ne %struct.L1* %15, null
  br i1 %16, label %4, label %17

17:                                               ; preds = %14
  ret void
}

; Function Attrs: nounwind
declare dso_local void @free(i8*) #3

; Function Attrs: noinline nounwind uwtable
define internal void @l2_destroy(%struct.L2* %0) #0 {
  %2 = alloca %struct.L2*, align 8
  %3 = alloca %struct.L2*, align 8
  store %struct.L2* %0, %struct.L2** %2, align 8
  br label %4

4:                                                ; preds = %14, %1
  %5 = load %struct.L2*, %struct.L2** %2, align 8
  %6 = getelementptr inbounds %struct.L2, %struct.L2* %5, i32 0, i32 2
  %7 = load %struct.L3*, %struct.L3** %6, align 8
  call void @l3_destroy(%struct.L3* %7)
  %8 = load %struct.L2*, %struct.L2** %2, align 8
  %9 = getelementptr inbounds %struct.L2, %struct.L2* %8, i32 0, i32 1
  %10 = load %struct.L2*, %struct.L2** %9, align 8
  store %struct.L2* %10, %struct.L2** %3, align 8
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

; Function Attrs: noinline nounwind uwtable
define internal void @l3_destroy(%struct.L3* %0) #0 {
  %2 = alloca %struct.L3*, align 8
  %3 = alloca %struct.L3*, align 8
  store %struct.L3* %0, %struct.L3** %2, align 8
  br label %4

4:                                                ; preds = %14, %1
  %5 = load %struct.L3*, %struct.L3** %2, align 8
  %6 = getelementptr inbounds %struct.L3, %struct.L3* %5, i32 0, i32 0
  %7 = load %struct.L4*, %struct.L4** %6, align 8
  call void @l4_destroy(%struct.L4* %7)
  %8 = load %struct.L3*, %struct.L3** %2, align 8
  %9 = getelementptr inbounds %struct.L3, %struct.L3* %8, i32 0, i32 1
  %10 = load %struct.L3*, %struct.L3** %9, align 8
  store %struct.L3* %10, %struct.L3** %3, align 8
  %11 = load %struct.L3*, %struct.L3** %2, align 8
  %12 = bitcast %struct.L3* %11 to i8*
  call void @free(i8* %12) #6
  %13 = load %struct.L3*, %struct.L3** %3, align 8
  store %struct.L3* %13, %struct.L3** %2, align 8
  br label %14

14:                                               ; preds = %4
  %15 = load %struct.L3*, %struct.L3** %2, align 8
  %16 = icmp ne %struct.L3* %15, null
  br i1 %16, label %4, label %17

17:                                               ; preds = %14
  ret void
}

; Function Attrs: noinline nounwind uwtable
define internal void @l4_destroy(%struct.L4* %0) #0 {
  %2 = alloca %struct.L4*, align 8
  %3 = alloca %struct.L4*, align 8
  store %struct.L4* %0, %struct.L4** %2, align 8
  br label %4

4:                                                ; preds = %15, %1
  %5 = load %struct.L4*, %struct.L4** %2, align 8
  %6 = getelementptr inbounds %struct.L4, %struct.L4* %5, i32 0, i32 2
  %7 = load %struct.L5*, %struct.L5** %6, align 8
  %8 = bitcast %struct.L5* %7 to i8*
  call void @free(i8* %8) #6
  %9 = load %struct.L4*, %struct.L4** %2, align 8
  %10 = getelementptr inbounds %struct.L4, %struct.L4* %9, i32 0, i32 1
  %11 = load %struct.L4*, %struct.L4** %10, align 8
  store %struct.L4* %11, %struct.L4** %3, align 8
  %12 = load %struct.L4*, %struct.L4** %2, align 8
  %13 = bitcast %struct.L4* %12 to i8*
  call void @free(i8* %13) #6
  %14 = load %struct.L4*, %struct.L4** %3, align 8
  store %struct.L4* %14, %struct.L4** %2, align 8
  br label %15

15:                                               ; preds = %4
  %16 = load %struct.L4*, %struct.L4** %2, align 8
  %17 = icmp ne %struct.L4* %16, null
  br i1 %17, label %4, label %18

18:                                               ; preds = %15
  ret void
}

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
