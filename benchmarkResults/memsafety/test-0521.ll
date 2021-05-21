; ModuleID = '/home/curt/HeapDataFlow/benchmarkResults/memsafety/test-0521.bc'
source_filename = "/home/curt/HeapDataFlow/sv-benchmarks/c/memsafety/test-0521.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.list = type { %struct.node*, %struct.list* }
%struct.node = type { i32, %struct.node* }
%struct.iterator = type { %struct.list*, %struct.node* }

@.str = private unnamed_addr constant [2 x i8] c"0\00", align 1
@.str.1 = private unnamed_addr constant [62 x i8] c"/home/curt/HeapDataFlow/sv-benchmarks/c/memsafety/test-0521.c\00", align 1
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
  %2 = alloca %struct.list*, align 8
  %3 = alloca %struct.node*, align 8
  %4 = alloca %struct.list*, align 8
  %5 = alloca %struct.iterator, align 8
  %6 = alloca %struct.list*, align 8
  %7 = alloca %struct.node*, align 8
  %8 = alloca %struct.node*, align 8
  %9 = alloca %struct.node*, align 8
  %10 = alloca %struct.list*, align 8
  %11 = alloca %struct.list*, align 8
  %12 = alloca %struct.list*, align 8
  %13 = alloca %struct.node**, align 8
  %14 = alloca %struct.node*, align 8
  %15 = alloca %struct.node*, align 8
  %16 = alloca %struct.node***, align 8
  %17 = alloca %struct.node**, align 8
  %18 = alloca %struct.node*, align 8
  %19 = alloca %struct.iterator, align 8
  %20 = alloca %struct.list*, align 8
  %21 = alloca %struct.node*, align 8
  %22 = alloca %struct.node*, align 8
  %23 = alloca %struct.node*, align 8
  %24 = alloca %struct.list*, align 8
  %25 = alloca %struct.node*, align 8
  %26 = alloca %struct.node*, align 8
  store i32 0, i32* %1, align 4
  store %struct.list* null, %struct.list** %2, align 8
  br label %27

27:                                               ; preds = %47, %0
  %28 = call i32 @__VERIFIER_nondet_int()
  %29 = icmp ne i32 %28, 0
  br i1 %29, label %30, label %55

30:                                               ; preds = %27
  %31 = call noalias i8* @malloc(i64 16) #5
  %32 = bitcast i8* %31 to %struct.node*
  store %struct.node* %32, %struct.node** %3, align 8
  %33 = load %struct.node*, %struct.node** %3, align 8
  %34 = icmp ne %struct.node* %33, null
  br i1 %34, label %36, label %35

35:                                               ; preds = %30
  call void @abort() #4
  unreachable

36:                                               ; preds = %30
  %37 = load %struct.node*, %struct.node** %3, align 8
  %38 = getelementptr inbounds %struct.node, %struct.node* %37, i32 0, i32 1
  store %struct.node* null, %struct.node** %38, align 8
  %39 = call i32 @__VERIFIER_nondet_int()
  %40 = load %struct.node*, %struct.node** %3, align 8
  %41 = getelementptr inbounds %struct.node, %struct.node* %40, i32 0, i32 0
  store i32 %39, i32* %41, align 8
  %42 = call noalias i8* @malloc(i64 16) #5
  %43 = bitcast i8* %42 to %struct.list*
  store %struct.list* %43, %struct.list** %4, align 8
  %44 = load %struct.list*, %struct.list** %4, align 8
  %45 = icmp ne %struct.list* %44, null
  br i1 %45, label %47, label %46

46:                                               ; preds = %36
  call void @abort() #4
  unreachable

47:                                               ; preds = %36
  %48 = load %struct.node*, %struct.node** %3, align 8
  %49 = load %struct.list*, %struct.list** %4, align 8
  %50 = getelementptr inbounds %struct.list, %struct.list* %49, i32 0, i32 0
  store %struct.node* %48, %struct.node** %50, align 8
  %51 = load %struct.list*, %struct.list** %2, align 8
  %52 = load %struct.list*, %struct.list** %4, align 8
  %53 = getelementptr inbounds %struct.list, %struct.list* %52, i32 0, i32 1
  store %struct.list* %51, %struct.list** %53, align 8
  %54 = load %struct.list*, %struct.list** %4, align 8
  store %struct.list* %54, %struct.list** %2, align 8
  br label %27

55:                                               ; preds = %27
  %56 = load %struct.list*, %struct.list** %2, align 8
  store %struct.list* %56, %struct.list** %6, align 8
  %57 = load %struct.list*, %struct.list** %6, align 8
  %58 = getelementptr inbounds %struct.iterator, %struct.iterator* %5, i32 0, i32 0
  store %struct.list* %57, %struct.list** %58, align 8
  %59 = icmp ne %struct.list* %57, null
  br i1 %59, label %60, label %65

60:                                               ; preds = %55
  %61 = load %struct.list*, %struct.list** %6, align 8
  %62 = getelementptr inbounds %struct.list, %struct.list* %61, i32 0, i32 0
  %63 = load %struct.node*, %struct.node** %62, align 8
  %64 = getelementptr inbounds %struct.iterator, %struct.iterator* %5, i32 0, i32 1
  store %struct.node* %63, %struct.node** %64, align 8
  br label %65

65:                                               ; preds = %60, %55
  %66 = getelementptr inbounds %struct.iterator, %struct.iterator* %5, i32 0, i32 0
  %67 = load %struct.list*, %struct.list** %66, align 8
  %68 = icmp ne %struct.list* %67, null
  br i1 %68, label %70, label %69

69:                                               ; preds = %65
  store %struct.node* null, %struct.node** %7, align 8
  br label %96

70:                                               ; preds = %65
  %71 = getelementptr inbounds %struct.iterator, %struct.iterator* %5, i32 0, i32 1
  %72 = load %struct.node*, %struct.node** %71, align 8
  store %struct.node* %72, %struct.node** %8, align 8
  %73 = load %struct.node*, %struct.node** %8, align 8
  %74 = getelementptr inbounds %struct.node, %struct.node* %73, i32 0, i32 1
  %75 = load %struct.node*, %struct.node** %74, align 8
  %76 = getelementptr inbounds %struct.iterator, %struct.iterator* %5, i32 0, i32 1
  store %struct.node* %75, %struct.node** %76, align 8
  %77 = icmp ne %struct.node* %75, null
  br i1 %77, label %78, label %80

78:                                               ; preds = %70
  %79 = load %struct.node*, %struct.node** %8, align 8
  store %struct.node* %79, %struct.node** %7, align 8
  br label %95

80:                                               ; preds = %70
  %81 = getelementptr inbounds %struct.iterator, %struct.iterator* %5, i32 0, i32 0
  %82 = load %struct.list*, %struct.list** %81, align 8
  %83 = getelementptr inbounds %struct.list, %struct.list* %82, i32 0, i32 1
  %84 = load %struct.list*, %struct.list** %83, align 8
  %85 = getelementptr inbounds %struct.iterator, %struct.iterator* %5, i32 0, i32 0
  store %struct.list* %84, %struct.list** %85, align 8
  %86 = icmp ne %struct.list* %84, null
  br i1 %86, label %87, label %93

87:                                               ; preds = %80
  %88 = getelementptr inbounds %struct.iterator, %struct.iterator* %5, i32 0, i32 0
  %89 = load %struct.list*, %struct.list** %88, align 8
  %90 = getelementptr inbounds %struct.list, %struct.list* %89, i32 0, i32 0
  %91 = load %struct.node*, %struct.node** %90, align 8
  %92 = getelementptr inbounds %struct.iterator, %struct.iterator* %5, i32 0, i32 1
  store %struct.node* %91, %struct.node** %92, align 8
  br label %93

93:                                               ; preds = %87, %80
  %94 = load %struct.node*, %struct.node** %8, align 8
  store %struct.node* %94, %struct.node** %7, align 8
  br label %95

95:                                               ; preds = %93, %78
  br label %96

96:                                               ; preds = %95, %69
  br label %97

97:                                               ; preds = %131, %96
  %98 = load %struct.node*, %struct.node** %7, align 8
  %99 = icmp ne %struct.node* %98, null
  br i1 %99, label %100, label %132

100:                                              ; preds = %97
  %101 = getelementptr inbounds %struct.iterator, %struct.iterator* %5, i32 0, i32 0
  %102 = load %struct.list*, %struct.list** %101, align 8
  %103 = icmp ne %struct.list* %102, null
  br i1 %103, label %105, label %104

104:                                              ; preds = %100
  store %struct.node* null, %struct.node** %7, align 8
  br label %131

105:                                              ; preds = %100
  %106 = getelementptr inbounds %struct.iterator, %struct.iterator* %5, i32 0, i32 1
  %107 = load %struct.node*, %struct.node** %106, align 8
  store %struct.node* %107, %struct.node** %9, align 8
  %108 = load %struct.node*, %struct.node** %9, align 8
  %109 = getelementptr inbounds %struct.node, %struct.node* %108, i32 0, i32 1
  %110 = load %struct.node*, %struct.node** %109, align 8
  %111 = getelementptr inbounds %struct.iterator, %struct.iterator* %5, i32 0, i32 1
  store %struct.node* %110, %struct.node** %111, align 8
  %112 = icmp ne %struct.node* %110, null
  br i1 %112, label %113, label %115

113:                                              ; preds = %105
  %114 = load %struct.node*, %struct.node** %9, align 8
  store %struct.node* %114, %struct.node** %7, align 8
  br label %130

115:                                              ; preds = %105
  %116 = getelementptr inbounds %struct.iterator, %struct.iterator* %5, i32 0, i32 0
  %117 = load %struct.list*, %struct.list** %116, align 8
  %118 = getelementptr inbounds %struct.list, %struct.list* %117, i32 0, i32 1
  %119 = load %struct.list*, %struct.list** %118, align 8
  %120 = getelementptr inbounds %struct.iterator, %struct.iterator* %5, i32 0, i32 0
  store %struct.list* %119, %struct.list** %120, align 8
  %121 = icmp ne %struct.list* %119, null
  br i1 %121, label %122, label %128

122:                                              ; preds = %115
  %123 = getelementptr inbounds %struct.iterator, %struct.iterator* %5, i32 0, i32 0
  %124 = load %struct.list*, %struct.list** %123, align 8
  %125 = getelementptr inbounds %struct.list, %struct.list* %124, i32 0, i32 0
  %126 = load %struct.node*, %struct.node** %125, align 8
  %127 = getelementptr inbounds %struct.iterator, %struct.iterator* %5, i32 0, i32 1
  store %struct.node* %126, %struct.node** %127, align 8
  br label %128

128:                                              ; preds = %122, %115
  %129 = load %struct.node*, %struct.node** %9, align 8
  store %struct.node* %129, %struct.node** %7, align 8
  br label %130

130:                                              ; preds = %128, %113
  br label %131

131:                                              ; preds = %130, %104
  br label %97

132:                                              ; preds = %97
  %133 = load %struct.list*, %struct.list** %2, align 8
  store %struct.list* %133, %struct.list** %10, align 8
  br label %134

134:                                              ; preds = %212, %132
  %135 = load %struct.list*, %struct.list** %10, align 8
  %136 = icmp ne %struct.list* %135, null
  br i1 %136, label %137, label %142

137:                                              ; preds = %134
  %138 = load %struct.list*, %struct.list** %10, align 8
  %139 = getelementptr inbounds %struct.list, %struct.list* %138, i32 0, i32 1
  %140 = load %struct.list*, %struct.list** %139, align 8
  %141 = icmp ne %struct.list* %140, null
  br label %142

142:                                              ; preds = %137, %134
  %143 = phi i1 [ false, %134 ], [ %141, %137 ]
  br i1 %143, label %144, label %214

144:                                              ; preds = %142
  store %struct.list* null, %struct.list** %11, align 8
  br label %145

145:                                              ; preds = %202, %144
  %146 = load %struct.list*, %struct.list** %10, align 8
  %147 = icmp ne %struct.list* %146, null
  br i1 %147, label %148, label %212

148:                                              ; preds = %145
  %149 = load %struct.list*, %struct.list** %10, align 8
  %150 = getelementptr inbounds %struct.list, %struct.list* %149, i32 0, i32 1
  %151 = load %struct.list*, %struct.list** %150, align 8
  store %struct.list* %151, %struct.list** %12, align 8
  %152 = load %struct.list*, %struct.list** %12, align 8
  %153 = icmp ne %struct.list* %152, null
  br i1 %153, label %159, label %154

154:                                              ; preds = %148
  %155 = load %struct.list*, %struct.list** %11, align 8
  %156 = load %struct.list*, %struct.list** %10, align 8
  %157 = getelementptr inbounds %struct.list, %struct.list* %156, i32 0, i32 1
  store %struct.list* %155, %struct.list** %157, align 8
  %158 = load %struct.list*, %struct.list** %10, align 8
  store %struct.list* %158, %struct.list** %11, align 8
  br label %212

159:                                              ; preds = %148
  %160 = load %struct.list*, %struct.list** %10, align 8
  %161 = getelementptr inbounds %struct.list, %struct.list* %160, i32 0, i32 0
  store %struct.node** %161, %struct.node*** %13, align 8
  %162 = load %struct.list*, %struct.list** %10, align 8
  %163 = getelementptr inbounds %struct.list, %struct.list* %162, i32 0, i32 0
  %164 = load %struct.node*, %struct.node** %163, align 8
  store %struct.node* %164, %struct.node** %14, align 8
  %165 = load %struct.list*, %struct.list** %12, align 8
  %166 = getelementptr inbounds %struct.list, %struct.list* %165, i32 0, i32 0
  %167 = load %struct.node*, %struct.node** %166, align 8
  store %struct.node* %167, %struct.node** %15, align 8
  br label %168

168:                                              ; preds = %187, %159
  %169 = load %struct.node*, %struct.node** %14, align 8
  %170 = icmp ne %struct.node* %169, null
  br i1 %170, label %174, label %171

171:                                              ; preds = %168
  %172 = load %struct.node*, %struct.node** %15, align 8
  %173 = icmp ne %struct.node* %172, null
  br label %174

174:                                              ; preds = %171, %168
  %175 = phi i1 [ true, %168 ], [ %173, %171 ]
  br i1 %175, label %176, label %202

176:                                              ; preds = %174
  store %struct.node*** %13, %struct.node**** %16, align 8
  %177 = load %struct.node*, %struct.node** %15, align 8
  %178 = icmp ne %struct.node* %177, null
  br i1 %178, label %179, label %185

179:                                              ; preds = %176
  %180 = load %struct.node*, %struct.node** %14, align 8
  %181 = icmp ne %struct.node* %180, null
  br i1 %181, label %182, label %186

182:                                              ; preds = %179
  %183 = call i32 @__VERIFIER_nondet_int()
  %184 = icmp ne i32 %183, 0
  br i1 %184, label %185, label %186

185:                                              ; preds = %182, %176
  store %struct.node** %14, %struct.node*** %17, align 8
  br label %187

186:                                              ; preds = %182, %179
  store %struct.node** %15, %struct.node*** %17, align 8
  br label %187

187:                                              ; preds = %186, %185
  %188 = load %struct.node**, %struct.node*** %17, align 8
  %189 = load %struct.node*, %struct.node** %188, align 8
  store %struct.node* %189, %struct.node** %18, align 8
  %190 = load %struct.node*, %struct.node** %18, align 8
  %191 = getelementptr inbounds %struct.node, %struct.node* %190, i32 0, i32 1
  %192 = load %struct.node*, %struct.node** %191, align 8
  %193 = load %struct.node**, %struct.node*** %17, align 8
  store %struct.node* %192, %struct.node** %193, align 8
  %194 = load %struct.node*, %struct.node** %18, align 8
  %195 = getelementptr inbounds %struct.node, %struct.node* %194, i32 0, i32 1
  store %struct.node* null, %struct.node** %195, align 8
  %196 = load %struct.node*, %struct.node** %18, align 8
  %197 = load %struct.node***, %struct.node**** %16, align 8
  %198 = load %struct.node**, %struct.node*** %197, align 8
  store %struct.node* %196, %struct.node** %198, align 8
  %199 = load %struct.node*, %struct.node** %18, align 8
  %200 = getelementptr inbounds %struct.node, %struct.node* %199, i32 0, i32 1
  %201 = load %struct.node***, %struct.node**** %16, align 8
  store %struct.node** %200, %struct.node*** %201, align 8
  br label %168

202:                                              ; preds = %174
  %203 = load %struct.list*, %struct.list** %11, align 8
  %204 = load %struct.list*, %struct.list** %10, align 8
  %205 = getelementptr inbounds %struct.list, %struct.list* %204, i32 0, i32 1
  store %struct.list* %203, %struct.list** %205, align 8
  %206 = load %struct.list*, %struct.list** %10, align 8
  store %struct.list* %206, %struct.list** %11, align 8
  %207 = load %struct.list*, %struct.list** %12, align 8
  %208 = getelementptr inbounds %struct.list, %struct.list* %207, i32 0, i32 1
  %209 = load %struct.list*, %struct.list** %208, align 8
  store %struct.list* %209, %struct.list** %10, align 8
  %210 = load %struct.list*, %struct.list** %12, align 8
  %211 = bitcast %struct.list* %210 to i8*
  call void @free(i8* %211) #5
  br label %145

212:                                              ; preds = %154, %145
  %213 = load %struct.list*, %struct.list** %11, align 8
  store %struct.list* %213, %struct.list** %10, align 8
  br label %134

214:                                              ; preds = %142
  %215 = load %struct.list*, %struct.list** %10, align 8
  store %struct.list* %215, %struct.list** %2, align 8
  %216 = load %struct.list*, %struct.list** %2, align 8
  store %struct.list* %216, %struct.list** %20, align 8
  %217 = load %struct.list*, %struct.list** %20, align 8
  %218 = getelementptr inbounds %struct.iterator, %struct.iterator* %19, i32 0, i32 0
  store %struct.list* %217, %struct.list** %218, align 8
  %219 = icmp ne %struct.list* %217, null
  br i1 %219, label %220, label %225

220:                                              ; preds = %214
  %221 = load %struct.list*, %struct.list** %20, align 8
  %222 = getelementptr inbounds %struct.list, %struct.list* %221, i32 0, i32 0
  %223 = load %struct.node*, %struct.node** %222, align 8
  %224 = getelementptr inbounds %struct.iterator, %struct.iterator* %19, i32 0, i32 1
  store %struct.node* %223, %struct.node** %224, align 8
  br label %225

225:                                              ; preds = %220, %214
  %226 = getelementptr inbounds %struct.iterator, %struct.iterator* %19, i32 0, i32 0
  %227 = load %struct.list*, %struct.list** %226, align 8
  %228 = icmp ne %struct.list* %227, null
  br i1 %228, label %230, label %229

229:                                              ; preds = %225
  store %struct.node* null, %struct.node** %21, align 8
  br label %256

230:                                              ; preds = %225
  %231 = getelementptr inbounds %struct.iterator, %struct.iterator* %19, i32 0, i32 1
  %232 = load %struct.node*, %struct.node** %231, align 8
  store %struct.node* %232, %struct.node** %22, align 8
  %233 = load %struct.node*, %struct.node** %22, align 8
  %234 = getelementptr inbounds %struct.node, %struct.node* %233, i32 0, i32 1
  %235 = load %struct.node*, %struct.node** %234, align 8
  %236 = getelementptr inbounds %struct.iterator, %struct.iterator* %19, i32 0, i32 1
  store %struct.node* %235, %struct.node** %236, align 8
  %237 = icmp ne %struct.node* %235, null
  br i1 %237, label %238, label %240

238:                                              ; preds = %230
  %239 = load %struct.node*, %struct.node** %22, align 8
  store %struct.node* %239, %struct.node** %21, align 8
  br label %255

240:                                              ; preds = %230
  %241 = getelementptr inbounds %struct.iterator, %struct.iterator* %19, i32 0, i32 0
  %242 = load %struct.list*, %struct.list** %241, align 8
  %243 = getelementptr inbounds %struct.list, %struct.list* %242, i32 0, i32 1
  %244 = load %struct.list*, %struct.list** %243, align 8
  %245 = getelementptr inbounds %struct.iterator, %struct.iterator* %19, i32 0, i32 0
  store %struct.list* %244, %struct.list** %245, align 8
  %246 = icmp ne %struct.list* %244, null
  br i1 %246, label %247, label %253

247:                                              ; preds = %240
  %248 = getelementptr inbounds %struct.iterator, %struct.iterator* %19, i32 0, i32 0
  %249 = load %struct.list*, %struct.list** %248, align 8
  %250 = getelementptr inbounds %struct.list, %struct.list* %249, i32 0, i32 0
  %251 = load %struct.node*, %struct.node** %250, align 8
  %252 = getelementptr inbounds %struct.iterator, %struct.iterator* %19, i32 0, i32 1
  store %struct.node* %251, %struct.node** %252, align 8
  br label %253

253:                                              ; preds = %247, %240
  %254 = load %struct.node*, %struct.node** %22, align 8
  store %struct.node* %254, %struct.node** %21, align 8
  br label %255

255:                                              ; preds = %253, %238
  br label %256

256:                                              ; preds = %255, %229
  br label %257

257:                                              ; preds = %291, %256
  %258 = load %struct.node*, %struct.node** %21, align 8
  %259 = icmp ne %struct.node* %258, null
  br i1 %259, label %260, label %292

260:                                              ; preds = %257
  %261 = getelementptr inbounds %struct.iterator, %struct.iterator* %19, i32 0, i32 0
  %262 = load %struct.list*, %struct.list** %261, align 8
  %263 = icmp ne %struct.list* %262, null
  br i1 %263, label %265, label %264

264:                                              ; preds = %260
  store %struct.node* null, %struct.node** %21, align 8
  br label %291

265:                                              ; preds = %260
  %266 = getelementptr inbounds %struct.iterator, %struct.iterator* %19, i32 0, i32 1
  %267 = load %struct.node*, %struct.node** %266, align 8
  store %struct.node* %267, %struct.node** %23, align 8
  %268 = load %struct.node*, %struct.node** %23, align 8
  %269 = getelementptr inbounds %struct.node, %struct.node* %268, i32 0, i32 1
  %270 = load %struct.node*, %struct.node** %269, align 8
  %271 = getelementptr inbounds %struct.iterator, %struct.iterator* %19, i32 0, i32 1
  store %struct.node* %270, %struct.node** %271, align 8
  %272 = icmp ne %struct.node* %270, null
  br i1 %272, label %273, label %275

273:                                              ; preds = %265
  %274 = load %struct.node*, %struct.node** %23, align 8
  store %struct.node* %274, %struct.node** %21, align 8
  br label %290

275:                                              ; preds = %265
  %276 = getelementptr inbounds %struct.iterator, %struct.iterator* %19, i32 0, i32 0
  %277 = load %struct.list*, %struct.list** %276, align 8
  %278 = getelementptr inbounds %struct.list, %struct.list* %277, i32 0, i32 1
  %279 = load %struct.list*, %struct.list** %278, align 8
  %280 = getelementptr inbounds %struct.iterator, %struct.iterator* %19, i32 0, i32 0
  store %struct.list* %279, %struct.list** %280, align 8
  %281 = icmp ne %struct.list* %279, null
  br i1 %281, label %282, label %288

282:                                              ; preds = %275
  %283 = getelementptr inbounds %struct.iterator, %struct.iterator* %19, i32 0, i32 0
  %284 = load %struct.list*, %struct.list** %283, align 8
  %285 = getelementptr inbounds %struct.list, %struct.list* %284, i32 0, i32 0
  %286 = load %struct.node*, %struct.node** %285, align 8
  %287 = getelementptr inbounds %struct.iterator, %struct.iterator* %19, i32 0, i32 1
  store %struct.node* %286, %struct.node** %287, align 8
  br label %288

288:                                              ; preds = %282, %275
  %289 = load %struct.node*, %struct.node** %23, align 8
  store %struct.node* %289, %struct.node** %21, align 8
  br label %290

290:                                              ; preds = %288, %273
  br label %291

291:                                              ; preds = %290, %264
  br label %257

292:                                              ; preds = %257
  br label %293

293:                                              ; preds = %313, %292
  %294 = load %struct.list*, %struct.list** %2, align 8
  %295 = icmp ne %struct.list* %294, null
  br i1 %295, label %296, label %317

296:                                              ; preds = %293
  %297 = load %struct.list*, %struct.list** %2, align 8
  %298 = getelementptr inbounds %struct.list, %struct.list* %297, i32 0, i32 1
  %299 = load %struct.list*, %struct.list** %298, align 8
  store %struct.list* %299, %struct.list** %24, align 8
  %300 = load %struct.list*, %struct.list** %2, align 8
  %301 = getelementptr inbounds %struct.list, %struct.list* %300, i32 0, i32 0
  %302 = load %struct.node*, %struct.node** %301, align 8
  store %struct.node* %302, %struct.node** %25, align 8
  br label %303

303:                                              ; preds = %306, %296
  %304 = load %struct.node*, %struct.node** %25, align 8
  %305 = icmp ne %struct.node* %304, null
  br i1 %305, label %306, label %313

306:                                              ; preds = %303
  %307 = load %struct.node*, %struct.node** %25, align 8
  %308 = getelementptr inbounds %struct.node, %struct.node* %307, i32 0, i32 1
  %309 = load %struct.node*, %struct.node** %308, align 8
  store %struct.node* %309, %struct.node** %26, align 8
  %310 = load %struct.node*, %struct.node** %25, align 8
  %311 = bitcast %struct.node* %310 to i8*
  call void @free(i8* %311) #5
  %312 = load %struct.node*, %struct.node** %26, align 8
  store %struct.node* %312, %struct.node** %25, align 8
  br label %303

313:                                              ; preds = %303
  %314 = load %struct.list*, %struct.list** %2, align 8
  %315 = bitcast %struct.list* %314 to i8*
  call void @free(i8* %315) #5
  %316 = load %struct.list*, %struct.list** %24, align 8
  store %struct.list* %316, %struct.list** %2, align 8
  br label %293

317:                                              ; preds = %293
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
