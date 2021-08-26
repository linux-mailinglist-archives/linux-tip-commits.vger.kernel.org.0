Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4121E3F8C1B
	for <lists+linux-tip-commits@lfdr.de>; Thu, 26 Aug 2021 18:25:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243116AbhHZQ0U (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 26 Aug 2021 12:26:20 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33174 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243095AbhHZQ0H (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 26 Aug 2021 12:26:07 -0400
Date:   Thu, 26 Aug 2021 16:25:18 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1629995119;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eyxUYq9oy39+hg26Uis5iJEXX4OXjqS7AIC/RA8N5O8=;
        b=e6xNMW0aCZ9tPVjNAInYSlFWqUJbBBJOXnDPKeOdYvgHZnIscoPdbm3J3TUp7zwudQnS3Q
        nw/T7w33UB/yoMBVaduVRcZ61V8rcjyAwJpfh7IvZBUqOfB95FwCJHUNeWJjvT0EIun8A9
        7EUj/Z97RXQshwKZ/5tDwc1cAzyuR/WmI/qRF2S5aLf5QWz3lzXSA59tWQA/+XCHp6Nm0t
        +F7b6VAzJ1HUYQNOSS5zouBZ05VYnQAknlK36U7gBcuq4RLZZ2HrLPOa8OFMgL+JsLFBH3
        FFrmHcD6MqnKm8L/rkOrCEp00OlLKEDw0pNEWVQoE2ENo7QyHbsKwqG6Fq9LhA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1629995119;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eyxUYq9oy39+hg26Uis5iJEXX4OXjqS7AIC/RA8N5O8=;
        b=gJNPz230S2LClhA9JkQlhrr3Crv8plTIMbS9ebwG4qtr3ljjgw851+QLGAwfA4tn9ibW7y
        znnceMI337gGjkAg==
From:   "tip-bot2 for Ezequiel Garcia" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] dt-bindings: timer: convert rockchip,rk-timer.txt to YAML
Cc:     Ezequiel Garcia <ezequiel@collabora.com>,
        Rob Herring <robh@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210506111136.3941-4-ezequiel@collabora.com>
References: <20210506111136.3941-4-ezequiel@collabora.com>
MIME-Version: 1.0
Message-ID: <162999511851.25758.16379386113086143052.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     faa186adbd06f3e7113ae1dc6766e2273d5d9231
Gitweb:        https://git.kernel.org/tip/faa186adbd06f3e7113ae1dc6766e2273d5d9231
Author:        Ezequiel Garcia <ezequiel@collabora.com>
AuthorDate:    Thu, 06 May 2021 08:11:36 -03:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Fri, 13 Aug 2021 09:24:23 +02:00

dt-bindings: timer: convert rockchip,rk-timer.txt to YAML

Convert Rockchip Timer dt-bindings to YAML.

Signed-off-by: Ezequiel Garcia <ezequiel@collabora.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20210506111136.3941-4-ezequiel@collabora.com
---
 Documentation/devicetree/bindings/timer/rockchip,rk-timer.txt  | 27 +---
 Documentation/devicetree/bindings/timer/rockchip,rk-timer.yaml | 64 +++++++-
 2 files changed, 64 insertions(+), 27 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/timer/rockchip,rk-timer.txt
 create mode 100644 Documentation/devicetree/bindings/timer/rockchip,rk-timer.yaml

diff --git a/Documentation/devicetree/bindings/timer/rockchip,rk-timer.txt b/Documentation/devicetree/bindings/timer/rockchip,rk-timer.txt
deleted file mode 100644
index d65fdce..0000000
--- a/Documentation/devicetree/bindings/timer/rockchip,rk-timer.txt
+++ /dev/null
@@ -1,27 +0,0 @@
-Rockchip rk timer
-
-Required properties:
-- compatible: should be:
-  "rockchip,rv1108-timer", "rockchip,rk3288-timer": for Rockchip RV1108
-  "rockchip,rk3036-timer", "rockchip,rk3288-timer": for Rockchip RK3036
-  "rockchip,rk3066-timer", "rockchip,rk3288-timer": for Rockchip RK3066
-  "rockchip,rk3188-timer", "rockchip,rk3288-timer": for Rockchip RK3188
-  "rockchip,rk3228-timer", "rockchip,rk3288-timer": for Rockchip RK3228
-  "rockchip,rk3229-timer", "rockchip,rk3288-timer": for Rockchip RK3229
-  "rockchip,rk3288-timer": for Rockchip RK3288
-  "rockchip,rk3368-timer", "rockchip,rk3288-timer": for Rockchip RK3368
-  "rockchip,rk3399-timer": for Rockchip RK3399
-- reg: base address of the timer register starting with TIMERS CONTROL register
-- interrupts: should contain the interrupts for Timer0
-- clocks : must contain an entry for each entry in clock-names
-- clock-names : must include the following entries:
-  "timer", "pclk"
-
-Example:
-	timer: timer@ff810000 {
-		compatible = "rockchip,rk3288-timer";
-		reg = <0xff810000 0x20>;
-		interrupts = <GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&xin24m>, <&cru PCLK_TIMER>;
-		clock-names = "timer", "pclk";
-	};
diff --git a/Documentation/devicetree/bindings/timer/rockchip,rk-timer.yaml b/Documentation/devicetree/bindings/timer/rockchip,rk-timer.yaml
new file mode 100644
index 0000000..e26ecb5
--- /dev/null
+++ b/Documentation/devicetree/bindings/timer/rockchip,rk-timer.yaml
@@ -0,0 +1,64 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/timer/rockchip,rk-timer.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Rockchip Timer Device Tree Bindings
+
+maintainers:
+  - Daniel Lezcano <daniel.lezcano@linaro.org>
+
+properties:
+  compatible:
+    oneOf:
+      - const: rockchip,rk3288-timer
+      - const: rockchip,rk3399-timer
+      - items:
+          - enum:
+              - rockchip,rv1108-timer
+              - rockchip,rk3036-timer
+              - rockchip,rk3066-timer
+              - rockchip,rk3188-timer
+              - rockchip,rk3228-timer
+              - rockchip,rk3229-timer
+              - rockchip,rk3288-timer
+              - rockchip,rk3368-timer
+              - rockchip,px30-timer
+          - const: rockchip,rk3288-timer
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    minItems: 2
+    maxItems: 2
+
+  clock-names:
+    items:
+      - const: pclk
+      - const: timer
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - clock-names
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/clock/rk3288-cru.h>
+
+    timer: timer@ff810000 {
+        compatible = "rockchip,rk3288-timer";
+        reg = <0xff810000 0x20>;
+        interrupts = <GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>;
+        clocks = <&cru PCLK_TIMER>, <&xin24m>;
+        clock-names = "pclk", "timer";
+    };
