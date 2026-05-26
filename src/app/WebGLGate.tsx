import { type ReactNode, useMemo } from 'react';
import { detectWebGLSupport } from './webglSupport';

type WebGLGateProps = {
  children: ReactNode;
};

export function WebGLGate({ children }: WebGLGateProps) {
  const support = useMemo(() => detectWebGLSupport(), []);

  if (!support.supported) {
    return (
      <div className="fallback" role="status">
        このブラウザでは WebGL
        を利用できないため、正四面体と星空を表示できません。
      </div>
    );
  }

  return children;
}
