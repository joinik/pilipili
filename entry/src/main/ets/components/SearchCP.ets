@Component
export default struct SearchCP {
  build() {
    Row({ space: 5 }) {
      Row() {
        Text('󰀩').width(20).fontWeight(FontWeight.Bold)
        TextInput({ placeholder: "meta70怎么样" })
          .backgroundColor("#e9f4e9")
          .placeholderFont({ size: 12 })
          .layoutWeight(1)
      }
      .backgroundColor("#e9f4e9")
      .width("90%")
      .height(40)
      .borderRadius("50%")
      .padding({left:20, right:20})

      // 用户头像
      Image($r("app.media.head")).width(30)

    }.width("100%")

  }
}