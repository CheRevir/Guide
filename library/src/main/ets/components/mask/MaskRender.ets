import { DrawContext, RenderNode } from '@kit.ArkUI';

/**
 * 引导蒙版绘制
 */
export abstract class MaskRender extends RenderNode {
  constructor() {
    super();
    this.frame = {
      x: 0,
      y: 0,
      width: this.size.width,
      height: this.size.height
    };
  }

  /**
   * 绘制
   * @param context
   */
  draw(context: DrawContext): void {
    this.drawMask(context);
  }

  /**
   * 绘制蒙版
   * @param context
   */
  abstract drawMask(context: DrawContext);

  /**
   * 设置蒙版大小
   * @param size
   */
  setSize(size: Size) {
    this.size = size;
  }
}