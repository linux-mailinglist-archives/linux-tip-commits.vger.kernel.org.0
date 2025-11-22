Return-Path: <linux-tip-commits+bounces-7460-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DEA9DC7CAC1
	for <lists+linux-tip-commits@lfdr.de>; Sat, 22 Nov 2025 09:30:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8DA584E0672
	for <lists+linux-tip-commits@lfdr.de>; Sat, 22 Nov 2025 08:30:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3357E26F2A1;
	Sat, 22 Nov 2025 08:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pJEXyT44";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3wGD+MuV"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56CF436D516;
	Sat, 22 Nov 2025 08:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763800250; cv=none; b=BbQn1jUVysoZLMARED8kWCOilmNxPScns4bgWfb+GDskeiekide4L3MVArt93sexCy5EOJ407UhWxRvcmswyNLrTzD3XPHTJtmCiGO3JyGycWm7eo+CBbSZMCd0Q4qMoVHqNb9u0HHPU1Z7m24F+oC6BoKlnUzXqrAgRxBguNiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763800250; c=relaxed/simple;
	bh=C59sB4AjlHj82XJY9ggl6tsZvCN8T7e52VxxNjXlZaU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=cdEPdryi3nq4sPoWy7p2Rie2d0DScIeh3qp/JIOdi0zc56iNhbioWuXVn8baABr+JaEPSHwSt94E1c3yAH3odrsep2ngfcND4E7BvmHmWQ4kvgcnsXwrwf0HlgZdq1sL3hGNcKaHtkwB6jLCHEiDs2NnvqRdBAg5sFsC61/Li10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pJEXyT44; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3wGD+MuV; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 22 Nov 2025 08:30:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1763800245;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CIAAi7j+p/zFv3nFPrtMnkI+DsRBbiyOtP1jOjpFd6A=;
	b=pJEXyT44iNQN2bNemNCC5zqjmuRE3u4gR0VVmMbmjjEKOf5J5O6Ioi8/nqO/YN4nYbArlX
	qegbv1LdkSqYc4qUQy4ISqKDHVtec4O8Y/ODYv5Th+BusHiiZ6es3BBiFpDeYoudZblctW
	0GiHGDrD4QGLeiXWt1mjBw6KBMsur/PIbHYtHmauz9zqkNEf+3mflqnkvb/0Lp1eNGqGpP
	SkqIW+J3WpJXL+OGOAQ5TwpE76LBdVs5f/IRUegyAXOK0o1B/56JKefPYsNTVD7obTmgf0
	v+pWqoCHyfTERBR4nc5quW9y5B9lUPWN8jm7JRm7/ermgvxF+x6UG1yuJxLdFQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1763800245;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CIAAi7j+p/zFv3nFPrtMnkI+DsRBbiyOtP1jOjpFd6A=;
	b=3wGD+MuVBLUAlcD3Caz8Vht1Sy9niC2ehLbS3u9+8Q/L8kyejiFot4BtLsG4I7JC73GHFV
	9eTXFAyPSL3Z7hBg==
From: "tip-bot2 for Frederic Weisbecker" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] genirq: Fix interrupt threads affinity vs. cpuset
 isolated partitions
Cc: Thomas Gleixner <tglx@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>, Ingo Molnar <mingo@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20251121143500.42111-3-frederic@kernel.org>
References: <20251121143500.42111-3-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176380024448.498.12563041798827142550.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     801afdfbfcd90ff62a4b2469bbda1d958f7a5353
Gitweb:        https://git.kernel.org/tip/801afdfbfcd90ff62a4b2469bbda1d958f7=
a5353
Author:        Frederic Weisbecker <frederic@kernel.org>
AuthorDate:    Fri, 21 Nov 2025 15:34:59 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sat, 22 Nov 2025 09:26:18 +01:00

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
Signed-off-by: Ingo Molnar <mingo@kernel.org>
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

