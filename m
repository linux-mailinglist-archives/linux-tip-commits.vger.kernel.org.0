Return-Path: <linux-tip-commits+bounces-5716-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 431DAABFA69
	for <lists+linux-tip-commits@lfdr.de>; Wed, 21 May 2025 17:58:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50A4F1BC0FDE
	for <lists+linux-tip-commits@lfdr.de>; Wed, 21 May 2025 15:54:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B1F5227EB2;
	Wed, 21 May 2025 15:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mgtliNf/";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WB96/xk+"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B2D3221D99;
	Wed, 21 May 2025 15:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747842577; cv=none; b=TkJqhzD4LA3vgNHH6gAEryYu5E3B0m6NTLAL1Uitk5D+6+tRbtWSUaWgO9ZAzKFRyKtzEBamb/+3O8DlP8+i8E9eVsrNthx+S0uePqoKwt68WwQ7OhiCMYL4Xb+tt+yKMhh+zX5QnCFhyc6Q9zLFxNUvjZMJvFdMZ88pqi6u0vE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747842577; c=relaxed/simple;
	bh=aw9zYKs9MISJLI8iig2OA3oFf/4iilKNknnX3HbRSG8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=SaUg2sK8ryV22Qpnbz+7lQaM/wXywS4J2sBlHnSpBuoWEK5KFr64CP3Rkktz4aGW1lzbmkFgu+Tkxo7souIK3N0URoCy5fWBDh68slF8BckxlyPGxeZ6FAkj/4NEj+FvvJCRi8p4WLLgxGX18jtxH2XhQdOGsqQHeeLt9vcMwxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mgtliNf/; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WB96/xk+; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 21 May 2025 15:49:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1747842572;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GeNjqHciE3nwYrjZ2uSVDx3uUbuyDOjTCQLq1jX4Uv8=;
	b=mgtliNf/Sz+fTb2/E+22Fr8zIS9nMUPOlW7IjG0kE9O9SVPBjp/YiDX1WQCiiZwOZw+qMC
	4zptKIqT+m11NVki6TrTtw5V7B0840xf/1qjloFNq3UIbZUe74dTLse2xLt+hCq8uakYJp
	7n8xdDKPPRTqqCKE3WEoPiDmWCZRmXNBuvMpOmV2zYLJGddkfERQNw3wKwr1/TJ4v0BsQa
	zFisOO266Z50+fes2OY25C42Qc0Nkj6gA2wW3gqiAdNsL+/ISkfJbg024CkVkXFXRAfm4A
	LZ6QMyc/a4dzf/w4uKQOIGtkmZYyMR0jXfAgc3YXXnZQPk1tlCBriIEdIg9ylw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1747842572;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GeNjqHciE3nwYrjZ2uSVDx3uUbuyDOjTCQLq1jX4Uv8=;
	b=WB96/xk+QxGwfbLdPv649D8hquLZfyD6eFnlx6HoD/cldhvblp6ltlEETz7vhKjL+JbQte
	Ok2nQzCN5fI4y+DA==
From: "tip-bot2 for Rob Herring (Arm)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/clocksource] dt-bindings: timer: Convert
 ezchip,nps400-timer to DT schema
Cc: "Rob Herring (Arm)" <robh@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250506022237.2587355-1-robh@kernel.org>
References: <20250506022237.2587355-1-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174784257145.406.4047795947097755103.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/clocksource branch of tip:

Commit-ID:     2b3b58f233afb4b1edf779c95e8106fe7c707c7c
Gitweb:        https://git.kernel.org/tip/2b3b58f233afb4b1edf779c95e8106fe7c707c7c
Author:        Rob Herring (Arm) <robh@kernel.org>
AuthorDate:    Mon, 05 May 2025 21:22:35 -05:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Fri, 16 May 2025 11:10:33 +02:00

dt-bindings: timer: Convert ezchip,nps400-timer to DT schema

Convert the EZChip NPS400 Timer bindings to DT schema format. It's a
straight-forward conversion. The 2 bindings only differ in compatible
and one required property, so the schemas can be combined.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
Link: https://lore.kernel.org/r/20250506022237.2587355-1-robh@kernel.org
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 Documentation/devicetree/bindings/timer/ezchip,nps400-timer.yaml | 45 +++++++++++++++++++++++++++++++++++++++++++++
 Documentation/devicetree/bindings/timer/ezchip,nps400-timer0.txt | 17 -----------------
 Documentation/devicetree/bindings/timer/ezchip,nps400-timer1.txt | 15 ---------------
 3 files changed, 45 insertions(+), 32 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/timer/ezchip,nps400-timer.yaml
 delete mode 100644 Documentation/devicetree/bindings/timer/ezchip,nps400-timer0.txt
 delete mode 100644 Documentation/devicetree/bindings/timer/ezchip,nps400-timer1.txt

diff --git a/Documentation/devicetree/bindings/timer/ezchip,nps400-timer.yaml b/Documentation/devicetree/bindings/timer/ezchip,nps400-timer.yaml
new file mode 100644
index 0000000..317c501
--- /dev/null
+++ b/Documentation/devicetree/bindings/timer/ezchip,nps400-timer.yaml
@@ -0,0 +1,45 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/ezchip,nps400-timer.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: EZChip NPS400 Timers
+
+maintainers:
+  - Noam Camus <noamca@mellanox.com>
+
+properties:
+  compatible:
+    enum:
+      - ezchip,nps400-timer0
+      - ezchip,nps400-timer1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+required:
+  - compatible
+  - clocks
+
+additionalProperties: false
+
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: ezchip,nps400-timer0
+    then:
+      required: [ interrupts ]
+
+examples:
+  - |
+    timer {
+        compatible = "ezchip,nps400-timer0";
+        interrupts = <3>;
+        clocks = <&sysclk>;
+    };
diff --git a/Documentation/devicetree/bindings/timer/ezchip,nps400-timer0.txt b/Documentation/devicetree/bindings/timer/ezchip,nps400-timer0.txt
deleted file mode 100644
index e3cfce8..0000000
--- a/Documentation/devicetree/bindings/timer/ezchip,nps400-timer0.txt
+++ /dev/null
@@ -1,17 +0,0 @@
-NPS Network Processor
-
-Required properties:
-
-- compatible :	should be "ezchip,nps400-timer0"
-
-Clocks required for compatible = "ezchip,nps400-timer0":
-- interrupts : The interrupt of the first timer
-- clocks : Must contain a single entry describing the clock input
-
-Example:
-
-timer {
-	compatible = "ezchip,nps400-timer0";
-	interrupts = <3>;
-	clocks = <&sysclk>;
-};
diff --git a/Documentation/devicetree/bindings/timer/ezchip,nps400-timer1.txt b/Documentation/devicetree/bindings/timer/ezchip,nps400-timer1.txt
deleted file mode 100644
index c0ab419..0000000
--- a/Documentation/devicetree/bindings/timer/ezchip,nps400-timer1.txt
+++ /dev/null
@@ -1,15 +0,0 @@
-NPS Network Processor
-
-Required properties:
-
-- compatible :	should be "ezchip,nps400-timer1"
-
-Clocks required for compatible = "ezchip,nps400-timer1":
-- clocks : Must contain a single entry describing the clock input
-
-Example:
-
-timer {
-	compatible = "ezchip,nps400-timer1";
-	clocks = <&sysclk>;
-};

