Return-Path: <linux-tip-commits+bounces-6671-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDF5BB802AE
	for <lists+linux-tip-commits@lfdr.de>; Wed, 17 Sep 2025 16:44:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 689261757FC
	for <lists+linux-tip-commits@lfdr.de>; Wed, 17 Sep 2025 14:44:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27CC32FBE0C;
	Wed, 17 Sep 2025 14:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="H+MYv3En";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BghIdHhK"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CA402F5479;
	Wed, 17 Sep 2025 14:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758120248; cv=none; b=cy+NCSW5ssVbXy6dD/SB2MiPVEV5aIov+hG3BU4Tr27iBOzcmS3wJn0UDOvJV5V0n8cJKOYvZy7Dr7qUnUZ7PQEIrsd1A1UOGRE48b9VjLOAbzi6nMjqVP0ux8kNDfPGzoLLjcIw980xv8BgVNQHpuT5p7aZ1pW0MQauuXxn8DA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758120248; c=relaxed/simple;
	bh=32ueQfqmlP61CPySgOz/9czr1dcjb4TU7Ckjt9GbTMQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=BFZX5ddG/krUI1t9/MUs8p2WMJ8cDHm1Wa4flcxHotAVR/0e8pQIRCtohbbhsK/7fe8gOzMLlE2w+95Vdd4jLh27Xdic/3PKBePrvebZRdNy5pfg/EO0KULF8NF85TcWiEBn8A1paHS+wSVRRdmMDz00sKtfacXCnfURxr8yfG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=H+MYv3En; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BghIdHhK; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 17 Sep 2025 14:44:03 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1758120244;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sWef1Ek/Nm2sxQSld+AC2+lnXoBb7GvZF7ZBj8KcLD0=;
	b=H+MYv3En/b/jPfwPbtML8mY5NZYq2DO7ifbj6EdSGS8QKXgINh/C5sYeB2sRRoTHtpbxKf
	yKexh0JCHKNXe2Y7PFjP3AP5YtC8sBqvjV7FbHiqM/zHBhrQEE1qAmUwEHtdMQ8p+oFPfL
	MPp/VXU6km/jo7K0ew2L2oFEv0c4eqev+amv3Mi3q1L0cMoa/e5KJchHZ5aKKuTyWvnuGx
	RUrXi3tKUTGv9AyphqAIj96tb9uqHGmwgF0IaNeyxWxQmyTPepTDElUbMWC0pI5U8HLZx5
	y12KKRzHQUcYEKn2z0R7rkn5eo2jcrMzxh+AcsPi1A6fRCXchj6h1hXT64o7bw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1758120244;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sWef1Ek/Nm2sxQSld+AC2+lnXoBb7GvZF7ZBj8KcLD0=;
	b=BghIdHhKgdyTEKX3zs4z6okqzZaaTTsJXJfCzC+Lko9I4saHMheNrTlz6pP2a6+8PFD3mH
	B9dP8NYuiRshA7CQ==
From: "tip-bot2 for Sebastian Andrzej Siewior" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: irq/core] softirq: Allow to drop the softirq-BKL lock on PREEMPT_RT
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20250904142526.1845999-4-bigeasy@linutronix.de>
References: <20250904142526.1845999-4-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175812024313.709179.12544322345414745069.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     3253cb49cbad4772389d6ef55be75db1f97da910
Gitweb:        https://git.kernel.org/tip/3253cb49cbad4772389d6ef55be75db1f97=
da910
Author:        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate:    Thu, 04 Sep 2025 16:25:25 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 17 Sep 2025 16:25:41 +02:00

softirq: Allow to drop the softirq-BKL lock on PREEMPT_RT

softirqs are preemptible on PREEMPT_RT. There is synchronisation between
individual sections which disable bottom halves. This in turn means that
a forced threaded interrupt cannot preempt another forced threaded
interrupt. Instead it will PI-boost the other handler and wait for its
completion.

This is required because code within a softirq section is assumed to be
non-preemptible and may expect exclusive access to per-CPU resources
such as variables or pinned timers.

Code with such expectation has been identified and updated to use
local_lock_nested_bh() for locking of the per-CPU resource. This means the
softirq lock can be removed.

Disable the softirq synchronization, but add a new config switch
CONFIG_PREEMPT_RT_NEEDS_BH_LOCK which allows to re-enable the synchronized
behavior in case that there are issues, which haven't been detected yet.

The softirq_ctrl.cnt accounting remains to let the NOHZ code know if
softirqs are currently handled.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/Kconfig.preempt | 13 ++++++-
 kernel/softirq.c       | 83 +++++++++++++++++++++++++++++++----------
 2 files changed, 76 insertions(+), 20 deletions(-)

diff --git a/kernel/Kconfig.preempt b/kernel/Kconfig.preempt
index 54ea59f..da32680 100644
--- a/kernel/Kconfig.preempt
+++ b/kernel/Kconfig.preempt
@@ -103,6 +103,19 @@ config PREEMPT_RT
 	  Select this if you are building a kernel for systems which
 	  require real-time guarantees.
=20
+config PREEMPT_RT_NEEDS_BH_LOCK
+	bool "Enforce softirq synchronisation on PREEMPT_RT"
+	depends on PREEMPT_RT
+	help
+	  Enforce synchronisation across the softirqs context. On PREEMPT_RT
+	  the softirq is preemptible. This enforces the same per-CPU BLK
+	  semantic non-PREEMPT_RT builds have. This should not be needed
+	  because per-CPU locks were added to avoid the per-CPU BKL.
+
+	  This switch provides the old behaviour for testing reasons. Select
+	  this if you suspect an error with preemptible softirq and want test
+	  the old synchronized behaviour.
+
 config PREEMPT_COUNT
        bool
=20
diff --git a/kernel/softirq.c b/kernel/softirq.c
index 4e2c980..7719891 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -165,7 +165,11 @@ void __local_bh_disable_ip(unsigned long ip, unsigned in=
t cnt)
 	/* First entry of a task into a BH disabled section? */
 	if (!current->softirq_disable_cnt) {
 		if (preemptible()) {
-			local_lock(&softirq_ctrl.lock);
+			if (IS_ENABLED(CONFIG_PREEMPT_RT_NEEDS_BH_LOCK))
+				local_lock(&softirq_ctrl.lock);
+			else
+				migrate_disable();
+
 			/* Required to meet the RCU bottomhalf requirements. */
 			rcu_read_lock();
 		} else {
@@ -177,17 +181,34 @@ void __local_bh_disable_ip(unsigned long ip, unsigned i=
nt cnt)
 	 * Track the per CPU softirq disabled state. On RT this is per CPU
 	 * state to allow preemption of bottom half disabled sections.
 	 */
-	newcnt =3D __this_cpu_add_return(softirq_ctrl.cnt, cnt);
-	/*
-	 * Reflect the result in the task state to prevent recursion on the
-	 * local lock and to make softirq_count() & al work.
-	 */
-	current->softirq_disable_cnt =3D newcnt;
+	if (IS_ENABLED(CONFIG_PREEMPT_RT_NEEDS_BH_LOCK)) {
+		newcnt =3D this_cpu_add_return(softirq_ctrl.cnt, cnt);
+		/*
+		 * Reflect the result in the task state to prevent recursion on the
+		 * local lock and to make softirq_count() & al work.
+		 */
+		current->softirq_disable_cnt =3D newcnt;
=20
-	if (IS_ENABLED(CONFIG_TRACE_IRQFLAGS) && newcnt =3D=3D cnt) {
-		raw_local_irq_save(flags);
-		lockdep_softirqs_off(ip);
-		raw_local_irq_restore(flags);
+		if (IS_ENABLED(CONFIG_TRACE_IRQFLAGS) && newcnt =3D=3D cnt) {
+			raw_local_irq_save(flags);
+			lockdep_softirqs_off(ip);
+			raw_local_irq_restore(flags);
+		}
+	} else {
+		bool sirq_dis =3D false;
+
+		if (!current->softirq_disable_cnt)
+			sirq_dis =3D true;
+
+		this_cpu_add(softirq_ctrl.cnt, cnt);
+		current->softirq_disable_cnt +=3D cnt;
+		WARN_ON_ONCE(current->softirq_disable_cnt < 0);
+
+		if (IS_ENABLED(CONFIG_TRACE_IRQFLAGS) && sirq_dis) {
+			raw_local_irq_save(flags);
+			lockdep_softirqs_off(ip);
+			raw_local_irq_restore(flags);
+		}
 	}
 }
 EXPORT_SYMBOL(__local_bh_disable_ip);
@@ -195,23 +216,42 @@ EXPORT_SYMBOL(__local_bh_disable_ip);
 static void __local_bh_enable(unsigned int cnt, bool unlock)
 {
 	unsigned long flags;
+	bool sirq_en =3D false;
 	int newcnt;
=20
-	DEBUG_LOCKS_WARN_ON(current->softirq_disable_cnt !=3D
-			    this_cpu_read(softirq_ctrl.cnt));
+	if (IS_ENABLED(CONFIG_PREEMPT_RT_NEEDS_BH_LOCK)) {
+		DEBUG_LOCKS_WARN_ON(current->softirq_disable_cnt !=3D
+				    this_cpu_read(softirq_ctrl.cnt));
+		if (softirq_count() =3D=3D cnt)
+			sirq_en =3D true;
+	} else {
+		if (current->softirq_disable_cnt =3D=3D cnt)
+			sirq_en =3D true;
+	}
=20
-	if (IS_ENABLED(CONFIG_TRACE_IRQFLAGS) && softirq_count() =3D=3D cnt) {
+	if (IS_ENABLED(CONFIG_TRACE_IRQFLAGS) && sirq_en) {
 		raw_local_irq_save(flags);
 		lockdep_softirqs_on(_RET_IP_);
 		raw_local_irq_restore(flags);
 	}
=20
-	newcnt =3D __this_cpu_sub_return(softirq_ctrl.cnt, cnt);
-	current->softirq_disable_cnt =3D newcnt;
+	if (IS_ENABLED(CONFIG_PREEMPT_RT_NEEDS_BH_LOCK)) {
+		newcnt =3D this_cpu_sub_return(softirq_ctrl.cnt, cnt);
+		current->softirq_disable_cnt =3D newcnt;
=20
-	if (!newcnt && unlock) {
-		rcu_read_unlock();
-		local_unlock(&softirq_ctrl.lock);
+		if (!newcnt && unlock) {
+			rcu_read_unlock();
+			local_unlock(&softirq_ctrl.lock);
+		}
+	} else {
+		current->softirq_disable_cnt -=3D cnt;
+		this_cpu_sub(softirq_ctrl.cnt, cnt);
+		if (unlock && !current->softirq_disable_cnt) {
+			migrate_enable();
+			rcu_read_unlock();
+		} else {
+			WARN_ON_ONCE(current->softirq_disable_cnt < 0);
+		}
 	}
 }
=20
@@ -228,7 +268,10 @@ void __local_bh_enable_ip(unsigned long ip, unsigned int=
 cnt)
 	lock_map_release(&bh_lock_map);
=20
 	local_irq_save(flags);
-	curcnt =3D __this_cpu_read(softirq_ctrl.cnt);
+	if (IS_ENABLED(CONFIG_PREEMPT_RT_NEEDS_BH_LOCK))
+		curcnt =3D this_cpu_read(softirq_ctrl.cnt);
+	else
+		curcnt =3D current->softirq_disable_cnt;
=20
 	/*
 	 * If this is not reenabling soft interrupts, no point in trying to

