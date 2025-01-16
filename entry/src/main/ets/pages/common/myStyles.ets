export class MyTextModifier implements  AttributeModifier<TextAttribute> {
  private fs10Gray: string = ''
  constructor(str:string) {
    if (str === 'fs10Gray') {
      this.fs10Gray = str
    }
  }

  // 普通状态 设置text的fs为10 color为Gray
  applyNormalAttribute(instance: TextAttribute): void {
    if (this.fs10Gray === 'fs10Gray') {
      // 设置text的fs为10 color为Gray
      instance.fontSize(10)
        .fontColor(Color.Gray)
      return
    } else {

    }
  }

}

