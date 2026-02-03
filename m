Return-Path: <linux-tip-commits+bounces-8188-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yBBwEVvagWlBLQMAu9opvQ
	(envelope-from <linux-tip-commits+bounces-8188-lists+linux-tip-commits=lfdr.de@vger.kernel.org>)
	for <lists+linux-tip-commits@lfdr.de>; Tue, 03 Feb 2026 12:22:03 +0100
X-Original-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B4B5D8376
	for <lists+linux-tip-commits@lfdr.de>; Tue, 03 Feb 2026 12:22:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0799530F75A7
	for <lists+linux-tip-commits@lfdr.de>; Tue,  3 Feb 2026 11:18:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90992335095;
	Tue,  3 Feb 2026 11:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zRAXPgSh";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="a/q+mRnB"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5C2633438F;
	Tue,  3 Feb 2026 11:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770117520; cv=none; b=RKajIjhzwnwpLkWbp39FNIvCblS2zhu8m6/wtrvmJV5oeAYqIqzVcvA1E5vB/Aus4o5RGaVTKu718WguVN17naPV85xcIjYNNOScvUnmjqXWALoyIStmP1NqjAjFSu12trS8jR20SwlioYlZ/2krIDI+2lw9zlPXMu4xpDYYNvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770117520; c=relaxed/simple;
	bh=CDiw5LPCUi7lVQR5iHBH7XUvMZEwqlqrC7+W/7uFkN8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=sEhONzifkytE4jIIKjVAACDYf0VkO5MT8uiDKomTtKnBluzOrZ0dNTYKGo+19+ZRoj+4sHrSQ0zQFUAyFUpMOPerLzuK/t8jfai5s+LgPsGL6rG8/cC/UmsP0gGMs4Ep+RvI5aimcHZWyi9OQX9d/yJGb4/E+vW100HfI7BgbbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zRAXPgSh; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=a/q+mRnB; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 03 Feb 2026 11:18:36 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1770117517;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XPs/SXDKhwNULMGNbYyCyoFxH7VsNzvVc/SQ6ukt3rY=;
	b=zRAXPgShmmpV4hFBeuUbcr64UdIsROpulWhu6iRsFaKBsaki391+NwPTfexln2KJ8FfdYU
	9mUr9FupJWlDK96/tclGS2BYsRmTkFvKc18MDxov+L05VjNMYx69mhyWSzzEFWzF71qwQt
	Ot40IQCA25TFqLLcv1h5ozd5WUgisjRfZExPkPAx0E6GSRPKMVh+ABdtxrZrXqQe8Xjbm2
	Qqi+ey7uN2oUJGhPIWHRGjXOXkrDFkSiLO1bKEvjcKzW1HrtEOCsHOmR57H31B3izv/6vP
	bFhRb9sfTJy8yRhqAy1Uj/EVrULCuKrWK7vehBTYMUi03sO108gVWMgnx/62vw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1770117517;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XPs/SXDKhwNULMGNbYyCyoFxH7VsNzvVc/SQ6ukt3rY=;
	b=a/q+mRnBtaDDkj8R6PlEWJ1M4Zjna3VZYHLx4P4336S3klEC9EGBzm6CzfCqcFj2Rw5Cdt
	fhj/SwqXk7SRSoAw==
From: "tip-bot2 for Wangyang Guo" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: sched/core] sched/clock: Avoid false sharing for sched_clock_irqtime
Cc: Benjamin Lei <benjamin.lei@intel.com>,
 K Prateek Nayak <kprateek.nayak@amd.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Shrikanth Hegde <sshegde@linux.ibm.com>,
 Wangyang Guo <wangyang.guo@intel.com>, Tim Chen <tim.c.chen@linux.intel.com>,
 Tianyou Li <tianyou.li@intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20260127072509.2627346-1-wangyang.guo@intel.com>
References: <20260127072509.2627346-1-wangyang.guo@intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <177011751611.2495410.2667373807222067688.tip-bot2@tip-bot2>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8188-lists,linux-tip-commits=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_EQ_TO_DOM(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	HAS_REPLYTO(0.00)[linux-kernel@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tip-bot2@linutronix.de,linux-tip-commits@vger.kernel.org];
	DKIM_TRACE(0.00)[linutronix.de:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-tip-commits];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,amd.com:email,intel.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linutronix.de:dkim,vger.kernel.org:replyto,infradead.org:email]
X-Rspamd-Queue-Id: 8B4B5D8376
X-Rspamd-Action: no action

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     505da6689305b1103e9a8ab6636c6a7cf74cd5b1
Gitweb:        https://git.kernel.org/tip/505da6689305b1103e9a8ab6636c6a7cf74=
cd5b1
Author:        Wangyang Guo <wangyang.guo@intel.com>
AuthorDate:    Tue, 27 Jan 2026 15:25:09 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 03 Feb 2026 12:04:19 +01:00

sched/clock: Avoid false sharing for sched_clock_irqtime

Read-mostly sched_clock_irqtime may share the same cacheline with
frequently updated nohz struct. Make it as static_key to avoid
false sharing issue.

The only user of disable_sched_clock_irqtime()
is tsc_.*mark_unstable() which may be invoked under atomic context
and require a workqueue to disable static_key. But both of them
calls clear_sched_clock_stable() just before doing
disable_sched_clock_irqtime(). We can reuse
"sched_clock_work" to also disable sched_clock_irqtime().

One additional case need to handle is if the tsc is marked unstable
before late_initcall() phase, sched_clock_work will not be invoked
and sched_clock_irqtime will stay enabled although clock is unstable:
  tsc_init()
    enable_sched_clock_irqtime() # irqtime accounting is enabled here
    ...
    if (unsynchronized_tsc()) # true
      mark_tsc_unstable()
        clear_sched_clock_stable()
          __sched_clock_stable_early =3D 0;
          ...
          if (static_key_count(&sched_clock_running.key) =3D=3D 2)
            # Only happens at sched_clock_init_late()
            __clear_sched_clock_stable(); # Never executed
  ...

  # late_initcall() phase
  sched_clock_init_late()
    if (__sched_clock_stable_early) # Already false
      __set_sched_clock_stable(); # sched_clock is never marked stable
  # TSC unstable, but sched_clock_work won't run to disable irqtime

So we need to disable_sched_clock_irqtime() in sched_clock_init_late()
if clock is unstable.

Reported-by: Benjamin Lei <benjamin.lei@intel.com>
Suggested-by: K Prateek Nayak <kprateek.nayak@amd.com>
Suggested-by: Peter Zijlstra <peterz@infradead.org>
Suggested-by: Shrikanth Hegde <sshegde@linux.ibm.com>
Signed-off-by: Wangyang Guo <wangyang.guo@intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: K Prateek Nayak <kprateek.nayak@amd.com>
Reviewed-by: Tim Chen <tim.c.chen@linux.intel.com>
Reviewed-by: Tianyou Li <tianyou.li@intel.com>
Reviewed-by: Shrikanth Hegde <sshegde@linux.ibm.com>
Tested-by: K Prateek Nayak <kprateek.nayak@amd.com>
Link: https://patch.msgid.link/20260127072509.2627346-1-wangyang.guo@intel.com
---
 arch/x86/kernel/tsc.c  |  2 --
 kernel/sched/clock.c   |  3 +++
 kernel/sched/cputime.c |  9 +++++----
 kernel/sched/sched.h   |  4 ++--
 4 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index 7d3e13e..7be44b5 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -1143,7 +1143,6 @@ static void tsc_cs_mark_unstable(struct clocksource *cs)
 	tsc_unstable =3D 1;
 	if (using_native_sched_clock())
 		clear_sched_clock_stable();
-	disable_sched_clock_irqtime();
 	pr_info("Marking TSC unstable due to clocksource watchdog\n");
 }
=20
@@ -1213,7 +1212,6 @@ void mark_tsc_unstable(char *reason)
 	tsc_unstable =3D 1;
 	if (using_native_sched_clock())
 		clear_sched_clock_stable();
-	disable_sched_clock_irqtime();
 	pr_info("Marking TSC unstable due to %s\n", reason);
=20
 	clocksource_mark_unstable(&clocksource_tsc_early);
diff --git a/kernel/sched/clock.c b/kernel/sched/clock.c
index f5e6dd6..2ae4fbf 100644
--- a/kernel/sched/clock.c
+++ b/kernel/sched/clock.c
@@ -173,6 +173,7 @@ notrace static void __sched_clock_work(struct work_struct=
 *work)
 			scd->tick_gtod, __gtod_offset,
 			scd->tick_raw,  __sched_clock_offset);
=20
+	disable_sched_clock_irqtime();
 	static_branch_disable(&__sched_clock_stable);
 }
=20
@@ -238,6 +239,8 @@ static int __init sched_clock_init_late(void)
=20
 	if (__sched_clock_stable_early)
 		__set_sched_clock_stable();
+	else
+		disable_sched_clock_irqtime();  /* disable if clock unstable. */
=20
 	return 0;
 }
diff --git a/kernel/sched/cputime.c b/kernel/sched/cputime.c
index 4f97896..ff0dfca 100644
--- a/kernel/sched/cputime.c
+++ b/kernel/sched/cputime.c
@@ -12,6 +12,8 @@
=20
 #ifdef CONFIG_IRQ_TIME_ACCOUNTING
=20
+DEFINE_STATIC_KEY_FALSE(sched_clock_irqtime);
+
 /*
  * There are no locks covering percpu hardirq/softirq time.
  * They are only modified in vtime_account, on corresponding CPU
@@ -25,16 +27,15 @@
  */
 DEFINE_PER_CPU(struct irqtime, cpu_irqtime);
=20
-int sched_clock_irqtime;
-
 void enable_sched_clock_irqtime(void)
 {
-	sched_clock_irqtime =3D 1;
+	static_branch_enable(&sched_clock_irqtime);
 }
=20
 void disable_sched_clock_irqtime(void)
 {
-	sched_clock_irqtime =3D 0;
+	if (irqtime_enabled())
+		static_branch_disable(&sched_clock_irqtime);
 }
=20
 static void irqtime_account_delta(struct irqtime *irqtime, u64 delta,
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 2aa4251..a821cc8 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -3333,11 +3333,11 @@ struct irqtime {
 };
=20
 DECLARE_PER_CPU(struct irqtime, cpu_irqtime);
-extern int sched_clock_irqtime;
+DECLARE_STATIC_KEY_FALSE(sched_clock_irqtime);
=20
 static inline int irqtime_enabled(void)
 {
-	return sched_clock_irqtime;
+	return static_branch_likely(&sched_clock_irqtime);
 }
=20
 /*

