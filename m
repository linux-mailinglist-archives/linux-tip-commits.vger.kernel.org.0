Return-Path: <linux-tip-commits+bounces-4439-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BF83FA6EB3E
	for <lists+linux-tip-commits@lfdr.de>; Tue, 25 Mar 2025 09:15:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E9B916C35D
	for <lists+linux-tip-commits@lfdr.de>; Tue, 25 Mar 2025 08:15:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 877C61A7AE3;
	Tue, 25 Mar 2025 08:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="N2Xt3B9U";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DAWvqiqx"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF34F204693;
	Tue, 25 Mar 2025 08:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742890498; cv=none; b=dAfy/A9rfJDlbLYboeMa/L5MR04Hf4p46jOg/ENmnBHc+lZC7OOnB8k5IeBE4g7pK9fSS4j+8y3h7IfkzN8m5smAJ+MaDStlb2ptVr7wo+u54kKPzooQ2djjZXYdsojIMsT+I/VptJ2H4MT4TWyBP5H+H4vdetJFqO04hUr6Q8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742890498; c=relaxed/simple;
	bh=6RIChLFcwdC6aM35gmMxc0YpR233ZumN/Zx4dcu4UYQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=bTf4RYKT83nKUBhjBpw7uunDWoUQOL5lhluQOoMzPiyhWgR0dAxdKdNi93lxK4f5g86mdDSvfERt00vAXj17dLrrmjyFhNtREZltJ1pQNl8vO4tmTLflLzVIiNAGRg6VhWddv7lPkDnTZYwb5FnIeGuq8S51KU8J3QGwxtKG3WM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=N2Xt3B9U; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DAWvqiqx; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 25 Mar 2025 08:14:53 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742890494;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=97IRLafD28YGMxQIhEEl6Pt6gPnwfdxDVkQZV+PT9dE=;
	b=N2Xt3B9UI1hVS8rZlZk6Vx6iqmjBkoPgP51+HoRDSk83HdmsF3UX2UWQvc2GGYTcltD/5g
	dJMfdrfkYLvUWXq3z8kGeBm0cUjNb8oHbg+8bqr7Eocu5YHOWNwDT3ka+8jFEOr4l5ZSDP
	pZJQ00VpfYqbvr+QuUN34r3LN7kRk2gCYbUNbyMYUEjreKZRdrDO6ObpCZ3FV6JUh/91sc
	DYCie4Y9TKM1dSPXmV6THa5to6rcXm+LPpZvp5+4T93LFZGi11p8uu7SAHbZ06c9a2uNfi
	SdMzYWvv5SXG8g6/Jack/964q++fd3JIGTl7HBT1H9NXkv4B/23jSV9g8pjhxQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742890494;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=97IRLafD28YGMxQIhEEl6Pt6gPnwfdxDVkQZV+PT9dE=;
	b=DAWvqiqxMd97bHwu5gWCBY0nIn0Fs8NZMq8lcYLZRTjrruAW5dWfV+yEZx2JuN+s/7jK5V
	GZaVxv1O9kbQGxCQ==
From: "tip-bot2 for Nick Hu" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/clocksource] dt-bindings: timer: Add SiFive CLINT2
Cc: Nick Hu <nick.hu@sifive.com>, Samuel Holland <samuel.holland@sifive.com>,
 Conor Dooley <conor.dooley@microchip.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250321083507.25298-1-nick.hu@sifive.com>
References: <20250321083507.25298-1-nick.hu@sifive.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174289049320.14745.2681693065117216206.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/clocksource branch of tip:

Commit-ID:     0f920690a82cc99ae08cab08bee2e5685b62fd04
Gitweb:        https://git.kernel.org/tip/0f920690a82cc99ae08cab08bee2e5685b62fd04
Author:        Nick Hu <nick.hu@sifive.com>
AuthorDate:    Fri, 21 Mar 2025 16:35:06 +08:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Sun, 23 Mar 2025 10:55:43 +01:00

dt-bindings: timer: Add SiFive CLINT2

Add compatible string and property for the SiFive CLINT v2. The SiFive
CLINT v2 is incompatible with the SiFive CLINT v0 due to differences
in their control methods.

Signed-off-by: Nick Hu <nick.hu@sifive.com>
Reviewed-by: Samuel Holland <samuel.holland@sifive.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Link: https://lore.kernel.org/r/20250321083507.25298-1-nick.hu@sifive.com
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 Documentation/devicetree/bindings/timer/sifive,clint.yaml | 22 +++++++-
 1 file changed, 22 insertions(+)

diff --git a/Documentation/devicetree/bindings/timer/sifive,clint.yaml b/Documentation/devicetree/bindings/timer/sifive,clint.yaml
index 73edde5..653e2e0 100644
--- a/Documentation/devicetree/bindings/timer/sifive,clint.yaml
+++ b/Documentation/devicetree/bindings/timer/sifive,clint.yaml
@@ -37,6 +37,12 @@ properties:
               - starfive,jh8100-clint   # StarFive JH8100
           - const: sifive,clint0        # SiFive CLINT v0 IP block
       - items:
+          - {}
+          - const: sifive,clint2        # SiFive CLINT v2 IP block
+        description:
+          SiFive CLINT v2 is the HRT that supports the Zicntr. The control of sifive,clint2
+          differs from that of sifive,clint0, making them incompatible.
+      - items:
           - enum:
               - allwinner,sun20i-d1-clint
               - sophgo,cv1800b-clint
@@ -62,6 +68,22 @@ properties:
     minItems: 1
     maxItems: 4095
 
+  sifive,fine-ctr-bits:
+    maximum: 15
+    description: The width in bits of the fine counter.
+
+if:
+  properties:
+    compatible:
+      contains:
+        const: sifive,clint2
+then:
+  required:
+    - sifive,fine-ctr-bits
+else:
+  properties:
+    sifive,fine-ctr-bits: false
+
 additionalProperties: false
 
 required:

