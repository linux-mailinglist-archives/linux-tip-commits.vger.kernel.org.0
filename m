Return-Path: <linux-tip-commits+bounces-7884-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 39F3DD1110E
	for <lists+linux-tip-commits@lfdr.de>; Mon, 12 Jan 2026 09:08:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 007C03042EE3
	for <lists+linux-tip-commits@lfdr.de>; Mon, 12 Jan 2026 08:04:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB744346E46;
	Mon, 12 Jan 2026 08:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mT9U5mBl";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="z28k/gh6"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA130340A4D;
	Mon, 12 Jan 2026 08:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768205008; cv=none; b=SJkYsH2mdfZftPzxtLQEO7NKLhHXiVHpIft6YsbNWMEpTVCHoz0QPLew2I7cEm1PpV0icVhLntYHQ3N/YYg2lIUr1Upo4B1mLX5klll2pRNeT9SeVb7P6hVjHQpdYlzHREabw0ihDnogD1Z3mF9vUvQ9+ZF3xt4i/ihEkj0WU8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768205008; c=relaxed/simple;
	bh=g3+hoRe/AkvvKj5Mg7RrCJsxjO5Dx6EvTIRHTtBz2Lk=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=h2akhCqngPQ7BBhDiPwEMa164SLVqKW3wu7tEzsrqvv1gyMbJIDh1DOuIYGgdUJ+Cfe7H1AeKswmL2hLV/msGrpZm9Pe+iR+GyVMb0YP6voPxAaiXs7ADqGunnHUsNKTmKFqf7JfxhDVQHSi+dglF9QbCRadYKPPyECdJs+vOVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mT9U5mBl; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=z28k/gh6; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 12 Jan 2026 08:03:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1768205004;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J3oK55V2PQYWiyqF26MXY6cjn2DwHpWfBFHI6yq16Xg=;
	b=mT9U5mBlXDYJWzQKAEq28iadmmcKmWwWCyJzjJkvJUo9sV0C1m3rXN6Esk9c0f5j61xzG1
	fYBwJgQGdfbtgMJl+ai+peI2FoEMqYECJmlG0xRXYfiBMC/idlVWm1j+1dVfsgfeaxs5ZV
	GlWew9sp2Z8Xzf2SCEak3kaaVGPnHIvalmrfieIByfc3uwmW9dXOg5ZKYvpblhLdfb38NK
	iusYYVoOEB8UDoSgobKPWnWjyXM5KsmQmbLynDyeyUUaZ/c8xf5uke+UKktRuAsC/g1CIn
	44FdBvI6B8b7j7pQ8VmCMp+eZY9WAaMmSq57aNKYVTFFQM3whXyu570QsgLHdQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1768205004;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J3oK55V2PQYWiyqF26MXY6cjn2DwHpWfBFHI6yq16Xg=;
	b=z28k/gh6voxyjV7vbQH5O0pUj2gcfotz//2eJLNGEqH/ERn+QCsGZ7psLFjsnSYxRQ9JKM
	H9ujOjfAuh4nSmDQ==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched: Further restrict the preemption modes
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Valentin Schneider <vschneid@redhat.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251219101502.GB1132199@noisy.programming.kicks-ass.net>
References: <20251219101502.GB1132199@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176820500332.510.37525067093416732.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     7dadeaa6e851e7d67733f3e24fc53ee107781d0f
Gitweb:        https://git.kernel.org/tip/7dadeaa6e851e7d67733f3e24fc53ee1077=
81d0f
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Thu, 18 Dec 2025 15:25:10 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 08 Jan 2026 12:43:57 +01:00

sched: Further restrict the preemption modes

The introduction of PREEMPT_LAZY was for multiple reasons:

  - PREEMPT_RT suffered from over-scheduling, hurting performance compared to
    !PREEMPT_RT.

  - the introduction of (more) features that rely on preemption; like
    folio_zero_user() which can do large memset() without preemption checks.

    (Xen already had a horrible hack to deal with long running hypercalls)

  - the endless and uncontrolled sprinkling of cond_resched() -- mostly cargo
    cult or in response to poor to replicate workloads.

By moving to a model that is fundamentally preemptable these things become
managable and avoid needing to introduce more horrible hacks.

Since this is a requirement; limit PREEMPT_NONE to architectures that do not
support preemption at all. Further limit PREEMPT_VOLUNTARY to those
architectures that do not yet have PREEMPT_LAZY support (with the eventual go=
al
to make this the empty set and completely remove voluntary preemption and
cond_resched() -- notably VOLUNTARY is already limited to !ARCH_NO_PREEMPT.)

This leaves up-to-date architectures (arm64, loongarch, powerpc, riscv, s390,
x86) with only two preemption models: full and lazy.

While Lazy has been the recommended setting for a while, not all distributions
have managed to make the switch yet. Force things along. Keep the patch minim=
al
in case of hard to address regressions that might pop up.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Valentin Schneider <vschneid@redhat.com>
Link: https://patch.msgid.link/20251219101502.GB1132199@noisy.programming.kic=
ks-ass.net
---
 kernel/Kconfig.preempt | 3 +++
 kernel/sched/core.c    | 2 +-
 kernel/sched/debug.c   | 2 +-
 3 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/kernel/Kconfig.preempt b/kernel/Kconfig.preempt
index da32680..88c594c 100644
--- a/kernel/Kconfig.preempt
+++ b/kernel/Kconfig.preempt
@@ -16,11 +16,13 @@ config ARCH_HAS_PREEMPT_LAZY
=20
 choice
 	prompt "Preemption Model"
+	default PREEMPT_LAZY if ARCH_HAS_PREEMPT_LAZY
 	default PREEMPT_NONE
=20
 config PREEMPT_NONE
 	bool "No Forced Preemption (Server)"
 	depends on !PREEMPT_RT
+	depends on ARCH_NO_PREEMPT
 	select PREEMPT_NONE_BUILD if !PREEMPT_DYNAMIC
 	help
 	  This is the traditional Linux preemption model, geared towards
@@ -35,6 +37,7 @@ config PREEMPT_NONE
=20
 config PREEMPT_VOLUNTARY
 	bool "Voluntary Kernel Preemption (Desktop)"
+	depends on !ARCH_HAS_PREEMPT_LAZY
 	depends on !ARCH_NO_PREEMPT
 	depends on !PREEMPT_RT
 	select PREEMPT_VOLUNTARY_BUILD if !PREEMPT_DYNAMIC
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 5b17d8e..fa72075 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -7553,7 +7553,7 @@ int preempt_dynamic_mode =3D preempt_dynamic_undefined;
=20
 int sched_dynamic_mode(const char *str)
 {
-# ifndef CONFIG_PREEMPT_RT
+# if !(defined(CONFIG_PREEMPT_RT) || defined(CONFIG_ARCH_HAS_PREEMPT_LAZY))
 	if (!strcmp(str, "none"))
 		return preempt_dynamic_none;
=20
diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index 41caa22..5f9b771 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -243,7 +243,7 @@ static ssize_t sched_dynamic_write(struct file *filp, con=
st char __user *ubuf,
=20
 static int sched_dynamic_show(struct seq_file *m, void *v)
 {
-	int i =3D IS_ENABLED(CONFIG_PREEMPT_RT) * 2;
+	int i =3D (IS_ENABLED(CONFIG_PREEMPT_RT) || IS_ENABLED(CONFIG_ARCH_HAS_PREE=
MPT_LAZY)) * 2;
 	int j;
=20
 	/* Count entries in NULL terminated preempt_modes */

