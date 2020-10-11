Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6B5F28A918
	for <lists+linux-tip-commits@lfdr.de>; Sun, 11 Oct 2020 20:01:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388346AbgJKR5W (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 11 Oct 2020 13:57:22 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:39916 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388329AbgJKR5W (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 11 Oct 2020 13:57:22 -0400
Date:   Sun, 11 Oct 2020 17:57:17 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1602439039;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OoL5C434wqjTa99Nv01A6MN2Yz5eB16LxLl4GxE+1lo=;
        b=42NKj3a7mkilcIT7SGGH9L1Jms7FVdTEavjZTz7dmYs+a10fiT9qWnRi16ZE4QRod/0pIn
        L8v7twW6ubC5fdgyKf7z/QHvmAc0EBoVd82FylkI4KD9vvWufGCv1fG8c2s17L6JxICA6S
        oVAoOX60OMzxl/mMkAfMv76v99A5ibE18zMc30T29aA/6R2MQmkMbjDnSJACB3oTslN8cN
        bjQBIa2M+gr9XZ5dOndCNqe9EhSSGxcKGquQL85mk5vPPAXC3DQBA6PIrtywmVQ/jiZ/Gb
        +aEqmwDQfBcE/3+dBFcVrTjUEPL6po1xfM7AHJf4rFFjwKBKjsdQ2Z7CYzlT8w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1602439039;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OoL5C434wqjTa99Nv01A6MN2Yz5eB16LxLl4GxE+1lo=;
        b=bZjraSU02OZjhRIZR21U/NsuJLXJbR9moJMzmHGUQrM9Ck+5CaNbSRYY8YmTqNEhwQW6L9
        7e2KiskRR9nOnWBg==
From:   "tip-bot2 for Mark-PK Tsai" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] dt-bindings: interrupt-controller: Add MStar
 interrupt controller
Cc:     "Mark-PK Tsai" <mark-pk.tsai@mediatek.com>,
        Marc Zyngier <maz@kernel.org>, Rob Herring <robh@kernel.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200902063344.1852-3-mark-pk.tsai@mediatek.com>
References: <20200902063344.1852-3-mark-pk.tsai@mediatek.com>
MIME-Version: 1.0
Message-ID: <160243903788.7002.2720069443029819185.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     6d8af863b89da6bdce013db2216b432b4016042e
Gitweb:        https://git.kernel.org/tip/6d8af863b89da6bdce013db2216b432b4016042e
Author:        Mark-PK Tsai <mark-pk.tsai@mediatek.com>
AuthorDate:    Wed, 02 Sep 2020 14:33:44 +08:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Sat, 10 Oct 2020 12:45:16 +01:00

dt-bindings: interrupt-controller: Add MStar interrupt controller

Add binding for MStar interrupt controller.

Signed-off-by: Mark-PK Tsai <mark-pk.tsai@mediatek.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Reviewed-by: Rob Herring <robh@kernel.org>
Link: https://lore.kernel.org/r/20200902063344.1852-3-mark-pk.tsai@mediatek.com
---
 Documentation/devicetree/bindings/interrupt-controller/mstar,mst-intc.yaml | 64 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 64 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/mstar,mst-intc.yaml

diff --git a/Documentation/devicetree/bindings/interrupt-controller/mstar,mst-intc.yaml b/Documentation/devicetree/bindings/interrupt-controller/mstar,mst-intc.yaml
new file mode 100644
index 0000000..bbf0f26
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/mstar,mst-intc.yaml
@@ -0,0 +1,64 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/interrupt-controller/mstar,mst-intc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: MStar Interrupt Controller
+
+maintainers:
+  - Mark-PK Tsai <mark-pk.tsai@mediatek.com>
+
+description: |+
+  MStar, SigmaStar and Mediatek TV SoCs contain multiple legacy
+  interrupt controllers that routes interrupts to the GIC.
+
+  The HW block exposes a number of interrupt controllers, each
+  can support up to 64 interrupts.
+
+properties:
+  compatible:
+    const: mstar,mst-intc
+
+  interrupt-controller: true
+
+  "#interrupt-cells":
+    const: 3
+    description: |
+      Use the same format as specified by GIC in arm,gic.yaml.
+
+  reg:
+    maxItems: 1
+
+  mstar,irqs-map-range:
+    description: |
+      The range <start, end> of parent interrupt controller's interrupt
+      lines that are hardwired to mstar interrupt controller.
+    $ref: /schemas/types.yaml#/definitions/uint32-matrix
+    items:
+      minItems: 2
+      maxItems: 2
+
+  mstar,intc-no-eoi:
+    description:
+      Mark this controller has no End Of Interrupt(EOI) implementation.
+    type: boolean
+
+required:
+  - compatible
+  - reg
+  - mstar,irqs-map-range
+
+additionalProperties: false
+
+examples:
+  - |
+    mst_intc0: interrupt-controller@1f2032d0 {
+      compatible = "mstar,mst-intc";
+      interrupt-controller;
+      #interrupt-cells = <3>;
+      interrupt-parent = <&gic>;
+      reg = <0x1f2032d0 0x30>;
+      mstar,irqs-map-range = <0 63>;
+    };
+...
