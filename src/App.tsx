import { Canvas } from '@react-three/fiber';
import { PerspectiveCamera, Preload } from '@react-three/drei';
import { useRef } from 'react';
import { WebGLGate } from './app/WebGLGate';
import {
  TetrahedronScene,
  type DragRotationDelta,
} from './scenes/TetrahedronScene';

export default function App() {
  const dragDeltaRef = useRef<DragRotationDelta>({ x: 0, y: 0 });
  const dragStateRef = useRef({ active: false, x: 0, y: 0 });

  const handlePointerDown = (event: React.PointerEvent<HTMLDivElement>) => {
    dragStateRef.current = { active: true, x: event.clientX, y: event.clientY };
    event.currentTarget.setPointerCapture(event.pointerId);
  };

  const handlePointerMove = (event: React.PointerEvent<HTMLDivElement>) => {
    if (!dragStateRef.current.active) {
      return;
    }

    const nextX = event.clientX;
    const nextY = event.clientY;

    dragDeltaRef.current.x += nextX - dragStateRef.current.x;
    dragDeltaRef.current.y += nextY - dragStateRef.current.y;
    dragStateRef.current.x = nextX;
    dragStateRef.current.y = nextY;
  };

  const handlePointerEnd = (event: React.PointerEvent<HTMLDivElement>) => {
    dragStateRef.current.active = false;

    if (event.currentTarget.hasPointerCapture(event.pointerId)) {
      event.currentTarget.releasePointerCapture(event.pointerId);
    }
  };

  return (
    <main
      className="stage"
      aria-label="白い正四面体と回転する星空"
      onPointerDown={handlePointerDown}
      onPointerMove={handlePointerMove}
      onPointerUp={handlePointerEnd}
      onPointerCancel={handlePointerEnd}
      onPointerLeave={handlePointerEnd}
    >
      <WebGLGate>
        <Canvas
          gl={{ antialias: true, alpha: false, preserveDrawingBuffer: true }}
          dpr={[1, 2]}
          onCreated={({ gl }) => {
            gl.setClearColor('#000000', 1);
          }}
        >
          <PerspectiveCamera makeDefault position={[0, 0, 8]} fov={48} />
          <TetrahedronScene dragDeltaRef={dragDeltaRef} />
          <Preload all />
        </Canvas>
      </WebGLGate>
    </main>
  );
}
