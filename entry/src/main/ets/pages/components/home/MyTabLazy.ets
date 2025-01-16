import { BangumiItemModel } from '../../../models/bangumi/BangumiList';
import { HotVideoItem } from '../../../models/HotVideoItem';
import { LiveItemModel } from '../../../models/LiveItem';
import { RcmdVideoItemModel } from '../../../models/RecVideoItem';

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

@ObservedV2
export class HotVideoSource extends BasicDataSource {
  @Trace
  public items: HotVideoItem[] = []

  public totalCount(): number {
    return this.items.length;
  }

  public getData(index: number): HotVideoItem {
    return this.items[index];
  }

  public addData(index: number, data: HotVideoItem): void {
    this.items.splice(index, 0, data);
    this.notifyDataAdd(index);
  }

  public addBatchData(data: HotVideoItem[]): void {
    this.items = this.items.concat(data)
    this.notifyDataAdd(this.items.length - 1);
  }

  public pushData(data: HotVideoItem): void {
    this.items.push(data);
    this.notifyDataAdd(this.items.length - 1);
  }
}


@ObservedV2
export class RcmdVideoSource extends BasicDataSource {
  @Trace
  public items: RcmdVideoItemModel[] = []

  public totalCount(): number {
    return this.items.length;
  }

  public getData(index: number): RcmdVideoItemModel {
    return this.items[index];
  }

  public addData(index: number, data: RcmdVideoItemModel): void {
    this.items.splice(index, 0, data);
    this.notifyDataAdd(index);
  }

  public addBatchData(data: RcmdVideoItemModel[]): void {
    this.items = this.items.concat(data)
    this.notifyDataAdd(this.items.length - 1);
  }

  public pushData(data: RcmdVideoItemModel): void {
    this.items.push(data);
    this.notifyDataAdd(this.items.length - 1);
  }
}

@ObservedV2
export class LiveListSource extends BasicDataSource {
  @Trace
  public items: LiveItemModel[] = []

  public totalCount(): number {
    return this.items.length;
  }

  public getData(index: number): LiveItemModel {
    return this.items[index];
  }

  public addData(index: number, data: LiveItemModel): void {
    this.items.splice(index, 0, data);
    this.notifyDataAdd(index);
  }

  public addBatchData(data: LiveItemModel[]): void {
    this.items = this.items.concat(data)
    this.notifyDataAdd(this.items.length - 1);
  }

  public pushData(data: LiveItemModel): void {
    this.items.push(data);
    this.notifyDataAdd(this.items.length - 1);
  }
}
@ObservedV2
export class BangumiListSource extends BasicDataSource {
  @Trace
  public items: BangumiItemModel[] = []

  public totalCount(): number {
    return this.items.length;
  }

  public getData(index: number): BangumiItemModel {
    return this.items[index];
  }

  public addData(index: number, data: BangumiItemModel): void {
    this.items.splice(index, 0, data);
    this.notifyDataAdd(index);
  }

  public addBatchData(data: BangumiItemModel[]): void {
    this.items = this.items.concat(data)
    this.notifyDataAdd(this.items.length - 1);
  }

  public pushData(data: BangumiItemModel): void {
    this.items.push(data);
    this.notifyDataAdd(this.items.length - 1);
  }
}