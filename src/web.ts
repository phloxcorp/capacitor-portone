import { WebPlugin } from '@capacitor/core';

import type { CapacitorPortOnePlugin } from './definitions';

export class CapacitorPortOneWeb extends WebPlugin implements CapacitorPortOnePlugin {
  async echo(options: { value: string }): Promise<{ value: string }> {
    console.log('ECHO', options);
    return options;
  }
}
