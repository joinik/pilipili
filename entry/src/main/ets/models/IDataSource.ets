interface IDataSource {
  totalCount(): number;
  getData(index: number): Object;
  registerDataChangeListener(listener: DataChangeListener): void;
  unregisterDataChangeListener(listener: DataChangeListener): void;
  notifyDataReload(): void;
  notifyDataAdd(index: number): void;
  notifyDataChange(index: number): void;
  notifyDataDelete(index: number): void;
}