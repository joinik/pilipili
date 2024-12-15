import { RecVideoItemModel } from '../../../models/RecVideoItem';

class BasicDataSource implements IDataSource {
  public listeners: DataChangeListener[] = [];

  public totalCount(): number {
    return 0;
  }

  public getData(index: number): Object {
    return Object;
  }

  registerDataChangeListener(listener: DataChangeListener): void {
    if (this.listeners.indexOf(listener) < 0) {
      console.info('add listener');
      this.listeners.push(listener);
    }
  }

  unregisterDataChangeListener(listener: DataChangeListener): void {
    const pos = this.listeners.indexOf(listener);
    if (pos >= 0) {
      console.info('remove listener');
      this.listeners.splice(pos, 1);
    }
  }

  notifyDataReload(): void {
    this.listeners.forEach(listener => {
      listener.onDataReloaded();
    })
  }

  notifyDataAdd(index: number): void {
    this.listeners.forEach(listener => {
      listener.onDataAdd(index);
    })
  }

  notifyDataChange(index: number): void {
    this.listeners.forEach(listener => {
      listener.onDataChange(index);
    })
  }

  notifyDataDelete(index: number): void {
    this.listeners.forEach(listener => {
      listener.onDataDelete(index);
    })
  }

  notifyDataMove(from: number, to: number): void {
    this.listeners.forEach(listener => {
      listener.onDataMove(from, to);
    })
  }
}

export class RecVideoSource extends BasicDataSource {
  public items: RecVideoItemModel[] = []

  public totalCount(): number {
    return this.items.length;
  }

  public getData(index: number): RecVideoItemModel {
    return this.items[index];
  }

  public addData(index: number, data: RecVideoItemModel): void {
    this.items.splice(index, 0, data);
    this.notifyDataAdd(index);
  }

  public addBatchData(data: RecVideoItemModel[]): void {
    this.items = this.items.concat(data)
    this.notifyDataAdd(this.items.length - 1);
  }

  public pushData(data: RecVideoItemModel): void {
    this.items.push(data);
    this.notifyDataAdd(this.items.length - 1);
  }
}


