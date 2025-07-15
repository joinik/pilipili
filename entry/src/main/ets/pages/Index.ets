import Home from './Home';
import Personal from './Personal';
import Trend from './Trend';
import { AppStorageV2, SymbolGlyphModifier } from '@kit.ArkUI';

@Entry
@ComponentV2
struct Index {
  pathStack: NavPathStack = new NavPathStack();
  @Local currentIndex: number = 0;

  // 全局设置一个NavPathStack
  aboutToAppear(): void {
    AppStorageV2.connect(NavPathStack, 'navPathStack', () => this.pathStack)
  }

  @Builder
  TabBuilder(image: string, activeImage: string, text: string | Resource, index: number) {
    Column() {
      Text(this.currentIndex == index ? activeImage : image).width(28).height(28).margin({ left: 10 })
      Text(text).fontSize(12).fontColor(this.currentIndex == index ? "#000" : "#a0a0a0")
    }.width("100%")
    .height("100%")
    .justifyContent(FlexAlign.Center)
  }

  build() {
    // 采用相对布局
    Navigation(this.pathStack) {
      Column() {
        Tabs({ barPosition: BarPosition.End, index: this.currentIndex }) {
          // 首页
          TabContent() {
            Home()
          }.tabBar(this.TabBuilder('󰀥', '󰀡', $r('app.string.Home'), 0))

          // 动态
          TabContent() {
            Trend()
          }.tabBar(this.TabBuilder('󰗷', '󰗷', $r('app.string.dynamic'), 1))

          // 个人中心
          TabContent() {
            Personal()
          }.tabBar(this.TabBuilder('󰝵', '󰝴', $r('app.string.personal'), 2))
        }.onChange((val) => {
          this.currentIndex = val
        }).scrollable(false)
      }.width('100%').height('100%').padding(10)
    }.hideTitleBar(true)
  }
}