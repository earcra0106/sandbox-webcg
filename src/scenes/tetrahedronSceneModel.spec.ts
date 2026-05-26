import { describe, expect, it } from 'vitest';
import {
  createRandomRotationAxis,
  createStarPositions,
} from './tetrahedronSceneModel';

describe('createRandomRotationAxis', () => {
  it('正規化された回転軸を生成する', () => {
    const axis = createRandomRotationAxis(() => 0.25);

    expect(axis.length()).toBeCloseTo(1);
  });

  it('乱数が偏ってもゼロベクトルを返さない', () => {
    const axis = createRandomRotationAxis(() => 0.5);

    expect(axis.length()).toBeCloseTo(1);
  });
});

describe('createStarPositions', () => {
  it('指定した数の星座標を生成する', () => {
    const positions = createStarPositions({
      count: 4,
      radius: 10,
      random: () => 0.25,
    });

    expect(positions).toHaveLength(12);
  });

  it('天球半径付近に星を配置する', () => {
    const positions = createStarPositions({
      count: 1,
      radius: 10,
      random: () => 0.25,
    });
    const distance = Math.hypot(positions[0], positions[1], positions[2]);

    expect(distance).toBeCloseTo(10);
  });
});
