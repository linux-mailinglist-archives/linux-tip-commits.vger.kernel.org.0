Return-Path: <linux-tip-commits+bounces-5720-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 50D96ABFA76
	for <lists+linux-tip-commits@lfdr.de>; Wed, 21 May 2025 17:59:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4F60188E105
	for <lists+linux-tip-commits@lfdr.de>; Wed, 21 May 2025 15:56:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A565822AE68;
	Wed, 21 May 2025 15:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="l8SxnSD5";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mv5DUP5v"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CDBB22A1D4;
	Wed, 21 May 2025 15:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747842581; cv=none; b=QMUnZXXSUz/l+FPHNpACJ5K6TRK7J4vUM5HTnLZ1P2qxLtFLXROQYy/2ImX2xapaTJDFiXdZA4JPUyhEQyUPxRVoTxLJheB1AcwaA1M/35Dv130Kht9ErhgfhjtIiFZIk70hCDBH3UQULNYZWuqXUTHVVFAAzAUhabIoR8g0OCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747842581; c=relaxed/simple;
	bh=v8DGNAZqBn7qxdUxh87MuxaJcajFdB3El3g1cwKUFOQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=jASPmTnAALZqZINz4Y5hiGQbOYWABdbRij1Elu2mG4w9cNOc4lDCJKbKXfXakVUqVx3ZoxQXwBBtmHxd0OISK+IhBFBXOCTgOl2Chugp6EwTQ7g8Pm1LkVC/cxFjfUabeJeRq4YgX+4QdKEZ1FmzhVkEVur/J+8dHqG9IqkDkH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=l8SxnSD5; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mv5DUP5v; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 21 May 2025 15:49:36 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1747842577;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MeCUmUq5yC8Y2rfrGiAhlb8jyYWjEP3/SNiJoi8iWkA=;
	b=l8SxnSD5RlLPqYCpo8Tebm0F5TgpcDmRQCs9Esrp+cifdniLoKoHnU7JL7YN59ZWq0G2Im
	+TEZGO7H/i3jKGCKk4RC8+gT+SR9mE7C6c9eay6GE82O8tPpBEw5j1G1SVojjs3oEF9reS
	drjYA01b8UFUYbK9PLvmPwHbd6DMj20wOgWCoGpz024NW0aQEEbbLSTd//DaLrjvzKeZWj
	u9/SWA7VQlOlva/pL8dxsPz/Pvgf70M2KlYyA35ICGkusDx+Q41gpjMvgITUPa63W7fkQa
	PI5TuSvBARxwCLHOiOOCErSDHXHpdqHCNU5+XZmcx/69Ev6Lq+2SaFM744+/8g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1747842577;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MeCUmUq5yC8Y2rfrGiAhlb8jyYWjEP3/SNiJoi8iWkA=;
	b=mv5DUP5vABSabG1dUq6Tkoz+flngmXXzCssFl+oHt+dCD8kX2gmmBdDPR6Oo2KyRIc45ZY
	+LqgBebxRifNC3Bw==
From: "tip-bot2 for Rob Herring (Arm)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/clocksource] dt-bindings: timer: Convert arm,mps2-timer
 to DT schema
Cc: "Rob Herring (Arm)" <robh@kernel.org>, Liviu Dudau <liviu.dudau@arm.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250506022210.2586404-1-robh@kernel.org>
References: <20250506022210.2586404-1-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174784257641.406.10179818835384921673.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/clocksource branch of tip:

Commit-ID:     7aeeac55658f68181c9dd6af07717db07cfeab7a
Gitweb:        https://git.kernel.org/tip/7aeeac55658f68181c9dd6af07717db07cfeab7a
Author:        Rob Herring (Arm) <robh@kernel.org>
AuthorDate:    Mon, 05 May 2025 21:22:09 -05:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Fri, 16 May 2025 11:10:33 +02:00

dt-bindings: timer: Convert arm,mps2-timer to DT schema

Convert the Arm MPS2 Timer binding to DT schema format. It's a
straight-forward conversion.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>
Link: https://lore.kernel.org/r/20250506022210.2586404-1-robh@kernel.org
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 Documentation/devicetree/bindings/timer/arm,mps2-timer.txt  | 28 +----
 Documentation/devicetree/bindings/timer/arm,mps2-timer.yaml | 49 +++++++-
 2 files changed, 49 insertions(+), 28 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/timer/arm,mps2-timer.txt
 create mode 100644 Documentation/devicetree/bindings/timer/arm,mps2-timer.yaml

diff --git a/Documentation/devicetree/bindings/timer/arm,mps2-timer.txt b/Documentation/devicetree/bindings/timer/arm,mps2-timer.txt
deleted file mode 100644
index 48f84d7..0000000
--- a/Documentation/devicetree/bindings/timer/arm,mps2-timer.txt
+++ /dev/null
@@ -1,28 +0,0 @@
-ARM MPS2 timer
-
-The MPS2 platform has simple general-purpose 32 bits timers.
-
-Required properties:
-- compatible	: Should be "arm,mps2-timer"
-- reg		: Address and length of the register set
-- interrupts	: Reference to the timer interrupt
-
-Required clocking property, have to be one of:
-- clocks	  : The input clock of the timer
-- clock-frequency : The rate in HZ in input of the ARM MPS2 timer
-
-Examples:
-
-timer1: mps2-timer@40000000 {
-	compatible = "arm,mps2-timer";
-	reg = <0x40000000 0x1000>;
-	interrupts = <8>;
-	clocks = <&sysclk>;
-};
-
-timer2: mps2-timer@40001000 {
-	compatible = "arm,mps2-timer";
-	reg = <0x40001000 0x1000>;
-	interrupts = <9>;
-	clock-frequency = <25000000>;
-};
diff --git a/Documentation/devicetree/bindings/timer/arm,mps2-timer.yaml b/Documentation/devicetree/bindings/timer/arm,mps2-timer.yaml
new file mode 100644
index 0000000..64c6aed
--- /dev/null
+++ b/Documentation/devicetree/bindings/timer/arm,mps2-timer.yaml
@@ -0,0 +1,49 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/arm,mps2-timer.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ARM MPS2 timer
+
+maintainers:
+  - Vladimir Murzin <vladimir.murzin@arm.com>
+
+description:
+  The MPS2 platform has simple general-purpose 32 bits timers.
+
+properties:
+  compatible:
+    const: arm,mps2-timer
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  clock-frequency:
+    description: Rate in Hz of the timer input clock
+
+oneOf:
+  - required: [clocks]
+  - required: [clock-frequency]
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
+    timer@40000000 {
+        compatible = "arm,mps2-timer";
+        reg = <0x40000000 0x1000>;
+        interrupts = <8>;
+        clocks = <&sysclk>;
+    };

