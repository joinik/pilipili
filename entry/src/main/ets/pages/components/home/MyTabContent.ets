import { RecVideoItemModel } from "../../../models/RecVideoItem";
import VideoHttp from "../../services/Home";
import { promptAction, UIUtils } from '@kit.ArkUI';
import { BangumiListSource, RecVideoSource } from "./MyTabLazy";
import { OfflinePage } from "../OffLinePage";
import { BangumiHttp } from "../../services/Bangumi";
import { BangumiItemModel } from "../../../models/bangumi/BangumiList";

@ComponentV2
export struct MyTabContent {
  private scroller: Scroller = new Scroller();
  @Local isShow: boolean = false;
  @Param @Require flagIndex: number
  @Local egLanes: LengthConstrain = UIUtils.makeObserved({ minLength: 100, maxLength: 300 })
  @Local bangumiList: BangumiListSource = new BangumiListSource()
  @Local recVideos: RecVideoSource = new RecVideoSource()
  @Local currentBp: string = 'unknown';
  @Local isLoading: boolean = false
  @Local isWaitingForLoading: boolean = true
  @Local pageBangumi: number = 1
  @Local pageRecm: number = 0

  // 监听器
  @Monitor("flagIndex")
  onFlagIndex() {
    this.flagIndex != 3 ? this.egLanes.minLength = 150 : this.egLanes.minLength = 100
    switch (this.flagIndex) {
      case 0:
        // 直播tab
        console.log("直播")
        break
      case 2:
        console.log("直播")
        // 热门tab
        break
      case 3:
        // 番剧tab
        console.log("番剧tab-》》》》》")
        BangumiHttp.getList().then(res => {
          if (res.data) {
            this.bangumiList.items = res.data.list
          } else {
            promptAction.showToast({ message: res.message });
          }
        }).catch(() => {
          promptAction.showToast({ message: '请确保网络已连接' });
        })
        break
    }
  }

  // 生命周期函数
  async aboutToAppear() {
    if (this.flagIndex == 1) {
      this.egLanes.minLength = 150
      const resp = await VideoHttp.getRcmdVideoList(this.pageRecm)
      if (resp.data) {
        this.recVideos.items = resp.data.item
        promptAction.showToast({ message: resp.message });
      } else {
        promptAction.showToast({ message: resp.message });
      }
    }
  }

  // 滑动触发
  onScroll = async (last: number) => {
    if (this.flagIndex == 3) {
      // 刷新番剧列表
      const total: number = this.bangumiList.totalCount() - 6
      if (last > total) {
        try {
          this.pageBangumi += 1
          const res = await BangumiHttp.getList(-1, -1, this.pageBangumi)
          if (res.data) {
            promptAction.showToast({ message: res.message });
            this.bangumiList.addBatchData(res.data.list)
          } else {
            promptAction.showToast({ message: res.message });
          }
        } catch (e) {
          promptAction.showToast({ message: '1111111请确保网络已连接' });
        }
      }
    } else if (this.flagIndex == 1) {
      // 刷新推荐列表
      const total: number = this.recVideos.totalCount() - 2
      if (last > total) {
        try {
          this.pageRecm += 1
          const res = await VideoHttp.getRcmdVideoList(this.pageRecm)
          if (res.data?.item) {
            promptAction.showToast({ message: res.message });
            console.log('刷新列表数据------>')
            this.recVideos.addBatchData(res.data.item)
          } else {
            promptAction.showToast({ message: res.message });
          }
        } catch (e) {
          promptAction.showToast({ message: '请确保网络已连接' });
        }
      }
    }
  }

  build() {
    Column() {
      if (!this.recVideos.totalCount()) {
        LoadingProgress()
          .color(0xf04142)
          .width(70)
          .height(70)
          .margin({ top: 180 })
      } else {
        List({ space: 8, scroller: this.scroller }) {
          if (this.flagIndex == 1) {
            // 推案tab页面
            LazyForEach(this.recVideos, (item: RecVideoItemModel) => {
              ListItem() {
                MyContent({ item: item })
              }
            }, (item: string) => item)
          } else if (this.flagIndex == 3) {
            // 番剧tab 页面
            if (!this.bangumiList.totalCount()) {
              ListItem() {
                LoadingProgress()
                  .color(0xf04142)
                  .width(70)
                  .height(70)
                  .margin({ top: 180 , left:180})
              }
            } else {
              LazyForEach(this.bangumiList, (item: BangumiItemModel) => {
                ListItem() {
                  MyBangumi({ item: item })
                }
              }, (item: string) => item)
            }
          } else if (this.flagIndex == 2) {
            // 直播tab页面
            ListItem() {
              Text('直播').onClick(() => {
                console.log('this.flagIndex', this.flagIndex)
              })
            }
          } else {
            // 热门tab页面
            ListItem() {
              Text('直播2222').onClick(() => {
                console.log('this.flagIndex>>>>>>>>', this.flagIndex)
              })
            }
          }
        }
        // 设置列数，列间距
        .lanes(this.egLanes, 8)
        .scrollBar(BarState.Off)
        .cachedCount(20)
        .onScrollIndex(async (_first: number, last: number) => {
          this.onScroll(last)
        })
      }
    }.height('100%')
  }
}

@ComponentV2({ freezeWhenInactive: true })
struct MyContent {
  @Require @Param item: RecVideoItemModel

  build() {
    Column({ space: 5 }) {
      Image(this.item.pic)
        .height(100)// .width('100vp')
        .borderRadius(8)
      Text(this.item.title)
        .fontSize(14)
        .maxLines(2)
        .constraintSize({ maxWidth: 200 })
        .textOverflow({ overflow: TextOverflow.Ellipsis })
        .margin({ left: 10, right: 10 })
      Row() {
        if (this.item.is_followed) {
          Text('已关注')
            .backgroundColor('#cef2d3')
            .fontColor('#6fa881')
            .fontSize(12)
        }
        Text(this.item.owner ? this.item.owner.name : "")
          .fontColor('#ff9aa09b')
          .fontSize(12)
        // 三点设置按钮
        Image($r("app.media.more"))
          .width(13)
          .height(16)
      }
      .padding({ left: 10, right: 10, bottom: 10 })
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
    }
    .backgroundColor('#eff4ee')
    .borderRadius('8%')
    .borderWidth({ bottom: 2 })
    .borderColor({ bottom: '#dde0db' })
    .height(170)
  }
}

@ComponentV2({ freezeWhenInactive: true })
struct MyBangumi {
  @Require @Param item: BangumiItemModel

  build() {
    Column() {
      Stack({ alignContent: Alignment.TopEnd }) {
        Image(this.item.cover)
          .borderRadius(10)// .width(100)
          .height(160)
        Text(this.item.badge)
          .fontSize(12)
          .backgroundColor('#475d92')
          .fontColor('#ffffff')
          .borderRadius(4)
          .padding(4)
          .margin({ top: 5, right: 5 })
        Text(this.item.order)
          .fontColor('#ffffff')
          .margin({ top: 135, right: 25 })
          .fontSize(10)
          .padding(4)
          .opacity(0.8)
          .borderRadius(4)
          .backgroundColor('#5a7678')
      }
      Text(this.item.title)
        .fontSize(14)
        .padding({ top: 8, left: 4, bottom: 8 })
        .maxLines(1)
        .textOverflow({ overflow: TextOverflow.Ellipsis })
      Text(this.item.index_show)
        .fontSize(12)
        .padding({ left: 4 })
        .fontColor(Color.Gray)
    }
    .alignItems(HorizontalAlign.Start)
  }
}