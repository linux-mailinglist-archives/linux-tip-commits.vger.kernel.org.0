Return-Path: <linux-tip-commits+bounces-5728-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A838DABFA85
	for <lists+linux-tip-commits@lfdr.de>; Wed, 21 May 2025 18:01:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 634F9188A0A2
	for <lists+linux-tip-commits@lfdr.de>; Wed, 21 May 2025 15:57:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D77C227054E;
	Wed, 21 May 2025 15:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="z7LwjBb1";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dNyFwkPG"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9467E258CDB;
	Wed, 21 May 2025 15:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747842586; cv=none; b=TzdZkss8hRSABbfI29kGsounSUpV100nzXD72Ws2KFUWMqYfcdrjCZpnDSiHs2xNOpuCaQbeihPIemssrY2kvYVc330ezJW8+a4D7iUN22tmeSN8RJPojZ66BILu5wU8Ou6adKFmAZiQbxoIVjheyuD/joPPrs3l6K/XEvJacYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747842586; c=relaxed/simple;
	bh=m2MB1PtqeBIOss9N4RBh1hGKgUdIZ2fJFqbxeISpyxM=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=qX6uKI3YwQmojn4K/xYt1s2tywGoNavY3qbaak+GNMoxMrY+8+7WYvjZW2q7XOGTllqS/ITpM4kLvnTpU/Sek6HUtQZNV41APkeUET7s+kxw8Nn2AMtiGz4411NjOVbbkKmSqqgWl5QIw7FvEH++G55L2VCz/P7zTd3U5JkVvZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=z7LwjBb1; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dNyFwkPG; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 21 May 2025 15:49:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1747842581;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RTc2T3X5ug5uioh1ofJ4W48jDDItNHM1pjjURzgvtY8=;
	b=z7LwjBb1iMU4MxtCPxio3shOkL6iPeOfVeomDhBTtv74fT0XAuPHU9TutddYdzzbiKcGBI
	Kk8ZVwqCUp6sVwCBdNjr6CxRJNKAurM/NRgOP1Vp1+wBzJnYErWQ0lEz/RXoTfna5+MtV2
	lsf/LY9DNOoUf+uVQkAy9J8XXnhRYnka6e1eHLm7W/lvzC7Zskd/U5mTtx8UiYEAOTw/ZN
	mWlw2NXdo7xgtUbE1yHSYtR6zb+kxZCb9OwantAYFrgUlaGeqteBwbtmYaX/sorZSiYChQ
	VXyvmSqlBzy8NTT0N5DRZibrjyPwgYykbXHZF8YcSZ4uDQFLK1M95u+svD2LWQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1747842581;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RTc2T3X5ug5uioh1ofJ4W48jDDItNHM1pjjURzgvtY8=;
	b=dNyFwkPGEIPVJAP/+XHEThS7t/VLjG41bJ0fILzMIa3V7eCpP4DvFFvxlMYSj7SPlhXNV7
	KbWR4dqCzCr0PABQ==
From: "tip-bot2 for Rob Herring (Arm)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/clocksource] dt-bindings: timer: Convert
 marvell,orion-timer to DT schema
Cc: "Rob Herring (Arm)" <robh@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250506022305.2588431-1-robh@kernel.org>
References: <20250506022305.2588431-1-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174784258028.406.7193626994702834035.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/clocksource branch of tip:

Commit-ID:     ea1ab43e5cec8704556fcdd38082a08160b2b2ce
Gitweb:        https://git.kernel.org/tip/ea1ab43e5cec8704556fcdd38082a08160b2b2ce
Author:        Rob Herring (Arm) <robh@kernel.org>
AuthorDate:    Mon, 05 May 2025 21:23:04 -05:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Fri, 16 May 2025 11:10:33 +02:00

dt-bindings: timer: Convert marvell,orion-timer to DT schema

Convert the Marvell Orion Timer binding to DT schema format. It's a
straight-forward conversion.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Link: https://lore.kernel.org/r/20250506022305.2588431-1-robh@kernel.org
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 Documentation/devicetree/bindings/timer/marvell,orion-timer.txt  | 16 ----------------
 Documentation/devicetree/bindings/timer/marvell,orion-timer.yaml | 43 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 43 insertions(+), 16 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/timer/marvell,orion-timer.txt
 create mode 100644 Documentation/devicetree/bindings/timer/marvell,orion-timer.yaml

diff --git a/Documentation/devicetree/bindings/timer/marvell,orion-timer.txt b/Documentation/devicetree/bindings/timer/marvell,orion-timer.txt
deleted file mode 100644
index cd1a0c2..0000000
--- a/Documentation/devicetree/bindings/timer/marvell,orion-timer.txt
+++ /dev/null
@@ -1,16 +0,0 @@
-Marvell Orion SoC timer
-
-Required properties:
-- compatible: shall be "marvell,orion-timer"
-- reg: base address of the timer register starting with TIMERS CONTROL register
-- interrupts: should contain the interrupts for Timer0 and Timer1
-- clocks: phandle of timer reference clock (tclk)
-
-Example:
-	timer: timer {
-		compatible = "marvell,orion-timer";
-		reg = <0x20300 0x20>;
-		interrupt-parent = <&bridge_intc>;
-		interrupts = <1>, <2>;
-		clocks = <&core_clk 0>;
-	};
diff --git a/Documentation/devicetree/bindings/timer/marvell,orion-timer.yaml b/Documentation/devicetree/bindings/timer/marvell,orion-timer.yaml
new file mode 100644
index 0000000..f973aff
--- /dev/null
+++ b/Documentation/devicetree/bindings/timer/marvell,orion-timer.yaml
@@ -0,0 +1,43 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/marvell,orion-timer.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Marvell Orion SoC timer
+
+maintainers:
+  - Andrew Lunn <andrew@lunn.ch>
+  - Gregory Clement <gregory.clement@bootlin.com>
+
+properties:
+  compatible:
+    const: marvell,orion-timer
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  interrupts:
+    items:
+      - description: Timer0 interrupt
+      - description: Timer1 interrupt
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
+    timer@20300 {
+        compatible = "marvell,orion-timer";
+        reg = <0x20300 0x20>;
+        interrupts = <1>, <2>;
+        clocks = <&core_clk 0>;
+    };

