Return-Path: <linux-tip-commits+bounces-2408-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A6FD99F12A
	for <lists+linux-tip-commits@lfdr.de>; Tue, 15 Oct 2024 17:29:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F907285DC5
	for <lists+linux-tip-commits@lfdr.de>; Tue, 15 Oct 2024 15:29:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD9D01B2196;
	Tue, 15 Oct 2024 15:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nWLEBhq9";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bmC1hR8k"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECFCF4C8C;
	Tue, 15 Oct 2024 15:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729006186; cv=none; b=T9lmIFv2IEOlMXnpAFFlb4Dimr2OIiOejWrkfEk2kYuba/Hrjq0wvIZk+1xnt9LhneuPRfEtg+iwjp9KWKlWZfpG8hp4cVvPlTldhKmG2I3fn8KJnzXTGW7V8fRo4chutubcUWNSxILyi2bH0+UBu1wAOgmKulmvKsLDnWPP9sY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729006186; c=relaxed/simple;
	bh=osEnqY6n4+TYkhuIMT1YrH8//hmkomUBC7mGw+rm1x8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=CGBUY6U3CWg8ZQ1SMZqEt3zgDx/yQNn4znTI7aOZ93ECf71OHQzYR6dYraxQ7MiPUa2UixznB02mu5rbkxbA8zB4RWHfddjlhPdqB2rsVKcWVYLQbiLmjhbT/EnVujWmjHcE+NuGaPEt8Og2+MZ5fvmVn81ggsvpiwCn7BsQDyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nWLEBhq9; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bmC1hR8k; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 15 Oct 2024 15:29:41 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1729006182;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a8MdtsceLEjeWv4liPKhooCy4EQul1plu+GzQR2PP0Y=;
	b=nWLEBhq9XmgnhPR2MhiSgni3QRjmel+kk83HRgieHLBS776i4b/bL1KW7q20OJUEW/bi4N
	341dleTTZMvHahKGpijaTdw9jH96d26832SOAoKcirXseaci3BYbguRGJk58KUqtsrJYl5
	nJSVk3684iF9D9jENs+1GlMrC81gX9s6Bgr93Iccf0L9v67N1DqyxZbOSDxgX8ReyS0bbc
	UkBAlLVziAdKdtnYlNw4NIbPMhLKaNWUdsVA2Q6/RKHKE7OpL6llZmEITKmGU8IEZv03IM
	d8kmesil14ekbewLR1qrJNSUyXaDYMR1YFspucDXgQelqDCDfQ5Sg7SQXUsgrw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1729006182;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a8MdtsceLEjeWv4liPKhooCy4EQul1plu+GzQR2PP0Y=;
	b=bmC1hR8k7wnzOdNAVZ8eAA3urelmwAkrJVfMfXOhu+TGQVEBO5R3kssxr87Qk+6nQhP5Ok
	se1ddcRGM8pDRoCg==
From: "tip-bot2 for Dr. David Alan Gilbert" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: timers/core] clocksource: Remove unused clocksource_change_rating
Cc: "Dr. David Alan Gilbert" <linux@treblig.org>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20241010135446.213098-1-linux@treblig.org>
References: <20241010135446.213098-1-linux@treblig.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172900618177.1442.10003492219179239392.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     bafffd56c608106d11e7aec851f114dcd66b2091
Gitweb:        https://git.kernel.org/tip/bafffd56c608106d11e7aec851f114dcd66b2091
Author:        Dr. David Alan Gilbert <linux@treblig.org>
AuthorDate:    Thu, 10 Oct 2024 14:54:46 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 10 Oct 2024 21:03:10 +02:00

clocksource: Remove unused clocksource_change_rating

clocksource_change_rating() has been unused since 2017's commit
63ed4e0c67df ("Drivers: hv: vmbus: Consolidate all Hyper-V specific clocksource code")

Remove it.

__clocksource_change_rating now only has one use which is ifdef'd.
Move it into the ifdef'd section.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20241010135446.213098-1-linux@treblig.org

---
 include/linux/clocksource.h |  1 +-
 kernel/time/clocksource.c   | 40 +++++++++---------------------------
 2 files changed, 10 insertions(+), 31 deletions(-)

diff --git a/include/linux/clocksource.h b/include/linux/clocksource.h
index d35b677..ef1b16d 100644
--- a/include/linux/clocksource.h
+++ b/include/linux/clocksource.h
@@ -215,7 +215,6 @@ static inline s64 clocksource_cyc2ns(u64 cycles, u32 mult, u32 shift)
 
 extern int clocksource_unregister(struct clocksource*);
 extern void clocksource_touch_watchdog(void);
-extern void clocksource_change_rating(struct clocksource *cs, int rating);
 extern void clocksource_suspend(void);
 extern void clocksource_resume(void);
 extern struct clocksource * __init clocksource_default_clock(void);
diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
index 23336ee..aab6472 100644
--- a/kernel/time/clocksource.c
+++ b/kernel/time/clocksource.c
@@ -20,6 +20,8 @@
 #include "tick-internal.h"
 #include "timekeeping_internal.h"
 
+static void clocksource_enqueue(struct clocksource *cs);
+
 static noinline u64 cycles_to_nsec_safe(struct clocksource *cs, u64 start, u64 end)
 {
 	u64 delta = clocksource_delta(end, start, cs->mask);
@@ -171,7 +173,6 @@ static inline void clocksource_watchdog_unlock(unsigned long *flags)
 }
 
 static int clocksource_watchdog_kthread(void *data);
-static void __clocksource_change_rating(struct clocksource *cs, int rating);
 
 static void clocksource_watchdog_work(struct work_struct *work)
 {
@@ -191,6 +192,13 @@ static void clocksource_watchdog_work(struct work_struct *work)
 	kthread_run(clocksource_watchdog_kthread, NULL, "kwatchdog");
 }
 
+static void clocksource_change_rating(struct clocksource *cs, int rating)
+{
+	list_del(&cs->list);
+	cs->rating = rating;
+	clocksource_enqueue(cs);
+}
+
 static void __clocksource_unstable(struct clocksource *cs)
 {
 	cs->flags &= ~(CLOCK_SOURCE_VALID_FOR_HRES | CLOCK_SOURCE_WATCHDOG);
@@ -697,7 +705,7 @@ static int __clocksource_watchdog_kthread(void)
 	list_for_each_entry_safe(cs, tmp, &watchdog_list, wd_list) {
 		if (cs->flags & CLOCK_SOURCE_UNSTABLE) {
 			list_del_init(&cs->wd_list);
-			__clocksource_change_rating(cs, 0);
+			clocksource_change_rating(cs, 0);
 			select = 1;
 		}
 		if (cs->flags & CLOCK_SOURCE_RESELECT) {
@@ -1255,34 +1263,6 @@ int __clocksource_register_scale(struct clocksource *cs, u32 scale, u32 freq)
 }
 EXPORT_SYMBOL_GPL(__clocksource_register_scale);
 
-static void __clocksource_change_rating(struct clocksource *cs, int rating)
-{
-	list_del(&cs->list);
-	cs->rating = rating;
-	clocksource_enqueue(cs);
-}
-
-/**
- * clocksource_change_rating - Change the rating of a registered clocksource
- * @cs:		clocksource to be changed
- * @rating:	new rating
- */
-void clocksource_change_rating(struct clocksource *cs, int rating)
-{
-	unsigned long flags;
-
-	mutex_lock(&clocksource_mutex);
-	clocksource_watchdog_lock(&flags);
-	__clocksource_change_rating(cs, rating);
-	clocksource_watchdog_unlock(&flags);
-
-	clocksource_select();
-	clocksource_select_watchdog(false);
-	clocksource_suspend_select(false);
-	mutex_unlock(&clocksource_mutex);
-}
-EXPORT_SYMBOL(clocksource_change_rating);
-
 /*
  * Unbind clocksource @cs. Called with clocksource_mutex held
  */

