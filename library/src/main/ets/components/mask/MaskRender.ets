import { DrawContext, RenderNode } from '@kit.ArkUI';

/**
 * 引导遮罩绘制
 */
export abstract class MaskRender extends RenderNode {
  /**
   * 绘制
   * @param context
   */
  draw(context: DrawContext): void {
    this.drawMask(context);
  }

  /**
   * 绘制遮罩
   * @param context
   */
  abstract drawMask(context: DrawContext);
}