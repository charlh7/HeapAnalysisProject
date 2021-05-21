; ModuleID = '/home/curt/HeapDataFlow/benchmarkResults/memsafety/test-0137.bc'
source_filename = "/home/curt/HeapDataFlow/sv-benchmarks/c/memsafety/test-0137.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.list_head = type { %struct.list_head*, %struct.list_head* }
%struct.node = type { i32, %struct.list_head }

@.str = private unnamed_addr constant [2 x i8] c"0\00", align 1
@.str.1 = private unnamed_addr constant [62 x i8] c"/home/curt/HeapDataFlow/sv-benchmarks/c/memsafety/test-0137.c\00", align 1
@__PRETTY_FUNCTION__.reach_error = private unnamed_addr constant [19 x i8] c"void reach_error()\00", align 1
@gl_list = dso_local global %struct.list_head { %struct.list_head* @gl_list, %struct.list_head* @gl_list }, align 8

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
  call void @gl_read()
  call void @gl_sort()
  call void @gl_destroy()
  ret i32 0
}

; Function Attrs: noinline nounwind uwtable
define internal void @gl_read() #0 {
  br label %1

1:                                                ; preds = %3, %0
  %2 = call i32 @__VERIFIER_nondet_int()
  call void @gl_insert(i32 %2)
  br label %3

3:                                                ; preds = %1
  %4 = call i32 @__VERIFIER_nondet_int()
  %5 = icmp ne i32 %4, 0
  br i1 %5, label %1, label %6

6:                                                ; preds = %3
  ret void
}

; Function Attrs: noinline nounwind uwtable
define internal void @gl_insert(i32 %0) #0 {
  %2 = alloca i32, align 4
  %3 = alloca %struct.node*, align 8
  store i32 %0, i32* %2, align 4
  %4 = call noalias i8* @malloc(i64 24) #6
  %5 = bitcast i8* %4 to %struct.node*
  store %struct.node* %5, %struct.node** %3, align 8
  %6 = load %struct.node*, %struct.node** %3, align 8
  %7 = icmp ne %struct.node* %6, null
  br i1 %7, label %9, label %8

8:                                                ; preds = %1
  call void @abort() #5
  unreachable

9:                                                ; preds = %1
  %10 = load i32, i32* %2, align 4
  %11 = load %struct.node*, %struct.node** %3, align 8
  %12 = getelementptr inbounds %struct.node, %struct.node* %11, i32 0, i32 0
  store i32 %10, i32* %12, align 8
  %13 = load %struct.node*, %struct.node** %3, align 8
  %14 = getelementptr inbounds %struct.node, %struct.node* %13, i32 0, i32 1
  call void @list_add(%struct.list_head* %14, %struct.list_head* @gl_list)
  ret void
}

declare dso_local i32 @__VERIFIER_nondet_int() #2

; Function Attrs: nounwind
declare dso_local noalias i8* @malloc(i64) #3

; Function Attrs: noreturn nounwind
declare dso_local void @abort() #1

; Function Attrs: noinline nounwind uwtable
define internal void @list_add(%struct.list_head* %0, %struct.list_head* %1) #0 {
  %3 = alloca %struct.list_head*, align 8
  %4 = alloca %struct.list_head*, align 8
  store %struct.list_head* %0, %struct.list_head** %3, align 8
  store %struct.list_head* %1, %struct.list_head** %4, align 8
  %5 = load %struct.list_head*, %struct.list_head** %3, align 8
  %6 = load %struct.list_head*, %struct.list_head** %4, align 8
  %7 = load %struct.list_head*, %struct.list_head** %4, align 8
  %8 = getelementptr inbounds %struct.list_head, %struct.list_head* %7, i32 0, i32 0
  %9 = load %struct.list_head*, %struct.list_head** %8, align 8
  call void @__list_add(%struct.list_head* %5, %struct.list_head* %6, %struct.list_head* %9)
  ret void
}

; Function Attrs: noinline nounwind uwtable
define internal void @__list_add(%struct.list_head* %0, %struct.list_head* %1, %struct.list_head* %2) #0 {
  %4 = alloca %struct.list_head*, align 8
  %5 = alloca %struct.list_head*, align 8
  %6 = alloca %struct.list_head*, align 8
  store %struct.list_head* %0, %struct.list_head** %4, align 8
  store %struct.list_head* %1, %struct.list_head** %5, align 8
  store %struct.list_head* %2, %struct.list_head** %6, align 8
  %7 = load %struct.list_head*, %struct.list_head** %4, align 8
  %8 = load %struct.list_head*, %struct.list_head** %6, align 8
  %9 = getelementptr inbounds %struct.list_head, %struct.list_head* %8, i32 0, i32 1
  store %struct.list_head* %7, %struct.list_head** %9, align 8
  %10 = load %struct.list_head*, %struct.list_head** %6, align 8
  %11 = load %struct.list_head*, %struct.list_head** %4, align 8
  %12 = getelementptr inbounds %struct.list_head, %struct.list_head* %11, i32 0, i32 0
  store %struct.list_head* %10, %struct.list_head** %12, align 8
  %13 = load %struct.list_head*, %struct.list_head** %5, align 8
  %14 = load %struct.list_head*, %struct.list_head** %4, align 8
  %15 = getelementptr inbounds %struct.list_head, %struct.list_head* %14, i32 0, i32 1
  store %struct.list_head* %13, %struct.list_head** %15, align 8
  %16 = load %struct.list_head*, %struct.list_head** %4, align 8
  %17 = load %struct.list_head*, %struct.list_head** %5, align 8
  %18 = getelementptr inbounds %struct.list_head, %struct.list_head* %17, i32 0, i32 0
  store %struct.list_head* %16, %struct.list_head** %18, align 8
  ret void
}

; Function Attrs: noinline nounwind uwtable
define internal void @gl_sort() #0 {
  %1 = alloca %struct.list_head, align 8
  %2 = alloca %struct.list_head*, align 8
  %3 = call i32 @list_empty(%struct.list_head* @gl_list)
  %4 = icmp ne i32 %3, 0
  br i1 %4, label %5, label %6

5:                                                ; preds = %0
  br label %22

6:                                                ; preds = %0
  %7 = getelementptr inbounds %struct.list_head, %struct.list_head* %1, i32 0, i32 0
  store %struct.list_head* %1, %struct.list_head** %7, align 8
  %8 = getelementptr inbounds %struct.list_head, %struct.list_head* %1, i32 0, i32 1
  store %struct.list_head* %1, %struct.list_head** %8, align 8
  br label %9

9:                                                ; preds = %12, %6
  %10 = call %struct.list_head* @gl_seek_max()
  store %struct.list_head* %10, %struct.list_head** %2, align 8
  %11 = icmp ne %struct.list_head* %10, null
  br i1 %11, label %12, label %14

12:                                               ; preds = %9
  %13 = load %struct.list_head*, %struct.list_head** %2, align 8
  call void @list_move(%struct.list_head* %13, %struct.list_head* %1)
  br label %9

14:                                               ; preds = %9
  %15 = getelementptr inbounds %struct.list_head, %struct.list_head* %1, i32 0, i32 0
  %16 = load %struct.list_head*, %struct.list_head** %15, align 8
  %17 = getelementptr inbounds %struct.list_head, %struct.list_head* %16, i32 0, i32 1
  store %struct.list_head* @gl_list, %struct.list_head** %17, align 8
  %18 = getelementptr inbounds %struct.list_head, %struct.list_head* %1, i32 0, i32 1
  %19 = load %struct.list_head*, %struct.list_head** %18, align 8
  %20 = getelementptr inbounds %struct.list_head, %struct.list_head* %19, i32 0, i32 0
  store %struct.list_head* @gl_list, %struct.list_head** %20, align 8
  %21 = bitcast %struct.list_head* %1 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 8 bitcast (%struct.list_head* @gl_list to i8*), i8* align 8 %21, i64 16, i1 false)
  br label %22

22:                                               ; preds = %14, %5
  ret void
}

; Function Attrs: noinline nounwind uwtable
define internal i32 @list_empty(%struct.list_head* %0) #0 {
  %2 = alloca %struct.list_head*, align 8
  store %struct.list_head* %0, %struct.list_head** %2, align 8
  %3 = load %struct.list_head*, %struct.list_head** %2, align 8
  %4 = getelementptr inbounds %struct.list_head, %struct.list_head* %3, i32 0, i32 0
  %5 = load %struct.list_head*, %struct.list_head** %4, align 8
  %6 = load %struct.list_head*, %struct.list_head** %2, align 8
  %7 = icmp eq %struct.list_head* %5, %6
  %8 = zext i1 %7 to i32
  ret i32 %8
}

; Function Attrs: noinline nounwind uwtable
define internal void @list_move(%struct.list_head* %0, %struct.list_head* %1) #0 {
  %3 = alloca %struct.list_head*, align 8
  %4 = alloca %struct.list_head*, align 8
  store %struct.list_head* %0, %struct.list_head** %3, align 8
  store %struct.list_head* %1, %struct.list_head** %4, align 8
  %5 = load %struct.list_head*, %struct.list_head** %3, align 8
  %6 = getelementptr inbounds %struct.list_head, %struct.list_head* %5, i32 0, i32 1
  %7 = load %struct.list_head*, %struct.list_head** %6, align 8
  %8 = load %struct.list_head*, %struct.list_head** %3, align 8
  %9 = getelementptr inbounds %struct.list_head, %struct.list_head* %8, i32 0, i32 0
  %10 = load %struct.list_head*, %struct.list_head** %9, align 8
  call void @__list_del(%struct.list_head* %7, %struct.list_head* %10)
  %11 = load %struct.list_head*, %struct.list_head** %3, align 8
  %12 = load %struct.list_head*, %struct.list_head** %4, align 8
  call void @list_add(%struct.list_head* %11, %struct.list_head* %12)
  ret void
}

; Function Attrs: argmemonly nounwind willreturn
declare void @llvm.memcpy.p0i8.p0i8.i64(i8* noalias nocapture writeonly, i8* noalias nocapture readonly, i64, i1 immarg) #4

; Function Attrs: noinline nounwind uwtable
define internal %struct.list_head* @gl_seek_max() #0 {
  %1 = alloca %struct.list_head*, align 8
  %2 = alloca %struct.list_head*, align 8
  %3 = alloca %struct.list_head*, align 8
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  store %struct.list_head* null, %struct.list_head** %3, align 8
  %6 = call i32 @list_empty(%struct.list_head* @gl_list)
  %7 = icmp ne i32 %6, 0
  br i1 %7, label %8, label %9

8:                                                ; preds = %0
  store %struct.list_head* null, %struct.list_head** %1, align 8
  br label %37

9:                                                ; preds = %0
  %10 = load %struct.list_head*, %struct.list_head** getelementptr inbounds (%struct.list_head, %struct.list_head* @gl_list, i32 0, i32 0), align 8
  store %struct.list_head* %10, %struct.list_head** %3, align 8
  %11 = load %struct.list_head*, %struct.list_head** %3, align 8
  %12 = call i32 @val_from_node(%struct.list_head* %11)
  store i32 %12, i32* %4, align 4
  br label %13

13:                                               ; preds = %9
  %14 = load %struct.list_head*, %struct.list_head** %3, align 8
  %15 = getelementptr inbounds %struct.list_head, %struct.list_head* %14, i32 0, i32 0
  %16 = load %struct.list_head*, %struct.list_head** %15, align 8
  store %struct.list_head* %16, %struct.list_head** %2, align 8
  br label %17

17:                                               ; preds = %31, %13
  %18 = load %struct.list_head*, %struct.list_head** %2, align 8
  %19 = load %struct.list_head*, %struct.list_head** %3, align 8
  %20 = icmp ne %struct.list_head* %18, %19
  br i1 %20, label %21, label %35

21:                                               ; preds = %17
  %22 = load %struct.list_head*, %struct.list_head** %2, align 8
  %23 = call i32 @val_from_node(%struct.list_head* %22)
  store i32 %23, i32* %5, align 4
  %24 = load i32, i32* %5, align 4
  %25 = load i32, i32* %4, align 4
  %26 = icmp slt i32 %24, %25
  br i1 %26, label %27, label %28

27:                                               ; preds = %21
  br label %31

28:                                               ; preds = %21
  %29 = load %struct.list_head*, %struct.list_head** %2, align 8
  store %struct.list_head* %29, %struct.list_head** %3, align 8
  %30 = load i32, i32* %5, align 4
  store i32 %30, i32* %4, align 4
  br label %31

31:                                               ; preds = %28, %27
  %32 = load %struct.list_head*, %struct.list_head** %2, align 8
  %33 = getelementptr inbounds %struct.list_head, %struct.list_head* %32, i32 0, i32 0
  %34 = load %struct.list_head*, %struct.list_head** %33, align 8
  store %struct.list_head* %34, %struct.list_head** %2, align 8
  br label %17

35:                                               ; preds = %17
  %36 = load %struct.list_head*, %struct.list_head** %3, align 8
  store %struct.list_head* %36, %struct.list_head** %1, align 8
  br label %37

37:                                               ; preds = %35, %8
  %38 = load %struct.list_head*, %struct.list_head** %1, align 8
  ret %struct.list_head* %38
}

; Function Attrs: noinline nounwind uwtable
define internal i32 @val_from_node(%struct.list_head* %0) #0 {
  %2 = alloca %struct.list_head*, align 8
  %3 = alloca %struct.node*, align 8
  store %struct.list_head* %0, %struct.list_head** %2, align 8
  %4 = load %struct.list_head*, %struct.list_head** %2, align 8
  %5 = bitcast %struct.list_head* %4 to i8*
  %6 = getelementptr inbounds i8, i8* %5, i64 sub (i64 0, i64 ptrtoint (%struct.list_head* getelementptr inbounds (%struct.node, %struct.node* null, i32 0, i32 1) to i64))
  %7 = bitcast i8* %6 to %struct.node*
  store %struct.node* %7, %struct.node** %3, align 8
  %8 = load %struct.node*, %struct.node** %3, align 8
  %9 = getelementptr inbounds %struct.node, %struct.node* %8, i32 0, i32 0
  %10 = load i32, i32* %9, align 8
  ret i32 %10
}

; Function Attrs: noinline nounwind uwtable
define internal void @__list_del(%struct.list_head* %0, %struct.list_head* %1) #0 {
  %3 = alloca %struct.list_head*, align 8
  %4 = alloca %struct.list_head*, align 8
  store %struct.list_head* %0, %struct.list_head** %3, align 8
  store %struct.list_head* %1, %struct.list_head** %4, align 8
  %5 = load %struct.list_head*, %struct.list_head** %3, align 8
  %6 = load %struct.list_head*, %struct.list_head** %4, align 8
  %7 = getelementptr inbounds %struct.list_head, %struct.list_head* %6, i32 0, i32 1
  store %struct.list_head* %5, %struct.list_head** %7, align 8
  %8 = load %struct.list_head*, %struct.list_head** %4, align 8
  %9 = load %struct.list_head*, %struct.list_head** %3, align 8
  %10 = getelementptr inbounds %struct.list_head, %struct.list_head* %9, i32 0, i32 0
  store %struct.list_head* %8, %struct.list_head** %10, align 8
  ret void
}

; Function Attrs: noinline nounwind uwtable
define internal void @gl_destroy() #0 {
  %1 = alloca %struct.list_head*, align 8
  br label %2

2:                                                ; preds = %5, %0
  %3 = load %struct.list_head*, %struct.list_head** getelementptr inbounds (%struct.list_head, %struct.list_head* @gl_list, i32 0, i32 0), align 8
  store %struct.list_head* %3, %struct.list_head** %1, align 8
  %4 = icmp ne %struct.list_head* @gl_list, %3
  br i1 %4, label %5, label %14

5:                                                ; preds = %2
  %6 = load %struct.list_head*, %struct.list_head** %1, align 8
  %7 = getelementptr inbounds %struct.list_head, %struct.list_head* %6, i32 0, i32 0
  %8 = load %struct.list_head*, %struct.list_head** %7, align 8
  store %struct.list_head* %8, %struct.list_head** getelementptr inbounds (%struct.list_head, %struct.list_head* @gl_list, i32 0, i32 0), align 8
  %9 = load %struct.list_head*, %struct.list_head** %1, align 8
  %10 = bitcast %struct.list_head* %9 to i8*
  %11 = getelementptr inbounds i8, i8* %10, i64 sub (i64 0, i64 ptrtoint (%struct.list_head* getelementptr inbounds (%struct.node, %struct.node* null, i32 0, i32 1) to i64))
  %12 = bitcast i8* %11 to %struct.node*
  %13 = bitcast %struct.node* %12 to i8*
  call void @free(i8* %13) #6
  br label %2

14:                                               ; preds = %2
  ret void
}

; Function Attrs: nounwind
declare dso_local void @free(i8*) #3

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
