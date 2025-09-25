Return-Path: <linux-tip-commits+bounces-6760-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9246FBA19A9
	for <lists+linux-tip-commits@lfdr.de>; Thu, 25 Sep 2025 23:39:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41983176D94
	for <lists+linux-tip-commits@lfdr.de>; Thu, 25 Sep 2025 21:39:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAD6432E755;
	Thu, 25 Sep 2025 21:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xNJjGuAZ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bufTePn0"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE770322C8A;
	Thu, 25 Sep 2025 21:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758836027; cv=none; b=LG/fDIuqgjRekoN7ij9obNw/6qpjdmb2LUYm+nt/9dLLXJdSgP/zn/wDOnzfkUIXt8foyXFoDqQzJZXMgYoj8Fs9phpQ1ZcBM9AJYEZ6QjvEj3YDo3V7rGxFDZHmCU83/jME8eUK4ZsStc2uMfKaV47V3yCjXAGae5Zck3Q+63w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758836027; c=relaxed/simple;
	bh=8bLAwghSsBJ3v3APd/ROPpHQEdFYIyAgCAdWbpe0prY=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=HFOvdyq1uV0Rta6DkYu0uIE/c87izZl562g88tJpWBD3yot2ym7PEAugUfl/crIsmZdotNW+A5l1iT8kPJ2cPnd4fFhwfrsRlHe6T1u1yeq4qFATQjMvCg81Zm+VqvTm2TA0YuSFrPmEUzf5wAexjomNmpOG1VuftpHLnhHW3lY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xNJjGuAZ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bufTePn0; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 25 Sep 2025 21:33:42 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1758836024;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=pg4hhP5+7ZxcxZFg1ZDak5DD4oJueIkO9HQZRisTgB0=;
	b=xNJjGuAZDd9PDGtgHea0GIvRPBCd364ngGoZLmhu0daC5hMWipAmQH46e5p0UtMDjuT6ik
	bDrxHcy9/ayrU+JyOuF6Yx/ZEe2F0thu2tLTMTrjnVZG45HT9LUQ8/oHc7MTcEhqkM+gPR
	OCIv6ftNcHKsiDE+iejTWOHVCkTiqGcF5VZSqKw2c/COL0IX0DxX0keOcvlXeByO6bEQcP
	+gv57VLF6tTk9Xm8dyLiTBSbIPfbUXI/9ocUZPUhL9O5bXTRlfjV1WV/F1gHvJBjSINFfy
	vJUj8nNkaqANZS7Zc3jnbKzpLUaJfTKxuTgAUb3BjeeDCaCn825WqQt5Xf+1Aw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1758836024;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=pg4hhP5+7ZxcxZFg1ZDak5DD4oJueIkO9HQZRisTgB0=;
	b=bufTePn0b5ZDR7g6ehlbE9ImqqiDt5uS63P+LjU7zRV+k+SDbP4UEviYM0GO3Mmnqj4HB3
	K84E3RmdfKPNbhAg==
From: "tip-bot2 for Frank Li" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/clocksource] dt-bindings: timer: Add fsl,timrot.yaml
Cc: Frank Li <Frank.Li@nxp.com>, Daniel Lezcano <daniel.lezcano@linaro.org>,
 Conor Dooley <conor.dooley@microchip.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175883602274.709179.8781172810349226531.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/clocksource branch of ti=
p:

Commit-ID:     ffc5870fc4e0ea72bf73ad5ab1d648aa0b4f7cbf
Gitweb:        https://git.kernel.org/tip/ffc5870fc4e0ea72bf73ad5ab1d648aa0b4=
f7cbf
Author:        Frank Li <Frank.Li@nxp.com>
AuthorDate:    Wed, 28 May 2025 12:53:50 -04:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Tue, 23 Sep 2025 10:56:05 +02:00

dt-bindings: timer: Add fsl,timrot.yaml

Add fsl,timrot.yaml for i.MX23/i.MX28 timer.

Also add a generic fallback compatible string "fsl,timrot" for legacy
devices, which have existed for over 15 years.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Link: https://lore.kernel.org/r/20250528165351.691848-1-Frank.Li@nxp.com
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

