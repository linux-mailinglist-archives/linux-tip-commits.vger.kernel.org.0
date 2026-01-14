Return-Path: <linux-tip-commits+bounces-7991-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E8DFBD1E26B
	for <lists+linux-tip-commits@lfdr.de>; Wed, 14 Jan 2026 11:41:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D20F0302075C
	for <lists+linux-tip-commits@lfdr.de>; Wed, 14 Jan 2026 10:40:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11EBE392819;
	Wed, 14 Jan 2026 10:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="eiuY52Ff";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YvACc6+A"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 791BE393DFB;
	Wed, 14 Jan 2026 10:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768387218; cv=none; b=mXRqVpcU/z7VVm3HQVwHUGDkeA3Fjao/ZbitrnD1B3/q8CbIeCzna2WtXkr47SCX++RpUFG2maSrz0L6VXCekVksfU3WySWYqS1e/jtUWsWciDQ1BUK1vcageH4eCq+jUUj3f/+e9iH7t2DGnJ4NTAP7ImSbc+soCtavpBbILPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768387218; c=relaxed/simple;
	bh=DGe6fJVwz+yufeUOtnxIuFa5tEXZenAvqs5e+sBnCec=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=IHqHduD83zY4BMoRToh4vQLaYULX62tdCDXNnEqgPn7fopYxmNf6o/C2Zt+okKtU1QNU+brAXUuPJrzt68evkbkJfiCZk8HY0MljV6P/xHtMhZMy7z0DtUyufNu1hcWUThYQPWmIPQ1TAEtoKePwFcjnETlvwkLdgKFYXLFRiYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=eiuY52Ff; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YvACc6+A; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 14 Jan 2026 10:40:10 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1768387211;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J8iqxJn0B9qR7wGo1iFuw2aTfHAqYhwwyCxNQkX7p84=;
	b=eiuY52FfU6HBu0i2mDbAI6w97DrNjvnq5N5K+iBJwLFdYLgZoBgRSyUZAO8VuxNVFNlryu
	sJ9EZdzTv3Lrp1OgEpECs4ij8An1dMENZAuou8yRkw7KrSYyrlR4aSWh9/xY51Up1WiCoS
	3EVMOypgyxrD0aXu4MlPjFFRw8Vc0JxNpCIUcrEec0Ge6WTGf2PA5V5B4Ckq21x8Qr9iMB
	A1YLHbgGZWbcfSB5VlTgGOGz2xrUvDyG4i5Bhop6MOT7XQincVSnBhnb/SfXo9pbvXGxAo
	FznhS6Q9I3vtQg3/qBOH7b31mnRRI/IPY2ogCbXCBDVS6Wq245cjqU1D8hnfnw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1768387211;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J8iqxJn0B9qR7wGo1iFuw2aTfHAqYhwwyCxNQkX7p84=;
	b=YvACc6+AMrkQhH5EEe3G9V8PM7tjlEGwqwh5LtjmgnW2tZzEmhMSlvTlmxnELQ5y1hS8Rs
	vHOvxOz0/+tS/1Bw==
From: "tip-bot2 for Juergen Gross" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/paravirt] x86/paravirt: Move paravirt_sched_clock() related
 code into tsc.c
Cc: Juergen Gross <jgross@suse.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20260105110520.21356-13-jgross@suse.com>
References: <20260105110520.21356-13-jgross@suse.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176838721060.510.4425027098779923219.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/paravirt branch of tip:

Commit-ID:     39965afb11511003cf7d8f34579bd592b8b70b80
Gitweb:        https://git.kernel.org/tip/39965afb11511003cf7d8f34579bd592b8b=
70b80
Author:        Juergen Gross <jgross@suse.com>
AuthorDate:    Mon, 05 Jan 2026 12:05:11 +01:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 12 Jan 2026 18:47:39 +01:00

x86/paravirt: Move paravirt_sched_clock() related code into tsc.c

The only user of paravirt_sched_clock() is in tsc.c, so move the code
from paravirt.c and paravirt.h to tsc.c.

Signed-off-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://patch.msgid.link/20260105110520.21356-13-jgross@suse.com
---
 arch/x86/include/asm/paravirt.h    | 12 ------------
 arch/x86/include/asm/timer.h       |  1 +
 arch/x86/kernel/kvmclock.c         |  1 +
 arch/x86/kernel/paravirt.c         |  7 -------
 arch/x86/kernel/tsc.c              | 10 +++++++++-
 arch/x86/xen/time.c                |  1 +
 drivers/clocksource/hyperv_timer.c |  2 ++
 7 files changed, 14 insertions(+), 20 deletions(-)

diff --git a/arch/x86/include/asm/paravirt.h b/arch/x86/include/asm/paravirt.h
index 766a7ce..b69e75a 100644
--- a/arch/x86/include/asm/paravirt.h
+++ b/arch/x86/include/asm/paravirt.h
@@ -14,20 +14,8 @@
 #ifndef __ASSEMBLER__
 #include <linux/types.h>
 #include <linux/cpumask.h>
-#include <linux/static_call_types.h>
 #include <asm/frame.h>
=20
-u64 dummy_sched_clock(void);
-
-DECLARE_STATIC_CALL(pv_sched_clock, dummy_sched_clock);
-
-void paravirt_set_sched_clock(u64 (*func)(void));
-
-static __always_inline u64 paravirt_sched_clock(void)
-{
-	return static_call(pv_sched_clock)();
-}
-
 __visible void __native_queued_spin_unlock(struct qspinlock *lock);
 bool pv_is_native_spin_unlock(void);
 __visible bool __native_vcpu_is_preempted(long cpu);
diff --git a/arch/x86/include/asm/timer.h b/arch/x86/include/asm/timer.h
index 23baf8c..fda18bc 100644
--- a/arch/x86/include/asm/timer.h
+++ b/arch/x86/include/asm/timer.h
@@ -12,6 +12,7 @@ extern void recalibrate_cpu_khz(void);
 extern int no_timer_check;
=20
 extern bool using_native_sched_clock(void);
+void paravirt_set_sched_clock(u64 (*func)(void));
=20
 /*
  * We use the full linear equation: f(x) =3D a + b*x, in order to allow
diff --git a/arch/x86/kernel/kvmclock.c b/arch/x86/kernel/kvmclock.c
index ca0a49e..b5991d5 100644
--- a/arch/x86/kernel/kvmclock.c
+++ b/arch/x86/kernel/kvmclock.c
@@ -19,6 +19,7 @@
 #include <linux/cc_platform.h>
=20
 #include <asm/hypervisor.h>
+#include <asm/timer.h>
 #include <asm/x86_init.h>
 #include <asm/kvmclock.h>
=20
diff --git a/arch/x86/kernel/paravirt.c b/arch/x86/kernel/paravirt.c
index 42991d4..4e37db8 100644
--- a/arch/x86/kernel/paravirt.c
+++ b/arch/x86/kernel/paravirt.c
@@ -60,13 +60,6 @@ void __init native_pv_lock_init(void)
 		static_branch_enable(&virt_spin_lock_key);
 }
=20
-DEFINE_STATIC_CALL(pv_sched_clock, native_sched_clock);
-
-void paravirt_set_sched_clock(u64 (*func)(void))
-{
-	static_call_update(pv_sched_clock, func);
-}
-
 static noinstr void pv_native_safe_halt(void)
 {
 	native_safe_halt();
diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index 7d3e13e..d5d0b50 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -267,19 +267,27 @@ u64 native_sched_clock_from_tsc(u64 tsc)
 /* We need to define a real function for sched_clock, to override the
    weak default version */
 #ifdef CONFIG_PARAVIRT
+DEFINE_STATIC_CALL(pv_sched_clock, native_sched_clock);
+
 noinstr u64 sched_clock_noinstr(void)
 {
-	return paravirt_sched_clock();
+	return static_call(pv_sched_clock)();
 }
=20
 bool using_native_sched_clock(void)
 {
 	return static_call_query(pv_sched_clock) =3D=3D native_sched_clock;
 }
+
+void paravirt_set_sched_clock(u64 (*func)(void))
+{
+	static_call_update(pv_sched_clock, func);
+}
 #else
 u64 sched_clock_noinstr(void) __attribute__((alias("native_sched_clock")));
=20
 bool using_native_sched_clock(void) { return true; }
+void paravirt_set_sched_clock(u64 (*func)(void)) { }
 #endif
=20
 notrace u64 sched_clock(void)
diff --git a/arch/x86/xen/time.c b/arch/x86/xen/time.c
index e4754b2..6f9f665 100644
--- a/arch/x86/xen/time.c
+++ b/arch/x86/xen/time.c
@@ -19,6 +19,7 @@
 #include <linux/sched/cputime.h>
=20
 #include <asm/pvclock.h>
+#include <asm/timer.h>
 #include <asm/xen/hypervisor.h>
 #include <asm/xen/hypercall.h>
 #include <asm/xen/cpuid.h>
diff --git a/drivers/clocksource/hyperv_timer.c b/drivers/clocksource/hyperv_=
timer.c
index 10356d4..e9f5034 100644
--- a/drivers/clocksource/hyperv_timer.c
+++ b/drivers/clocksource/hyperv_timer.c
@@ -535,6 +535,8 @@ static __always_inline void hv_setup_sched_clock(void *sc=
hed_clock)
 	sched_clock_register(sched_clock, 64, NSEC_PER_SEC);
 }
 #elif defined CONFIG_PARAVIRT
+#include <asm/timer.h>
+
 static __always_inline void hv_setup_sched_clock(void *sched_clock)
 {
 	/* We're on x86/x64 *and* using PV ops */

