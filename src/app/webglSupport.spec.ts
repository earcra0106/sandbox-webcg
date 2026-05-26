import { describe, expect, it, vi } from 'vitest';
import { detectWebGLSupport } from './webglSupport';

describe('detectWebGLSupport', () => {
  it('WebGL 2 を優先して対応可否を返す', () => {
    const context = {};
    const canvas = {
      getContext: vi.fn((name: string) => (name === 'webgl2' ? context : null)),
    } as unknown as HTMLCanvasElement;

    expect(detectWebGLSupport(() => canvas)).toEqual({
      supported: true,
      version: 'webgl2',
    });
    expect(canvas.getContext).toHaveBeenCalledWith('webgl2');
  });

  it('WebGL 2 がない場合は WebGL 1 を確認する', () => {
    const context = {};
    const canvas = {
      getContext: vi.fn((name: string) => (name === 'webgl' ? context : null)),
    } as unknown as HTMLCanvasElement;

    expect(detectWebGLSupport(() => canvas)).toEqual({
      supported: true,
      version: 'webgl',
    });
  });

  it('canvas を作れない場合は未対応を返す', () => {
    expect(detectWebGLSupport(() => null)).toEqual({
      supported: false,
      version: null,
    });
  });
});
