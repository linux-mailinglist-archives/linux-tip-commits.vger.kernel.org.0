Return-Path: <linux-tip-commits+bounces-7393-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 516F9C6A4C2
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Nov 2025 16:26:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id 04CA62B5E1
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Nov 2025 15:26:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AC04364024;
	Tue, 18 Nov 2025 15:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NzoGMsKm";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BAaBpYxN"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2455359718;
	Tue, 18 Nov 2025 15:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763479604; cv=none; b=cW9fWt+yP05n9P2ZkCrM10AtqOtIbFSfm4JYWuHbbK00B1zx9SHQKtRGoXEb9govnHjF4iRLyMmD4rsO4vwL07W/SM4IuQK2rnP+u0WihlGDUnehjasoiZW3xoghX2NRooJ6rH6yuVqLjIyQHL1lj1U6K2tPQK7nit6I4vQbVWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763479604; c=relaxed/simple;
	bh=R98v1/aV1O3lYXH1bo1JWhEkIiN+jZpQopnsIPbrca4=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=X10AhQJhFy1ky9TSRx6KFtAAow79MlBGo074peu0/cZaQ/gKSt0lg9lZw9QVRnd/JINZhOicEcfpka+vXttPPJ6hV5SRYPlx3B63rYv6Q2dSpC866tXBTgBLbqzAlCJ89wqFEwDYyN77Qg7vFIc0nPlSl05g75qIgWw9/Eh1UBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NzoGMsKm; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BAaBpYxN; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 18 Nov 2025 15:26:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1763479601;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZwMcWxow73DaivKWigbTFAnQ0fHCl39cftk9B/wJH1k=;
	b=NzoGMsKm72zSST4f3Zb3uS7ARakeWbZ3NoLyEqPAJzqwMizBSh1Fi9qPdZRLESXA8jErQY
	57h+UQp7RurUyPCITrehcN8R0m7BGUiLwRw5dM/GbV27QOX1OK9L0ngRGpfBTsfrx3X1Zc
	Y0bZtiqpn1peJrmD69GMCvlKGMjPRu/8LAMVEIJroHVeKju9eWc6tXNEdEW8bOlQBANF0C
	NZTAdQkEh50ag15zTFV9eR3jHiK33hwjVPXVTbOSNj5bqG6KBqlRQX2IOWGUjOO9n1pVHz
	0DIbLy9/uQEeYClRTPWhVsvqJPRcsLM/UjxM7rJ54DVRENr6W4vfnTaqBa2erA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1763479601;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZwMcWxow73DaivKWigbTFAnQ0fHCl39cftk9B/wJH1k=;
	b=BAaBpYxNPm3jg+mQCL1HsiGckUI5xdG0yAtQSTGmcYoTLnt7QkU3KsWpyZjf9i6S5Ng0so
	zCA6SSS5/UvNI5CA==
From: "tip-bot2 for Frederic Weisbecker" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] genirq: Fix interrupt threads affinity vs. cpuset
 isolated partitions
Cc: Frederic Weisbecker <frederic@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20251118143052.68778-2-frederic@kernel.org>
References: <20251118143052.68778-2-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176347960014.498.6283912824750064104.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     844dcacab287a46862a244ed413df26ef77400a6
Gitweb:        https://git.kernel.org/tip/844dcacab287a46862a244ed413df26ef77=
400a6
Author:        Frederic Weisbecker <frederic@kernel.org>
AuthorDate:    Tue, 18 Nov 2025 15:30:51 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 18 Nov 2025 16:19:40 +01:00

genirq: Fix interrupt threads affinity vs. cpuset isolated partitions

When a cpuset isolated partition is created / updated or destroyed, the
interrupt threads are affine blindly to all the non-isolated CPUs. And this
happens without taking into account the interrupt threads initial affinity
that becomes ignored.

For example in a system with 8 CPUs, if an interrupt and its kthread are
initially affine to CPU 5, creating an isolated partition with only CPU 2
inside will eventually end up affining the interrupt kthread to all CPUs
but CPU 2 (that is CPUs 0,1,3-7), losing the kthread preference for CPU 5.

Besides the blind re-affinity, this doesn't take care of the actual low
level interrupt which isn't migrated. As of today the only way to isolate
non managed interrupts, along with their kthreads, is to overwrite their
affinity separately, for example through /proc/irq/

To avoid doing that manually, future development should focus on updating
the interrupt's affinity whenever cpuset isolated partitions are updated.

In the meantime, cpuset shouldn't fiddle with interrupt threads directly.
To prevent from that, set the PF_NO_SETAFFINITY flag to them.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://patch.msgid.link/20251118143052.68778-2-frederic@kernel.org
---
 kernel/irq/manage.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index c1ce30c..3c55805 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -176,7 +176,7 @@ bool irq_can_set_affinity_usr(unsigned int irq)
 }
=20
 /**
- * irq_set_thread_affinity - Notify irq threads to adjust affinity
+ * irq_thread_update_affinity - Notify irq threads to adjust affinity
  * @desc:	irq descriptor which has affinity changed
  *
  * Just set IRQTF_AFFINITY and delegate the affinity setting to the
@@ -184,7 +184,7 @@ bool irq_can_set_affinity_usr(unsigned int irq)
  * we hold desc->lock and this code can be called from hard interrupt
  * context.
  */
-static void irq_set_thread_affinity(struct irq_desc *desc)
+static void irq_thread_update_affinity(struct irq_desc *desc)
 {
 	struct irqaction *action;
=20
@@ -283,7 +283,7 @@ int irq_do_set_affinity(struct irq_data *data, const stru=
ct cpumask *mask,
 		fallthrough;
 	case IRQ_SET_MASK_OK_NOCOPY:
 		irq_validate_effective_affinity(data);
-		irq_set_thread_affinity(desc);
+		irq_thread_update_affinity(desc);
 		ret =3D 0;
 	}
=20
@@ -1035,8 +1035,16 @@ static void irq_thread_check_affinity(struct irq_desc =
*desc, struct irqaction *a
 		set_cpus_allowed_ptr(current, mask);
 	free_cpumask_var(mask);
 }
+
+static inline void irq_thread_set_affinity(struct task_struct *t,
+					   struct irq_desc *desc)
+{
+	kthread_bind_mask(t, irq_data_get_effective_affinity_mask(&desc->irq_data));
+}
 #else
 static inline void irq_thread_check_affinity(struct irq_desc *desc, struct i=
rqaction *action) { }
+static inline void irq_thread_set_affinity(struct task_struct *t,
+					   struct irq_desc *desc) { }
 #endif
=20
 static int irq_wait_for_interrupt(struct irq_desc *desc,
@@ -1221,6 +1229,7 @@ static void wake_up_and_wait_for_irq_thread_ready(struc=
t irq_desc *desc,
 	if (!action || !action->thread)
 		return;
=20
+	irq_thread_set_affinity(action->thread, desc);
 	wake_up_process(action->thread);
 	wait_event(desc->wait_for_threads,
 		   test_bit(IRQTF_READY, &action->thread_flags));
@@ -1408,16 +1417,7 @@ setup_irq_thread(struct irqaction *new, unsigned int i=
rq, bool secondary)
 	 * references an already freed task_struct.
 	 */
 	new->thread =3D get_task_struct(t);
-	/*
-	 * Tell the thread to set its affinity. This is
-	 * important for shared interrupt handlers as we do
-	 * not invoke setup_affinity() for the secondary
-	 * handlers as everything is already set up. Even for
-	 * interrupts marked with IRQF_NO_BALANCE this is
-	 * correct as we want the thread to move to the cpu(s)
-	 * on which the requesting code placed the interrupt.
-	 */
-	set_bit(IRQTF_AFFINITY, &new->thread_flags);
+
 	return 0;
 }
=20

