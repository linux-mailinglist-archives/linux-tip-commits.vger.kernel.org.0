Return-Path: <linux-tip-commits+bounces-1684-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 512629304F1
	for <lists+linux-tip-commits@lfdr.de>; Sat, 13 Jul 2024 12:17:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CE1C282830
	for <lists+linux-tip-commits@lfdr.de>; Sat, 13 Jul 2024 10:17:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCDF64AEDA;
	Sat, 13 Jul 2024 10:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UsGw4eLW";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OH2pe91B"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25B4F3E49E;
	Sat, 13 Jul 2024 10:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720865822; cv=none; b=H8vgt3AA5dWkhUDkqI4x/dE9lspgSS25+GRfkFelwH1RP+eH3MpElC9KZGQvLOpN1oNsu0wRfFBY/oLPk7m1QejhT1fEujn9T1gvCMIjtrZ7cx6p2kaaFLME3CHgdkPl86QNJr7CBVRVpq3ns3sz69qyZzG2Hu3BTMnfS4NdXX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720865822; c=relaxed/simple;
	bh=WtDRdICEeJNZWtyqDcb5bOm4gD/YTY33MzVmrpHZBBM=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=hLSCasDFYZ8VNrfbjI56pTvoBarum7Z2dydUp+mXzTGMDWQ9+qCNXFEewVKZvDWOQtB5SuvXg+tszRsSmgZjLw3O9a5AESGN4j7GaDTlGBgRZ7crwEpZJdWQ4BMl6U+kuoIvCaE5UWyF9u7EOuZXqDkl7qAxo5IS/53xVtMc0+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UsGw4eLW; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OH2pe91B; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 13 Jul 2024 10:16:53 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1720865814;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=amzq9mFedUqxqbg0+MFkw5kzHQGtcb83hQ6RqbetsFs=;
	b=UsGw4eLWg3acLgcRkWzuemEYWkZod8uvam2iV/UDtH+6nOq3A9aIlDbWzf9tkVrh8/xUg+
	LRKTGa+4pfJSHnn0rm4iU69jKZZscsLXStYUWgniQAKYrx6mBbtG0K3jJfkciIyYgKOpof
	vTCE+1qLVgrmGOTVRNy7kFcM/45rGBsS4FlEXRFFUJvcpI9tYGc5SnoHc2s3Y1DAcNdHlH
	DbBaE6LO/QiXiWTrRsWZpgL4R5bUWcAhQAhxVjclf/Z3UyG9i96RWjOd9fdOlCNyqNFY5k
	JEmmWRNtFt2MOfNpBPnLxctIMzTVfMT2AOeFZmT5NtQPvmKvB7xmgzWj1Ta7wA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1720865814;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=amzq9mFedUqxqbg0+MFkw5kzHQGtcb83hQ6RqbetsFs=;
	b=OH2pe91BeRLUfS4JJJ/q90GwZEochgr1WI3DaITchzQK8EbRYs9KYDgJnJcsj6/jOeVej5
	wgho4K6NFbkeBbDA==
From: "tip-bot2 for Chris Packham" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: timers/core] dt-bindings: timer: Add schema for realtek,otto-timer
Cc: Chris Packham <chris.packham@alliedtelesis.co.nz>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240710043524.1535151-6-chris.packham@alliedtelesis.co.nz>
References: <20240710043524.1535151-6-chris.packham@alliedtelesis.co.nz>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172086581394.2215.7938188375162127019.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     128f44f788cab8cab53edf9fa35eccbaa48fb4b2
Gitweb:        https://git.kernel.org/tip/128f44f788cab8cab53edf9fa35eccbaa48fb4b2
Author:        Chris Packham <chris.packham@alliedtelesis.co.nz>
AuthorDate:    Wed, 10 Jul 2024 16:35:19 +12:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Fri, 12 Jul 2024 16:07:06 +02:00

dt-bindings: timer: Add schema for realtek,otto-timer

Add the devicetree schema for the realtek,otto-timer present on a number
of Realtek SoCs.

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Link: https://lore.kernel.org/r/20240710043524.1535151-6-chris.packham@alliedtelesis.co.nz
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 Documentation/devicetree/bindings/timer/realtek,otto-timer.yaml | 63 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 63 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/timer/realtek,otto-timer.yaml

diff --git a/Documentation/devicetree/bindings/timer/realtek,otto-timer.yaml b/Documentation/devicetree/bindings/timer/realtek,otto-timer.yaml
new file mode 100644
index 0000000..7b6ec2c
--- /dev/null
+++ b/Documentation/devicetree/bindings/timer/realtek,otto-timer.yaml
@@ -0,0 +1,63 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/timer/realtek,otto-timer.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Realtek Otto SoCs Timer/Counter
+
+description:
+  Realtek SoCs support a number of timers/counters. These are used
+  as a per CPU clock event generator and an overall CPU clocksource.
+
+maintainers:
+  - Chris Packham <chris.packham@alliedtelesis.co.nz>
+
+properties:
+  $nodename:
+    pattern: "^timer@[0-9a-f]+$"
+
+  compatible:
+    items:
+      - enum:
+          - realtek,rtl9302-timer
+      - const: realtek,otto-timer
+
+  reg:
+    items:
+      - description: timer0 registers
+      - description: timer1 registers
+      - description: timer2 registers
+      - description: timer3 registers
+      - description: timer4 registers
+
+  clocks:
+    maxItems: 1
+
+  interrupts:
+    items:
+      - description: timer0 interrupt
+      - description: timer1 interrupt
+      - description: timer2 interrupt
+      - description: timer3 interrupt
+      - description: timer4 interrupt
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - interrupts
+
+additionalProperties: false
+
+examples:
+  - |
+    timer@3200 {
+      compatible = "realtek,rtl9302-timer", "realtek,otto-timer";
+      reg = <0x3200 0x10>, <0x3210 0x10>, <0x3220 0x10>,
+            <0x3230 0x10>, <0x3240 0x10>;
+
+      interrupt-parent = <&intc>;
+      interrupts = <7>, <8>, <9>, <10>, <11>;
+      clocks = <&lx_clk>;
+    };

