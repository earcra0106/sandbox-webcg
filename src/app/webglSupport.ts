export type WebGLSupport =
  | {
      supported: true;
      version: 'webgl2' | 'webgl';
    }
  | {
      supported: false;
      version: null;
    };

type CreateCanvas = () => HTMLCanvasElement | null;

const defaultCreateCanvas: CreateCanvas = () => {
  if (typeof document === 'undefined') {
    return null;
  }

  return document.createElement('canvas');
};

export function detectWebGLSupport(
  createCanvas: CreateCanvas = defaultCreateCanvas,
): WebGLSupport {
  const canvas = createCanvas();

  if (!canvas) {
    return { supported: false, version: null };
  }

  if (canvas.getContext('webgl2')) {
    return { supported: true, version: 'webgl2' };
  }

  if (canvas.getContext('webgl')) {
    return { supported: true, version: 'webgl' };
  }

  return { supported: false, version: null };
}
