import { guideController, GuideController } from './GuideController';
import { GuideState } from './GuideState';

/**
 * 引导组件
 */
@ComponentV2
export struct Guide {
  /**
   * 引导控制器
   */
  controller: GuideController = guideController;
  @Local private state: GuideState = this.controller.state;
  /**
   * 主体内容
   */
  @BuilderParam builder: () => void;

  @Monitor('state.isShow')
  onStataChange() {
    if (this.controller.listener) {
      this.controller.listener.onState(this.state.isShow);
    }
  }

  build() {
    Stack() {
      this.builder();

      if (this.state.isShow) {
        NodeContainer(this.controller)
          .width('100%')
          .height('100%')
      }
    }
    .width('100%')
    .height('100%')

  }
}