import { Vector3 } from 'three';

type RandomSource = () => number;

export type StarPositionOptions = {
  count: number;
  radius: number;
  random?: RandomSource;
};

export function createRandomRotationAxis(
  random: RandomSource = Math.random,
): Vector3 {
  const axis = new Vector3(random() - 0.5, random() - 0.5, random() - 0.5);

  if (axis.lengthSq() === 0) {
    return new Vector3(0, 1, 0);
  }

  return axis.normalize();
}

export function createStarPositions({
  count,
  radius,
  random = Math.random,
}: StarPositionOptions): Float32Array {
  const positions = new Float32Array(count * 3);

  for (let index = 0; index < count; index += 1) {
    const z = random() * 2 - 1;
    const theta = random() * Math.PI * 2;
    const radial = Math.sqrt(1 - z * z);
    const offset = index * 3;

    positions[offset] = Math.cos(theta) * radial * radius;
    positions[offset + 1] = Math.sin(theta) * radial * radius;
    positions[offset + 2] = z * radius;
  }

  return positions;
}
