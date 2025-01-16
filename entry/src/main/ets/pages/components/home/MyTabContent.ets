import { RcmdVideoItemModel } from "../../../models/RecVideoItem";
import VideoHttp from "../../services/Home";
import { promptAction, UIUtils } from '@kit.ArkUI';
import { BangumiListSource, HotVideoSource, LiveListSource, RcmdVideoSource } from "./MyTabLazy";
import { BangumiHttp } from "../../services/Bangumi";
import { BangumiItemModel } from "../../../models/bangumi/BangumiList";
import { LiveHttp } from "../../services/Live";
import { LiveItemModel } from "../../../models/LiveItem";
import { HotVideoItem } from "../../../models/HotVideoItem";
import { timestampTranslate, videoHMS, viewTranslate } from "../../utils/videoTools";
import { MyTextModifier } from "../../common/myStyles";

interface Args<T> {
  item: T;
  modifier: MyTextModifier;

  // constructor(item:T, mo:MyTextModifier) {
  //   this.item = item
  //   this.midifier = mo
  // }
}


@ComponentV2
export struct MyTabContent {
  private scroller: Scroller = new Scroller();
  @Local isShow: boolean = false;
  @Param @Require flagIndex: number
  @Local egLanes: LengthConstrain = UIUtils.makeObserved({ minLength: 100, maxLength: 400 })
  @Local bangumiList: BangumiListSource = new BangumiListSource()
  @Local rcmdVideos: RcmdVideoSource = new RcmdVideoSource()
  @Local liveList: LiveListSource = new LiveListSource()
  @Local hotList: HotVideoSource = new HotVideoSource()
  @Local currentBp: string = 'unknown';
  @Local isLoading: boolean = false
  @Local isWaitingForLoading: boolean = true
  @Local pageBangumi: number = 1
  @Local pageRcmd: number = 0
  @Local pageLive: number = 1
  @Local pageHot: number = 1;
  @Local myTextModifier: MyTextModifier = new MyTextModifier('fs10Gray')

  // 监听器
  @Monitor("flagIndex")
  onFlagIndex() {
    this.flagIndex != 3 ? this.egLanes.minLength = 150 : this.egLanes.minLength = 100
    switch (this.flagIndex) {
      case 0:
        // 直播tab
        LiveHttp.getList().then(res => {
          if (res.data) {
            this.liveList.items = res.data.list
            promptAction.showToast({ message: res.message });
          } else {
            promptAction.showToast({ message: res.message });
          }
        }).catch(() => {
          promptAction.showToast({ message: '请确保网络已连接' });
        })
        break
      case 2:
        console.log("热门")
        this.egLanes.minLength = 200
        VideoHttp.getHotVideoList(1, 20).then(res => {
          if (res.data) {
            this.hotList.items = res.data.list
            promptAction.showToast({ message: res.message })
          } else {
            promptAction.showToast({ message: res.message });
          }
        }).catch(() => {
          promptAction.showToast({ message: '请确保网络已连接' });
        })
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
      const resp = await VideoHttp.getRcmdVideoList(this.pageRcmd)
      if (resp.data && resp.data.item) {
        this.rcmdVideos.items = resp.data.item
        promptAction.showToast({ message: resp.message });
      } else {
        promptAction.showToast({ message: resp.message });
      }
    }
    setTimeout(() => {
      this.isWaitingForLoading = false
    }, 6000)
  }

  // 滑动触发
  onScroll = async (last: number) => {

    switch (this.flagIndex) {
      case 0:
        // 直播滑动
        const totalLive: number = this.liveList.totalCount() - 2
        if (last < totalLive) {
          break
        }
        try {
          this.pageLive += 1
          const res = await LiveHttp.getList(this.pageLive)
          if (res.data) {
            this.liveList.addBatchData(res.data.list)
          } else {
            promptAction.showToast({ message: res.message });
          }
        } catch (e) {
          promptAction.showToast({ message: '请确保网络已连接' });
        }
        break
      case 1:
        // 刷新推荐列表
        const totalRcmd: number = this.rcmdVideos.totalCount() - 2
        if (last > totalRcmd) {
          try {
            this.pageRcmd += 1
            const res = await VideoHttp.getRcmdVideoList(this.pageRcmd)
            if (res.data && res.data.item) {
              promptAction.showToast({ message: res.message });
              console.log('刷新列表数据------>')
              this.rcmdVideos.addBatchData(res.data.item)
            } else {
              promptAction.showToast({ message: res.message });
            }
          } catch (e) {
            promptAction.showToast({ message: '请确保网络已连接' });
          }
        }
        break
      case 2:
        // 滑动热门列表
        const totalHot: number = this.hotList.totalCount() - 2
        if (last > totalHot) {
          try {
            this.pageHot += 1
            const res = await VideoHttp.getHotVideoList(this.pageHot, 20)
            if (res.data) {
              promptAction.showToast({ message: res.message });
              this.hotList.addBatchData(res.data.list)
            } else {
              promptAction.showToast({ message: res.message });
            }
          } catch (e) {
            promptAction.showToast({ message: '请确保网络已连接' });
          }
        }
        break
      case 3:
        // 滑动番剧列表
        // 刷新番剧列表
        const totalBangumi: number = this.bangumiList.totalCount() - 6
        if (last > totalBangumi) {
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
        break

    }

  }

  build() {
    Column() {
      if (!this.rcmdVideos.totalCount()) {
        if (this.isWaitingForLoading) {
          LoadingProgress()
            .color(0xf04142)
            .width(70)
            .height(70)
            .margin({ top: 180 })
        } else {

        }
      } else {
        List({ space: 8, scroller: this.scroller }) {
          if (this.flagIndex == 1) {
            // 推荐tab页面
            LazyForEach(this.rcmdVideos, (item: RcmdVideoItemModel) => {
              ListItem() {
                RcmdTab({ item: item })
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
                  .margin({ top: 180, left: 180 })
              }
            } else {
              LazyForEach(this.bangumiList, (item: BangumiItemModel) => {
                ListItem() {
                  MyBangumi({ item: item })
                }
              }, (item: string) => item)
            }
          } else if (this.flagIndex == 2) {
            // 热门tab页面
            if (!this.hotList.totalCount()) {
              ListItem() {
                LoadingProgress()
                  .color(0xf04142)
                  .width(70)
                  .height(70)
                  .margin({ top: 180, left: 180 })
              }
            } else {
              LazyForEach(this.hotList, (item: HotVideoItem) => {
                ListItem() {
                  // MyHot(new Args(item, this.md))
                  MyHot({item:item, modifier:this.myTextModifier})
                }
              }, (item: string) => item)
            }
          } else {
            // 直播tab页面
            if (!this.liveList.totalCount()) {
              ListItem() {
                LoadingProgress()
                  .color(0xf04142)
                  .width(70)
                  .height(70)
                  .margin({ top: 180, left: 180 })
              }
            } else {
              LazyForEach(this.liveList, (item: LiveItemModel) => {
                ListItem() {
                  LiveTab({ liveItem: item })
                }
              }, (item: string) => item)
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
struct LiveTab {
  @Param @Require liveItem: LiveItemModel

  build() {
    Column({ space: 5 }) {
      Stack({ alignContent: Alignment.BottomStart }) {
        Image(this.liveItem.cover)
          .borderRadius(10)// .width(100)
          .height(160)
        Text(this.liveItem.area_name)
          .fontColor(0xffffffff)
          .fontSize(12)
          .margin({ left: 10, bottom: 5 })
        Text(this.liveItem.watched_show.text_small).fontColor(0xffffffff).fontSize(12)
          .margin({ left: 130, bottom: 5 })
      }

      Text(this.liveItem.title).fontSize(14)
      Text(this.liveItem.uname).fontSize(12).fontColor(Color.Gray)
    }.alignItems(HorizontalAlign.Start)
    .onClick(() => {
      console.log(JSON.stringify(this.liveItem))
    })

  }
}

@ComponentV2({ freezeWhenInactive: true })
struct RcmdTab {
  @Require @Param item: RcmdVideoItemModel

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


@Builder
function MyHot(arg0: Args<HotVideoItem>) {
  Column() {
    Flex({ justifyContent: FlexAlign.SpaceAround }) {
      Stack({ alignContent: Alignment.BottomEnd }) {
        Image(arg0.item.pic)
          .height(100)
          .width('100%')
          .borderRadius(8)
        Text(videoHMS((arg0.item.duration / 60).toFixed(2)))
          .margin({ right: 8 })
          .padding(4)
          .opacity(0.6)
          .borderRadius(4)
          .fontColor('#fff')
          .backgroundColor('#121813')
          .fontSize(10)
      }.width('100%')
      .margin({ right: 10 })

      Column({ space: 5 }) {
        Text(arg0.item.title)
          .fontSize(14)
          .height(49)
          .maxLines(3)
        Text(timestampTranslate(arg0.item.pubdate))
          .margin({ top: 5 })
          .fs10Gray()
        Text(arg0.item.owner.name)
          // .fs10Gray()
          .attributeModifier(arg0.modifier)


        Flex() {
          // 播放数
          Text($r('app.media.play_circle_fill'))
          .fs10Gray()

          Text(viewTranslate(arg0.item.stat.view))
            .fs10Gray()
          // 评论数
          Text() {
            ImageSpan($r('sys.symbol.list_bullet_square_fill'))
          }
          .fs10Gray()

          Text(arg0.item.stat.reply?.toString())
            .fs10Gray()
        }
      }.alignItems(HorizontalAlign.Start)
    }
    .width('100%')
  }
}

@Extend(Text)
function fs10Gray() {
  .fontSize(10)
  .fontColor(Color.Gray)
  .margin({ left: 5 })
}
