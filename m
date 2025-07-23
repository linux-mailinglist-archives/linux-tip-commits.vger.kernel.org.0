Return-Path: <linux-tip-commits+bounces-6166-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63D42B0EB9D
	for <lists+linux-tip-commits@lfdr.de>; Wed, 23 Jul 2025 09:18:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 955764E38E2
	for <lists+linux-tip-commits@lfdr.de>; Wed, 23 Jul 2025 07:17:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E206C273D66;
	Wed, 23 Jul 2025 07:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EfOCYcVz";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1ZDsnUkV"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C931272E7B;
	Wed, 23 Jul 2025 07:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753255044; cv=none; b=kBssV4UJzCvP5jy+RLA+5PM3U9oaIfwyI2/4d53v6UTAgYG1oYGstX6liOm+K0eG7PciNNza+gyl3UmSch4DzgYLaJcanjZxdiXLq8vP6S1FZ2H3HGvxduvtsBXtesxwb2Qq3AEqbP688mcyaQJO7vMiabwMUTsvnbdpyw5lzsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753255044; c=relaxed/simple;
	bh=CAmviE++K05i0tyt/igTnniprzPSphgUe/nUU0MEf48=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=BeLBqACumR+/x+06RcXNnGVG2x7MkF+gT6YF89SbmJf1HW2NKBrzR75yqq8zbtJDi5yZepwF+5Wri3Dmyk7pSwZlxbkxuMcfUTcnJUD/ymSIQJBSTa/2is7V3ALfZVYUZZ4jmrBdA01v8DLiChpwP7L/M5tx6+FixWhvPxuwm+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=EfOCYcVz; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1ZDsnUkV; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 23 Jul 2025 07:17:20 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1753255041;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5YgqHbpn8uvP6aw0jASz8JOJ2NdnI14ynxxsNjO8uco=;
	b=EfOCYcVzNOO1t9yYzA0+nXJbLRbGEMuQ0h6rwRsEnlPWr0eKK9hKO645V4vZ2qTe7S9wOx
	EhE0G1S2dReW/CMBCjuX+bBV4Fumh86qT1itpHF1qiqyH68AXWBYcnoyfHLEDpZc8ZQwJe
	4BR1Dc3sDUp74DcL3ek2qJOF4n4J1xavJsEYgdxRlAv7//ph4r36uCnlZhllpffCymimok
	N5wRLnl+W9iL67YMByfCwszzAQnj1o35M7dWHkNSHykN9WjdNs0Y1g0SDTif2iSQz3xbKg
	CJxwdv8je4UDLRT8x5ojlzqYynNrDC93p7LtYElwS2Oyit4S5LsXXX9Pa0jYJg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1753255041;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5YgqHbpn8uvP6aw0jASz8JOJ2NdnI14ynxxsNjO8uco=;
	b=1ZDsnUkV0a5lL0oFH45yzqimal0POu2AULlWn0i3nosFP+MDUigVfKre/vKqUlDkmtElZq
	yzZks/tirtDNLtAQ==
From: "tip-bot2 for Frank Li" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/clocksource] dt-bindings: timer: Add fsl,timrot.yaml
Cc: Frank Li <Frank.Li@nxp.com>, Conor Dooley <conor.dooley@microchip.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250528165351.691848-1-Frank.Li@nxp.com>
References: <20250528165351.691848-1-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175325504048.1420.1653390872405401266.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/clocksource branch of ti=
p:

Commit-ID:     70bb27a1b5f3c9b81d76243878bbb27fd2ae051c
Gitweb:        https://git.kernel.org/tip/70bb27a1b5f3c9b81d76243878bbb27fd2a=
e051c
Author:        Frank Li <Frank.Li@nxp.com>
AuthorDate:    Wed, 28 May 2025 12:53:50 -04:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Tue, 15 Jul 2025 13:22:24 +02:00

dt-bindings: timer: Add fsl,timrot.yaml

Add fsl,timrot.yaml for i.MX23/i.MX28 timer.

Also add a generic fallback compatible string "fsl,timrot" for legacy
devices, which have existed for over 15 years.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Link: https://lore.kernel.org/r/20250528165351.691848-1-Frank.Li@nxp.com
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 Documentation/devicetree/bindings/timer/fsl,timrot.yaml | 48 ++++++++-
 1 file changed, 48 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/timer/fsl,timrot.yaml

diff --git a/Documentation/devicetree/bindings/timer/fsl,timrot.yaml b/Docume=
ntation/devicetree/bindings/timer/fsl,timrot.yaml
new file mode 100644
index 0000000..d181f27
--- /dev/null
+++ b/Documentation/devicetree/bindings/timer/fsl,timrot.yaml
@@ -0,0 +1,48 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/timer/fsl,timrot.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Freescale MXS Timer
+
+maintainers:
+  - Frank Li <Frank.Li@nxp.com>
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - fsl,imx23-timrot
+          - fsl,imx28-timrot
+      - const: fsl,timrot
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    items:
+      - description: irq for timer0
+      - description: irq for timer1
+      - description: irq for timer2
+      - description: irq for timer3
+
+  clocks:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+
+additionalProperties: false
+
+examples:
+  - |
+    timer: timer@80068000 {
+        compatible =3D "fsl,imx28-timrot", "fsl,timrot";
+        reg =3D <0x80068000 0x2000>;
+        interrupts =3D <48>, <49>, <50>, <51>;
+        clocks =3D <&clks 26>;
+    };

