import { Guide, GuideArea, guideController, TranAreaMask } from 'guide';
import { CustomGuideParams } from './CustomGuideParams';

@Builder
function builder(params: CustomGuideParams) {
  Column() {
    Text(`${params.count}`)
      .fontColor(Color.White)

    Image($r('sys.media.ohos_ic_public_close'))
      .size({
        width: 100,
        height: 100
      })
      .onClick(() => {
        guideController.dismiss();
      })
  }
  .justifyContent(FlexAlign.Center)
  .height('100%')
  .width('100%')
  .onClick(() => {
    params.count++;
    guideController.rebuild();
  })
}

@Entry
@ComponentV2
struct Index {
  @Local message: string = 'Hello World';
  private params: CustomGuideParams = new CustomGuideParams();
  private area: Area = {
    width: 0,
    height: 0,
    position: {},
    globalPosition: {}
  }

  aboutToAppear(): void {

  }

  build() {
    Stack() {
      Guide() {
        Column() {
          Text(this.message)
            .id('HelloWorld')
            .fontSize($r('app.float.page_text_font_size'))
            .fontWeight(FontWeight.Bold)
            .onAreaChange((oldValue: Area, newValue: Area) => {
              this.area = newValue;
            })
            .backgroundColor(Color.Red)
            .margin({
              top: 10
            })
            .onClick(() => {
              this.message = 'Welcome';

            })

          Text('aaaaaaaaa')
            .fontSize($r('app.float.page_text_font_size'))
            .fontWeight(FontWeight.Bold)
            .onClick(() => {
              guideController.setMask(new TranAreaMask(new GuideArea(this.area, 0,{},true)))
                .setGuideBuilder(wrapBuilder(builder))
                .setGuideBuilderParams(this.params)
                .show();
            })
            .margin({
              top: 100
            })
        }
        .height('100%')
        .width('100%')

      }
    }
  }
}