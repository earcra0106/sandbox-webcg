# WebGPU 仕様メモ

WebGPU は現代的な GPU API に近い設計を持つブラウザ向けグラフィックス API です。

このプロジェクトでは、WebGPU の利用前に `navigator.gpu` を確認し、未対応環境では明確なメッセージを表示します。

## 主な確認対象

- adapter と device の取得
- canvas context の設定
- WGSL シェーダー
- render pipeline、bind group、buffer、texture の管理
- command encoder と render pass の組み立て
- uniform buffer や storage buffer の扱い
- WebGL 実装との初期化コスト、記述量、設計差

