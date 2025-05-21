Return-Path: <linux-tip-commits+bounces-5707-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DF2DEABFA74
	for <lists+linux-tip-commits@lfdr.de>; Wed, 21 May 2025 17:59:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D313DA2215C
	for <lists+linux-tip-commits@lfdr.de>; Wed, 21 May 2025 15:52:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A50202222C5;
	Wed, 21 May 2025 15:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MyAlpqGy";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AxEtJO85"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F1D522171A;
	Wed, 21 May 2025 15:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747842570; cv=none; b=G6UzAykcljLmyIL2rYk8C1OnrNPg0fYs2Y7n78UNG/3w2GZatmi8mQljIiRFSZrLTVqazLhBvRZzplmd0iC+P0Q7IGIu/1zcdy8YeQVQKRuQaO+go7RNWdD4mBOn7gGawn6HgtKpSkxMT5Bceyq1qB533SfnSeP9thMwfPBiBxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747842570; c=relaxed/simple;
	bh=C8qwNnd+NPJzceXoCvx0Oi9n2HaLQOlBbAI6Wwgn8Rw=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=DoiQYcIq1ECF5aJX7+aveJOqvDqTwJxc6i4EOjB128Z++A9iThOqHvIjcMYRo1F+7u8fMhdBK6cw/CjSZeFezmYGwc6EZT/SOQDQkntaKlLz4rsuGfpPfR1cqsLF/rqm4IqAC8W6sjTyFJEKb+nopV6wcpkt0VEPWBDzVOUEt+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MyAlpqGy; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=AxEtJO85; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 21 May 2025 15:49:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1747842565;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E83f17TdLIx2g0JowSIYib0NRcviDb93fDN/0IBQxVk=;
	b=MyAlpqGyKonRUs6pVE33bcW566s/KtnqiuUYtyy/zQ4TZ6KXzZCXJGfL+SyklPGsfVWjv1
	J/Iv/fHhSLfsYAyd+foI9nxu6m76eVTrgoBN9+g9lFq3IB6diH7pkKmcrktLBmKe4wILkT
	bW0SR6K8i4nuoYZGheUQeaHJWNClmN2xG+yPD95eYNwVTWXkewaNpW/PG86TqVWANT8woa
	cDvFuOYAcFFH55zSSvl3vcaMQjk/G5/09OL+1ui1P7cpQEM6PdqXeXuusomfPR0c6ggRAF
	O95DDo7Pc8MVJqXnm51cGY35IX6e9z4JzusOTPtYtYHaGFeRLXtNo9qBc99pbA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1747842565;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E83f17TdLIx2g0JowSIYib0NRcviDb93fDN/0IBQxVk=;
	b=AxEtJO85BOnkp5KCvpfUKZQrHOJXhTjWJQc6ADmbJOff543qeX4n1q+XqcdC+oyOIRFFYC
	dJ+mm4CGKJpOxdCA==
From: "tip-bot2 for Rob Herring (Arm)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/clocksource] dt-bindings: timer: Convert st,spear-timer
 to DT schema
Cc: "Rob Herring (Arm)" <robh@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250506022326.2589389-1-robh@kernel.org>
References: <20250506022326.2589389-1-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174784256485.406.15086940010293500528.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/clocksource branch of tip:

Commit-ID:     379967d0c7942acf4df9bf68f5be3a79b5f3ae82
Gitweb:        https://git.kernel.org/tip/379967d0c7942acf4df9bf68f5be3a79b5f3ae82
Author:        Rob Herring (Arm) <robh@kernel.org>
AuthorDate:    Mon, 05 May 2025 21:23:25 -05:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Fri, 16 May 2025 11:10:34 +02:00

dt-bindings: timer: Convert st,spear-timer to DT schema

Convert the ST SPEAr Timer binding to DT schema format. It's a
straight-forward conversion.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
Link: https://lore.kernel.org/r/20250506022326.2589389-1-robh@kernel.org
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 Documentation/devicetree/bindings/timer/st,spear-timer.txt  | 16 +---
 Documentation/devicetree/bindings/timer/st,spear-timer.yaml | 36 +++++++-
 2 files changed, 36 insertions(+), 16 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/timer/st,spear-timer.txt
 create mode 100644 Documentation/devicetree/bindings/timer/st,spear-timer.yaml

diff --git a/Documentation/devicetree/bindings/timer/st,spear-timer.txt b/Documentation/devicetree/bindings/timer/st,spear-timer.txt
deleted file mode 100644
index b5238a0..0000000
--- a/Documentation/devicetree/bindings/timer/st,spear-timer.txt
+++ /dev/null
@@ -1,16 +0,0 @@
-* SPEAr ARM Timer
-
-** Timer node required properties:
-
-- compatible : Should be:
-	"st,spear-timer"
-- reg: Address range of the timer registers
-- interrupt: Should contain the timer interrupt number
-
-Example:
-
-	timer@f0000000 {
-		compatible = "st,spear-timer";
-		reg = <0xf0000000 0x400>;
-		interrupts = <2>;
-	};
diff --git a/Documentation/devicetree/bindings/timer/st,spear-timer.yaml b/Documentation/devicetree/bindings/timer/st,spear-timer.yaml
new file mode 100644
index 0000000..9f26b5f
--- /dev/null
+++ b/Documentation/devicetree/bindings/timer/st,spear-timer.yaml
@@ -0,0 +1,36 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/timer/st,spear-timer.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: SPEAr ARM Timer
+
+maintainers:
+  - Viresh Kumar <vireshk@kernel.org>
+  - Shiraz Hashim <shiraz.linux.kernel@gmail.com>
+
+properties:
+  compatible:
+    const: st,spear-timer
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
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
+    timer@f0000000 {
+        compatible = "st,spear-timer";
+        reg = <0xf0000000 0x400>;
+        interrupts = <2>;
+    };

