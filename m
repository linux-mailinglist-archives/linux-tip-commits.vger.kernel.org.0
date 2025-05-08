Return-Path: <linux-tip-commits+bounces-5501-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1888AAB01DB
	for <lists+linux-tip-commits@lfdr.de>; Thu,  8 May 2025 19:55:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2ED784A0F90
	for <lists+linux-tip-commits@lfdr.de>; Thu,  8 May 2025 17:55:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A95A287509;
	Thu,  8 May 2025 17:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="S+M7uKfY";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RNKTueFr"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53C98286D53;
	Thu,  8 May 2025 17:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746726874; cv=none; b=u+AM7gNrZnoLYf+acyPg1S1YTSKrpiWXbYCFTtqXZK+mF0B1DQJs4jwA8hhG1rBnj6csyqyINeI2/Kd7Bmdk69Zystia5/QwP2P6sQ+YOPHVG3Z+v7mcODKLtvH9wOG2hwvKmtZ85josX+6yIivii80AtWgmiqx4QaPo9KW3WvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746726874; c=relaxed/simple;
	bh=3ooRgAlIYeMxETGeOM25a9HqFKLsBy65YzaUyCRASL8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=l2Y+bS9I9h7AI4EHcnxJIN/jdc319OplbKb2214n81oB+0Z5MKDQumxdu5FhWybFRX/qUasrJDqKXIlkYUv05P4MlDTpJ8vjm+L7iBi3I7uUQ/ya2/SNbNZulYlGIB9U+Brb2oXuhetMPGYGNDt/H2pbqz4Dc+UBRrYO6nfdTjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=S+M7uKfY; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RNKTueFr; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 08 May 2025 17:54:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746726869;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zGvnTE8hXhq21noRX0c9H6SNDGwrUL6QvGFtbAN1DHk=;
	b=S+M7uKfY4Gv6NRN18jopdZDfBMqWy5XTukBcic918S5rQyji5q7+Q0AdDuwDYL6sfnJBH2
	39zOt1ti2nQKyWQ0cq+qPjlzVrORqovGwy4Qsu6UBdPTy2Da8ZvJyexdZ6s6iahHqunQPk
	Eg92/IkJdYazmRltMfdNaC9tNqCHJm/jxaqktnE2H9UT53iqPkzqnOL6GNFlyNCLakOm8H
	r5Rbsv22NMkmD6spNd8LMgKVjzA7JnRgqjX+Nsh5mLa/69rbmziKQSw/RBJAviMhSOHm3E
	793C86YwKNE758kYX/PudG/uAwFJNVxB8+NT49jHrs8kbi7COqBiA8CwcF2M4A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746726869;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zGvnTE8hXhq21noRX0c9H6SNDGwrUL6QvGFtbAN1DHk=;
	b=RNKTueFr1evS+Vt6Bba1V19TPtUCD7z+R4G5A7POWldK5/CHeb74rrxOWQ1/rIEhFfu1s7
	gE4GSB3ARa1ktMBA==
From: "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/cleanups] timers: Rename NEXT_TIMER_MAX_DELTA as
 TIMER_NEXT_MAX_DELTA
Cc: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250507175338.672442-7-mingo@kernel.org>
References: <20250507175338.672442-7-mingo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174672686902.406.14161273108311252606.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/cleanups branch of tip:

Commit-ID:     220beffd36c26ac68e1c646f91b7ddf4f39039e6
Gitweb:        https://git.kernel.org/tip/220beffd36c26ac68e1c646f91b7ddf4f39039e6
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Wed, 07 May 2025 19:53:34 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 08 May 2025 19:49:33 +02:00

timers: Rename NEXT_TIMER_MAX_DELTA as TIMER_NEXT_MAX_DELTA

Move this macro to the canonical TIMER_* namespace.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20250507175338.672442-7-mingo@kernel.org

---
 arch/powerpc/kvm/booke.c |  8 ++++----
 include/linux/timer.h    |  2 +-
 kernel/time/timer.c      | 12 ++++++------
 3 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/arch/powerpc/kvm/booke.c b/arch/powerpc/kvm/booke.c
index 6a48059..791d194 100644
--- a/arch/powerpc/kvm/booke.c
+++ b/arch/powerpc/kvm/booke.c
@@ -572,7 +572,7 @@ static int kvmppc_booke_irqprio_deliver(struct kvm_vcpu *vcpu,
 
 /*
  * Return the number of jiffies until the next timeout.  If the timeout is
- * longer than the NEXT_TIMER_MAX_DELTA, then return NEXT_TIMER_MAX_DELTA
+ * longer than the TIMER_NEXT_MAX_DELTA, then return TIMER_NEXT_MAX_DELTA
  * because the larger value can break the timer APIs.
  */
 static unsigned long watchdog_next_timeout(struct kvm_vcpu *vcpu)
@@ -598,7 +598,7 @@ static unsigned long watchdog_next_timeout(struct kvm_vcpu *vcpu)
 	if (do_div(nr_jiffies, tb_ticks_per_jiffy))
 		nr_jiffies++;
 
-	return min_t(unsigned long long, nr_jiffies, NEXT_TIMER_MAX_DELTA);
+	return min_t(unsigned long long, nr_jiffies, TIMER_NEXT_MAX_DELTA);
 }
 
 static void arm_next_watchdog(struct kvm_vcpu *vcpu)
@@ -616,10 +616,10 @@ static void arm_next_watchdog(struct kvm_vcpu *vcpu)
 	spin_lock_irqsave(&vcpu->arch.wdt_lock, flags);
 	nr_jiffies = watchdog_next_timeout(vcpu);
 	/*
-	 * If the number of jiffies of watchdog timer >= NEXT_TIMER_MAX_DELTA
+	 * If the number of jiffies of watchdog timer >= TIMER_NEXT_MAX_DELTA
 	 * then do not run the watchdog timer as this can break timer APIs.
 	 */
-	if (nr_jiffies < NEXT_TIMER_MAX_DELTA)
+	if (nr_jiffies < TIMER_NEXT_MAX_DELTA)
 		mod_timer(&vcpu->arch.wdt_timer, jiffies + nr_jiffies);
 	else
 		timer_delete(&vcpu->arch.wdt_timer);
diff --git a/include/linux/timer.h b/include/linux/timer.h
index 4e1237f..68cf8e2 100644
--- a/include/linux/timer.h
+++ b/include/linux/timer.h
@@ -156,7 +156,7 @@ extern int timer_reduce(struct timer_list *timer, unsigned long expires);
  * The jiffies value which is added to now, when there is no timer
  * in the timer wheel:
  */
-#define NEXT_TIMER_MAX_DELTA	((1UL << 30) - 1)
+#define TIMER_NEXT_MAX_DELTA	((1UL << 30) - 1)
 
 extern void add_timer(struct timer_list *timer);
 extern void add_timer_local(struct timer_list *timer);
diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index 6f520e5..11c6a11 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -1900,7 +1900,7 @@ static void timer_recalc_next_expiry(struct timer_base *base)
 	unsigned long clk, next, adj;
 	unsigned lvl, offset = 0;
 
-	next = base->clk + NEXT_TIMER_MAX_DELTA;
+	next = base->clk + TIMER_NEXT_MAX_DELTA;
 	clk = base->clk;
 	for (lvl = 0; lvl < LVL_DEPTH; lvl++, offset += LVL_SIZE) {
 		int pos = next_pending_bucket(base, offset, clk & LVL_MASK);
@@ -1963,7 +1963,7 @@ static void timer_recalc_next_expiry(struct timer_base *base)
 
 	WRITE_ONCE(base->next_expiry, next);
 	base->next_expiry_recalc = false;
-	base->timers_pending = !(next == base->clk + NEXT_TIMER_MAX_DELTA);
+	base->timers_pending = !(next == base->clk + TIMER_NEXT_MAX_DELTA);
 }
 
 #ifdef CONFIG_NO_HZ_COMMON
@@ -2015,7 +2015,7 @@ static unsigned long next_timer_interrupt(struct timer_base *base,
 	 * easy comparable to find out which base holds the first pending timer.
 	 */
 	if (!base->timers_pending)
-		WRITE_ONCE(base->next_expiry, basej + NEXT_TIMER_MAX_DELTA);
+		WRITE_ONCE(base->next_expiry, basej + TIMER_NEXT_MAX_DELTA);
 
 	return base->next_expiry;
 }
@@ -2399,7 +2399,7 @@ static inline void __run_timers(struct timer_base *base)
 		 * timer at this clk are that all matching timers have been
 		 * dequeued or no timer has been queued since
 		 * base::next_expiry was set to base::clk +
-		 * NEXT_TIMER_MAX_DELTA.
+		 * TIMER_NEXT_MAX_DELTA.
 		 */
 		WARN_ON_ONCE(!levels && !base->next_expiry_recalc
 			     && base->timers_pending);
@@ -2544,7 +2544,7 @@ int timers_prepare_cpu(unsigned int cpu)
 	for (b = 0; b < NR_BASES; b++) {
 		base = per_cpu_ptr(&timer_bases[b], cpu);
 		base->clk = jiffies;
-		base->next_expiry = base->clk + NEXT_TIMER_MAX_DELTA;
+		base->next_expiry = base->clk + TIMER_NEXT_MAX_DELTA;
 		base->next_expiry_recalc = false;
 		base->timers_pending = false;
 		base->is_idle = false;
@@ -2599,7 +2599,7 @@ static void __init init_timer_cpu(int cpu)
 		base->cpu = cpu;
 		raw_spin_lock_init(&base->lock);
 		base->clk = jiffies;
-		base->next_expiry = base->clk + NEXT_TIMER_MAX_DELTA;
+		base->next_expiry = base->clk + TIMER_NEXT_MAX_DELTA;
 		timer_base_init_expiry_lock(base);
 	}
 }

