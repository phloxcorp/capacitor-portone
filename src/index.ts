import { registerPlugin } from '@capacitor/core';

import type { CapacitorPortOnePlugin } from './definitions';

const CapacitorPortOne = registerPlugin<CapacitorPortOnePlugin>('CapacitorPortOne', {
  web: () => import('./web').then((m) => new m.CapacitorPortOneWeb()),
});

export * from './definitions';
export { CapacitorPortOne };
