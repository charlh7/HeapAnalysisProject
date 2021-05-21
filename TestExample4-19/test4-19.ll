; ModuleID = 'Tests/TestExample4-19/test4-19.bc'
source_filename = "Tests/TestExample4-19/test4-19.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.Node = type { %struct.Node*, %struct.Node*, i32, i32 }

@.str = private unnamed_addr constant [15 x i8] c"Input arg: %s\0A\00", align 1
@.str.1 = private unnamed_addr constant [9 x i8] c"Max: %i\0A\00", align 1
@.str.2 = private unnamed_addr constant [30 x i8] c"No input args - max set to 3\0A\00", align 1

; Function Attrs: noinline nounwind uwtable
define dso_local void @createTree(%struct.Node* %0) #0 {
  %2 = alloca %struct.Node*, align 8
  %3 = alloca %struct.Node*, align 8
  %4 = alloca %struct.Node*, align 8
  %5 = alloca %struct.Node*, align 8
  %6 = alloca %struct.Node*, align 8
  %7 = alloca %struct.Node*, align 8
  %8 = alloca %struct.Node*, align 8
  store %struct.Node* %0, %struct.Node** %2, align 8
  %9 = load %struct.Node*, %struct.Node** %2, align 8
  %10 = getelementptr inbounds %struct.Node, %struct.Node* %9, i32 0, i32 2
  store i32 1, i32* %10, align 8
  %11 = call noalias i8* @malloc(i64 24) #4
  %12 = bitcast i8* %11 to %struct.Node*
  store %struct.Node* %12, %struct.Node** %3, align 8
  %13 = call noalias i8* @malloc(i64 24) #4
  %14 = bitcast i8* %13 to %struct.Node*
  store %struct.Node* %14, %struct.Node** %4, align 8
  %15 = call noalias i8* @malloc(i64 24) #4
  %16 = bitcast i8* %15 to %struct.Node*
  store %struct.Node* %16, %struct.Node** %5, align 8
  %17 = call noalias i8* @malloc(i64 24) #4
  %18 = bitcast i8* %17 to %struct.Node*
  store %struct.Node* %18, %struct.Node** %6, align 8
  %19 = call noalias i8* @malloc(i64 24) #4
  %20 = bitcast i8* %19 to %struct.Node*
  store %struct.Node* %20, %struct.Node** %7, align 8
  %21 = call noalias i8* @malloc(i64 24) #4
  %22 = bitcast i8* %21 to %struct.Node*
  store %struct.Node* %22, %struct.Node** %8, align 8
  %23 = load %struct.Node*, %struct.Node** %3, align 8
  %24 = getelementptr inbounds %struct.Node, %struct.Node* %23, i32 0, i32 2
  store i32 2, i32* %24, align 8
  %25 = load %struct.Node*, %struct.Node** %4, align 8
  %26 = getelementptr inbounds %struct.Node, %struct.Node* %25, i32 0, i32 2
  store i32 3, i32* %26, align 8
  %27 = load %struct.Node*, %struct.Node** %5, align 8
  %28 = getelementptr inbounds %struct.Node, %struct.Node* %27, i32 0, i32 2
  store i32 4, i32* %28, align 8
  %29 = load %struct.Node*, %struct.Node** %6, align 8
  %30 = getelementptr inbounds %struct.Node, %struct.Node* %29, i32 0, i32 2
  store i32 12, i32* %30, align 8
  %31 = load %struct.Node*, %struct.Node** %7, align 8
  %32 = getelementptr inbounds %struct.Node, %struct.Node* %31, i32 0, i32 2
  store i32 13, i32* %32, align 8
  %33 = load %struct.Node*, %struct.Node** %8, align 8
  %34 = getelementptr inbounds %struct.Node, %struct.Node* %33, i32 0, i32 2
  store i32 14, i32* %34, align 8
  %35 = load %struct.Node*, %struct.Node** %3, align 8
  %36 = load %struct.Node*, %struct.Node** %2, align 8
  %37 = getelementptr inbounds %struct.Node, %struct.Node* %36, i32 0, i32 0
  store %struct.Node* %35, %struct.Node** %37, align 8
  %38 = load %struct.Node*, %struct.Node** %6, align 8
  %39 = load %struct.Node*, %struct.Node** %2, align 8
  %40 = getelementptr inbounds %struct.Node, %struct.Node* %39, i32 0, i32 1
  store %struct.Node* %38, %struct.Node** %40, align 8
  %41 = load %struct.Node*, %struct.Node** %4, align 8
  %42 = load %struct.Node*, %struct.Node** %3, align 8
  %43 = getelementptr inbounds %struct.Node, %struct.Node* %42, i32 0, i32 0
  store %struct.Node* %41, %struct.Node** %43, align 8
  %44 = load %struct.Node*, %struct.Node** %7, align 8
  %45 = load %struct.Node*, %struct.Node** %3, align 8
  %46 = getelementptr inbounds %struct.Node, %struct.Node* %45, i32 0, i32 1
  store %struct.Node* %44, %struct.Node** %46, align 8
  %47 = load %struct.Node*, %struct.Node** %5, align 8
  %48 = load %struct.Node*, %struct.Node** %4, align 8
  %49 = getelementptr inbounds %struct.Node, %struct.Node* %48, i32 0, i32 0
  store %struct.Node* %47, %struct.Node** %49, align 8
  %50 = load %struct.Node*, %struct.Node** %8, align 8
  %51 = load %struct.Node*, %struct.Node** %4, align 8
  %52 = getelementptr inbounds %struct.Node, %struct.Node* %51, i32 0, i32 1
  store %struct.Node* %50, %struct.Node** %52, align 8
  ret void
}

; Function Attrs: nounwind
declare dso_local noalias i8* @malloc(i64) #1

; Function Attrs: noinline nounwind uwtable
define dso_local void @testCode(%struct.Node* %0, i32 %1) #0 {
  %3 = alloca %struct.Node*, align 8
  %4 = alloca i32, align 4
  %5 = alloca %struct.Node*, align 8
  %6 = alloca %struct.Node*, align 8
  %7 = alloca %struct.Node*, align 8
  store %struct.Node* %0, %struct.Node** %3, align 8
  store i32 %1, i32* %4, align 4
  %8 = load %struct.Node*, %struct.Node** %3, align 8
  store %struct.Node* %8, %struct.Node** %5, align 8
  br label %9

9:                                                ; preds = %15, %2
  %10 = load %struct.Node*, %struct.Node** %3, align 8
  %11 = getelementptr inbounds %struct.Node, %struct.Node* %10, i32 0, i32 2
  %12 = load i32, i32* %11, align 8
  %13 = load i32, i32* %4, align 4
  %14 = icmp slt i32 %12, %13
  br i1 %14, label %15, label %19

15:                                               ; preds = %9
  %16 = load %struct.Node*, %struct.Node** %3, align 8
  %17 = getelementptr inbounds %struct.Node, %struct.Node* %16, i32 0, i32 0
  %18 = load %struct.Node*, %struct.Node** %17, align 8
  store %struct.Node* %18, %struct.Node** %3, align 8
  br label %9

19:                                               ; preds = %9
  %20 = load %struct.Node*, %struct.Node** %3, align 8
  %21 = getelementptr inbounds %struct.Node, %struct.Node* %20, i32 0, i32 1
  %22 = load %struct.Node*, %struct.Node** %21, align 8
  store %struct.Node* %22, %struct.Node** %6, align 8
  %23 = call noalias i8* @malloc(i64 24) #4
  %24 = bitcast i8* %23 to %struct.Node*
  store %struct.Node* %24, %struct.Node** %7, align 8
  %25 = load %struct.Node*, %struct.Node** %6, align 8
  %26 = getelementptr inbounds %struct.Node, %struct.Node* %25, i32 0, i32 1
  %27 = load %struct.Node*, %struct.Node** %26, align 8
  store %struct.Node* %27, %struct.Node** %6, align 8
  %28 = load %struct.Node*, %struct.Node** %3, align 8
  %29 = getelementptr inbounds %struct.Node, %struct.Node* %28, i32 0, i32 1
  %30 = load %struct.Node*, %struct.Node** %29, align 8
  %31 = getelementptr inbounds %struct.Node, %struct.Node* %30, i32 0, i32 2
  %32 = load i32, i32* %31, align 8
  %33 = load %struct.Node*, %struct.Node** %6, align 8
  %34 = getelementptr inbounds %struct.Node, %struct.Node* %33, i32 0, i32 2
  %35 = load i32, i32* %34, align 8
  %36 = add nsw i32 %32, %35
  %37 = load %struct.Node*, %struct.Node** %7, align 8
  %38 = getelementptr inbounds %struct.Node, %struct.Node* %37, i32 0, i32 3
  store i32 %36, i32* %38, align 4
  ret void
}

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @main(i32 %0, i8** %1) #0 {
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  %5 = alloca i8**, align 8
  %6 = alloca i32, align 4
  %7 = alloca %struct.Node*, align 8
  store i32 0, i32* %3, align 4
  store i32 %0, i32* %4, align 4
  store i8** %1, i8*** %5, align 8
  %8 = load i32, i32* %4, align 4
  %9 = icmp eq i32 %8, 2
  br i1 %9, label %10, label %25

10:                                               ; preds = %2
  %11 = load i8**, i8*** %5, align 8
  %12 = getelementptr inbounds i8*, i8** %11, i64 1
  %13 = load i8*, i8** %12, align 8
  %14 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([15 x i8], [15 x i8]* @.str, i64 0, i64 0), i8* %13)
  %15 = load i8**, i8*** %5, align 8
  %16 = getelementptr inbounds i8*, i8** %15, i64 1
  %17 = load i8*, i8** %16, align 8
  %18 = call i32 @atoi(i8* %17) #5
  store i32 %18, i32* %6, align 4
  %19 = load i32, i32* %6, align 4
  %20 = icmp sgt i32 %19, 3
  br i1 %20, label %21, label %22

21:                                               ; preds = %10
  store i32 3, i32* %6, align 4
  br label %22

22:                                               ; preds = %21, %10
  %23 = load i32, i32* %6, align 4
  %24 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([9 x i8], [9 x i8]* @.str.1, i64 0, i64 0), i32 %23)
  br label %27

25:                                               ; preds = %2
  %26 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([30 x i8], [30 x i8]* @.str.2, i64 0, i64 0))
  store i32 3, i32* %6, align 4
  br label %27

27:                                               ; preds = %25, %22
  %28 = call noalias i8* @malloc(i64 24) #4
  %29 = bitcast i8* %28 to %struct.Node*
  store %struct.Node* %29, %struct.Node** %7, align 8
  %30 = load %struct.Node*, %struct.Node** %7, align 8
  call void @createTree(%struct.Node* %30)
  %31 = load %struct.Node*, %struct.Node** %7, align 8
  %32 = load i32, i32* %6, align 4
  call void @testCode(%struct.Node* %31, i32 %32)
  ret i32 0
}

declare dso_local i32 @printf(i8*, ...) #2

; Function Attrs: nounwind readonly
declare dso_local i32 @atoi(i8*) #3

attributes #0 = { noinline nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { nounwind readonly "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #4 = { nounwind }
attributes #5 = { nounwind readonly }

!llvm.module.flags = !{!0}
!llvm.ident = !{!1}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{!"clang version 10.0.1 "}
