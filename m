Return-Path: <linux-tip-commits+bounces-7540-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 998C2C8A62B
	for <lists+linux-tip-commits@lfdr.de>; Wed, 26 Nov 2025 15:41:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C3113A94EC
	for <lists+linux-tip-commits@lfdr.de>; Wed, 26 Nov 2025 14:40:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49DD13043AF;
	Wed, 26 Nov 2025 14:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gkM7vz/k";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0nBpyfg6"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97825303A28;
	Wed, 26 Nov 2025 14:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764168040; cv=none; b=ac6LW2ueR94JLteVX8R2B9vaR5ivKJrmSMUVyjqPwJ7wSTSWFVmPoL/tz8wKveyy8INDWScDC+dDrjl5kqN9IiDBgB6M8b/ElZaCSG4hXNDwLb507TH524RZfvQBtUx/pN11EiHL1sCj45pr7tPf/3AJt8zANWKXNfxLqN+NYnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764168040; c=relaxed/simple;
	bh=XKdCvfDBGP1GNsz2dsXEhQ3HaFsCQP2ub73aP5mXYFU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=AJgkxhry+SbR0VwXTByxK3UY4KEEREzLHnprHgTDC3JLw5dGY0OCFkhqJyI9x32jOYq5SqFmfUkTldvFoDOEy1ooOHeT+hRK7N8bI8TudSNa/LRI5I5qFrdzulsxymiHNpdM/GVm6KGXajTmAewydapDs2hEhc7ALvxqLwLmRiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gkM7vz/k; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0nBpyfg6; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 26 Nov 2025 14:40:13 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1764168037;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vXDr0tSmerpHja6dH+9rlAskwODzX9N2HofBhf9nwBg=;
	b=gkM7vz/kGoBFiNw64nZpEceBwnvIa2LJpO0G1mF4kxG3fCm0/neUpKg7CgOhL5UOLqI/+I
	5ahk8z/woqvKlOBJvm2QRo5USt7fhiQlsBf/X/Jr4tukjAAciJNtstAVzvchvkiwD+Ry6i
	gbGzxcg/aj/6iPN8DUI5C2Fy+hMTATQ2h0n4DDaFweQ7/LAPj1G5Y7p3+J4fJjHb2gBtJ1
	OJ66CNYY3mpTw7v84nfuPSFyxUZe3nwCjjpLfyR1GCUyFLXkKxVTCqJP1HU0pKyT0+QPT1
	QSuGAALj96ILG92e8eoFHZa9eEfYXv9y4uvBWaxfBz1kjv8WtXLXyglv5v9REA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1764168037;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vXDr0tSmerpHja6dH+9rlAskwODzX9N2HofBhf9nwBg=;
	b=0nBpyfg62u37Z+GVx847ygPqZyGRDiYxNfDz9O/YxTNnb1gjc/TeISlVPkd3cm/b1+UG/6
	ZR1JE87kPkyjYIDA==
From: "tip-bot2 for Hao-Wen Ting" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/clocksource] dt-bindings: timer: Add Realtek SYSTIMER
Cc: "Hao-Wen Ting" <haowen.ting@realtek.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Krzysztof Kozlowski <krzk@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251126060110.198330-2-haowen.ting@realtek.com>
References: <20251126060110.198330-2-haowen.ting@realtek.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176416803579.498.9556135999679281056.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/clocksource branch of ti=
p:

Commit-ID:     40caba2bd027ab57c196b690e4e7f3c1746acb96
Gitweb:        https://git.kernel.org/tip/40caba2bd027ab57c196b690e4e7f3c1746=
acb96
Author:        Hao-Wen Ting <haowen.ting@realtek.com>
AuthorDate:    Wed, 26 Nov 2025 14:01:09 +08:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Wed, 26 Nov 2025 11:25:15 +01:00

dt-bindings: timer: Add Realtek SYSTIMER

The Realtek SYSTIMER (System Timer) is a 64-bit global hardware counter
operating at a fixed 1MHz frequency. Thanks to its compare match
interrupt capability, the timer natively supports oneshot mode for tick
broadcast functionality.

Signed-off-by: Hao-Wen Ting <haowen.ting@realtek.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
Link: https://patch.msgid.link/20251126060110.198330-2-haowen.ting@realtek.com
---
 Documentation/devicetree/bindings/timer/realtek,rtd1625-systimer.yaml | 47 +=
++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/timer/realtek,rtd1625-s=
ystimer.yaml

diff --git a/Documentation/devicetree/bindings/timer/realtek,rtd1625-systimer=
.yaml b/Documentation/devicetree/bindings/timer/realtek,rtd1625-systimer.yaml
new file mode 100644
index 0000000..e08d3d2
--- /dev/null
+++ b/Documentation/devicetree/bindings/timer/realtek,rtd1625-systimer.yaml
@@ -0,0 +1,47 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/timer/realtek,rtd1625-systimer.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Realtek System Timer
+
+maintainers:
+  - Hao-Wen Ting <haowen.ting@realtek.com>
+
+description:
+  The Realtek SYSTIMER (System Timer) is a 64-bit global hardware counter op=
erating
+  at a fixed 1MHz frequency. Thanks to its compare match interrupt capabilit=
y,
+  the timer natively supports oneshot mode for tick broadcast functionality.
+
+properties:
+  compatible:
+    oneOf:
+      - const: realtek,rtd1625-systimer
+      - items:
+          - const: realtek,rtd1635-systimer
+          - const: realtek,rtd1625-systimer
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - interrupts
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    timer@89420 {
+        compatible =3D "realtek,rtd1635-systimer",
+                     "realtek,rtd1625-systimer";
+        reg =3D <0x89420 0x18>;
+        interrupts =3D <GIC_SPI 112 IRQ_TYPE_LEVEL_HIGH>;
+    };

