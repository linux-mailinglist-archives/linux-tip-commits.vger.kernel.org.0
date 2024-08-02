Return-Path: <linux-tip-commits+bounces-1926-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B7979461DB
	for <lists+linux-tip-commits@lfdr.de>; Fri,  2 Aug 2024 18:35:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 44523B20D78
	for <lists+linux-tip-commits@lfdr.de>; Fri,  2 Aug 2024 16:35:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69EC2136324;
	Fri,  2 Aug 2024 16:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BNrJqh12";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="9dNcqAFc"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC17916BE2A;
	Fri,  2 Aug 2024 16:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722616505; cv=none; b=l8/BvzozVyNGO+OMoi3ZQ1kAjdpzcl2n9nnyT0K/f0EGedu2WRDRbDIpPvTONeLqos1Do8O52Rnv8uEZkXeY0BZFq/P2x+ILLC7ov+mn945xPXQjcVNLJQMRVMqnQrcobfu/DUmWzyZRn7+Y9ez5LvEoWyfKo6l9Q2xHiDUsSeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722616505; c=relaxed/simple;
	bh=7sK8rNjZZhwYmmPHmi2LKs6R+dT+6VeVx+wozCqrrYU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=cFNtOdUpLBuusnRALAXCyiLyBjwioJU2aYJq1eE75LXkx4NgOeudb5oyXw7Uu6NWkoIMDhhTBUS4o5uIqiE56M83jWRkkl5PwALLFfct4I8JhipM7kgkTh9NDIjnZflYjSuPfbZez+BHjQYWJfR5ej65VB3obAeqg73UfcjJer0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BNrJqh12; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=9dNcqAFc; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 02 Aug 2024 16:35:01 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722616502;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FSTAWXjR998w4h634AY5Wg4shWnXdsbL0lQYaLA1Z5k=;
	b=BNrJqh12nayihNLobcWsVbGRYdaegQL751roOKxTn95XjGqhJVtvO/MPpSgLaUnJ7IHAVZ
	7SXVxUL+tUDITgdVntyxUZNb6eMV7ijZo2M8wHxk5wChtFdHs/6REbtvlQ9zez2DmSDCzV
	gU++EpSV1UiNhHY+PzSrArRXJZx2NW+w2ScKYwQwlMjPBcZwKcqxHGLAQ6sVcEsrTU/GeA
	2zbc/LnSumtcL6YdAMbByWLAWU67IwXYW7Qg7ky/zQfgiq3n5OzTKwz+rn/LPjpRE7VOM0
	e0N26dOUgvsrS72yz5dXiIQJvgyK1UPYXRM256QLHBFeIL8bQMeZ3kH5yd9pIQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722616502;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FSTAWXjR998w4h634AY5Wg4shWnXdsbL0lQYaLA1Z5k=;
	b=9dNcqAFc8fHj2RlLd8ULGCbr0cP5UXjToR0cr4O2uT3cyENFfmW3HYrj30xnMnnllA07ZB
	yRsSf7R3hqPzPJCQ==
From: "tip-bot2 for David Woodhouse" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/timers] x86/i8253: Disable PIT timer 0 when not in use
Cc: David Woodhouse <dwmw@amazon.co.uk>, Thomas Gleixner <tglx@linutronix.de>,
 Michael Kelley <mhkelley@outlook.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240802135555.564941-1-dwmw2@infradead.org>
References: <20240802135555.564941-1-dwmw2@infradead.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172261650197.2215.13331839934148253272.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/timers branch of tip:

Commit-ID:     70e6b7d9ae3c63df90a7bba7700e8d5c300c3c60
Gitweb:        https://git.kernel.org/tip/70e6b7d9ae3c63df90a7bba7700e8d5c300c3c60
Author:        David Woodhouse <dwmw@amazon.co.uk>
AuthorDate:    Fri, 02 Aug 2024 14:55:54 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 02 Aug 2024 18:27:05 +02:00

x86/i8253: Disable PIT timer 0 when not in use

Leaving the PIT interrupt running can cause noticeable steal time for
virtual guests. The VMM generally has a timer which toggles the IRQ input
to the PIC and I/O APIC, which takes CPU time away from the guest. Even
on real hardware, running the counter may use power needlessly (albeit
not much).

Make sure it's turned off if it isn't going to be used.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Michael Kelley <mhkelley@outlook.com>
Link: https://lore.kernel.org/all/20240802135555.564941-1-dwmw2@infradead.org

---
 arch/x86/kernel/i8253.c     | 11 +++++++++--
 drivers/clocksource/i8253.c | 13 +++++++++----
 include/linux/i8253.h       |  1 +
 3 files changed, 19 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/i8253.c b/arch/x86/kernel/i8253.c
index 2b7999a..80e262b 100644
--- a/arch/x86/kernel/i8253.c
+++ b/arch/x86/kernel/i8253.c
@@ -8,6 +8,7 @@
 #include <linux/timex.h>
 #include <linux/i8253.h>
 
+#include <asm/hypervisor.h>
 #include <asm/apic.h>
 #include <asm/hpet.h>
 #include <asm/time.h>
@@ -39,9 +40,15 @@ static bool __init use_pit(void)
 
 bool __init pit_timer_init(void)
 {
-	if (!use_pit())
+	if (!use_pit()) {
+		/*
+		 * Don't just ignore the PIT. Ensure it's stopped, because
+		 * VMMs otherwise steal CPU time just to pointlessly waggle
+		 * the (masked) IRQ.
+		 */
+		clockevent_i8253_disable();
 		return false;
-
+	}
 	clockevent_i8253_init(true);
 	global_clock_event = &i8253_clockevent;
 	return true;
diff --git a/drivers/clocksource/i8253.c b/drivers/clocksource/i8253.c
index d4350bb..cb215e6 100644
--- a/drivers/clocksource/i8253.c
+++ b/drivers/clocksource/i8253.c
@@ -108,11 +108,8 @@ int __init clocksource_i8253_init(void)
 #endif
 
 #ifdef CONFIG_CLKEVT_I8253
-static int pit_shutdown(struct clock_event_device *evt)
+void clockevent_i8253_disable(void)
 {
-	if (!clockevent_state_oneshot(evt) && !clockevent_state_periodic(evt))
-		return 0;
-
 	raw_spin_lock(&i8253_lock);
 
 	outb_p(0x30, PIT_MODE);
@@ -123,6 +120,14 @@ static int pit_shutdown(struct clock_event_device *evt)
 	}
 
 	raw_spin_unlock(&i8253_lock);
+}
+
+static int pit_shutdown(struct clock_event_device *evt)
+{
+	if (!clockevent_state_oneshot(evt) && !clockevent_state_periodic(evt))
+		return 0;
+
+	clockevent_i8253_disable();
 	return 0;
 }
 
diff --git a/include/linux/i8253.h b/include/linux/i8253.h
index 8336b2f..bf169cf 100644
--- a/include/linux/i8253.h
+++ b/include/linux/i8253.h
@@ -24,6 +24,7 @@ extern raw_spinlock_t i8253_lock;
 extern bool i8253_clear_counter_on_shutdown;
 extern struct clock_event_device i8253_clockevent;
 extern void clockevent_i8253_init(bool oneshot);
+extern void clockevent_i8253_disable(void);
 
 extern void setup_pit_timer(void);
 

