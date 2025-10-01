export interface CapacitorPortOnePlugin {
  echo(options: { value: string }): Promise<{ value: string }>;
}
