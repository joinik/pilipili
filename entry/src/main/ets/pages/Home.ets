import { MyTabContent } from "./components/home/MyTabContent";
import SearchCP from "./components/SearchCP";

@ComponentV2
export default struct Home {
  @Local currentIndex: number = 1;

  @Builder
  TabBuilder(text: string | Resource, index: number) {
    Column() {
      Text(text).fontSize(12).fontColor(this.currentIndex == index ? "#000" : "#a0a0a0")
      Divider()
        .margin({ top: 10 })
        .width(26)
        .height(3)
        .backgroundColor(this.currentIndex == index ? Color.Black : Color.White)
    }.width("100%")
    .height("100%")
    .justifyContent(FlexAlign.Center)
    .onClick(() => {

      this.currentIndex = index
      console.log(this.currentIndex + ">>>>")
    })
  }

  build() {
    Column() {
      // 搜索框
      SearchCP()
      // tab页组件
      Tabs() {
        TabContent() {
          MyTabContent({ flagIndex: this.currentIndex })
        }.tabBar(this.TabBuilder('直播', 0))

        TabContent() {
          MyTabContent({ flagIndex: this.currentIndex })

        }.tabBar(this.TabBuilder('推荐', 1))

        TabContent() {
          MyTabContent({ flagIndex: this.currentIndex})

        }.tabBar(this.TabBuilder('热门', 2))

        TabContent() {
          MyTabContent({ flagIndex: this.currentIndex })
        }.tabBar(this.TabBuilder('番剧', 3))
      }
      .onChange((val) => {
        this.currentIndex = val
      })
    }
  }
}