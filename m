Return-Path: <linux-tip-commits+bounces-2693-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 074CC9B9E26
	for <lists+linux-tip-commits@lfdr.de>; Sat,  2 Nov 2024 10:24:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E9891C218F7
	for <lists+linux-tip-commits@lfdr.de>; Sat,  2 Nov 2024 09:24:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBA881607AA;
	Sat,  2 Nov 2024 09:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bU0EYvV4";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NUlGdjq+"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABE4015A856;
	Sat,  2 Nov 2024 09:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730539479; cv=none; b=oAbSwn2REm7xmbjeNlAjsu/49z+/54il+AuZ9glaI7hfkLOucV7hr1PUpCQNM7uNaGBCM735ozr4bEAIaeVaQU0TfFbzb2TrVPPFQYx/BLEaUIhzOFX0JhcmH85kbZXzoAQt1JwNFZgEgrJYQJRrpaiPclrykUbmsGvY0ezSEmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730539479; c=relaxed/simple;
	bh=8bHD8LkF6irBIGrh+Gy/ufOIziS7pNVpR3UgcfDsnnk=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=H3pihBwRTl/So4YyoYXFOTvnh3bfEKO7RRcrR24Amin4fZ729NJttzoHBivfA3ohDK4/G9pRcy2cp/TcvNRTCJWNwLCjWqtBeXFsUAUASL8W74okkCvyjmUlqNM0ZQeXO57DN/sghgFXgYbxezTxEIj9847IIp17FrWFhZZI0kE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bU0EYvV4; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NUlGdjq+; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 02 Nov 2024 09:24:35 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730539476;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4rhq/1wUN75zQ4J6tZsX6bfty+RwxtFtyRfVtUtdASA=;
	b=bU0EYvV4msSfPXPIP660hYqPY5sXip36PSf2UXUX4eQ7aedDZGY2gmY/Y1a7tgYXvaBXRd
	1Jn2wVWyvnI2hEE+mRjAJ7KF/3utZBIQsb+qnKhVqPN2DC+fuHiGEHITGhETi3H5da0hJL
	ea+sRVMxukVWo9mma/Cn37ShmWBvV/jW5iF1yXN6J/jpl8Xo7JDEtLbJOw/Z54SVUmqZSa
	I+9ZZ+yEZT9P72Y4KLtjzLHwJSGblY+tVTrwkRBYelkEJnhhkQOhzYX0l8PXO5C+jMFAW7
	oTb6E+Jz7eDh40seQl/aj6epbuOX8HFVBY5ldQCRZvx+sSPFItEeD5tPBTEmXQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730539476;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4rhq/1wUN75zQ4J6tZsX6bfty+RwxtFtyRfVtUtdASA=;
	b=NUlGdjq+aOAuFxMoZ8/MMpG8shh2p/xJgjbn2pcFRKB0LlAJMX/xlLom13hG3fl0eqyYHS
	OuLWQIBdpLqPe/Cw==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] timekeeping: Remove CONFIG_DEBUG_TIMEKEEPING
Cc: Thomas Gleixner <tglx@linutronix.de>, John Stultz <jstultz@google.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20241031120328.536010148@linutronix.de>
References: <20241031120328.536010148@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173053947519.3137.18070271560339427815.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     d44d26987bb3df6d76556827097fc9ce17565cb8
Gitweb:        https://git.kernel.org/tip/d44d26987bb3df6d76556827097fc9ce17565cb8
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Thu, 31 Oct 2024 13:04:07 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sat, 02 Nov 2024 10:14:31 +01:00

timekeeping: Remove CONFIG_DEBUG_TIMEKEEPING

Since 135225a363ae timekeeping_cycles_to_ns() handles large offsets which
would lead to 64bit multiplication overflows correctly. It's also protected
against negative motion of the clocksource unconditionally, which was
exclusive to x86 before.

timekeeping_advance() handles large offsets already correctly.

That means the value of CONFIG_DEBUG_TIMEKEEPING which analyzed these cases
is very close to zero. Remove all of it.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: John Stultz <jstultz@google.com>
Link: https://lore.kernel.org/all/20241031120328.536010148@linutronix.de

---
 arch/riscv/configs/defconfig                        |   1 +-
 include/linux/timekeeper_internal.h                 |  16 +--
 kernel/time/timekeeping.c                           | 108 +-----------
 lib/Kconfig.debug                                   |  13 +-
 tools/testing/selftests/wireguard/qemu/debug.config |   1 +-
 5 files changed, 3 insertions(+), 136 deletions(-)

diff --git a/arch/riscv/configs/defconfig b/arch/riscv/configs/defconfig
index 2341393..26c01b9 100644
--- a/arch/riscv/configs/defconfig
+++ b/arch/riscv/configs/defconfig
@@ -301,7 +301,6 @@ CONFIG_DEBUG_MEMORY_INIT=y
 CONFIG_DEBUG_PER_CPU_MAPS=y
 CONFIG_SOFTLOCKUP_DETECTOR=y
 CONFIG_WQ_WATCHDOG=y
-CONFIG_DEBUG_TIMEKEEPING=y
 CONFIG_DEBUG_RT_MUTEXES=y
 CONFIG_DEBUG_SPINLOCK=y
 CONFIG_DEBUG_MUTEXES=y
diff --git a/include/linux/timekeeper_internal.h b/include/linux/timekeeper_internal.h
index a3b6380..e39d4d5 100644
--- a/include/linux/timekeeper_internal.h
+++ b/include/linux/timekeeper_internal.h
@@ -76,9 +76,6 @@ struct tk_read_base {
  *				ntp shifted nano seconds.
  * @ntp_err_mult:		Multiplication factor for scaled math conversion
  * @skip_second_overflow:	Flag used to avoid updating NTP twice with same second
- * @last_warning:		Warning ratelimiter (DEBUG_TIMEKEEPING)
- * @underflow_seen:		Underflow warning flag (DEBUG_TIMEKEEPING)
- * @overflow_seen:		Overflow warning flag (DEBUG_TIMEKEEPING)
  *
  * Note: For timespec(64) based interfaces wall_to_monotonic is what
  * we need to add to xtime (or xtime corrected for sub jiffy times)
@@ -147,19 +144,6 @@ struct timekeeper {
 	u32			ntp_error_shift;
 	u32			ntp_err_mult;
 	u32			skip_second_overflow;
-
-#ifdef CONFIG_DEBUG_TIMEKEEPING
-	long			last_warning;
-	/*
-	 * These simple flag variables are managed
-	 * without locks, which is racy, but they are
-	 * ok since we don't really care about being
-	 * super precise about how many events were
-	 * seen, just that a problem was observed.
-	 */
-	int			underflow_seen;
-	int			overflow_seen;
-#endif
 };
 
 #ifdef CONFIG_GENERIC_TIME_VSYSCALL
diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index 17cae88..d115ade 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -226,97 +226,6 @@ static inline u64 tk_clock_read(const struct tk_read_base *tkr)
 	return clock->read(clock);
 }
 
-#ifdef CONFIG_DEBUG_TIMEKEEPING
-#define WARNING_FREQ (HZ*300) /* 5 minute rate-limiting */
-
-static void timekeeping_check_update(struct timekeeper *tk, u64 offset)
-{
-
-	u64 max_cycles = tk->tkr_mono.clock->max_cycles;
-	const char *name = tk->tkr_mono.clock->name;
-
-	if (offset > max_cycles) {
-		printk_deferred("WARNING: timekeeping: Cycle offset (%lld) is larger than allowed by the '%s' clock's max_cycles value (%lld): time overflow danger\n",
-				offset, name, max_cycles);
-		printk_deferred("         timekeeping: Your kernel is sick, but tries to cope by capping time updates\n");
-	} else {
-		if (offset > (max_cycles >> 1)) {
-			printk_deferred("INFO: timekeeping: Cycle offset (%lld) is larger than the '%s' clock's 50%% safety margin (%lld)\n",
-					offset, name, max_cycles >> 1);
-			printk_deferred("      timekeeping: Your kernel is still fine, but is feeling a bit nervous\n");
-		}
-	}
-
-	if (tk->underflow_seen) {
-		if (jiffies - tk->last_warning > WARNING_FREQ) {
-			printk_deferred("WARNING: Underflow in clocksource '%s' observed, time update ignored.\n", name);
-			printk_deferred("         Please report this, consider using a different clocksource, if possible.\n");
-			printk_deferred("         Your kernel is probably still fine.\n");
-			tk->last_warning = jiffies;
-		}
-		tk->underflow_seen = 0;
-	}
-
-	if (tk->overflow_seen) {
-		if (jiffies - tk->last_warning > WARNING_FREQ) {
-			printk_deferred("WARNING: Overflow in clocksource '%s' observed, time update capped.\n", name);
-			printk_deferred("         Please report this, consider using a different clocksource, if possible.\n");
-			printk_deferred("         Your kernel is probably still fine.\n");
-			tk->last_warning = jiffies;
-		}
-		tk->overflow_seen = 0;
-	}
-}
-
-static inline u64 timekeeping_cycles_to_ns(const struct tk_read_base *tkr, u64 cycles);
-
-static inline u64 timekeeping_debug_get_ns(const struct tk_read_base *tkr)
-{
-	struct timekeeper *tk = &tk_core.timekeeper;
-	u64 now, last, mask, max, delta;
-	unsigned int seq;
-
-	/*
-	 * Since we're called holding a seqcount, the data may shift
-	 * under us while we're doing the calculation. This can cause
-	 * false positives, since we'd note a problem but throw the
-	 * results away. So nest another seqcount here to atomically
-	 * grab the points we are checking with.
-	 */
-	do {
-		seq = read_seqcount_begin(&tk_core.seq);
-		now = tk_clock_read(tkr);
-		last = tkr->cycle_last;
-		mask = tkr->mask;
-		max = tkr->clock->max_cycles;
-	} while (read_seqcount_retry(&tk_core.seq, seq));
-
-	delta = clocksource_delta(now, last, mask);
-
-	/*
-	 * Try to catch underflows by checking if we are seeing small
-	 * mask-relative negative values.
-	 */
-	if (unlikely((~delta & mask) < (mask >> 3)))
-		tk->underflow_seen = 1;
-
-	/* Check for multiplication overflows */
-	if (unlikely(delta > max))
-		tk->overflow_seen = 1;
-
-	/* timekeeping_cycles_to_ns() handles both under and overflow */
-	return timekeeping_cycles_to_ns(tkr, now);
-}
-#else
-static inline void timekeeping_check_update(struct timekeeper *tk, u64 offset)
-{
-}
-static inline u64 timekeeping_debug_get_ns(const struct tk_read_base *tkr)
-{
-	BUG();
-}
-#endif
-
 /**
  * tk_setup_internals - Set up internals to use clocksource clock.
  *
@@ -421,19 +330,11 @@ static inline u64 timekeeping_cycles_to_ns(const struct tk_read_base *tkr, u64 c
 	return ((delta * tkr->mult) + tkr->xtime_nsec) >> tkr->shift;
 }
 
-static __always_inline u64 __timekeeping_get_ns(const struct tk_read_base *tkr)
+static __always_inline u64 timekeeping_get_ns(const struct tk_read_base *tkr)
 {
 	return timekeeping_cycles_to_ns(tkr, tk_clock_read(tkr));
 }
 
-static inline u64 timekeeping_get_ns(const struct tk_read_base *tkr)
-{
-	if (IS_ENABLED(CONFIG_DEBUG_TIMEKEEPING))
-		return timekeeping_debug_get_ns(tkr);
-
-	return __timekeeping_get_ns(tkr);
-}
-
 /**
  * update_fast_timekeeper - Update the fast and NMI safe monotonic timekeeper.
  * @tkr: Timekeeping readout base from which we take the update
@@ -477,7 +378,7 @@ static __always_inline u64 __ktime_get_fast_ns(struct tk_fast *tkf)
 		seq = raw_read_seqcount_latch(&tkf->seq);
 		tkr = tkf->base + (seq & 0x01);
 		now = ktime_to_ns(tkr->base);
-		now += __timekeeping_get_ns(tkr);
+		now += timekeeping_get_ns(tkr);
 	} while (raw_read_seqcount_latch_retry(&tkf->seq, seq));
 
 	return now;
@@ -593,7 +494,7 @@ static __always_inline u64 __ktime_get_real_fast(struct tk_fast *tkf, u64 *mono)
 		tkr = tkf->base + (seq & 0x01);
 		basem = ktime_to_ns(tkr->base);
 		baser = ktime_to_ns(tkr->base_real);
-		delta = __timekeeping_get_ns(tkr);
+		delta = timekeeping_get_ns(tkr);
 	} while (raw_read_seqcount_latch_retry(&tkf->seq, seq));
 
 	if (mono)
@@ -2333,9 +2234,6 @@ static bool timekeeping_advance(enum timekeeping_adv_mode mode)
 	if (offset < real_tk->cycle_interval && mode == TK_ADV_TICK)
 		return false;
 
-	/* Do some additional sanity checking */
-	timekeeping_check_update(tk, offset);
-
 	/*
 	 * With NO_HZ we may have to accumulate many cycle_intervals
 	 * (think "ticks") worth of time at once. To do this efficiently,
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 7315f64..14977b9 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1328,19 +1328,6 @@ config SCHEDSTATS
 
 endmenu
 
-config DEBUG_TIMEKEEPING
-	bool "Enable extra timekeeping sanity checking"
-	help
-	  This option will enable additional timekeeping sanity checks
-	  which may be helpful when diagnosing issues where timekeeping
-	  problems are suspected.
-
-	  This may include checks in the timekeeping hotpaths, so this
-	  option may have a (very small) performance impact to some
-	  workloads.
-
-	  If unsure, say N.
-
 config DEBUG_PREEMPT
 	bool "Debug preemptible kernel"
 	depends on DEBUG_KERNEL && PREEMPTION && TRACE_IRQFLAGS_SUPPORT
diff --git a/tools/testing/selftests/wireguard/qemu/debug.config b/tools/testing/selftests/wireguard/qemu/debug.config
index 9d17221..139fd9a 100644
--- a/tools/testing/selftests/wireguard/qemu/debug.config
+++ b/tools/testing/selftests/wireguard/qemu/debug.config
@@ -31,7 +31,6 @@ CONFIG_SCHED_DEBUG=y
 CONFIG_SCHED_INFO=y
 CONFIG_SCHEDSTATS=y
 CONFIG_SCHED_STACK_END_CHECK=y
-CONFIG_DEBUG_TIMEKEEPING=y
 CONFIG_DEBUG_PREEMPT=y
 CONFIG_DEBUG_RT_MUTEXES=y
 CONFIG_DEBUG_SPINLOCK=y

