Return-Path: <linux-tip-commits+bounces-4717-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 83CACA7D6A1
	for <lists+linux-tip-commits@lfdr.de>; Mon,  7 Apr 2025 09:48:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D019176266
	for <lists+linux-tip-commits@lfdr.de>; Mon,  7 Apr 2025 07:45:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4AAD226193;
	Mon,  7 Apr 2025 07:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XNTcauUs";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="eIjq2WGy"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26B3922B594;
	Mon,  7 Apr 2025 07:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744011790; cv=none; b=I+BXOSJNisnxWfdgdGoQAG+IOkcc395TRnpxBJ4yx1jOK8Bsd9OmR3q7N2DI2BAiVgCVdQpgamyqOdZngJNU71P8Nv7HUTvk/wH6oERFhWsfh6Jyi/LY5zZGfosqUy4SHWSAlkz9QloUZYHRR6U2sFnvS9ITwVKstKOap4ZWk1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744011790; c=relaxed/simple;
	bh=xAH5BUwyBkhO2XEIHUgxeZp0qr/q+P3OpxuIX1SpsAw=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=p8df1eudmw8K1tFnRMZpWWlGiEa9PXP5TmLNCtDu1X19KaAI6seJlgU+HlaKHSAbQOZdPFtHL5v3a2IdlcI9eVRPkaApYjz2p3CWcKxx+pXPx4g27AixYO8fZrI8Bv3Ae961pZ5XpCaPDnoWDttjrzDZ1J5EKMqppDayUfFIUdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XNTcauUs; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=eIjq2WGy; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 07 Apr 2025 07:43:05 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744011786;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=keot3RlGNjjnjN8ljBBkm4ZRMz9gtt3klfATNbBR+Eg=;
	b=XNTcauUsyxPV1utjcTnghvV2HlEbzV3QBeoc8T7iQEj0lqNd9M3joadzKK7bG1NF8Bp0ZG
	GwZy+s1ZQMxbn8RcivyPySNAJ08n4EuATRwUOdILxug9xvkuKecZCuAPb1XOPRqM8tuybP
	/Pznwq2Gm2e9uls7lVD3Eu1WbnVY0huKWVOcZlp+Cu+T2XbEfhhGP+LFbt1bm0dEIG4MBd
	Yu3kYLIpbnVUWVnF2LyCfc2WNqR9+Ak6h1zxFjfxNLDmIgftEM9tptUv/ZV1sqfy8ehTva
	DbvaIphT49Y4y9kR4oyM5LkO+N9CX68a3Ht/LfJAiMzmL230vCmjR1YUQwstag==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744011786;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=keot3RlGNjjnjN8ljBBkm4ZRMz9gtt3klfATNbBR+Eg=;
	b=eIjq2WGy4tvphqd+X0eC1cK/eiiJLsiviZR8XmhbpY/D/ZCoKUc4gVq/0l57zWKFhDNIvY
	E08rkIiLWdrsjjBA==
From: "tip-bot2 for Caleb James DeLisle" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/drivers] dt-bindings: interrupt-controller: Add EcoNet
 EN751221 INTC
Cc: Caleb James DeLisle <cjd@cjdns.fr>, Thomas Gleixner <tglx@linutronix.de>,
 "Rob Herring (Arm)" <robh@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250330170306.2584136-3-cjd@cjdns.fr>
References: <20250330170306.2584136-3-cjd@cjdns.fr>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174401178571.31282.13288482181779829610.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/drivers branch of tip:

Commit-ID:     9773c540441c6ae15aefb49e67142e94369dbbc0
Gitweb:        https://git.kernel.org/tip/9773c540441c6ae15aefb49e67142e94369dbbc0
Author:        Caleb James DeLisle <cjd@cjdns.fr>
AuthorDate:    Sun, 30 Mar 2025 17:02:58 
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 07 Apr 2025 09:39:38 +02:00

dt-bindings: interrupt-controller: Add EcoNet EN751221 INTC

Document the device tree binding for the interrupt controller in the
EcoNet EN751221 MIPS SoC.

Signed-off-by: Caleb James DeLisle <cjd@cjdns.fr>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Link: https://lore.kernel.org/all/20250330170306.2584136-3-cjd@cjdns.fr

---
 Documentation/devicetree/bindings/interrupt-controller/econet,en751221-intc.yaml | 78 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 78 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/econet,en751221-intc.yaml

diff --git a/Documentation/devicetree/bindings/interrupt-controller/econet,en751221-intc.yaml b/Documentation/devicetree/bindings/interrupt-controller/econet,en751221-intc.yaml
new file mode 100644
index 0000000..5536319
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/econet,en751221-intc.yaml
@@ -0,0 +1,78 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/interrupt-controller/econet,en751221-intc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: EcoNet EN751221 Interrupt Controller
+
+maintainers:
+  - Caleb James DeLisle <cjd@cjdns.fr>
+
+description:
+  The EcoNet EN751221 Interrupt Controller is a simple interrupt controller
+  designed for the MIPS 34Kc MT SMP processor with 2 VPEs. Each interrupt can
+  be routed to either VPE but not both, so to support per-CPU interrupts, a
+  secondary IRQ number is allocated to control masking/unmasking on VPE#1. For
+  lack of a better term we call these "shadow interrupts". The assignment of
+  shadow interrupts is defined by the SoC integrator when wiring the interrupt
+  lines, so they are configurable in the device tree.
+
+allOf:
+  - $ref: /schemas/interrupt-controller.yaml#
+
+properties:
+  compatible:
+    const: econet,en751221-intc
+
+  reg:
+    maxItems: 1
+
+  "#interrupt-cells":
+    const: 1
+
+  interrupt-controller: true
+
+  interrupts:
+    maxItems: 1
+    description: Interrupt line connecting this controller to its parent.
+
+  econet,shadow-interrupts:
+    $ref: /schemas/types.yaml#/definitions/uint32-matrix
+    description:
+      An array of interrupt number pairs where each pair represents a shadow
+      interrupt relationship. The first number in each pair is the primary IRQ,
+      and the second is its shadow IRQ used for VPE#1 control. For example,
+      <8 3> means IRQ 8 is shadowed by IRQ 3, so IRQ 3 cannot be mapped, but
+      when VPE#1 requests IRQ 8, it will manipulate the IRQ 3 mask bit.
+    minItems: 1
+    maxItems: 20
+    items:
+      items:
+        - description: primary per-CPU IRQ
+        - description: shadow IRQ number
+
+required:
+  - compatible
+  - reg
+  - interrupt-controller
+  - "#interrupt-cells"
+  - interrupts
+
+additionalProperties: false
+
+examples:
+  - |
+    interrupt-controller@1fb40000 {
+        compatible = "econet,en751221-intc";
+        reg = <0x1fb40000 0x100>;
+
+        interrupt-controller;
+        #interrupt-cells = <1>;
+
+        interrupt-parent = <&cpuintc>;
+        interrupts = <2>;
+
+        econet,shadow-interrupts = <7 2>, <8 3>, <13 12>, <30 29>;
+    };
+...

