Return-Path: <linux-tip-commits+bounces-7455-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 107CEC7B9AB
	for <lists+linux-tip-commits@lfdr.de>; Fri, 21 Nov 2025 21:01:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD8903A67CC
	for <lists+linux-tip-commits@lfdr.de>; Fri, 21 Nov 2025 20:01:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD251302CA5;
	Fri, 21 Nov 2025 20:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="eRcC0HgG";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nGs2JmHa"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EF4430507B;
	Fri, 21 Nov 2025 20:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763755294; cv=none; b=PQhJN8suir0EunM8pMKecEWBlhMQHoVK+JDedJTL2wyTmFI3lK9Cc72frHJZBHvl48/K0IfvOLA7XS1uxTJUUHSm1XJB4QS8+G6MqPZbxQ78BKjlArmFTlKNWjrhuLX8dXz2CkSgR0QPjaMEFmOiDOGLrHFDtijBUXge0rbNiww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763755294; c=relaxed/simple;
	bh=ZCCPrGXA1+ZJDzn456dyBBrmBr1SNzaq3PKJjDG6Y4M=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=MNnKA1f45Vh4lTp4Zw11hFrn5EYGnYSJyylMsn9qvx3/5TbUp57iEa5Vyl0WwdW8SEODSG22sH4/2O8wvPD5vZ51xcbcHwKUP1wDRNHxSjP67DGvI/PXcDcx0/SglAMjw6TuYghyUDT6Shdin4K3+eC6Q4zJsHca2rZ3JjKgtf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=eRcC0HgG; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nGs2JmHa; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 21 Nov 2025 20:01:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1763755290;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gbIH4wV+EbTu8MYbfgKasTWchwv2wCCRNHQxSEervRs=;
	b=eRcC0HgGbHGc8+1Fm291Xma3NlvWARaaLHhz4tnqZJjhZJK12HImvRp+Y0sCXywYdrvQEO
	GPYnuqjnLH4oOf/hFANizatNAU8xztWZdHVPKKKG87OsV0paHEKsH9ynqbfv4tPGAeqdFX
	EhK0GMO98OH0rq9by7rABSSGFObvue9dqzwagVXEIt6dDgUm1fN45+5pa9zmfxaAehNyKh
	LRmRqRmV+lPtJSTH1naCX3ob1PY9o+/yIgMi5nIfLsxaoYNDcmWi51YyI6aG8iwjiv5dn5
	+Y4dMQb9ykX4ar3m+hx5wT9vPMh0+qbiSZlhvWhoEr7KqA0/p3xiai9dd9tkZQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1763755290;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gbIH4wV+EbTu8MYbfgKasTWchwv2wCCRNHQxSEervRs=;
	b=nGs2JmHafG7k674VASoAniUHgWRrPZlNAxTihDT6otu1s44VbNB/9cTgRmKV1KVgHQIjIN
	8yu/iU4bR+CZbzAg==
From: "tip-bot2 for Frederic Weisbecker" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] genirq: Fix interrupt threads affinity vs. cpuset
 isolated partitions
Cc: Thomas Gleixner <tglx@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20251121143500.42111-3-frederic@kernel.org>
References: <20251121143500.42111-3-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176375528915.498.18209596343505969827.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     71b89ad36c06603c093f04e142972d67c9272f14
Gitweb:        https://git.kernel.org/tip/71b89ad36c06603c093f04e142972d67c92=
72f14
Author:        Frederic Weisbecker <frederic@kernel.org>
AuthorDate:    Fri, 21 Nov 2025 15:34:59 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 21 Nov 2025 20:50:30 +01:00

genirq: Fix interrupt threads affinity vs. cpuset isolated partitions

When a cpuset isolated partition is created / updated or destroyed, the
interrupt threads are affined blindly to all the non-isolated CPUs. This
happens without taking into account the interrupt threads initial affinity
that becomes ignored.

For example in a system with 8 CPUs, if an interrupt and its kthread are
initially affine to CPU 5, creating an isolated partition with only CPU 2
inside will eventually end up affining the interrupt kthread to all CPUs
but CPU 2 (that is CPUs 0,1,3-7), losing the kthread preference for CPU 5.

Besides the blind re-affining, this doesn't take care of the actual low
level interrupt which isn't migrated. As of today the only way to isolate
non managed interrupts, along with their kthreads, is to overwrite their
affinity separately, for example through /proc/irq/

To avoid doing that manually, future development should focus on updating
the interrupt's affinity whenever cpuset isolated partitions are updated.

In the meantime, cpuset shouldn't fiddle with interrupt threads directly.
To prevent from that, set the PF_NO_SETAFFINITY flag to them.

This is done through kthread_bind_mask() by affining them initially to all
possible CPUs as at that point the interrupt is not started up which means
the affinity of the hard interrupt is not known. The thread will adjust
that once it reaches the handler, which is guaranteed to happen after the
initial affinity of the hard interrupt is established.

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://patch.msgid.link/20251121143500.42111-3-frederic@kernel.org
---
 kernel/irq/manage.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index c1ce30c..61da1c6 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -1408,16 +1408,23 @@ setup_irq_thread(struct irqaction *new, unsigned int =
irq, bool secondary)
 	 * references an already freed task_struct.
 	 */
 	new->thread =3D get_task_struct(t);
+
 	/*
-	 * Tell the thread to set its affinity. This is
-	 * important for shared interrupt handlers as we do
-	 * not invoke setup_affinity() for the secondary
-	 * handlers as everything is already set up. Even for
-	 * interrupts marked with IRQF_NO_BALANCE this is
-	 * correct as we want the thread to move to the cpu(s)
-	 * on which the requesting code placed the interrupt.
+	 * The affinity can not be established yet, but it will be once the
+	 * interrupt is enabled. Delay and defer the actual setting to the
+	 * thread itself once it is ready to run. In the meantime, prevent
+	 * it from ever being re-affined directly by cpuset or
+	 * housekeeping. The proper way to do it is to re-affine the whole
+	 * vector.
 	 */
-	set_bit(IRQTF_AFFINITY, &new->thread_flags);
+	kthread_bind_mask(t, cpu_possible_mask);
+
+	/*
+	 * Ensure the thread adjusts the affinity once it reaches the
+	 * thread function.
+	 */
+	new->thread_flags =3D BIT(IRQTF_AFFINITY);
+
 	return 0;
 }
=20

