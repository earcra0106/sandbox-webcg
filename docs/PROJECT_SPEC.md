# Project Spec Index

`sandbox-webcg` は、ウェブページ上で CG 表現を試すための実験プロジェクトです。

このファイルは、Codex と開発者が後から必要な仕様だけを参照できるようにするための目次です。詳細は `docs/specs/` 配下の分割ファイルに記載します。

## Specs

- [プロジェクト概要](./specs/project-overview.md)
- [WebGL 仕様メモ](./specs/webgl.md)
- [WebGPU 仕様メモ](./specs/webgpu.md)
- [推奨ディレクトリ構成](./specs/directory-structure.md)
- [実験追加時の記録ルール](./specs/experiment-records.md)
- [実装ガイドライン](./specs/implementation-guidelines.md)
- [UI 方針](./specs/ui-guidelines.md)
- [動作確認方針](./specs/verification.md)

## Environment And Packages

2026-05-26 時点では、最初の実装目標として白い正四面体と回転する星空背景を表示するアプリを想定しています。

使用技術は Vite、TypeScript、React、ESLint、Prettier、Three.js、Vitest を基本とします。

`@react-three/fiber`、`@react-three/drei`、`gsap` などの補助ライブラリを導入した場合は、導入した技術名と導入目的を `docs/specs/` 配下に記録し、この目次からリンクしてください。
