Return-Path: <linux-tip-commits+bounces-8331-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8LqAFd0Oo2nY9AQAu9opvQ
	(envelope-from <linux-tip-commits+bounces-8331-lists+linux-tip-commits=lfdr.de@vger.kernel.org>)
	for <lists+linux-tip-commits@lfdr.de>; Sat, 28 Feb 2026 16:50:53 +0100
X-Original-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AD2851C4267
	for <lists+linux-tip-commits@lfdr.de>; Sat, 28 Feb 2026 16:50:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5303931F3FC4
	for <lists+linux-tip-commits@lfdr.de>; Sat, 28 Feb 2026 15:41:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A59E481641;
	Sat, 28 Feb 2026 15:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sUEKdIa6";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4s1mEkzf"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFE63481228;
	Sat, 28 Feb 2026 15:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772293029; cv=none; b=P656VLoUNPDXSDx+uld7E/xKByYhUajPFKLUlq05zKLCrlqV1hqqPpzhuCM+OURtcZCZnNGa8TV8GsHhepJPtvqMyAdmqjrAYdAhUphzxjEBkxKQTfEG/16VluK3WRHqP21N//qxpUWnOIL4gCHhCg7FBtm8HNXO+4SNDnin1Lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772293029; c=relaxed/simple;
	bh=cgvoVfWi3XBEwDtGlOx+R/fehWXCLYSBpFoALZNlmzo=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=JOaGwcmuGepaC0tZimaB0PxSgcMhx1epYA/72rwE0eGLhZtiLG5mW8leRgFooqu4W/ucthKvi5mYB/ZDHW3QNgQUhgIcIrcGrz6jCfD00zZfAJIblXkRF6Riaea6IXV0XKz+hc1d9ABMn27GHiMtgB2oQ69Re1dox+68zBfMwNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sUEKdIa6; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4s1mEkzf; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 28 Feb 2026 15:36:58 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1772293019;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jgnEGBgbdlcHFeOuDXJ61woTo72u6n6yT3TNTDHAWlE=;
	b=sUEKdIa68hYTRS/wMGKFx8cYnevvLWLT9FtZui4uFmtB19pTOFP2o8mDT7kWvf8214Wuqn
	5hpzD2C2rSJMQ5HrKtvU7BRmKPNdoOpePhmIsz2K4qlAJAK3b2ixWoY+fCpMvSOwSRBV83
	xpWAv+10UXoND4Lzl1affCKqhl7HFfcmjjmEx/FvsSLFvX2+bzb/ioU4LtkhB/nfOSBOGg
	Bw3MHApQkO1Iy/aseeEOwuuRc9s67q06/o2oibTt1R2IksZ41/Moo+fFbhmnsl3FrQzc7P
	Gn63YZ+v1pHhFAQVAJuVaXEk2zSP/ygnhxcWXvBcPA4IBYJ87Fnyz0Izph5c8w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1772293019;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jgnEGBgbdlcHFeOuDXJ61woTo72u6n6yT3TNTDHAWlE=;
	b=4s1mEkzfI5gJpBqe7eYfbUPRq/mpaodTXJEWBcVsU8hRjgqnsHlzibNFW7Bm7xgOJI6p+g
	e+QkW5O+PPSqkmCg==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/hrtick] hrtimer: Provide a static branch based
 hrtimer_hres_enabled()
Cc: Thomas Gleixner <tglx@kernel.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20260224163429.136503358@kernel.org>
References: <20260224163429.136503358@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <177229301810.1647592.3760899744853358120.tip-bot2@tip-bot2>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8331-lists,linux-tip-commits=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-tip-commits];
	MISSING_XM_UA(0.00)[];
	HAS_REPLYTO(0.00)[linux-kernel@vger.kernel.org]
X-Rspamd-Queue-Id: AD2851C4267
X-Rspamd-Action: no action

The following commit has been merged into the sched/hrtick branch of tip:

Commit-ID:     0a93d30861617ecf207dcc4c6c736435fac36dae
Gitweb:        https://git.kernel.org/tip/0a93d30861617ecf207dcc4c6c736435fac=
36dae
Author:        Thomas Gleixner <tglx@kernel.org>
AuthorDate:    Tue, 24 Feb 2026 17:35:42 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 27 Feb 2026 16:40:04 +01:00

hrtimer: Provide a static branch based hrtimer_hres_enabled()

The scheduler evaluates this via hrtimer_is_hres_active() every time it has
to update HRTICK. This needs to follow three pointers, which is expensive.

Provide a static branch based mechanism to avoid that.

Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://patch.msgid.link/20260224163429.136503358@kernel.org
---
 include/linux/hrtimer.h | 13 +++++++++----
 kernel/time/hrtimer.c   | 28 +++++++++++++++++++++++++---
 2 files changed, 34 insertions(+), 7 deletions(-)

diff --git a/include/linux/hrtimer.h b/include/linux/hrtimer.h
index 74adbd4..c9ca105 100644
--- a/include/linux/hrtimer.h
+++ b/include/linux/hrtimer.h
@@ -153,17 +153,22 @@ static inline int hrtimer_is_hres_active(struct hrtimer=
 *timer)
 }
=20
 #ifdef CONFIG_HIGH_RES_TIMERS
+extern unsigned int hrtimer_resolution;
 struct clock_event_device;
=20
 extern void hrtimer_interrupt(struct clock_event_device *dev);
=20
-extern unsigned int hrtimer_resolution;
+extern struct static_key_false hrtimer_highres_enabled_key;
=20
-#else
+static inline bool hrtimer_highres_enabled(void)
+{
+	return static_branch_likely(&hrtimer_highres_enabled_key);
+}
=20
+#else  /* CONFIG_HIGH_RES_TIMERS */
 #define hrtimer_resolution	(unsigned int)LOW_RES_NSEC
-
-#endif
+static inline bool hrtimer_highres_enabled(void) { return false; }
+#endif  /* !CONFIG_HIGH_RES_TIMERS */
=20
 static inline ktime_t
 __hrtimer_expires_remaining_adjusted(const struct hrtimer *timer, ktime_t no=
w)
diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index 3088db4..67917ce 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -126,6 +126,25 @@ static inline bool hrtimer_base_is_online(struct hrtimer=
_cpu_base *base)
 		return likely(base->online);
 }
=20
+#ifdef CONFIG_HIGH_RES_TIMERS
+DEFINE_STATIC_KEY_FALSE(hrtimer_highres_enabled_key);
+
+static void hrtimer_hres_workfn(struct work_struct *work)
+{
+	static_branch_enable(&hrtimer_highres_enabled_key);
+}
+
+static DECLARE_WORK(hrtimer_hres_work, hrtimer_hres_workfn);
+
+static inline void hrtimer_schedule_hres_work(void)
+{
+	if (!hrtimer_highres_enabled())
+		schedule_work(&hrtimer_hres_work);
+}
+#else
+static inline void hrtimer_schedule_hres_work(void) { }
+#endif
+
 /*
  * Functions and macros which are different for UP/SMP systems are kept in a
  * single place
@@ -649,7 +668,9 @@ static inline ktime_t hrtimer_update_base(struct hrtimer_=
cpu_base *base)
 }
=20
 /*
- * Is the high resolution mode active ?
+ * Is the high resolution mode active in the CPU base. This cannot use the
+ * static key as the CPUs are switched to high resolution mode
+ * asynchronously.
  */
 static inline int hrtimer_hres_active(struct hrtimer_cpu_base *cpu_base)
 {
@@ -750,6 +771,7 @@ static void hrtimer_switch_to_hres(void)
 	tick_setup_sched_timer(true);
 	/* "Retrigger" the interrupt to get things going */
 	retrigger_next_event(NULL);
+	hrtimer_schedule_hres_work();
 }
=20
 #else
@@ -947,11 +969,10 @@ static bool update_needs_ipi(struct hrtimer_cpu_base *c=
pu_base,
  */
 void clock_was_set(unsigned int bases)
 {
-	struct hrtimer_cpu_base *cpu_base =3D raw_cpu_ptr(&hrtimer_bases);
 	cpumask_var_t mask;
 	int cpu;
=20
-	if (!hrtimer_hres_active(cpu_base) && !tick_nohz_is_active())
+	if (!hrtimer_highres_enabled() && !tick_nohz_is_active())
 		goto out_timerfd;
=20
 	if (!zalloc_cpumask_var(&mask, GFP_KERNEL)) {
@@ -962,6 +983,7 @@ void clock_was_set(unsigned int bases)
 	/* Avoid interrupting CPUs if possible */
 	cpus_read_lock();
 	for_each_online_cpu(cpu) {
+		struct hrtimer_cpu_base *cpu_base;
 		unsigned long flags;
=20
 		cpu_base =3D &per_cpu(hrtimer_bases, cpu);

