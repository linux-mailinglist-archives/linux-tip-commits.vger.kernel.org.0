Return-Path: <linux-tip-commits+bounces-2503-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DEBAC9A2DFE
	for <lists+linux-tip-commits@lfdr.de>; Thu, 17 Oct 2024 21:43:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0EEC41C26776
	for <lists+linux-tip-commits@lfdr.de>; Thu, 17 Oct 2024 19:43:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63864202629;
	Thu, 17 Oct 2024 19:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1yf3urIj";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZOikoWCX"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C18222738A;
	Thu, 17 Oct 2024 19:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729194228; cv=none; b=h4UF1v+QaopPab/j3OXozb4xTokqQf+sFOpL03RfOmbKUyRjWTYM22K+765XAiWfUggJlG3GFH9cL8XARTzenc3kzzbEWsdOQFE4JDsgxd2A/JiJZVDQWXx0IeILqa+hDalbhnvVXKL0dV9/yoEiOfQdFkXoXErYm81TZfB4pIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729194228; c=relaxed/simple;
	bh=R8HgjdDGExRzcHarES8XZ5db42R/qNUB/AmNsIT5n8g=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=dAO6sVqNh0LpndoV5rU3Mu/5C1kbvKy7HIDKCmUtAE2XgTFoGnOHak2Td+HLALTGsprtrVxYfpYYfYVN7jJLE6rEhUf3Yevt0aDT4BY8TJ4nbgwNLXk33qvIbC4i1jpjw7BYaRMI5ipsOgtXv+DMh0mVO+GRvcCV9hO7Rz4tOeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1yf3urIj; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZOikoWCX; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 17 Oct 2024 19:43:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1729194221;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2ilCSoVrZpRMZGOHz8ag23av6GrTG+k4D5wQiUtLLtY=;
	b=1yf3urIjUyeXkOkgfujXUmYEqUw6bUxwQpPTVgklNz/oB/4z8UUEaaRzmTq/VjNSDwiJMS
	d7Y3F5qJrCaUuuEW5UmukQJBeSG9pG+07TWcBb59SN3yP3s0qLzGDLPb3Ox2OG9lDzhV3t
	2rQqNfU1ko9ORz6bCqm2UNJpdA0hCWawlx5yAzguEKbY01BnM+g68OJZJeTTxOz0/fDH3U
	shQTDmCeV0+FvwZk6Eejuzi5BwBbIM2Xnfm+uyO//upTvVCkwDVIj5BKcOO0TOVUCqDF3y
	BvuScmCahG/m5/60PeghpfQVLjlSAimDUpPh5b1YKn11L/IvfV7HPBNJeB7JKQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1729194221;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2ilCSoVrZpRMZGOHz8ag23av6GrTG+k4D5wQiUtLLtY=;
	b=ZOikoWCXfy1bw8olBZ83BcwTGLp98trMSwvIYKrOtgb2cbGNAkIVWbrx+IcmIWvF/AMudU
	br3zKWnACr4Yz8Bg==
From: "tip-bot2 for Kevin Chen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] dt-bindings: interrupt-controller: Add support for
 ASPEED AST27XX INTC
Cc: Kevin Chen <kevin_chen@aspeedtech.com>,
 Thomas Gleixner <tglx@linutronix.de>, "Rob Herring (Arm)" <robh@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20241016022410.1154574-2-kevin_chen@aspeedtech.com>
References: <20241016022410.1154574-2-kevin_chen@aspeedtech.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172919422081.1442.10684895848827385137.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     37a99ff53d1d913ec5b435cbe977a811b7b37995
Gitweb:        https://git.kernel.org/tip/37a99ff53d1d913ec5b435cbe977a811b7b37995
Author:        Kevin Chen <kevin_chen@aspeedtech.com>
AuthorDate:    Wed, 16 Oct 2024 10:24:09 +08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 17 Oct 2024 21:35:28 +02:00

dt-bindings: interrupt-controller: Add support for ASPEED AST27XX INTC

The ASPEED AST27XX interrupt controller(INTC) contains second level and
third level interrupt controller.

INTC0:
The second level INTC, which used to assert GIC if interrupt in INTC1 asserted.

INTC1_x:
The third level INTC, which used to assert INTC0 if interrupt in modules
of INTC asserted.

The relationship is like the following:
  +-----+   +-------+     +---------+---module0
  | GIC |---| INTC0 |--+--| INTC1_0 |---module1
  |     |   |       |  |  |         |---...
  +-----+   +-------+  |  +---------+---module31
                       |
                       |   +---------+---module0
                       +---| INTC1_1 |---module1
                       |   |         |---...
                       |   +---------+---module31
                      ...
                       |   +---------+---module0
                       +---| INTC1_5 |---module1
                           |         |---...
                           +---------+---module31

Signed-off-by: Kevin Chen <kevin_chen@aspeedtech.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Link: https://lore.kernel.org/all/20241016022410.1154574-2-kevin_chen@aspeedtech.com

---
 Documentation/devicetree/bindings/interrupt-controller/aspeed,ast2700-intc.yaml | 86 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 86 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/aspeed,ast2700-intc.yaml

diff --git a/Documentation/devicetree/bindings/interrupt-controller/aspeed,ast2700-intc.yaml b/Documentation/devicetree/bindings/interrupt-controller/aspeed,ast2700-intc.yaml
new file mode 100644
index 0000000..55636d0
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/aspeed,ast2700-intc.yaml
@@ -0,0 +1,86 @@
+# SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/interrupt-controller/aspeed,ast2700-intc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Aspeed AST2700 Interrupt Controller
+
+description:
+  This interrupt controller hardware is second level interrupt controller that
+  is hooked to a parent interrupt controller. It's useful to combine multiple
+  interrupt sources into 1 interrupt to parent interrupt controller.
+
+maintainers:
+  - Kevin Chen <kevin_chen@aspeedtech.com>
+
+properties:
+  compatible:
+    enum:
+      - aspeed,ast2700-intc-ic
+
+  reg:
+    maxItems: 1
+
+  interrupt-controller: true
+
+  '#interrupt-cells':
+    const: 2
+    description:
+      The first cell is the IRQ number, the second cell is the trigger
+      type as defined in interrupt.txt in this directory.
+
+  interrupts:
+    maxItems: 6
+    description: |
+      Depend to which INTC0 or INTC1 used.
+      INTC0 and INTC1 are two kinds of interrupt controller with enable and raw
+      status registers for use.
+      INTC0 is used to assert GIC if interrupt in INTC1 asserted.
+      INTC1 is used to assert INTC0 if interrupt of modules asserted.
+      +-----+   +-------+     +---------+---module0
+      | GIC |---| INTC0 |--+--| INTC1_0 |---module2
+      |     |   |       |  |  |         |---...
+      +-----+   +-------+  |  +---------+---module31
+                           |
+                           |   +---------+---module0
+                           +---| INTC1_1 |---module2
+                           |   |         |---...
+                           |   +---------+---module31
+                          ...
+                           |   +---------+---module0
+                           +---| INTC1_5 |---module2
+                               |         |---...
+                               +---------+---module31
+
+
+required:
+  - compatible
+  - reg
+  - interrupt-controller
+  - '#interrupt-cells'
+  - interrupts
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    bus {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        interrupt-controller@12101b00 {
+            compatible = "aspeed,ast2700-intc-ic";
+            reg = <0 0x12101b00 0 0x10>;
+            #interrupt-cells = <2>;
+            interrupt-controller;
+            interrupts = <GIC_SPI 192 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 193 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 194 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 195 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 196 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 197 IRQ_TYPE_LEVEL_HIGH>;
+        };
+    };

