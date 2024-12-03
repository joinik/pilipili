@Component
export struct MyTabContent {
  @Prop flagIndex:number

  @State bgColors: Color[] = [Color.Red, Color.Orange, Color.Yellow, Color.Green, Color.Pink, Color.Grey, Color.Blue, Color.Brown];
  @State currentBp: string = 'unknown';


  build() {
    GridRow({ columns: 2 }) {
      ForEach(this.bgColors, (item: Color, index?: number | undefined) => {
        GridCol() {
          Row() {
            Text(`${index}`)
          }.width('100%').height('50')
        }.backgroundColor(item)
      })
    }
  }
}