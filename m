Return-Path: <linux-tip-commits+bounces-5715-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 43DBBABFA7D
	for <lists+linux-tip-commits@lfdr.de>; Wed, 21 May 2025 18:00:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3E55A2405E
	for <lists+linux-tip-commits@lfdr.de>; Wed, 21 May 2025 15:54:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D88C227EA0;
	Wed, 21 May 2025 15:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0oNf9rrE";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MoETYDsb"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F584226D03;
	Wed, 21 May 2025 15:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747842577; cv=none; b=dheoGUtinJPjNvH0gOhlBcpbxoSRLAqEBaEEK2u0zsUFyoNyDTS400Gwq0U8YYHP3nT0IJHlm96oZSkDyk247ekSzO4MYpVkOi+s/b+CSbpZN7xvYC+N3HEV6/TvxG1xO8YDa+Lar3UBh13U+syVQfZDaZCOB6bIzsbjZEzmyLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747842577; c=relaxed/simple;
	bh=3DeLa96hC90egnDQlaZ6Dzeat/V5OnV/8iwK956cyNo=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=hVNu2XTw+6d1CajbnxOnxtDHhMQafkIVHqdmaeJl7xZDM0uFoQeWYT+3aftCE9Fgidiqw/UY9lA2eTlDP9r84X5GM6GkIYFD5ngAoj6v18hv0D3rCgr6I7eoWaKQnMbhcabaLOw+POUSzoaqsPoYQg5IBJLnTubrt6yo4HvHGPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0oNf9rrE; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MoETYDsb; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 21 May 2025 15:49:33 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1747842574;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WmuM+UYUPREQknuDQ3eiMPMCNVN9E52PMGfJTHwpsEk=;
	b=0oNf9rrEiu7NSMmlJPhb1Mwlc8u/j4A+lPg+C6FetnxeEKKFrRWb0FRcx1MW7dtFAL3H2I
	/6K8TLNNmT/DIuZS/xzmqBAGDWs2SBW2/520M2RFO9Ew2GlrDMSB5iT6YMzq2yQ8F5E8KW
	F8qUs/nORSyTaRvzrWfNewAbKnY27Hq9Ierqw4D1O4nblOYR0MT/mqh2KvgDhCGItc1H4c
	u8L1ZjcW7p3TV5BdkfQntEGhDzmUlJ98vk72c3/Xp3KS3wUZ1tANuk6ucdjMfnZG2sFB97
	OaIEBjvlrP9ZZ1+2TZFaErXcLEF3p/M1lVkG/d4Sg8Bnt4LnVTwzbkKKD0nE4g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1747842574;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WmuM+UYUPREQknuDQ3eiMPMCNVN9E52PMGfJTHwpsEk=;
	b=MoETYDsby7ZczNWkYcvPU51Zc1wgwc469I8AFVkdwe1HVmTOgBRfZ8xQS4hEHrjHJqT+rj
	V8ZuECzF4rNAM3BQ==
From: "tip-bot2 for Rob Herring (Arm)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/clocksource] dt-bindings: timer: Convert altr,timer-1.0
 to DT schema
Cc: "Rob Herring (Arm)" <robh@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250506022202.2586157-1-robh@kernel.org>
References: <20250506022202.2586157-1-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174784257310.406.8114070401913877015.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/clocksource branch of tip:

Commit-ID:     60160c4bf6ffefe26e4a40315160d828eda2bfff
Gitweb:        https://git.kernel.org/tip/60160c4bf6ffefe26e4a40315160d828eda2bfff
Author:        Rob Herring (Arm) <robh@kernel.org>
AuthorDate:    Mon, 05 May 2025 21:22:01 -05:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Fri, 16 May 2025 11:10:33 +02:00

dt-bindings: timer: Convert altr,timer-1.0 to DT schema

Convert the Altera Timer binding to DT schema format. It's a
straight-forward conversion.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
Link: https://lore.kernel.org/r/20250506022202.2586157-1-robh@kernel.org
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 Documentation/devicetree/bindings/timer/altr,timer-1.0.txt  | 18 +---
 Documentation/devicetree/bindings/timer/altr,timer-1.0.yaml | 39 +++++++-
 2 files changed, 39 insertions(+), 18 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/timer/altr,timer-1.0.txt
 create mode 100644 Documentation/devicetree/bindings/timer/altr,timer-1.0.yaml

diff --git a/Documentation/devicetree/bindings/timer/altr,timer-1.0.txt b/Documentation/devicetree/bindings/timer/altr,timer-1.0.txt
deleted file mode 100644
index e698e34..0000000
--- a/Documentation/devicetree/bindings/timer/altr,timer-1.0.txt
+++ /dev/null
@@ -1,18 +0,0 @@
-Altera Timer
-
-Required properties:
-
-- compatible : should be "altr,timer-1.0"
-- reg : Specifies base physical address and size of the registers.
-- interrupts : Should contain the timer interrupt number
-- clock-frequency : The frequency of the clock that drives the counter, in Hz.
-
-Example:
-
-timer {
-	compatible = "altr,timer-1.0";
-	reg = <0x00400000 0x00000020>;
-	interrupt-parent = <&cpu>;
-	interrupts = <11>;
-	clock-frequency = <125000000>;
-};
diff --git a/Documentation/devicetree/bindings/timer/altr,timer-1.0.yaml b/Documentation/devicetree/bindings/timer/altr,timer-1.0.yaml
new file mode 100644
index 0000000..576260c
--- /dev/null
+++ b/Documentation/devicetree/bindings/timer/altr,timer-1.0.yaml
@@ -0,0 +1,39 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/altr,timer-1.0.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Altera Timer
+
+maintainers:
+  - Dinh Nguyen <dinguyen@kernel.org>
+
+properties:
+  compatible:
+    const: altr,timer-1.0
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clock-frequency:
+    description: Frequency of the clock that drives the counter, in Hz.
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
+    timer@400000 {
+        compatible = "altr,timer-1.0";
+        reg = <0x00400000 0x00000020>;
+        interrupts = <11>;
+        clock-frequency = <125000000>;
+    };

