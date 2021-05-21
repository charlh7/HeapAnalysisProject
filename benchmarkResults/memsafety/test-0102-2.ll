; ModuleID = '/home/curt/HeapDataFlow/benchmarkResults/memsafety/test-0102-2.bc'
source_filename = "/home/curt/HeapDataFlow/sv-benchmarks/c/memsafety/test-0102-2.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.list_head = type { %struct.list_head*, %struct.list_head* }
%struct.sub_list = type { i32, %struct.list_head }
%struct.top_list = type { %struct.list_head, %struct.list_head, %struct.list_head }

@.str = private unnamed_addr constant [2 x i8] c"0\00", align 1
@.str.1 = private unnamed_addr constant [64 x i8] c"/home/curt/HeapDataFlow/sv-benchmarks/c/memsafety/test-0102-2.c\00", align 1
@__PRETTY_FUNCTION__.reach_error = private unnamed_addr constant [19 x i8] c"void reach_error()\00", align 1

; Function Attrs: noinline nounwind uwtable
define dso_local void @reach_error() #0 {
  call void @__assert_fail(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str, i64 0, i64 0), i8* getelementptr inbounds ([64 x i8], [64 x i8]* @.str.1, i64 0, i64 0), i32 3, i8* getelementptr inbounds ([19 x i8], [19 x i8]* @__PRETTY_FUNCTION__.reach_error, i64 0, i64 0)) #4
  unreachable
}

; Function Attrs: noreturn nounwind
declare dso_local void @__assert_fail(i8*, i8*, i32, i8*) #1

; Function Attrs: noinline nounwind uwtable
define dso_local void @destroy_sub(%struct.list_head* %0) #0 {
  %2 = alloca %struct.list_head*, align 8
  %3 = alloca %struct.sub_list*, align 8
  %4 = alloca %struct.sub_list*, align 8
  store %struct.list_head* %0, %struct.list_head** %2, align 8
  %5 = load %struct.list_head*, %struct.list_head** %2, align 8
  %6 = getelementptr inbounds %struct.list_head, %struct.list_head* %5, i32 0, i32 0
  %7 = load %struct.list_head*, %struct.list_head** %6, align 8
  %8 = bitcast %struct.list_head* %7 to i8*
  %9 = getelementptr inbounds i8, i8* %8, i64 sub (i64 0, i64 ptrtoint (%struct.list_head* getelementptr inbounds (%struct.sub_list, %struct.sub_list* null, i32 0, i32 1) to i64))
  %10 = bitcast i8* %9 to %struct.sub_list*
  store %struct.sub_list* %10, %struct.sub_list** %3, align 8
  br label %11

11:                                               ; preds = %16, %1
  %12 = load %struct.sub_list*, %struct.sub_list** %3, align 8
  %13 = getelementptr inbounds %struct.sub_list, %struct.sub_list* %12, i32 0, i32 1
  %14 = load %struct.list_head*, %struct.list_head** %2, align 8
  %15 = icmp ne %struct.list_head* %13, %14
  br i1 %15, label %16, label %27

16:                                               ; preds = %11
  %17 = load %struct.sub_list*, %struct.sub_list** %3, align 8
  %18 = getelementptr inbounds %struct.sub_list, %struct.sub_list* %17, i32 0, i32 1
  %19 = getelementptr inbounds %struct.list_head, %struct.list_head* %18, i32 0, i32 0
  %20 = load %struct.list_head*, %struct.list_head** %19, align 8
  %21 = bitcast %struct.list_head* %20 to i8*
  %22 = getelementptr inbounds i8, i8* %21, i64 sub (i64 0, i64 ptrtoint (%struct.list_head* getelementptr inbounds (%struct.sub_list, %struct.sub_list* null, i32 0, i32 1) to i64))
  %23 = bitcast i8* %22 to %struct.sub_list*
  store %struct.sub_list* %23, %struct.sub_list** %4, align 8
  %24 = load %struct.sub_list*, %struct.sub_list** %3, align 8
  %25 = bitcast %struct.sub_list* %24 to i8*
  call void @free(i8* %25) #5
  %26 = load %struct.sub_list*, %struct.sub_list** %4, align 8
  store %struct.sub_list* %26, %struct.sub_list** %3, align 8
  br label %11

27:                                               ; preds = %11
  ret void
}

; Function Attrs: nounwind
declare dso_local void @free(i8*) #2

; Function Attrs: noinline nounwind uwtable
define dso_local void @destroy_top(%struct.list_head* %0) #0 {
  %2 = alloca %struct.list_head*, align 8
  %3 = alloca %struct.top_list*, align 8
  %4 = alloca %struct.top_list*, align 8
  store %struct.list_head* %0, %struct.list_head** %2, align 8
  %5 = load %struct.list_head*, %struct.list_head** %2, align 8
  %6 = getelementptr inbounds %struct.list_head, %struct.list_head* %5, i32 0, i32 0
  %7 = load %struct.list_head*, %struct.list_head** %6, align 8
  %8 = bitcast %struct.list_head* %7 to i8*
  %9 = getelementptr inbounds i8, i8* %8, i64 0
  %10 = bitcast i8* %9 to %struct.top_list*
  store %struct.top_list* %10, %struct.top_list** %3, align 8
  br label %11

11:                                               ; preds = %16, %1
  %12 = load %struct.top_list*, %struct.top_list** %3, align 8
  %13 = getelementptr inbounds %struct.top_list, %struct.top_list* %12, i32 0, i32 0
  %14 = load %struct.list_head*, %struct.list_head** %2, align 8
  %15 = icmp ne %struct.list_head* %13, %14
  br i1 %15, label %16, label %29

16:                                               ; preds = %11
  %17 = load %struct.top_list*, %struct.top_list** %3, align 8
  %18 = getelementptr inbounds %struct.top_list, %struct.top_list* %17, i32 0, i32 0
  %19 = getelementptr inbounds %struct.list_head, %struct.list_head* %18, i32 0, i32 0
  %20 = load %struct.list_head*, %struct.list_head** %19, align 8
  %21 = bitcast %struct.list_head* %20 to i8*
  %22 = getelementptr inbounds i8, i8* %21, i64 0
  %23 = bitcast i8* %22 to %struct.top_list*
  store %struct.top_list* %23, %struct.top_list** %4, align 8
  %24 = load %struct.top_list*, %struct.top_list** %3, align 8
  %25 = getelementptr inbounds %struct.top_list, %struct.top_list* %24, i32 0, i32 1
  call void @destroy_sub(%struct.list_head* %25)
  %26 = load %struct.top_list*, %struct.top_list** %3, align 8
  %27 = bitcast %struct.top_list* %26 to i8*
  call void @free(i8* %27) #5
  %28 = load %struct.top_list*, %struct.top_list** %4, align 8
  store %struct.top_list* %28, %struct.top_list** %3, align 8
  br label %11

29:                                               ; preds = %11
  ret void
}

; Function Attrs: noinline nounwind uwtable
define dso_local void @insert_sub(%struct.list_head* %0) #0 {
  %2 = alloca %struct.list_head*, align 8
  %3 = alloca %struct.sub_list*, align 8
  store %struct.list_head* %0, %struct.list_head** %2, align 8
  %4 = call noalias i8* @malloc(i64 24) #5
  %5 = bitcast i8* %4 to %struct.sub_list*
  store %struct.sub_list* %5, %struct.sub_list** %3, align 8
  %6 = load %struct.sub_list*, %struct.sub_list** %3, align 8
  %7 = icmp ne %struct.sub_list* %6, null
  br i1 %7, label %9, label %8

8:                                                ; preds = %1
  call void @abort() #4
  unreachable

9:                                                ; preds = %1
  %10 = load %struct.sub_list*, %struct.sub_list** %3, align 8
  %11 = getelementptr inbounds %struct.sub_list, %struct.sub_list* %10, i32 0, i32 0
  store i32 0, i32* %11, align 8
  %12 = load %struct.sub_list*, %struct.sub_list** %3, align 8
  %13 = getelementptr inbounds %struct.sub_list, %struct.sub_list* %12, i32 0, i32 1
  %14 = load %struct.list_head*, %struct.list_head** %2, align 8
  call void @list_add_tail(%struct.list_head* %13, %struct.list_head* %14)
  ret void
}

; Function Attrs: nounwind
declare dso_local noalias i8* @malloc(i64) #2

; Function Attrs: noreturn nounwind
declare dso_local void @abort() #1

; Function Attrs: noinline nounwind uwtable
define internal void @list_add_tail(%struct.list_head* %0, %struct.list_head* %1) #0 {
  %3 = alloca %struct.list_head*, align 8
  %4 = alloca %struct.list_head*, align 8
  store %struct.list_head* %0, %struct.list_head** %3, align 8
  store %struct.list_head* %1, %struct.list_head** %4, align 8
  %5 = load %struct.list_head*, %struct.list_head** %3, align 8
  %6 = load %struct.list_head*, %struct.list_head** %4, align 8
  %7 = getelementptr inbounds %struct.list_head, %struct.list_head* %6, i32 0, i32 1
  %8 = load %struct.list_head*, %struct.list_head** %7, align 8
  %9 = load %struct.list_head*, %struct.list_head** %4, align 8
  call void @__list_add(%struct.list_head* %5, %struct.list_head* %8, %struct.list_head* %9)
  ret void
}

; Function Attrs: noinline nounwind uwtable
define dso_local void @create_sub_list(%struct.list_head* %0) #0 {
  %2 = alloca %struct.list_head*, align 8
  store %struct.list_head* %0, %struct.list_head** %2, align 8
  %3 = load %struct.list_head*, %struct.list_head** %2, align 8
  %4 = load %struct.list_head*, %struct.list_head** %2, align 8
  %5 = getelementptr inbounds %struct.list_head, %struct.list_head* %4, i32 0, i32 1
  store %struct.list_head* %3, %struct.list_head** %5, align 8
  %6 = load %struct.list_head*, %struct.list_head** %2, align 8
  %7 = load %struct.list_head*, %struct.list_head** %2, align 8
  %8 = getelementptr inbounds %struct.list_head, %struct.list_head* %7, i32 0, i32 0
  store %struct.list_head* %6, %struct.list_head** %8, align 8
  br label %9

9:                                                ; preds = %11, %1
  %10 = load %struct.list_head*, %struct.list_head** %2, align 8
  call void @insert_sub(%struct.list_head* %10)
  br label %11

11:                                               ; preds = %9
  %12 = call i32 @__VERIFIER_nondet_int()
  %13 = icmp ne i32 %12, 0
  br i1 %13, label %9, label %14

14:                                               ; preds = %11
  ret void
}

declare dso_local i32 @__VERIFIER_nondet_int() #3

; Function Attrs: noinline nounwind uwtable
define dso_local void @insert_top(%struct.list_head* %0) #0 {
  %2 = alloca %struct.list_head*, align 8
  %3 = alloca %struct.top_list*, align 8
  store %struct.list_head* %0, %struct.list_head** %2, align 8
  %4 = call noalias i8* @malloc(i64 48) #5
  %5 = bitcast i8* %4 to %struct.top_list*
  store %struct.top_list* %5, %struct.top_list** %3, align 8
  %6 = load %struct.top_list*, %struct.top_list** %3, align 8
  %7 = icmp ne %struct.top_list* %6, null
  br i1 %7, label %9, label %8

8:                                                ; preds = %1
  call void @abort() #4
  unreachable

9:                                                ; preds = %1
  %10 = load %struct.top_list*, %struct.top_list** %3, align 8
  %11 = getelementptr inbounds %struct.top_list, %struct.top_list* %10, i32 0, i32 1
  call void @create_sub_list(%struct.list_head* %11)
  %12 = load %struct.top_list*, %struct.top_list** %3, align 8
  %13 = getelementptr inbounds %struct.top_list, %struct.top_list* %12, i32 0, i32 2
  call void @create_sub_list(%struct.list_head* %13)
  %14 = load %struct.top_list*, %struct.top_list** %3, align 8
  %15 = getelementptr inbounds %struct.top_list, %struct.top_list* %14, i32 0, i32 0
  %16 = load %struct.list_head*, %struct.list_head** %2, align 8
  call void @list_add_tail(%struct.list_head* %15, %struct.list_head* %16)
  ret void
}

; Function Attrs: noinline nounwind uwtable
define dso_local void @create_top(%struct.list_head* %0) #0 {
  %2 = alloca %struct.list_head*, align 8
  store %struct.list_head* %0, %struct.list_head** %2, align 8
  br label %3

3:                                                ; preds = %5, %1
  %4 = load %struct.list_head*, %struct.list_head** %2, align 8
  call void @insert_top(%struct.list_head* %4)
  br label %5

5:                                                ; preds = %3
  %6 = call i32 @__VERIFIER_nondet_int()
  %7 = icmp ne i32 %6, 0
  br i1 %7, label %3, label %8

8:                                                ; preds = %5
  ret void
}

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @main() #0 {
  %1 = alloca i32, align 4
  %2 = alloca %struct.list_head, align 8
  store i32 0, i32* %1, align 4
  %3 = getelementptr inbounds %struct.list_head, %struct.list_head* %2, i32 0, i32 0
  store %struct.list_head* %2, %struct.list_head** %3, align 8
  %4 = getelementptr inbounds %struct.list_head, %struct.list_head* %2, i32 0, i32 1
  store %struct.list_head* %2, %struct.list_head** %4, align 8
  call void @create_top(%struct.list_head* %2)
  call void @destroy_top(%struct.list_head* %2)
  ret i32 0
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
