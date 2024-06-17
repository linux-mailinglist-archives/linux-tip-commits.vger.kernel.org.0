Return-Path: <linux-tip-commits+bounces-1405-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9509590B2C0
	for <lists+linux-tip-commits@lfdr.de>; Mon, 17 Jun 2024 16:47:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C196BB2EA81
	for <lists+linux-tip-commits@lfdr.de>; Mon, 17 Jun 2024 14:45:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A2CF1D1909;
	Mon, 17 Jun 2024 13:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1SrTjqQk";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zAyIh317"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C0881D0F7C;
	Mon, 17 Jun 2024 13:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718632273; cv=none; b=m82qlStB53xRS8RTwGUZoZQgXH6uI0wjW42Mu37AgLmr/4rAQ9zv7lgF8rrMmB3PKzvkWkLc674MtXmIdY6qsMmA7unjeMTfJPhMaOcdDfhs1oM3d+2Zx9Qafev2ghiuI3l45+bb9AG7v6yJQXVhQG9x78Gi/7JSmzUlIQJZ74o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718632273; c=relaxed/simple;
	bh=wz9OMkasvVAhzRQsMaJRqzDqW/8WRITYvHkHga8uE/I=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=l2H2r90eD1Qz6AOhBovEmPQL7q+IQXx80Ue1zgdLUyNrfi6hMJWT3goH7Xqkk3s4tmhB4F3SFy0kEsQ5xo0epJ7ug94N15ZrjYeTj3b06ubxkD8vEfOawE79RxDv3Qa3dTUz+WaoKEh/xq8KzSkZHS4zc1GNMTvZ0jmt/ihD42w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1SrTjqQk; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zAyIh317; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 17 Jun 2024 13:51:08 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1718632268;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EdJIi3oVHgxwPL1mDwTXZe9SUa1slCTjVJ3l2V2scKU=;
	b=1SrTjqQkRbXdWDAljVdoaRpkqDCz6SRuWQNn69soVDXN3KGD8/l8GtYURSiCRJPFA2zQYD
	ibPvM9jSlFYAOViN+s7/pGueWlulC/iNeDsZ3DOBax5p1GDTlrROUJE7jVPkxx44nnLrzZ
	jZQPvqw/adL5orse6xyx6Syv5vVTe1e7q6NyH+nfcEtC99le/LhRuPMroIj9tBOl5G5Ngj
	Qr5IKJPCSqjh96kAbUVyVKq65ccYrfOcQ4InKGE9EbIS/Dl6a4qIQO1Y15uXXXEO5WZtc9
	ySVM7jKooT70LOY6G0wmmVi0Pqjh92283p7tMiapEbCcE815jBBUJe/XKciuKw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1718632268;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EdJIi3oVHgxwPL1mDwTXZe9SUa1slCTjVJ3l2V2scKU=;
	b=zAyIh31774H2YJ7/pMWP4H4DGlGLWxFcpSTjGumjrdMbR4M5N7fp3nKVn7XWkAch0nqpqg
	bC3aEnqXHobJBeBQ==
From: "tip-bot2 for Herve Codina" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] dt-bindings: interrupt-controller: Add support for
 Microchip LAN966x OIC
Cc: Herve Codina <herve.codina@bootlin.com>,
 Thomas Gleixner <tglx@linutronix.de>, "Rob Herring (Arm)" <robh@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20240614173232.1184015-22-herve.codina@bootlin.com>
References: <20240614173232.1184015-22-herve.codina@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171863226824.10875.13497028437531251336.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     17972a5f1ba85ad8c4f32dfd00ff620a85e98416
Gitweb:        https://git.kernel.org/tip/17972a5f1ba85ad8c4f32dfd00ff620a85e98416
Author:        Herve Codina <herve.codina@bootlin.com>
AuthorDate:    Fri, 14 Jun 2024 19:32:22 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 17 Jun 2024 15:48:15 +02:00

dt-bindings: interrupt-controller: Add support for Microchip LAN966x OIC

The Microchip LAN966x outband interrupt controller (OIC) maps the
internal interrupt sources of the LAN966x device to an external
interrupt.
When the LAN966x device is used as a PCI device, the external interrupt
is routed to the PCI interrupt.

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Link: https://lore.kernel.org/r/20240614173232.1184015-22-herve.codina@bootlin.com

---
 Documentation/devicetree/bindings/interrupt-controller/microchip,lan966x-oic.yaml | 55 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/microchip,lan966x-oic.yaml

diff --git a/Documentation/devicetree/bindings/interrupt-controller/microchip,lan966x-oic.yaml b/Documentation/devicetree/bindings/interrupt-controller/microchip,lan966x-oic.yaml
new file mode 100644
index 0000000..b2adc71
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/microchip,lan966x-oic.yaml
@@ -0,0 +1,55 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/interrupt-controller/microchip,lan966x-oic.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Microchip LAN966x outband interrupt controller
+
+maintainers:
+  - Herve Codina <herve.codina@bootlin.com>
+
+allOf:
+  - $ref: /schemas/interrupt-controller.yaml#
+
+description: |
+  The Microchip LAN966x outband interrupt controller (OIC) maps the internal
+  interrupt sources of the LAN966x device to an external interrupt.
+  When the LAN966x device is used as a PCI device, the external interrupt is
+  routed to the PCI interrupt.
+
+properties:
+  compatible:
+    const: microchip,lan966x-oic
+
+  '#interrupt-cells':
+    const: 2
+
+  interrupt-controller: true
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+required:
+  - compatible
+  - '#interrupt-cells'
+  - interrupt-controller
+  - interrupts
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    interrupt-controller@e00c0120 {
+        compatible = "microchip,lan966x-oic";
+        reg = <0xe00c0120 0x190>;
+        #interrupt-cells = <2>;
+        interrupt-controller;
+        interrupts = <0>;
+        interrupt-parent = <&intc>;
+    };
+...

