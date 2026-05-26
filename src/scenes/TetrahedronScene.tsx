import { useFrame } from '@react-three/fiber';
import { useMemo, useRef, type RefObject } from 'react';
import { Quaternion, Vector3, type Group, type Points } from 'three';
import {
  createRandomRotationAxis,
  createStarPositions,
} from './tetrahedronSceneModel';

export type DragRotationDelta = {
  x: number;
  y: number;
};

type TetrahedronSceneProps = {
  dragDeltaRef: RefObject<DragRotationDelta>;
};

const starCount = 900;
const starRadius = 42;
const autoRotationSpeed = 0.35;
const dragRotationSpeed = 0.006;

export function TetrahedronScene({ dragDeltaRef }: TetrahedronSceneProps) {
  const groupRef = useRef<Group>(null);
  const starsRef = useRef<Points>(null);
  const autoAxis = useMemo(() => createRandomRotationAxis(), []);
  const starPositions = useMemo(
    () => createStarPositions({ count: starCount, radius: starRadius }),
    [],
  );

  useFrame((_, delta) => {
    const group = groupRef.current;

    if (!group) {
      return;
    }

    const autoRotation = new Quaternion().setFromAxisAngle(
      autoAxis,
      delta * autoRotationSpeed,
    );
    group.quaternion.multiply(autoRotation);

    const dragDelta = dragDeltaRef.current;
    if (dragDelta && (dragDelta.x !== 0 || dragDelta.y !== 0)) {
      const dragAxis = new Vector3(dragDelta.y, dragDelta.x, 0);
      const dragLength = dragAxis.length();

      if (dragLength > 0) {
        dragAxis.normalize();
        const dragRotation = new Quaternion().setFromAxisAngle(
          dragAxis,
          dragLength * dragRotationSpeed,
        );
        group.quaternion.premultiply(dragRotation);
      }

      dragDelta.x = 0;
      dragDelta.y = 0;
    }

    if (starsRef.current) {
      starsRef.current.rotation.y += delta * 0.015;
    }
  });

  return (
    <group ref={groupRef}>
      <points ref={starsRef}>
        <bufferGeometry>
          <bufferAttribute
            attach="attributes-position"
            args={[starPositions, 3]}
          />
        </bufferGeometry>
        <pointsMaterial
          color="#ffffff"
          size={0.085}
          sizeAttenuation
          depthWrite={false}
        />
      </points>

      <mesh>
        <tetrahedronGeometry args={[1.7, 0]} />
        <meshStandardMaterial
          color="#ffffff"
          roughness={0.42}
          metalness={0.04}
        />
      </mesh>

      <ambientLight intensity={1.2} />
      <directionalLight position={[4, 5, 6]} intensity={2.4} />
    </group>
  );
}
