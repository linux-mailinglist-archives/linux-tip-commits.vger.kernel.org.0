Return-Path: <linux-tip-commits+bounces-5721-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 78D7CABFAA9
	for <lists+linux-tip-commits@lfdr.de>; Wed, 21 May 2025 18:04:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 031657BA4AC
	for <lists+linux-tip-commits@lfdr.de>; Wed, 21 May 2025 15:54:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4021227BA4;
	Wed, 21 May 2025 15:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BWzMeqHq";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aEiFYHc5"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB40822A4D6;
	Wed, 21 May 2025 15:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747842581; cv=none; b=ejM3RNFdw2Ps9ntb8HZMEbdV2gYCbW18Ii0d/hlkG1FMyNWWSAVbJAB/h/e32riujbY6Mz51t75mgFguA71DPHF2YxsjcSTsJXPZYyAHbkPMe18XZQlxEx0R2TH3KMq46Y+Cv9qnHNiBe6pWFvZZFBjB9nu6PkDbhqCTD1xUItY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747842581; c=relaxed/simple;
	bh=IoL9m8u5qI9ivjdS6gOQsX0dgiXucQVqra6KE3EyGF0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=S1QzTabQ4S1ZuPqnw25nDz9a9uVTmbmjej7I3WB+1QMYNO8tiXS+ZwF8rEtrZdOm+kdEpJav6GN1nltGDADnhS3SUS/Eqa5NbwGJbYoaNmWqpy/X6/8kyFvpZNbGJOPz88AUPXmqUUhjLlG3k0Mp56XTo9JEiP5l1h3Pwer6GOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BWzMeqHq; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=aEiFYHc5; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 21 May 2025 15:49:35 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1747842576;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KH3TYNHlJpLDkz1lPt8QdhV4xKu8PebP92O/mC/F8+0=;
	b=BWzMeqHqggG0hsRSwPg6wvrVxyOVsKlOeaRGpKyZXsyPm9IZa6O26CSVIQMH6eXNjRMlu6
	lK7sUKyZp9SBzl4jW2Ho9qw6LM5HKbNzQRe1OwpfcwiR5YHPiswvgA0YnhmrNSZl6xgeFd
	+wTGk/zB0NopzFORT0XYqT3eIwnaK2mP3EnqK3JQ9S4if7B7VedlUMZYr1OtMGd0u+DmJA
	YJ73bgMKja6JQD1KvDesMolvcT4C/14P5RQ4uCRfY0oavOL0oPtlk4J0C+kWbLafKo2anL
	Vhw09J3qklIp66vl0upNyotKVI2ErStR3ot8+SRiweZM9vM03r3FvNhtiK676g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1747842576;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KH3TYNHlJpLDkz1lPt8QdhV4xKu8PebP92O/mC/F8+0=;
	b=aEiFYHc5WUz01r7fmW4eO8My7Ed+iIVdCB0KmKE+bbY3KPxFrgAGVH/92ig8r4Vdr5sLMq
	Zhn+9vzCTGIyx2Cw==
From: "tip-bot2 for Caleb James DeLisle" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/clocksource] dt-bindings: timer: Add EcoNet EN751221
 "HPT" CPU Timer
Cc: Caleb James DeLisle <cjd@cjdns.fr>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250507134500.390547-2-cjd@cjdns.fr>
References: <20250507134500.390547-2-cjd@cjdns.fr>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174784257560.406.16343833352032130353.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/clocksource branch of tip:

Commit-ID:     30fddbd5325459102e448c9a26a1bc15ef563381
Gitweb:        https://git.kernel.org/tip/30fddbd5325459102e448c9a26a1bc15ef563381
Author:        Caleb James DeLisle <cjd@cjdns.fr>
AuthorDate:    Wed, 07 May 2025 13:44:54 
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Fri, 16 May 2025 11:10:33 +02:00

dt-bindings: timer: Add EcoNet EN751221 "HPT" CPU Timer

Add device tree bindings for the so-called high-precision timer (HPT)
in the EcoNet EN751221 SoC.

Signed-off-by: Caleb James DeLisle <cjd@cjdns.fr>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Link: https://lore.kernel.org/r/20250507134500.390547-2-cjd@cjdns.fr
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 Documentation/devicetree/bindings/timer/econet,en751221-timer.yaml | 80 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 80 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/timer/econet,en751221-timer.yaml

diff --git a/Documentation/devicetree/bindings/timer/econet,en751221-timer.yaml b/Documentation/devicetree/bindings/timer/econet,en751221-timer.yaml
new file mode 100644
index 0000000..c1e7c2b
--- /dev/null
+++ b/Documentation/devicetree/bindings/timer/econet,en751221-timer.yaml
@@ -0,0 +1,80 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/timer/econet,en751221-timer.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: EcoNet EN751221 High Precision Timer (HPT)
+
+maintainers:
+  - Caleb James DeLisle <cjd@cjdns.fr>
+
+description:
+  The EcoNet High Precision Timer (HPT) is a timer peripheral found in various
+  EcoNet SoCs, including the EN751221 and EN751627 families. It provides per-VPE
+  count/compare registers and a per-CPU control register, with a single interrupt
+  line using a percpu-devid interrupt mechanism.
+
+properties:
+  compatible:
+    oneOf:
+      - const: econet,en751221-timer
+      - items:
+          - const: econet,en751627-timer
+          - const: econet,en751221-timer
+
+  reg:
+    minItems: 1
+    maxItems: 2
+
+  interrupts:
+    maxItems: 1
+    description: A percpu-devid timer interrupt shared across CPUs.
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
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: econet,en751627-timer
+    then:
+      properties:
+        reg:
+          items:
+            - description: VPE timers 0 and 1
+            - description: VPE timers 2 and 3
+    else:
+      properties:
+        reg:
+          items:
+            - description: VPE timers 0 and 1
+
+additionalProperties: false
+
+examples:
+  - |
+    timer@1fbf0400 {
+        compatible = "econet,en751627-timer", "econet,en751221-timer";
+        reg = <0x1fbf0400 0x100>, <0x1fbe0000 0x100>;
+        interrupt-parent = <&intc>;
+        interrupts = <30>;
+        clocks = <&hpt_clock>;
+    };
+  - |
+    timer@1fbf0400 {
+        compatible = "econet,en751221-timer";
+        reg = <0x1fbe0400 0x100>;
+        interrupt-parent = <&intc>;
+        interrupts = <30>;
+        clocks = <&hpt_clock>;
+    };
+...

