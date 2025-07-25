import { guideController, GuideController } from './GuideController';

/**
 * 引导组件
 */
@ComponentV2
export struct Guide {
  /**
   * 引导控制器
   */
  @Param controller: GuideController = guideController;
  /**
   * 主体内容
   */
  @BuilderParam builder: () => void;

  build() {
    Stack() {
      this.builder();

      if (this.controller.isShow) {
        NodeContainer(this.controller)
          .width('100%')
          .height('100%')
      }
    }
    .width('100%')
    .height('100%')

  }
}