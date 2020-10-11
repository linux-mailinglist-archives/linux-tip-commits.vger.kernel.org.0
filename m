Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1AD628A909
	for <lists+linux-tip-commits@lfdr.de>; Sun, 11 Oct 2020 20:00:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730170AbgJKSAW (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 11 Oct 2020 14:00:22 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:40026 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388348AbgJKR52 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 11 Oct 2020 13:57:28 -0400
Date:   Sun, 11 Oct 2020 17:57:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1602439046;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RDWDE1Y2duqskD+ujyVgp6X3uhszAt9oy0Uek6Qbv9k=;
        b=LFMUIWWk6pRyADN+yY4juIZh8E7lSikCzDTqSQm3P1lRXQCYVT2UQtMR9vFXxkhYtLGnJ1
        Mwx6uJDPUNnLpHFNnlkKTA6jfiSunYbIYLQJIiJcp2j2iKBCm5RaqE4cbfbpHin2uO9d6B
        9Vg9pUauxqf9MujaQc3kUnQi4Jx9cd8ZxodjtIpE5gFR5t1nbPGzU+4m5sboP39qkn2vPd
        Q8hL6XT6guj0IL3yPmfHh26W817LOXuV2ngnVfKYVxqxzQ25GJWxip5lFXHKsvsx4hwqn8
        T4dkqhLoBbA5Apl9eZW/znKqcke8Z+JTmoiE1VpJatIvyfPjiFg9gxS851+uIA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1602439046;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RDWDE1Y2duqskD+ujyVgp6X3uhszAt9oy0Uek6Qbv9k=;
        b=Ap9K0rTOzYrpGVrcKpf8iwmSkRbZj/IVGkqIr8qgjwHCVx0Md99xGI4rZpNKG1r/VVCeWa
        DUCNf32QGuw+ZHBg==
From:   "tip-bot2 for Cristian Ciocaltea" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] dt-bindings: interrupt-controller: Add Actions SIRQ
 controller binding
Cc:     Cristian Ciocaltea <cristian.ciocaltea@gmail.com>,
        Marc Zyngier <maz@kernel.org>, Rob Herring <robh@kernel.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: =?utf-8?q?=3Cc2046b747574ea56c1cf05c05b402c7f01d5e4fc=2E16001?=
 =?utf-8?q?14378=2Egit=2Ecristian=2Eciocaltea=40gmail=2Ecom=3E?=
References: =?utf-8?q?=3Cc2046b747574ea56c1cf05c05b402c7f01d5e4fc=2E160011?=
 =?utf-8?q?4378=2Egit=2Ecristian=2Eciocaltea=40gmail=2Ecom=3E?=
MIME-Version: 1.0
Message-ID: <160243904585.7002.14759227325508684983.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     b2bd271c3961f35dd127c99c8f576d9fcc2cb0c4
Gitweb:        https://git.kernel.org/tip/b2bd271c3961f35dd127c99c8f576d9fcc2cb0c4
Author:        Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
AuthorDate:    Mon, 14 Sep 2020 23:27:17 +03:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Fri, 25 Sep 2020 16:57:33 +01:00

dt-bindings: interrupt-controller: Add Actions SIRQ controller binding

Actions Semi Owl SoCs SIRQ interrupt controller is found in S500, S700
and S900 SoCs and provides support for handling up to 3 external
interrupt lines.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Reviewed-by: Rob Herring <robh@kernel.org>
Link: https://lore.kernel.org/r/c2046b747574ea56c1cf05c05b402c7f01d5e4fc.1600114378.git.cristian.ciocaltea@gmail.com
---
 Documentation/devicetree/bindings/interrupt-controller/actions,owl-sirq.yaml | 65 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 65 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/actions,owl-sirq.yaml

diff --git a/Documentation/devicetree/bindings/interrupt-controller/actions,owl-sirq.yaml b/Documentation/devicetree/bindings/interrupt-controller/actions,owl-sirq.yaml
new file mode 100644
index 0000000..5da333c
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/actions,owl-sirq.yaml
@@ -0,0 +1,65 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/interrupt-controller/actions,owl-sirq.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Actions Semi Owl SoCs SIRQ interrupt controller
+
+maintainers:
+  - Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
+  - Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
+
+description: |
+  This interrupt controller is found in the Actions Semi Owl SoCs (S500, S700
+  and S900) and provides support for handling up to 3 external interrupt lines.
+
+properties:
+  compatible:
+    enum:
+      - actions,s500-sirq
+      - actions,s700-sirq
+      - actions,s900-sirq
+
+  reg:
+    maxItems: 1
+
+  interrupt-controller: true
+
+  '#interrupt-cells':
+    const: 2
+    description:
+      The first cell is the input IRQ number, between 0 and 2, while the second
+      cell is the trigger type as defined in interrupt.txt in this directory.
+
+  'interrupts':
+    description: |
+      Contains the GIC SPI IRQs mapped to the external interrupt lines.
+      They shall be specified sequentially from output 0 to 2.
+    minItems: 3
+    maxItems: 3
+
+required:
+  - compatible
+  - reg
+  - interrupt-controller
+  - '#interrupt-cells'
+  - 'interrupts'
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    sirq: interrupt-controller@b01b0200 {
+      compatible = "actions,s500-sirq";
+      reg = <0xb01b0200 0x4>;
+      interrupt-controller;
+      #interrupt-cells = <2>;
+      interrupts = <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>, /* SIRQ0 */
+                   <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>, /* SIRQ1 */
+                   <GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH>; /* SIRQ2 */
+    };
+
+...
