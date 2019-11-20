Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EE259103B0F
	for <lists+linux-tip-commits@lfdr.de>; Wed, 20 Nov 2019 14:22:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730296AbfKTNV1 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 20 Nov 2019 08:21:27 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:56826 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730277AbfKTNV1 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 20 Nov 2019 08:21:27 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iXPv7-0007DN-OD; Wed, 20 Nov 2019 14:21:21 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id A47131C1A0D;
        Wed, 20 Nov 2019 14:21:05 +0100 (CET)
Date:   Wed, 20 Nov 2019 13:21:05 -0000
From:   "tip-bot2 for Rasmus Villemoes" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] dt/bindings: Add bindings for Layerscape external irqs
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Marc Zyngier <maz@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Borislav Petkov <bp@alien8.de>, linux-kernel@vger.kernel.org
In-Reply-To: <20191107122115.6244-2-linux@rasmusvillemoes.dk>
References: <20191107122115.6244-2-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Message-ID: <157425606561.12247.12430720845502996517.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     87cd38dfd9e67ffa7c3d3d1a54a2482ed23f1307
Gitweb:        https://git.kernel.org/tip/87cd38dfd9e67ffa7c3d3d1a54a2482ed23f1307
Author:        Rasmus Villemoes <linux@rasmusvillemoes.dk>
AuthorDate:    Thu, 07 Nov 2019 13:21:14 +01:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Sun, 10 Nov 2019 18:47:48 

dt/bindings: Add bindings for Layerscape external irqs

This adds Device Tree binding documentation for the external interrupt
lines with configurable polarity present on some Layerscape SOCs.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20191107122115.6244-2-linux@rasmusvillemoes.dk
---
 Documentation/devicetree/bindings/interrupt-controller/fsl,ls-extirq.txt | 49 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/fsl,ls-extirq.txt

diff --git a/Documentation/devicetree/bindings/interrupt-controller/fsl,ls-extirq.txt b/Documentation/devicetree/bindings/interrupt-controller/fsl,ls-extirq.txt
new file mode 100644
index 0000000..f0ad780
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/fsl,ls-extirq.txt
@@ -0,0 +1,49 @@
+* Freescale Layerscape external IRQs
+
+Some Layerscape SOCs (LS1021A, LS1043A, LS1046A) support inverting
+the polarity of certain external interrupt lines.
+
+The device node must be a child of the node representing the
+Supplemental Configuration Unit (SCFG).
+
+Required properties:
+- compatible: should be "fsl,<soc-name>-extirq", e.g. "fsl,ls1021a-extirq".
+- #interrupt-cells: Must be 2. The first element is the index of the
+  external interrupt line. The second element is the trigger type.
+- #address-cells: Must be 0.
+- interrupt-controller: Identifies the node as an interrupt controller
+- reg: Specifies the Interrupt Polarity Control Register (INTPCR) in
+  the SCFG.
+- interrupt-map: Specifies the mapping from external interrupts to GIC
+  interrupts.
+- interrupt-map-mask: Must be <0xffffffff 0>.
+
+Example:
+	scfg: scfg@1570000 {
+		compatible = "fsl,ls1021a-scfg", "syscon";
+		reg = <0x0 0x1570000 0x0 0x10000>;
+		big-endian;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0x0 0x0 0x1570000 0x10000>;
+
+		extirq: interrupt-controller@1ac {
+			compatible = "fsl,ls1021a-extirq";
+			#interrupt-cells = <2>;
+			#address-cells = <0>;
+			interrupt-controller;
+			reg = <0x1ac 4>;
+			interrupt-map =
+				<0 0 &gic GIC_SPI 163 IRQ_TYPE_LEVEL_HIGH>,
+				<1 0 &gic GIC_SPI 164 IRQ_TYPE_LEVEL_HIGH>,
+				<2 0 &gic GIC_SPI 165 IRQ_TYPE_LEVEL_HIGH>,
+				<3 0 &gic GIC_SPI 167 IRQ_TYPE_LEVEL_HIGH>,
+				<4 0 &gic GIC_SPI 168 IRQ_TYPE_LEVEL_HIGH>,
+				<5 0 &gic GIC_SPI 169 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-map-mask = <0xffffffff 0x0>;
+		};
+	};
+
+
+	interrupts-extended = <&gic GIC_SPI 88 IRQ_TYPE_LEVEL_HIGH>,
+			      <&extirq 1 IRQ_TYPE_LEVEL_LOW>;
