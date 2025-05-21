Return-Path: <linux-tip-commits+bounces-5712-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56C35ABFA3E
	for <lists+linux-tip-commits@lfdr.de>; Wed, 21 May 2025 17:54:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 384831700F9
	for <lists+linux-tip-commits@lfdr.de>; Wed, 21 May 2025 15:54:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 903B6226188;
	Wed, 21 May 2025 15:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="q76JXltm";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wXdHLw47"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80E90224249;
	Wed, 21 May 2025 15:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747842574; cv=none; b=UE7V3kmhvjdA2VFUTj+2fVzzNnofWihZu7VLLowYdVClU32K5Rg1og1s9q52MR426pwjP+2eEXe0jRQdGm6CRCbnK7DeqFQ4LVNPoJ+KgQZlNzXBPGwFMsH09sjEql4pU/rsIiuoXsVnEuWJvcgVbPLp+Kemu9bJZNcCZLmFF2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747842574; c=relaxed/simple;
	bh=ij8IYyCU8cqsW/RN7lrxvchrht99HZ/RBKa1IMEWkiw=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=YOXCHPGCu/S5Sl2ZeBF3Ag9oV11LSmYaXSYIEaahtuJb7TUt76B60SC8izU8Hie5T4I0P+nDs8K9k2IPL72oLGIQJic94oUeJnJngaDABFgm451WXXvSs4yNkuWwBXPTJSpsaeL8wI9DUXgg18CmX/W13iSZOSXOneDqngrjhj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=q76JXltm; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wXdHLw47; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 21 May 2025 15:49:28 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1747842570;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2/x2qIF9YjaB3ygbddbFPVEK5AJ4vDWqVla9tBQrDvk=;
	b=q76JXltmdafA4CSNVzaF3clrxbDa28nBgIxl33NR9zDTwwJ/upjlZYRFD2r2UsZGz492UK
	ii9EmYMxahDlFTcyF5ywff82G8yCS3jrecrBezbVi2vD7WWIlATofEtl9Y/76dGWXSCrSz
	cjqVXtQ5Ui4nx/RBRUmd9gyvqawKUwgZ6cYPhHYCzO+hD3QTS6jlwa6dXpDndT5sqrOwxY
	ROku+5fMLeumr1a6JvyXk08ADShdYsoM9A/rAeGvXUQRrFcIJeaN+EDVevRGu6gN79Mi9a
	MX8D/VrkiGlo4TMBQtkU8Uwwnjbzf2IwBHNAHQnKZ3XM/oMmPJGzMEC4C1hdBA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1747842570;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2/x2qIF9YjaB3ygbddbFPVEK5AJ4vDWqVla9tBQrDvk=;
	b=wXdHLw47mer2kupmZ5SJt+REPQ4PtVaI5iRoY1qJmscirc+qlQm1r0H4UfK3OXhIDNfwRL
	Hsb/N7FK+VZBe7Cw==
From: "tip-bot2 for Rob Herring (Arm)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/clocksource] dt-bindings: timer: Convert lsi,zevio-timer
 to DT schema
Cc: "Rob Herring (Arm)" <robh@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250506022257.2588136-1-robh@kernel.org>
References: <20250506022257.2588136-1-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174784256883.406.5912869229835644378.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/clocksource branch of tip:

Commit-ID:     e1e9fad1499c029e6052b13e9974f5cc2ccf7c89
Gitweb:        https://git.kernel.org/tip/e1e9fad1499c029e6052b13e9974f5cc2ccf7c89
Author:        Rob Herring (Arm) <robh@kernel.org>
AuthorDate:    Mon, 05 May 2025 21:22:56 -05:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Fri, 16 May 2025 11:10:33 +02:00

dt-bindings: timer: Convert lsi,zevio-timer to DT schema

Convert the TI NSPIRE Timer binding to DT schema format. It's a
straight-forward conversion.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
Link: https://lore.kernel.org/r/20250506022257.2588136-1-robh@kernel.org
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 Documentation/devicetree/bindings/timer/lsi,zevio-timer.txt  | 33 +----
 Documentation/devicetree/bindings/timer/lsi,zevio-timer.yaml | 56 +++++++-
 2 files changed, 56 insertions(+), 33 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/timer/lsi,zevio-timer.txt
 create mode 100644 Documentation/devicetree/bindings/timer/lsi,zevio-timer.yaml

diff --git a/Documentation/devicetree/bindings/timer/lsi,zevio-timer.txt b/Documentation/devicetree/bindings/timer/lsi,zevio-timer.txt
deleted file mode 100644
index b2d07ad..0000000
--- a/Documentation/devicetree/bindings/timer/lsi,zevio-timer.txt
+++ /dev/null
@@ -1,33 +0,0 @@
-TI-NSPIRE timer
-
-Required properties:
-
-- compatible : should be "lsi,zevio-timer".
-- reg : The physical base address and size of the timer (always first).
-- clocks: phandle to the source clock.
-
-Optional properties:
-
-- interrupts : The interrupt number of the first timer.
-- reg : The interrupt acknowledgement registers
-	(always after timer base address)
-
-If any of the optional properties are not given, the timer is added as a
-clock-source only.
-
-Example:
-
-timer {
-	compatible = "lsi,zevio-timer";
-	reg = <0x900D0000 0x1000>, <0x900A0020 0x8>;
-	interrupts = <19>;
-	clocks = <&timer_clk>;
-};
-
-Example (no clock-events):
-
-timer {
-	compatible = "lsi,zevio-timer";
-	reg = <0x900D0000 0x1000>;
-	clocks = <&timer_clk>;
-};
diff --git a/Documentation/devicetree/bindings/timer/lsi,zevio-timer.yaml b/Documentation/devicetree/bindings/timer/lsi,zevio-timer.yaml
new file mode 100644
index 0000000..358455d
--- /dev/null
+++ b/Documentation/devicetree/bindings/timer/lsi,zevio-timer.yaml
@@ -0,0 +1,56 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/timer/lsi,zevio-timer.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: TI-NSPIRE timer
+
+maintainers:
+  - Daniel Tang <dt.tangr@gmail.com>
+
+properties:
+  compatible:
+    const: lsi,zevio-timer
+
+  reg:
+    minItems: 1
+    items:
+      - description: Timer registers
+      - description: Interrupt acknowledgement registers (optional)
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - clocks
+
+allOf:
+  - if:
+      required: [ interrupts ]
+    then:
+      properties:
+        reg:
+          minItems: 2
+
+additionalProperties: false
+
+examples:
+  - |
+    timer@900d0000 {
+        compatible = "lsi,zevio-timer";
+        reg = <0x900D0000 0x1000>, <0x900A0020 0x8>;
+        interrupts = <19>;
+        clocks = <&timer_clk>;
+    };
+  - |
+    timer@900d0000 {
+        compatible = "lsi,zevio-timer";
+        reg = <0x900D0000 0x1000>;
+        clocks = <&timer_clk>;
+    };

