# 推奨ディレクトリ構成

実装を追加する場合は、Vite、TypeScript、React、Three.js を前提に次の構成を基本案とします。既存のフレームワークやビルド設定が導入された場合は、その慣習を優先してください。

```text
.
├── .codex/
│   └── skills/
├── .gitignore
├── .prettierrc
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
├── eslint.config.js
├── index.html
├── package.json
├── pnpm-lock.yaml
├── tsconfig.json
├── tsconfig.app.json
├── tsconfig.node.json
├── temp/
├── vite.config.ts
├── vitest.config.ts
└── src/
    ├── main.tsx
    ├── App.tsx
    ├── app/
    ├── scenes/
    │   └── TetrahedronScene.tsx
    ├── components/
    ├── objects/
    ├── controls/
    ├── styles/
    └── test/
```

`temp/` は作業再開用の一時メモ置き場として使い、Git 管理対象外にします。

テストは実装ファイルの近くに `*.spec.ts` または `*.spec.tsx` として配置するか、対象領域の `__tests__/` に配置します。

関数を作成する場合は、まず対応する spec ファイルを作成し、通ることを確認してから実装します。
