# 推奨ディレクトリ構成

実装を追加する場合は、次のような構成を基本案とします。既存のフレームワークやビルド設定が導入された場合は、その慣習を優先してください。

```text
.
├── AGENTS.md
├── README.md
├── docs/
│   ├── PROJECT_SPEC.md
│   ├── issues/
│   ├── specs/
│   │   ├── README.md
│   │   ├── project-overview.md
│   │   ├── webgl.md
│   │   └── webgpu.md
│   └── tasks/
├── src/
│   ├── main.ts
│   ├── experiments/
│   │   └── <experiment-name>/
│   │       ├── index.ts
│   │       ├── webgl.ts
│   │       ├── webgpu.ts
│   │       └── README.md
│   ├── renderers/
│   │   ├── webgl/
│   │   └── webgpu/
│   └── shaders/
│       ├── glsl/
│       └── wgsl/
└── tests/
```

