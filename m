Return-Path: <linux-tip-commits+bounces-8321-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4FVmImAOo2nY9AQAu9opvQ
	(envelope-from <linux-tip-commits+bounces-8321-lists+linux-tip-commits=lfdr.de@vger.kernel.org>)
	for <lists+linux-tip-commits@lfdr.de>; Sat, 28 Feb 2026 16:48:48 +0100
X-Original-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DF78A1C41F5
	for <lists+linux-tip-commits@lfdr.de>; Sat, 28 Feb 2026 16:48:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 61AAB30EC848
	for <lists+linux-tip-commits@lfdr.de>; Sat, 28 Feb 2026 15:39:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BC77481220;
	Sat, 28 Feb 2026 15:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4TCpH8Ho";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zd7+i6Mu"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4744A480358;
	Sat, 28 Feb 2026 15:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772293019; cv=none; b=g9T51qZvTk/Y5M0TBteRfCre9FCDr9GXGrVF+eqog4wo3KyCfEhAPi3luMe3Aocb4ey24bnKVIzdLyMQgbYI3sdz5tL5iAiNwUUXBGnQUEbf4hy5MTjlGzG/ve4a4JxNmWtr8RCduzjbN5jp3YNDTiiZDN0ihmBAaytqnXnoogA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772293019; c=relaxed/simple;
	bh=jHN+2AIjXuGXBcgeRKzdfZVZWiCQZfvHsSozDKebf/A=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=XV3HK1ygXLfPT7MISgYaV/HgSiZyeOzfrzsz4NI3jXTb3IrR8AW7fSpWCKvjNLcM1d5ye3I87raL3cjVMna0rn8brYytk/VR0g2A+BV9Nm4eeOEEKMmAa3jOX18C6PyUIIrePjMT5bhW0ZbSDZXqduPTpxU9ewm/+YkW/DoGhSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4TCpH8Ho; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zd7+i6Mu; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 28 Feb 2026 15:36:49 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1772293010;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2q2ryGt7dKDBfFIT1Cubb2LwXxiSzDWAsGUDWhNL2q0=;
	b=4TCpH8Ho6s6wfKCVL8toA6BS2d6gxv7LbhuhudEesSnB88PDRawKtLU7kfH/NEwbvFR+ov
	DPzLc2RirWeFJrbxsOY0ZD1bVIvv1WNLukulNZGUaPnViYTUxDT7X4Q97km/MUWtBlKDn5
	S1XrlOWl88e36GbyLP5E2GEXRarufZIebyeB39mVhqJq5teoAAp9vwTybyxYB7h++Wv2Ot
	h92z9VNZIiPV19/ks4QUiW/18YsTYvRtJJgcNPJX6/kI02VsIwqbIqeMYMLK1cqx1lfENt
	Sg+67a9ioIEXQZeO+JZvc5tbdEmHxmW032rz4/q/oK/xcOSIe/+g6pRt1N6dIA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1772293010;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2q2ryGt7dKDBfFIT1Cubb2LwXxiSzDWAsGUDWhNL2q0=;
	b=zd7+i6MuVaDpeHUVcSJVqIlaNDqR9QeT3GVLzkVRU3IQNuFLg0yNaK2Qah0wtstiosU6lU
	vtU9sXj96OYCl4Dw==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/hrtick] timekeeping: Allow inlining clocksource::read()
Cc: Thomas Gleixner <tglx@kernel.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20260224163429.675151545@kernel.org>
References: <20260224163429.675151545@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <177229300966.1647592.5015596163284801947.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8321-lists,linux-tip-commits=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:replyto,linutronix.de:dkim,infradead.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url];
	REPLYTO_DOM_EQ_TO_DOM(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tip-bot2@linutronix.de,linux-tip-commits@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linutronix.de:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-tip-commits];
	MISSING_XM_UA(0.00)[];
	HAS_REPLYTO(0.00)[linux-kernel@vger.kernel.org]
X-Rspamd-Queue-Id: DF78A1C41F5
X-Rspamd-Action: no action

The following commit has been merged into the sched/hrtick branch of tip:

Commit-ID:     2e27beeb66e43f3b84aef5a07e486a5d50695c06
Gitweb:        https://git.kernel.org/tip/2e27beeb66e43f3b84aef5a07e486a5d506=
95c06
Author:        Thomas Gleixner <tglx@kernel.org>
AuthorDate:    Tue, 24 Feb 2026 17:36:20 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 27 Feb 2026 16:40:07 +01:00

timekeeping: Allow inlining clocksource::read()

On some architectures clocksource::read() boils down to a single
instruction, so the indirect function call is just a massive overhead
especially with speculative execution mitigations in effect.

Allow architectures to enable conditional inlining of that read to avoid
that by:

   - providing a static branch to switch to the inlined variant

   - disabling the branch before clocksource changes

   - enabling the branch after a clocksource change, when the clocksource
     indicates in a feature flag that it is the one which provides the
     inlined variant

This is intentionally not a static call as that would only remove the
indirect call, but not the rest of the overhead.

Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://patch.msgid.link/20260224163429.675151545@kernel.org
---
 include/linux/clocksource.h |  2 +-
 kernel/time/Kconfig         |  3 +-
 kernel/time/timekeeping.c   | 74 ++++++++++++++++++++++++++----------
 3 files changed, 60 insertions(+), 19 deletions(-)

diff --git a/include/linux/clocksource.h b/include/linux/clocksource.h
index 65b7c41..54366d5 100644
--- a/include/linux/clocksource.h
+++ b/include/linux/clocksource.h
@@ -149,6 +149,8 @@ struct clocksource {
 #define CLOCK_SOURCE_SUSPEND_NONSTOP		0x80
 #define CLOCK_SOURCE_RESELECT			0x100
 #define CLOCK_SOURCE_VERIFY_PERCPU		0x200
+#define CLOCK_SOURCE_CAN_INLINE_READ		0x400
+
 /* simplify initialization of mask field */
 #define CLOCKSOURCE_MASK(bits) GENMASK_ULL((bits) - 1, 0)
=20
diff --git a/kernel/time/Kconfig b/kernel/time/Kconfig
index 7c6a52f..07b048b 100644
--- a/kernel/time/Kconfig
+++ b/kernel/time/Kconfig
@@ -17,6 +17,9 @@ config ARCH_CLOCKSOURCE_DATA
 config ARCH_CLOCKSOURCE_INIT
 	bool
=20
+config ARCH_WANTS_CLOCKSOURCE_READ_INLINE
+	bool
+
 # Timekeeping vsyscall support
 config GENERIC_TIME_VSYSCALL
 	bool
diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index 91fa200..63aa31f 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -3,34 +3,30 @@
  *  Kernel timekeeping code and accessor functions. Based on code from
  *  timer.c, moved in commit 8524070b7982.
  */
-#include <linux/timekeeper_internal.h>
-#include <linux/module.h>
-#include <linux/interrupt.h>
+#include <linux/audit.h>
+#include <linux/clocksource.h>
+#include <linux/compiler.h>
+#include <linux/jiffies.h>
 #include <linux/kobject.h>
-#include <linux/percpu.h>
-#include <linux/init.h>
-#include <linux/mm.h>
+#include <linux/module.h>
 #include <linux/nmi.h>
-#include <linux/sched.h>
-#include <linux/sched/loadavg.h>
+#include <linux/pvclock_gtod.h>
+#include <linux/random.h>
 #include <linux/sched/clock.h>
+#include <linux/sched/loadavg.h>
+#include <linux/static_key.h>
+#include <linux/stop_machine.h>
 #include <linux/syscore_ops.h>
-#include <linux/clocksource.h>
-#include <linux/jiffies.h>
+#include <linux/tick.h>
 #include <linux/time.h>
 #include <linux/timex.h>
-#include <linux/tick.h>
-#include <linux/stop_machine.h>
-#include <linux/pvclock_gtod.h>
-#include <linux/compiler.h>
-#include <linux/audit.h>
-#include <linux/random.h>
+#include <linux/timekeeper_internal.h>
=20
 #include <vdso/auxclock.h>
=20
 #include "tick-internal.h"
-#include "ntp_internal.h"
 #include "timekeeping_internal.h"
+#include "ntp_internal.h"
=20
 #define TK_CLEAR_NTP		(1 << 0)
 #define TK_CLOCK_WAS_SET	(1 << 1)
@@ -275,6 +271,11 @@ static inline void tk_update_sleep_time(struct timekeepe=
r *tk, ktime_t delta)
 	tk->monotonic_to_boot =3D ktime_to_timespec64(tk->offs_boot);
 }
=20
+#ifdef CONFIG_ARCH_WANTS_CLOCKSOURCE_READ_INLINE
+#include <asm/clock_inlined.h>
+
+static DEFINE_STATIC_KEY_FALSE(clocksource_read_inlined);
+
 /*
  * tk_clock_read - atomic clocksource read() helper
  *
@@ -288,13 +289,36 @@ static inline void tk_update_sleep_time(struct timekeep=
er *tk, ktime_t delta)
  * a read of the fast-timekeeper tkrs (which is protected by its own locking
  * and update logic).
  */
-static inline u64 tk_clock_read(const struct tk_read_base *tkr)
+static __always_inline u64 tk_clock_read(const struct tk_read_base *tkr)
 {
 	struct clocksource *clock =3D READ_ONCE(tkr->clock);
=20
+	if (static_branch_likely(&clocksource_read_inlined))
+		return arch_inlined_clocksource_read(clock);
+
 	return clock->read(clock);
 }
=20
+static inline void clocksource_disable_inline_read(void)
+{
+	static_branch_disable(&clocksource_read_inlined);
+}
+
+static inline void clocksource_enable_inline_read(void)
+{
+	static_branch_enable(&clocksource_read_inlined);
+}
+#else
+static __always_inline u64 tk_clock_read(const struct tk_read_base *tkr)
+{
+	struct clocksource *clock =3D READ_ONCE(tkr->clock);
+
+	return clock->read(clock);
+}
+static inline void clocksource_disable_inline_read(void) { }
+static inline void clocksource_enable_inline_read(void) { }
+#endif
+
 /**
  * tk_setup_internals - Set up internals to use clocksource clock.
  *
@@ -375,7 +399,7 @@ static noinline u64 delta_to_ns_safe(const struct tk_read=
_base *tkr, u64 delta)
 	return mul_u64_u32_add_u64_shr(delta, tkr->mult, tkr->xtime_nsec, tkr->shif=
t);
 }
=20
-static inline u64 timekeeping_cycles_to_ns(const struct tk_read_base *tkr, u=
64 cycles)
+static __always_inline u64 timekeeping_cycles_to_ns(const struct tk_read_bas=
e *tkr, u64 cycles)
 {
 	/* Calculate the delta since the last update_wall_time() */
 	u64 mask =3D tkr->mask, delta =3D (cycles - tkr->cycle_last) & mask;
@@ -1631,7 +1655,19 @@ int timekeeping_notify(struct clocksource *clock)
=20
 	if (tk->tkr_mono.clock =3D=3D clock)
 		return 0;
+
+	/* Disable inlined reads accross the clocksource switch */
+	clocksource_disable_inline_read();
+
 	stop_machine(change_clocksource, clock, NULL);
+
+	/*
+	 * If the clocksource has been selected and supports inlined reads
+	 * enable the branch.
+	 */
+	if (tk->tkr_mono.clock =3D=3D clock && clock->flags & CLOCK_SOURCE_CAN_INLI=
NE_READ)
+		clocksource_enable_inline_read();
+
 	tick_clock_notify();
 	return tk->tkr_mono.clock =3D=3D clock ? 0 : -1;
 }

