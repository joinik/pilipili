import {MyTabContent} from "./components/home/MyTabContent";
import SearchCP from "./components/SearchCP";

@Component
export default struct Home {
  @State message: string = '首页';
  @State currentIndex: number = 1;
  @Builder
  TabBuilder(text: string | Resource, index: number) {
    Column() {
      Text(text).fontSize(12).fontColor(this.currentIndex == index ? "#000" : "#a0a0a0")
      Row().margin({top:10}).width(26).height(3).backgroundColor(this.currentIndex == index ? Color.Black : Color.White)
    }.width("100%")
    .height("100%")
    .justifyContent(FlexAlign.Center)
  }

  build() {
    Column() {
      // 搜索框
      SearchCP()
      // tab页
      Tabs() {
        TabContent() {
            MyTabContent({ flagIndex: 0 })
        }.tabBar(this.TabBuilder('直播', 0))

        TabContent() {
            MyTabContent({ flagIndex: 1 })

        }.tabBar(this.TabBuilder('推荐', 1))

        TabContent() {
            MyTabContent({ flagIndex: 2 })

        }.tabBar(this.TabBuilder('热门', 2))

        TabContent() {
            MyTabContent({ flagIndex: 3 })
        }.tabBar(this.TabBuilder('番剧', 3))
      }
      .onChange((val) => {
        this.currentIndex = val
      })
    }
  }
}