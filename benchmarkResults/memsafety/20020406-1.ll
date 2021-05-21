; ModuleID = '/home/curt/HeapDataFlow/benchmarkResults/memsafety/20020406-1.bc'
source_filename = "/home/curt/HeapDataFlow/sv-benchmarks/c/memsafety/20020406-1.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.DUPFFstruct = type { i32, i32, i32* }

@.str = private unnamed_addr constant [2 x i8] c"0\00", align 1
@.str.1 = private unnamed_addr constant [63 x i8] c"/home/curt/HeapDataFlow/sv-benchmarks/c/memsafety/20020406-1.c\00", align 1
@__PRETTY_FUNCTION__.reach_error = private unnamed_addr constant [19 x i8] c"void reach_error()\00", align 1

; Function Attrs: noinline nounwind uwtable
define dso_local void @reach_error() #0 {
  call void @__assert_fail(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str, i64 0, i64 0), i8* getelementptr inbounds ([63 x i8], [63 x i8]* @.str.1, i64 0, i64 0), i32 3, i8* getelementptr inbounds ([19 x i8], [19 x i8]* @__PRETTY_FUNCTION__.reach_error, i64 0, i64 0)) #4
  unreachable
}

; Function Attrs: noreturn nounwind
declare dso_local void @__assert_fail(i8*, i8*, i32, i8*) #1

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @FFmul(i32 %0, i32 %1) #0 {
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  store i32 %0, i32* %3, align 4
  store i32 %1, i32* %4, align 4
  %5 = load i32, i32* %3, align 4
  ret i32 %5
}

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @DUPFFdeg(%struct.DUPFFstruct* %0) #0 {
  %2 = alloca %struct.DUPFFstruct*, align 8
  store %struct.DUPFFstruct* %0, %struct.DUPFFstruct** %2, align 8
  %3 = load %struct.DUPFFstruct*, %struct.DUPFFstruct** %2, align 8
  %4 = getelementptr inbounds %struct.DUPFFstruct, %struct.DUPFFstruct* %3, i32 0, i32 1
  %5 = load i32, i32* %4, align 4
  ret i32 %5
}

; Function Attrs: noinline nounwind uwtable
define dso_local %struct.DUPFFstruct* @DUPFFnew(i32 %0) #0 {
  %2 = alloca i32, align 4
  %3 = alloca %struct.DUPFFstruct*, align 8
  store i32 %0, i32* %2, align 4
  %4 = call noalias i8* @malloc(i64 16) #5
  %5 = bitcast i8* %4 to %struct.DUPFFstruct*
  store %struct.DUPFFstruct* %5, %struct.DUPFFstruct** %3, align 8
  %6 = load %struct.DUPFFstruct*, %struct.DUPFFstruct** %3, align 8
  %7 = getelementptr inbounds %struct.DUPFFstruct, %struct.DUPFFstruct* %6, i32 0, i32 2
  store i32* null, i32** %7, align 8
  %8 = load i32, i32* %2, align 4
  %9 = icmp sge i32 %8, 0
  br i1 %9, label %10, label %27

10:                                               ; preds = %1
  %11 = load i32, i32* %2, align 4
  %12 = add nsw i32 %11, 1
  %13 = sext i32 %12 to i64
  %14 = mul i64 %13, 4
  %15 = call noalias i8* @malloc(i64 %14) #5
  %16 = bitcast i8* %15 to i32*
  %17 = load %struct.DUPFFstruct*, %struct.DUPFFstruct** %3, align 8
  %18 = getelementptr inbounds %struct.DUPFFstruct, %struct.DUPFFstruct* %17, i32 0, i32 2
  store i32* %16, i32** %18, align 8
  %19 = load %struct.DUPFFstruct*, %struct.DUPFFstruct** %3, align 8
  %20 = getelementptr inbounds %struct.DUPFFstruct, %struct.DUPFFstruct* %19, i32 0, i32 2
  %21 = load i32*, i32** %20, align 8
  %22 = bitcast i32* %21 to i8*
  %23 = load i32, i32* %2, align 4
  %24 = add nsw i32 %23, 1
  %25 = sext i32 %24 to i64
  %26 = mul i64 %25, 4
  call void @llvm.memset.p0i8.i64(i8* align 4 %22, i8 0, i64 %26, i1 false)
  br label %27

27:                                               ; preds = %10, %1
  %28 = load i32, i32* %2, align 4
  %29 = load %struct.DUPFFstruct*, %struct.DUPFFstruct** %3, align 8
  %30 = getelementptr inbounds %struct.DUPFFstruct, %struct.DUPFFstruct* %29, i32 0, i32 0
  store i32 %28, i32* %30, align 8
  %31 = load %struct.DUPFFstruct*, %struct.DUPFFstruct** %3, align 8
  %32 = getelementptr inbounds %struct.DUPFFstruct, %struct.DUPFFstruct* %31, i32 0, i32 1
  store i32 -1, i32* %32, align 4
  %33 = load %struct.DUPFFstruct*, %struct.DUPFFstruct** %3, align 8
  ret %struct.DUPFFstruct* %33
}

; Function Attrs: nounwind
declare dso_local noalias i8* @malloc(i64) #2

; Function Attrs: argmemonly nounwind willreturn
declare void @llvm.memset.p0i8.i64(i8* nocapture writeonly, i8, i64, i1 immarg) #3

; Function Attrs: noinline nounwind uwtable
define dso_local void @DUPFFfree(%struct.DUPFFstruct* %0) #0 {
  %2 = alloca %struct.DUPFFstruct*, align 8
  store %struct.DUPFFstruct* %0, %struct.DUPFFstruct** %2, align 8
  ret void
}

; Function Attrs: noinline nounwind uwtable
define dso_local void @DUPFFswap(%struct.DUPFFstruct* %0, %struct.DUPFFstruct* %1) #0 {
  %3 = alloca %struct.DUPFFstruct*, align 8
  %4 = alloca %struct.DUPFFstruct*, align 8
  store %struct.DUPFFstruct* %0, %struct.DUPFFstruct** %3, align 8
  store %struct.DUPFFstruct* %1, %struct.DUPFFstruct** %4, align 8
  ret void
}

; Function Attrs: noinline nounwind uwtable
define dso_local %struct.DUPFFstruct* @DUPFFcopy(%struct.DUPFFstruct* %0) #0 {
  %2 = alloca %struct.DUPFFstruct*, align 8
  store %struct.DUPFFstruct* %0, %struct.DUPFFstruct** %2, align 8
  %3 = load %struct.DUPFFstruct*, %struct.DUPFFstruct** %2, align 8
  ret %struct.DUPFFstruct* %3
}

; Function Attrs: noinline nounwind uwtable
define dso_local void @DUPFFshift_add(%struct.DUPFFstruct* %0, %struct.DUPFFstruct* %1, i32 %2, i32 %3) #0 {
  %5 = alloca %struct.DUPFFstruct*, align 8
  %6 = alloca %struct.DUPFFstruct*, align 8
  %7 = alloca i32, align 4
  %8 = alloca i32, align 4
  store %struct.DUPFFstruct* %0, %struct.DUPFFstruct** %5, align 8
  store %struct.DUPFFstruct* %1, %struct.DUPFFstruct** %6, align 8
  store i32 %2, i32* %7, align 4
  store i32 %3, i32* %8, align 4
  ret void
}

; Function Attrs: noinline nounwind uwtable
define dso_local %struct.DUPFFstruct* @DUPFFexgcd(%struct.DUPFFstruct** %0, %struct.DUPFFstruct** %1, %struct.DUPFFstruct* %2, %struct.DUPFFstruct* %3) #0 {
  %5 = alloca %struct.DUPFFstruct*, align 8
  %6 = alloca %struct.DUPFFstruct**, align 8
  %7 = alloca %struct.DUPFFstruct**, align 8
  %8 = alloca %struct.DUPFFstruct*, align 8
  %9 = alloca %struct.DUPFFstruct*, align 8
  %10 = alloca %struct.DUPFFstruct*, align 8
  %11 = alloca %struct.DUPFFstruct*, align 8
  %12 = alloca %struct.DUPFFstruct*, align 8
  %13 = alloca %struct.DUPFFstruct*, align 8
  %14 = alloca %struct.DUPFFstruct*, align 8
  %15 = alloca %struct.DUPFFstruct*, align 8
  %16 = alloca i32, align 4
  %17 = alloca i32, align 4
  %18 = alloca i32, align 4
  %19 = alloca i32, align 4
  %20 = alloca i32, align 4
  %21 = alloca i32, align 4
  %22 = alloca i32, align 4
  %23 = alloca i32, align 4
  store %struct.DUPFFstruct** %0, %struct.DUPFFstruct*** %6, align 8
  store %struct.DUPFFstruct** %1, %struct.DUPFFstruct*** %7, align 8
  store %struct.DUPFFstruct* %2, %struct.DUPFFstruct** %8, align 8
  store %struct.DUPFFstruct* %3, %struct.DUPFFstruct** %9, align 8
  %24 = load %struct.DUPFFstruct*, %struct.DUPFFstruct** %8, align 8
  %25 = call i32 @DUPFFdeg(%struct.DUPFFstruct* %24)
  %26 = load %struct.DUPFFstruct*, %struct.DUPFFstruct** %9, align 8
  %27 = call i32 @DUPFFdeg(%struct.DUPFFstruct* %26)
  %28 = icmp slt i32 %25, %27
  br i1 %28, label %29, label %35

29:                                               ; preds = %4
  %30 = load %struct.DUPFFstruct**, %struct.DUPFFstruct*** %7, align 8
  %31 = load %struct.DUPFFstruct**, %struct.DUPFFstruct*** %6, align 8
  %32 = load %struct.DUPFFstruct*, %struct.DUPFFstruct** %9, align 8
  %33 = load %struct.DUPFFstruct*, %struct.DUPFFstruct** %8, align 8
  %34 = call %struct.DUPFFstruct* @DUPFFexgcd(%struct.DUPFFstruct** %30, %struct.DUPFFstruct** %31, %struct.DUPFFstruct* %32, %struct.DUPFFstruct* %33)
  store %struct.DUPFFstruct* %34, %struct.DUPFFstruct** %5, align 8
  br label %174

35:                                               ; preds = %4
  %36 = load %struct.DUPFFstruct*, %struct.DUPFFstruct** %8, align 8
  %37 = call i32 @DUPFFdeg(%struct.DUPFFstruct* %36)
  %38 = icmp ne i32 %37, 2
  br i1 %38, label %43, label %39

39:                                               ; preds = %35
  %40 = load %struct.DUPFFstruct*, %struct.DUPFFstruct** %9, align 8
  %41 = call i32 @DUPFFdeg(%struct.DUPFFstruct* %40)
  %42 = icmp ne i32 %41, 1
  br i1 %42, label %43, label %44

43:                                               ; preds = %39, %35
  call void @abort() #4
  unreachable

44:                                               ; preds = %39
  %45 = load %struct.DUPFFstruct*, %struct.DUPFFstruct** %8, align 8
  %46 = getelementptr inbounds %struct.DUPFFstruct, %struct.DUPFFstruct* %45, i32 0, i32 2
  %47 = load i32*, i32** %46, align 8
  %48 = getelementptr inbounds i32, i32* %47, i64 0
  %49 = load i32, i32* %48, align 4
  %50 = icmp eq i32 %49, 0
  br i1 %50, label %51, label %53

51:                                               ; preds = %44
  %52 = load %struct.DUPFFstruct*, %struct.DUPFFstruct** %8, align 8
  store %struct.DUPFFstruct* %52, %struct.DUPFFstruct** %5, align 8
  br label %174

53:                                               ; preds = %44
  store i32 2, i32* %19, align 4
  %54 = load %struct.DUPFFstruct*, %struct.DUPFFstruct** %8, align 8
  %55 = call i32 @DUPFFdeg(%struct.DUPFFstruct* %54)
  store i32 %55, i32* %20, align 4
  %56 = load i32, i32* %20, align 4
  %57 = icmp slt i32 %56, 0
  br i1 %57, label %58, label %59

58:                                               ; preds = %53
  store i32 0, i32* %20, align 4
  br label %59

59:                                               ; preds = %58, %53
  %60 = load %struct.DUPFFstruct*, %struct.DUPFFstruct** %9, align 8
  %61 = call i32 @DUPFFdeg(%struct.DUPFFstruct* %60)
  store i32 %61, i32* %21, align 4
  %62 = load i32, i32* %21, align 4
  %63 = icmp slt i32 %62, 0
  br i1 %63, label %64, label %65

64:                                               ; preds = %59
  store i32 0, i32* %21, align 4
  br label %65

65:                                               ; preds = %64, %59
  %66 = load %struct.DUPFFstruct*, %struct.DUPFFstruct** %8, align 8
  %67 = call %struct.DUPFFstruct* @DUPFFcopy(%struct.DUPFFstruct* %66)
  store %struct.DUPFFstruct* %67, %struct.DUPFFstruct** %10, align 8
  %68 = load %struct.DUPFFstruct*, %struct.DUPFFstruct** %9, align 8
  %69 = call %struct.DUPFFstruct* @DUPFFcopy(%struct.DUPFFstruct* %68)
  store %struct.DUPFFstruct* %69, %struct.DUPFFstruct** %11, align 8
  %70 = load i32, i32* %21, align 4
  %71 = call %struct.DUPFFstruct* @DUPFFnew(i32 %70)
  store %struct.DUPFFstruct* %71, %struct.DUPFFstruct** %12, align 8
  %72 = load %struct.DUPFFstruct*, %struct.DUPFFstruct** %12, align 8
  %73 = getelementptr inbounds %struct.DUPFFstruct, %struct.DUPFFstruct* %72, i32 0, i32 2
  %74 = load i32*, i32** %73, align 8
  %75 = getelementptr inbounds i32, i32* %74, i64 0
  store i32 1, i32* %75, align 4
  %76 = load %struct.DUPFFstruct*, %struct.DUPFFstruct** %12, align 8
  %77 = getelementptr inbounds %struct.DUPFFstruct, %struct.DUPFFstruct* %76, i32 0, i32 1
  store i32 0, i32* %77, align 4
  %78 = load i32, i32* %20, align 4
  %79 = call %struct.DUPFFstruct* @DUPFFnew(i32 %78)
  store %struct.DUPFFstruct* %79, %struct.DUPFFstruct** %13, align 8
  %80 = load i32, i32* %21, align 4
  %81 = call %struct.DUPFFstruct* @DUPFFnew(i32 %80)
  store %struct.DUPFFstruct* %81, %struct.DUPFFstruct** %14, align 8
  %82 = load i32, i32* %20, align 4
  %83 = call %struct.DUPFFstruct* @DUPFFnew(i32 %82)
  store %struct.DUPFFstruct* %83, %struct.DUPFFstruct** %15, align 8
  %84 = load %struct.DUPFFstruct*, %struct.DUPFFstruct** %15, align 8
  %85 = getelementptr inbounds %struct.DUPFFstruct, %struct.DUPFFstruct* %84, i32 0, i32 2
  %86 = load i32*, i32** %85, align 8
  %87 = getelementptr inbounds i32, i32* %86, i64 0
  store i32 1, i32* %87, align 4
  %88 = load %struct.DUPFFstruct*, %struct.DUPFFstruct** %15, align 8
  %89 = getelementptr inbounds %struct.DUPFFstruct, %struct.DUPFFstruct* %88, i32 0, i32 1
  store i32 0, i32* %89, align 4
  br label %90

90:                                               ; preds = %147, %65
  %91 = load %struct.DUPFFstruct*, %struct.DUPFFstruct** %11, align 8
  %92 = call i32 @DUPFFdeg(%struct.DUPFFstruct* %91)
  %93 = icmp sgt i32 %92, 0
  br i1 %93, label %94, label %154

94:                                               ; preds = %90
  %95 = load %struct.DUPFFstruct*, %struct.DUPFFstruct** %11, align 8
  %96 = call i32 @DUPFFdeg(%struct.DUPFFstruct* %95)
  store i32 %96, i32* %23, align 4
  %97 = load %struct.DUPFFstruct*, %struct.DUPFFstruct** %11, align 8
  %98 = getelementptr inbounds %struct.DUPFFstruct, %struct.DUPFFstruct* %97, i32 0, i32 2
  %99 = load i32*, i32** %98, align 8
  %100 = load i32, i32* %23, align 4
  %101 = sext i32 %100 to i64
  %102 = getelementptr inbounds i32, i32* %99, i64 %101
  %103 = load i32, i32* %102, align 4
  %104 = call i32 @FFmul(i32 1, i32 %103)
  store i32 %104, i32* %18, align 4
  br label %105

105:                                              ; preds = %110, %94
  %106 = load %struct.DUPFFstruct*, %struct.DUPFFstruct** %10, align 8
  %107 = call i32 @DUPFFdeg(%struct.DUPFFstruct* %106)
  %108 = load i32, i32* %23, align 4
  %109 = icmp sge i32 %107, %108
  br i1 %109, label %110, label %147

110:                                              ; preds = %105
  %111 = load %struct.DUPFFstruct*, %struct.DUPFFstruct** %10, align 8
  %112 = call i32 @DUPFFdeg(%struct.DUPFFstruct* %111)
  store i32 %112, i32* %22, align 4
  %113 = load %struct.DUPFFstruct*, %struct.DUPFFstruct** %10, align 8
  %114 = getelementptr inbounds %struct.DUPFFstruct, %struct.DUPFFstruct* %113, i32 0, i32 2
  %115 = load i32*, i32** %114, align 8
  %116 = load i32, i32* %22, align 4
  %117 = sext i32 %116 to i64
  %118 = getelementptr inbounds i32, i32* %115, i64 %117
  %119 = load i32, i32* %118, align 4
  store i32 %119, i32* %17, align 4
  %120 = load i32, i32* %17, align 4
  %121 = load i32, i32* %18, align 4
  %122 = call i32 @FFmul(i32 %120, i32 %121)
  store i32 %122, i32* %16, align 4
  %123 = load %struct.DUPFFstruct*, %struct.DUPFFstruct** %10, align 8
  %124 = load %struct.DUPFFstruct*, %struct.DUPFFstruct** %11, align 8
  %125 = load i32, i32* %22, align 4
  %126 = load i32, i32* %23, align 4
  %127 = sub nsw i32 %125, %126
  %128 = load i32, i32* %19, align 4
  %129 = load i32, i32* %16, align 4
  %130 = sub i32 %128, %129
  call void @DUPFFshift_add(%struct.DUPFFstruct* %123, %struct.DUPFFstruct* %124, i32 %127, i32 %130)
  %131 = load %struct.DUPFFstruct*, %struct.DUPFFstruct** %12, align 8
  %132 = load %struct.DUPFFstruct*, %struct.DUPFFstruct** %14, align 8
  %133 = load i32, i32* %22, align 4
  %134 = load i32, i32* %23, align 4
  %135 = sub nsw i32 %133, %134
  %136 = load i32, i32* %19, align 4
  %137 = load i32, i32* %16, align 4
  %138 = sub i32 %136, %137
  call void @DUPFFshift_add(%struct.DUPFFstruct* %131, %struct.DUPFFstruct* %132, i32 %135, i32 %138)
  %139 = load %struct.DUPFFstruct*, %struct.DUPFFstruct** %13, align 8
  %140 = load %struct.DUPFFstruct*, %struct.DUPFFstruct** %15, align 8
  %141 = load i32, i32* %22, align 4
  %142 = load i32, i32* %23, align 4
  %143 = sub nsw i32 %141, %142
  %144 = load i32, i32* %19, align 4
  %145 = load i32, i32* %16, align 4
  %146 = sub i32 %144, %145
  call void @DUPFFshift_add(%struct.DUPFFstruct* %139, %struct.DUPFFstruct* %140, i32 %143, i32 %146)
  br label %105

147:                                              ; preds = %105
  %148 = load %struct.DUPFFstruct*, %struct.DUPFFstruct** %10, align 8
  %149 = load %struct.DUPFFstruct*, %struct.DUPFFstruct** %11, align 8
  call void @DUPFFswap(%struct.DUPFFstruct* %148, %struct.DUPFFstruct* %149)
  %150 = load %struct.DUPFFstruct*, %struct.DUPFFstruct** %12, align 8
  %151 = load %struct.DUPFFstruct*, %struct.DUPFFstruct** %14, align 8
  call void @DUPFFswap(%struct.DUPFFstruct* %150, %struct.DUPFFstruct* %151)
  %152 = load %struct.DUPFFstruct*, %struct.DUPFFstruct** %13, align 8
  %153 = load %struct.DUPFFstruct*, %struct.DUPFFstruct** %15, align 8
  call void @DUPFFswap(%struct.DUPFFstruct* %152, %struct.DUPFFstruct* %153)
  br label %90

154:                                              ; preds = %90
  %155 = load %struct.DUPFFstruct*, %struct.DUPFFstruct** %11, align 8
  %156 = call i32 @DUPFFdeg(%struct.DUPFFstruct* %155)
  %157 = icmp eq i32 %156, 0
  br i1 %157, label %158, label %165

158:                                              ; preds = %154
  %159 = load %struct.DUPFFstruct*, %struct.DUPFFstruct** %10, align 8
  %160 = load %struct.DUPFFstruct*, %struct.DUPFFstruct** %11, align 8
  call void @DUPFFswap(%struct.DUPFFstruct* %159, %struct.DUPFFstruct* %160)
  %161 = load %struct.DUPFFstruct*, %struct.DUPFFstruct** %12, align 8
  %162 = load %struct.DUPFFstruct*, %struct.DUPFFstruct** %14, align 8
  call void @DUPFFswap(%struct.DUPFFstruct* %161, %struct.DUPFFstruct* %162)
  %163 = load %struct.DUPFFstruct*, %struct.DUPFFstruct** %13, align 8
  %164 = load %struct.DUPFFstruct*, %struct.DUPFFstruct** %15, align 8
  call void @DUPFFswap(%struct.DUPFFstruct* %163, %struct.DUPFFstruct* %164)
  br label %165

165:                                              ; preds = %158, %154
  %166 = load %struct.DUPFFstruct*, %struct.DUPFFstruct** %14, align 8
  call void @DUPFFfree(%struct.DUPFFstruct* %166)
  %167 = load %struct.DUPFFstruct*, %struct.DUPFFstruct** %15, align 8
  call void @DUPFFfree(%struct.DUPFFstruct* %167)
  %168 = load %struct.DUPFFstruct*, %struct.DUPFFstruct** %11, align 8
  call void @DUPFFfree(%struct.DUPFFstruct* %168)
  %169 = load %struct.DUPFFstruct*, %struct.DUPFFstruct** %12, align 8
  %170 = load %struct.DUPFFstruct**, %struct.DUPFFstruct*** %6, align 8
  store %struct.DUPFFstruct* %169, %struct.DUPFFstruct** %170, align 8
  %171 = load %struct.DUPFFstruct*, %struct.DUPFFstruct** %13, align 8
  %172 = load %struct.DUPFFstruct**, %struct.DUPFFstruct*** %7, align 8
  store %struct.DUPFFstruct* %171, %struct.DUPFFstruct** %172, align 8
  %173 = load %struct.DUPFFstruct*, %struct.DUPFFstruct** %10, align 8
  store %struct.DUPFFstruct* %173, %struct.DUPFFstruct** %5, align 8
  br label %174

174:                                              ; preds = %165, %51, %29
  %175 = load %struct.DUPFFstruct*, %struct.DUPFFstruct** %5, align 8
  ret %struct.DUPFFstruct* %175
}

; Function Attrs: noreturn nounwind
declare dso_local void @abort() #1

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @main() #0 {
  %1 = alloca i32, align 4
  %2 = alloca %struct.DUPFFstruct*, align 8
  %3 = alloca %struct.DUPFFstruct*, align 8
  %4 = alloca %struct.DUPFFstruct*, align 8
  %5 = alloca %struct.DUPFFstruct*, align 8
  %6 = alloca %struct.DUPFFstruct*, align 8
  store i32 0, i32* %1, align 4
  %7 = call %struct.DUPFFstruct* @DUPFFnew(i32 1)
  store %struct.DUPFFstruct* %7, %struct.DUPFFstruct** %2, align 8
  %8 = load %struct.DUPFFstruct*, %struct.DUPFFstruct** %2, align 8
  %9 = getelementptr inbounds %struct.DUPFFstruct, %struct.DUPFFstruct* %8, i32 0, i32 2
  %10 = load i32*, i32** %9, align 8
  %11 = getelementptr inbounds i32, i32* %10, i64 1
  store i32 1, i32* %11, align 4
  %12 = load %struct.DUPFFstruct*, %struct.DUPFFstruct** %2, align 8
  %13 = getelementptr inbounds %struct.DUPFFstruct, %struct.DUPFFstruct* %12, i32 0, i32 1
  store i32 1, i32* %13, align 4
  %14 = call %struct.DUPFFstruct* @DUPFFnew(i32 2)
  store %struct.DUPFFstruct* %14, %struct.DUPFFstruct** %3, align 8
  %15 = load %struct.DUPFFstruct*, %struct.DUPFFstruct** %3, align 8
  %16 = getelementptr inbounds %struct.DUPFFstruct, %struct.DUPFFstruct* %15, i32 0, i32 2
  %17 = load i32*, i32** %16, align 8
  %18 = getelementptr inbounds i32, i32* %17, i64 2
  store i32 1, i32* %18, align 4
  %19 = load %struct.DUPFFstruct*, %struct.DUPFFstruct** %3, align 8
  %20 = getelementptr inbounds %struct.DUPFFstruct, %struct.DUPFFstruct* %19, i32 0, i32 1
  store i32 2, i32* %20, align 4
  %21 = load %struct.DUPFFstruct*, %struct.DUPFFstruct** %2, align 8
  %22 = load %struct.DUPFFstruct*, %struct.DUPFFstruct** %3, align 8
  %23 = call %struct.DUPFFstruct* @DUPFFexgcd(%struct.DUPFFstruct** %4, %struct.DUPFFstruct** %5, %struct.DUPFFstruct* %21, %struct.DUPFFstruct* %22)
  store %struct.DUPFFstruct* %23, %struct.DUPFFstruct** %6, align 8
  %24 = load %struct.DUPFFstruct*, %struct.DUPFFstruct** %6, align 8
  store %struct.DUPFFstruct* %24, %struct.DUPFFstruct** %6, align 8
  ret i32 0
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
