Return-Path: <linux-tip-commits+bounces-7625-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D72A8CB21D9
	for <lists+linux-tip-commits@lfdr.de>; Wed, 10 Dec 2025 07:52:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D57F03005ABA
	for <lists+linux-tip-commits@lfdr.de>; Wed, 10 Dec 2025 06:52:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 367D223C8C7;
	Wed, 10 Dec 2025 06:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iPRn+STD";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FNFN2SVs"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 680231F3BA4;
	Wed, 10 Dec 2025 06:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765349537; cv=none; b=etckrz9ZxnJxsguptACLiFDIL7pdt/j+6hNOCA9MvO20nOSj4B2GHu4pJrrI2qJZ8l7qVcetCd3B454BQqQbvL2q8UJgOHxjOmBx2ecky2abq0g9gBo1cBm4aSbeLGMyS9oNxYXzrvEdgjU4wukn5clHdfK+Dl7ytwB0aXj5L/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765349537; c=relaxed/simple;
	bh=Fgxrsfp5ux6Evv0n77rdUgAZyas9VwMJRtMaQcM0Kcs=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=or/YtSrvNlb43iMcf+a8B3PCuO717dc/8BDsYpvKqNCn9HU4Kmo0RP/ACmcemj6bYWiXmCE3Ui/u31SieHNkmc9AMoTsz3SLGCD++mgSt+8PCgTb9a1hhYp784Hz8qAwePPUtqhbmmWs1v767nOmryx9YC/aAj4xTcE+vW/IT+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=iPRn+STD; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FNFN2SVs; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 10 Dec 2025 06:52:08 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1765349530;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=q+XtOJ15kTAOv/rc5c/PTgEsTGGnAAfMT47XI5a/cN8=;
	b=iPRn+STDetgTgs/G+iSFHyxfK+xdG1fB2BKb9SXi1vSrkdchVfTIJ2u77X1AmYFC3ge0Oq
	nD3yiEj9tOkXe+dVw+ekKJARL4ZG70z7A+7S1iCI1UzG2hqxceDP9Dg30ZmHpYglr74539
	BJrn/hTmnzOKccMxv+OjW8V5GGj3fSlrBYO7IlrjfcNKp8Lh0JOEk5oDa3Y4+kel9eXtxu
	uNcbYk2zp8w+WpLK4B74q89O7VDjEwzz8qVSUX+/FKJpjh6OKHpqupUWcBbb14FpQbLz57
	PXtNDU73QoM2vIEojcDsx/wIC05y16gPHHfMMGNa+q7H5A8u28qrblGBsiLjMw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1765349530;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=q+XtOJ15kTAOv/rc5c/PTgEsTGGnAAfMT47XI5a/cN8=;
	b=FNFN2SVsGeEmjAxxLj4z608Cy+8D2Ezj6mGP2FxOhIoslO/ia8bXa2KuIXGGqAUGgqFi2i
	HbmJYg9BKygjKrBw==
From: "tip-bot2 for Sebastian Andrzej Siewior" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: smp/urgent] cpu: Make atomic hotplug callbacks run with
 interrupts disabled on UP
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251127144723.ev9DuXXR@linutronix.de>
References: <20251127144723.ev9DuXXR@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176534952894.498.16086847818085207539.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the smp/urgent branch of tip:

Commit-ID:     c94291914b200e10c72cef23c8e4c67eb4fdbcd9
Gitweb:        https://git.kernel.org/tip/c94291914b200e10c72cef23c8e4c67eb4f=
dbcd9
Author:        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate:    Thu, 27 Nov 2025 15:47:23 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 10 Dec 2025 15:49:11 +09:00

cpu: Make atomic hotplug callbacks run with interrupts disabled on UP

On SMP systems the CPU hotplug callbacks in the "starting" range are
invoked while the CPU is brought up and interrupts are still
disabled. Callbacks which are added later are invoked via the
hotplug-thread on the target CPU and interrupts are explicitly disabled.

In the UP case callbacks which are added later are invoked directly without
the thread indirection. This is in principle okay since there is just one
CPU but those callbacks are invoked with interrupt disabled code. That's
incorrect as those callbacks assume interrupt disabled context.

Disable interrupts before invoking the callbacks on UP if the state is
atomic and interrupts are expected to be disabled.  The "save" part is
required because this is also invoked early in the boot process while
interrupts are disabled and must not be enabled prematurely.

Fixes: 06ddd17521bf1 ("sched/smp: Always define is_percpu_thread() and schedu=
ler_ipi()")
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://patch.msgid.link/20251127144723.ev9DuXXR@linutronix.de
---
 kernel/cpu.c | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/kernel/cpu.c b/kernel/cpu.c
index b674fdf..8df2d77 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -249,6 +249,14 @@ err:
 	return ret;
 }
=20
+/*
+ * The former STARTING/DYING states, ran with IRQs disabled and must not fai=
l.
+ */
+static bool cpuhp_is_atomic_state(enum cpuhp_state state)
+{
+	return CPUHP_AP_IDLE_DEAD <=3D state && state < CPUHP_AP_ONLINE;
+}
+
 #ifdef CONFIG_SMP
 static bool cpuhp_is_ap_state(enum cpuhp_state state)
 {
@@ -271,14 +279,6 @@ static inline void complete_ap_thread(struct cpuhp_cpu_s=
tate *st, bool bringup)
 	complete(done);
 }
=20
-/*
- * The former STARTING/DYING states, ran with IRQs disabled and must not fai=
l.
- */
-static bool cpuhp_is_atomic_state(enum cpuhp_state state)
-{
-	return CPUHP_AP_IDLE_DEAD <=3D state && state < CPUHP_AP_ONLINE;
-}
-
 /* Synchronization state management */
 enum cpuhp_sync_state {
 	SYNC_STATE_DEAD,
@@ -2364,7 +2364,14 @@ static int cpuhp_issue_call(int cpu, enum cpuhp_state =
state, bool bringup,
 	else
 		ret =3D cpuhp_invoke_callback(cpu, state, bringup, node, NULL);
 #else
-	ret =3D cpuhp_invoke_callback(cpu, state, bringup, node, NULL);
+	if (cpuhp_is_atomic_state(state)) {
+		guard(irqsave)();
+		ret =3D cpuhp_invoke_callback(cpu, state, bringup, node, NULL);
+		/* STARTING/DYING must not fail! */
+		WARN_ON_ONCE(ret);
+	} else {
+		ret =3D cpuhp_invoke_callback(cpu, state, bringup, node, NULL);
+	}
 #endif
 	BUG_ON(ret && !bringup);
 	return ret;

