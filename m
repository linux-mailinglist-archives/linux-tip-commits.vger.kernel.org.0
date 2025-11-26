Return-Path: <linux-tip-commits+bounces-7551-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A368C8A673
	for <lists+linux-tip-commits@lfdr.de>; Wed, 26 Nov 2025 15:43:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 049864ED39A
	for <lists+linux-tip-commits@lfdr.de>; Wed, 26 Nov 2025 14:42:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ABF130B510;
	Wed, 26 Nov 2025 14:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ESUdqYGj";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Wn7l9mzS"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 779C13090FA;
	Wed, 26 Nov 2025 14:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764168052; cv=none; b=MQDiBSK2kSadkTqECe7eYA8gfGOMCxdn/o0Pi9+K+NBkosagBToj4PYRNNlsp1/nR4yKipOoqT4uGeekBBRiN0Nh93rYN5WpmBs+jWUFBgcIwP5AP7eHLByM8v50dZMOllGDi2qG8L9RF5fhTmLMeZvoXOr7aIlDgbxj1232pqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764168052; c=relaxed/simple;
	bh=izH60OCWzm7IE/Y8GSm3zDDBOWJmHWMbNREUB2JhFrQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=qxrJLVB89PTNnQKP7SOs1DUpb2Fb9s9W9hWMBguEAgm6JSsNtdNq8oVmivkD86+98TRozNjKgYQeiAStQeYMAtRogRKzbicEdxQeOziZEXlFV3LurYDYFsmRq36hdeCgqETf49TA2YCpxB7Du1fGXUSCSt811XrZ6vednsLu1iE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ESUdqYGj; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Wn7l9mzS; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 26 Nov 2025 14:40:47 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1764168048;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gAfaxf7Vr4yMSirrZ+2t+qR1r8xWJhYvu1ur+tU3EZM=;
	b=ESUdqYGjqQIWV5PCo+KRpvBnVy9qKBokE1B3dRsO4CWu+o94ERaaAZGE30JashZvg8QcmA
	3v3gK8PIEAudRuyfxMIkSDumKEszcp++DO6h46U2L93BFoN1y45rsXH+IwhIwmUhHKwZCE
	fL1wSfPHgI3Ddo+dnas8ldTrFE0y7S0VqIMNiczBxwQkAIDE4KGWRCnlMxBLejF2QRqeBZ
	kic+PPnEFHorPvtaH79AIG4lu24edJzVUigupqwQBMaKx1F2HanA41g+NT7xvpBe4kEKfr
	AFmmonC7rJ0FsqK2CH3vBpyjUs0wuuVK9Bvj+jAUo5xcrJ9+DOjRl3iv9V1amw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1764168048;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gAfaxf7Vr4yMSirrZ+2t+qR1r8xWJhYvu1ur+tU3EZM=;
	b=Wn7l9mzShVRlg/nRKo0RuQe6TGRRykFGeDvtzWIHFCih4jULlywwFSA5MPP8tOtSZ8LveO
	3Kt1nhOLAWvimCDg==
From: "tip-bot2 for Enlin Mu" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/clocksource] clocksource/drivers/sprd: Enable register
 for timer counter from 32 bit to 64 bit
Cc: Enlin Mu <enlin.mu@unisoc.com>, Daniel Lezcano <daniel.lezcano@linaro.org>,
 Baolin Wang <baolin.wang@linux.alibaba.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251106021830.34846-1-enlin.mu@linux.dev>
References: <20251106021830.34846-1-enlin.mu@linux.dev>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176416804751.498.11528586048553005636.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/clocksource branch of ti=
p:

Commit-ID:     576c564ec3bb60e571c705a71907d7c0c039e6c0
Gitweb:        https://git.kernel.org/tip/576c564ec3bb60e571c705a71907d7c0c03=
9e6c0
Author:        Enlin Mu <enlin.mu@unisoc.com>
AuthorDate:    Thu, 06 Nov 2025 10:18:30 +08:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Wed, 26 Nov 2025 11:24:26 +01:00

clocksource/drivers/sprd: Enable register for timer counter from 32 bit to 64=
 bit

Using 32 bit for suspend compensation, the max compensation time is 36
hours(working clock is 32k).In some IOT devices, the suspend time may
be long, even exceeding 36 hours. Therefore, a 64 bit timer counter
is needed for counting.

Signed-off-by: Enlin Mu <enlin.mu@unisoc.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Link: https://patch.msgid.link/20251106021830.34846-1-enlin.mu@linux.dev
---
 drivers/clocksource/timer-sprd.c | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/drivers/clocksource/timer-sprd.c b/drivers/clocksource/timer-spr=
d.c
index 430cb99..2c07dd2 100644
--- a/drivers/clocksource/timer-sprd.c
+++ b/drivers/clocksource/timer-sprd.c
@@ -30,6 +30,7 @@
 #define TIMER_VALUE_SHDW_HI	0x1c
=20
 #define TIMER_VALUE_LO_MASK	GENMASK(31, 0)
+#define TIMER_VALUE_HI_MASK	GENMASK(31, 0)
=20
 static void sprd_timer_enable(void __iomem *base, u32 flag)
 {
@@ -162,15 +163,26 @@ static struct timer_of suspend_to =3D {
=20
 static u64 sprd_suspend_timer_read(struct clocksource *cs)
 {
-	return ~(u64)readl_relaxed(timer_of_base(&suspend_to) +
-				   TIMER_VALUE_SHDW_LO) & cs->mask;
+	u32 lo, hi;
+
+	do {
+		hi =3D readl_relaxed(timer_of_base(&suspend_to) +
+				   TIMER_VALUE_SHDW_HI);
+		lo =3D readl_relaxed(timer_of_base(&suspend_to) +
+				   TIMER_VALUE_SHDW_LO);
+	} while (hi !=3D readl_relaxed(timer_of_base(&suspend_to) + TIMER_VALUE_SHD=
W_HI));
+
+	return ~(((u64)hi << 32) | lo);
 }
=20
 static int sprd_suspend_timer_enable(struct clocksource *cs)
 {
-	sprd_timer_update_counter(timer_of_base(&suspend_to),
-				  TIMER_VALUE_LO_MASK);
-	sprd_timer_enable(timer_of_base(&suspend_to), TIMER_CTL_PERIOD_MODE);
+	writel_relaxed(TIMER_VALUE_LO_MASK,
+		       timer_of_base(&suspend_to) + TIMER_LOAD_LO);
+	writel_relaxed(TIMER_VALUE_HI_MASK,
+		       timer_of_base(&suspend_to) + TIMER_LOAD_HI);
+	sprd_timer_enable(timer_of_base(&suspend_to),
+			  TIMER_CTL_PERIOD_MODE|TIMER_CTL_64BIT_WIDTH);
=20
 	return 0;
 }
@@ -186,7 +198,7 @@ static struct clocksource suspend_clocksource =3D {
 	.read	=3D sprd_suspend_timer_read,
 	.enable =3D sprd_suspend_timer_enable,
 	.disable =3D sprd_suspend_timer_disable,
-	.mask	=3D CLOCKSOURCE_MASK(32),
+	.mask	=3D CLOCKSOURCE_MASK(64),
 	.flags	=3D CLOCK_SOURCE_IS_CONTINUOUS | CLOCK_SOURCE_SUSPEND_NONSTOP,
 };
=20

