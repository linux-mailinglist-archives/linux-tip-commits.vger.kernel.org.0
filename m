Return-Path: <linux-tip-commits+bounces-5705-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BD39AABFA51
	for <lists+linux-tip-commits@lfdr.de>; Wed, 21 May 2025 17:56:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A8A01C028F0
	for <lists+linux-tip-commits@lfdr.de>; Wed, 21 May 2025 15:52:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04954220680;
	Wed, 21 May 2025 15:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0Uhf0+ex";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pN5Fzuvg"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB44E213E74;
	Wed, 21 May 2025 15:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747842567; cv=none; b=ND7wCqfkodobVwfjw6L2k6Zk+cguAH47TqJ/QBc/YIQf09ODjbhVyu4XQbm26EBYVANBJRVCPULml+so2KYr9+qzwSeN9iahgg5FGfL4ZTteUOhOMpET0anWH2neVy3YyAwjxwieLB1KmcnKLBoi7qg+4sSi58O71/5gwdZX0+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747842567; c=relaxed/simple;
	bh=qEE2anjItOflx4iegRTyGxePdBY+gbcQ9hMCkkXCxN4=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=XGImrFP2BvgUotr7kIUh1yrgZIm/PF4atBwRYryMGn00KbaZu4jBe/CXkYFbDXrCdptVZ0vez47wOARaxNMhH+HVUvU/luzyjx2XY0kuyzd6u0hoHA6a9RgRo/1VBOfDzb7YOx25XXbZc+U9qsR8BefDFGKFt3x3p8J61U5be84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0Uhf0+ex; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pN5Fzuvg; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 21 May 2025 15:49:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1747842564;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VqIdfjIjUGbBzUjKI2axpl1OtMToZAnWR6NqjwMcNdE=;
	b=0Uhf0+ex92IeJZmruoA5QdoQ5ORonLA9t2Y3z/bNtliD+PFtqTilZZo36VXmwq/+A2eDfl
	oKw31e3lNTUUsd9rB/V+8X6GVhMYg9acDRnrOm/TRl+koMmyjVuYGcED2ZDgL9yrUOMkf5
	9+hESe8KbnXtTJ9KAJe7fgjp+SF48mdiwOJMkEhgo1ipokdvSkV4SYKtZzUUvb/ahsKO78
	GdJKc8lGU566tBP9c5enXGcPATOHdl7BXizxbkGHNbc1HigsVMKCTMyAAkdptX5MfrZO7L
	L6dskQeNwuT3B9dmfn7+y09A7wrlC7wxwno01TNWFA4LPXKPMONR4v9a54jxqQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1747842564;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VqIdfjIjUGbBzUjKI2axpl1OtMToZAnWR6NqjwMcNdE=;
	b=pN5FzuvgzcBt2qex77U3t/VFLQC03eHDOkjJuzUmlIsym2auktxh9M90l0iJwYspIhtduG
	g4boJj5ojMGQDCCQ==
From: "tip-bot2 for Rob Herring (Arm)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/clocksource] dt-bindings: timer: Convert
 marvell,armada-370-timer to DT schema
Cc: "Rob Herring (Arm)" <robh@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250506022301.2588282-1-robh@kernel.org>
References: <20250506022301.2588282-1-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174784256326.406.11743895008840312928.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/clocksource branch of tip:

Commit-ID:     4334d83904fc8b1a4bd5c0829164511456feb600
Gitweb:        https://git.kernel.org/tip/4334d83904fc8b1a4bd5c0829164511456feb600
Author:        Rob Herring (Arm) <robh@kernel.org>
AuthorDate:    Mon, 05 May 2025 21:23:00 -05:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Fri, 16 May 2025 11:10:34 +02:00

dt-bindings: timer: Convert marvell,armada-370-timer to DT schema

Convert the Marvell Armada 37x/380/XP Timer binding to DT schema format.
Update the compatible entries to match what is in use.
"marvell,armada-380-timer" in particular was missing.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Link: https://lore.kernel.org/r/20250506022301.2588282-1-robh@kernel.org
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 Documentation/devicetree/bindings/timer/marvell,armada-370-timer.yaml   | 88 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 Documentation/devicetree/bindings/timer/marvell,armada-370-xp-timer.txt | 44 +-----------------------------------
 2 files changed, 88 insertions(+), 44 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/timer/marvell,armada-370-timer.yaml
 delete mode 100644 Documentation/devicetree/bindings/timer/marvell,armada-370-xp-timer.txt

diff --git a/Documentation/devicetree/bindings/timer/marvell,armada-370-timer.yaml b/Documentation/devicetree/bindings/timer/marvell,armada-370-timer.yaml
new file mode 100644
index 0000000..bc0677f
--- /dev/null
+++ b/Documentation/devicetree/bindings/timer/marvell,armada-370-timer.yaml
@@ -0,0 +1,88 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/timer/marvell,armada-370-timer.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Marvell Armada 370, 375, 380 and XP Timers
+
+maintainers:
+  - Andrew Lunn <andrew@lunn.ch>
+  - Gregory Clement <gregory.clement@bootlin.com>
+
+properties:
+  compatible:
+    oneOf:
+      - items:
+          - const: marvell,armada-380-timer
+          - const: marvell,armada-xp-timer
+      - items:
+          - const: marvell,armada-375-timer
+          - const: marvell,armada-370-timer
+      - enum:
+          - marvell,armada-370-timer
+          - marvell,armada-xp-timer
+
+  reg:
+    items:
+      - description: Global timer registers
+      - description: Local/private timer registers
+
+  interrupts:
+    items:
+      - description: Global timer interrupt 0
+      - description: Global timer interrupt 1
+      - description: Global timer interrupt 2
+      - description: Global timer interrupt 3
+      - description: First private timer interrupt
+      - description: Second private timer interrupt
+
+  clocks:
+    minItems: 1
+    maxItems: 2
+
+  clock-names:
+    items:
+      - const: nbclk
+      - const: fixed
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+
+additionalProperties: false
+
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - marvell,armada-375-timer
+              - marvell,armada-xp-timer
+    then:
+      properties:
+        clocks:
+          minItems: 2
+        clock-names:
+          minItems: 2
+      required:
+        - clock-names
+    else:
+      properties:
+        clocks:
+          maxItems: 1
+        clock-names:
+          maxItems: 1
+
+examples:
+  - |
+    timer@20300 {
+        compatible = "marvell,armada-xp-timer";
+        reg = <0x20300 0x30>, <0x21040 0x30>;
+        interrupts = <37>, <38>, <39>, <40>, <5>, <6>;
+        clocks = <&coreclk 2>, <&refclk>;
+        clock-names = "nbclk", "fixed";
+    };
diff --git a/Documentation/devicetree/bindings/timer/marvell,armada-370-xp-timer.txt b/Documentation/devicetree/bindings/timer/marvell,armada-370-xp-timer.txt
deleted file mode 100644
index e9c78ce..0000000
--- a/Documentation/devicetree/bindings/timer/marvell,armada-370-xp-timer.txt
+++ /dev/null
@@ -1,44 +0,0 @@
-Marvell Armada 370 and Armada XP Timers
----------------------------------------
-
-Required properties:
-- compatible: Should be one of the following
-              "marvell,armada-370-timer",
-	      "marvell,armada-375-timer",
-	      "marvell,armada-xp-timer".
-- interrupts: Should contain the list of Global Timer interrupts and
-  then local timer interrupts
-- reg: Should contain location and length for timers register. First
-  pair for the Global Timer registers, second pair for the
-  local/private timers.
-
-Clocks required for compatible = "marvell,armada-370-timer":
-- clocks : Must contain a single entry describing the clock input
-
-Clocks required for compatibles = "marvell,armada-xp-timer",
-				  "marvell,armada-375-timer":
-- clocks : Must contain an entry for each entry in clock-names.
-- clock-names : Must include the following entries:
-  "nbclk" (L2/coherency fabric clock),
-  "fixed" (Reference 25 MHz fixed-clock).
-
-Examples:
-
-- Armada 370:
-
-	timer {
-		compatible = "marvell,armada-370-timer";
-		reg = <0x20300 0x30>, <0x21040 0x30>;
-		interrupts = <37>, <38>, <39>, <40>, <5>, <6>;
-		clocks = <&coreclk 2>;
-	};
-
-- Armada XP:
-
-	timer {
-		compatible = "marvell,armada-xp-timer";
-		reg = <0x20300 0x30>, <0x21040 0x30>;
-		interrupts = <37>, <38>, <39>, <40>, <5>, <6>;
-		clocks = <&coreclk 2>, <&refclk>;
-		clock-names = "nbclk", "fixed";
-	};

