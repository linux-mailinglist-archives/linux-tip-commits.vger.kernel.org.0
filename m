Return-Path: <linux-tip-commits+bounces-7710-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4355ACBFF94
	for <lists+linux-tip-commits@lfdr.de>; Mon, 15 Dec 2025 22:40:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C9661307A580
	for <lists+linux-tip-commits@lfdr.de>; Mon, 15 Dec 2025 21:35:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E25632E72B;
	Mon, 15 Dec 2025 21:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3lIEajBx";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="/OEo5j1l"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A1A732D7D3;
	Mon, 15 Dec 2025 21:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765834035; cv=none; b=pRaiu43+FjLVCVziIyZSOXQ0HMGpvl9ucATyaqj75tc1THPzCXfiyBAsFcbTsj3+6CbWW3UcpOiv8sruEPIDG3xGNfWr3bXC2GBQfJzeOHM1EU5IEwH+bEmTIBir9kXqjmZwpoQV+vrknjGZdKHNaivdUo9Merx4ezmXOzRbRas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765834035; c=relaxed/simple;
	bh=R2YWif0zTvtpEjpsrID8vSozwKeWgYvKGQYsQzhaLfc=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=qla8uXWSG9MnJ99vaiqpT4uFvSRtUZEQBpjdUUvnOBPqk5TRDgc1DHyoR2uCW0VcVobVtpUM84RRJj2SLO8XWiORlpgnMXVkrG89n6cEkrj4xlTaLnfT/rojqwuv61DCS73M625u1vIRYMefyteS4Gy+hvCf0BPmif5VhBfTCQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3lIEajBx; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=/OEo5j1l; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 15 Dec 2025 21:27:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1765834032;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z6zj7LzYaYyiek5QTjH8fyMfZJ30xpQULzHTUMr8Cmg=;
	b=3lIEajBxfXpSsiel9W1SaQD7IkoIP+neqvryyzg8FR2owIAfDBUkiSpxbmEs62G4OEkRN0
	hSDrPlRL4/WagAiSpSTv4WpG7VJF0csoD1dxE29EOUmk9lB518MKeDpD2RHbG7SExMwtoD
	iJjMuYiNshzFPtwLk0I7ajfO0W7G3YlcMJd1ZsWFMXO/tDsNQ2gNaSR1mYAnfQrf1uWEaJ
	awXpaP8b1nwNO8PGjY+64tWIIKhIhAabGFXq+k3AyJyAES3VEcPebL/+33n9TzK8+abq6a
	rGZpD1nfbw6iy+0s0aUbIZwj6pYsrXJAtzDjkPHG3+Ll7LuOAX1XM59Ezu98Gg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1765834032;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z6zj7LzYaYyiek5QTjH8fyMfZJ30xpQULzHTUMr8Cmg=;
	b=/OEo5j1lOURtjEiE61/DEo6KuXfmgTVQthK3HNUKk8Rp9Xvxy+2iWvYoC+H9f6RWEoFj3j
	SU/Z44whs+xm+RCg==
From: "tip-bot2 for Marc Zyngier" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] MIPS: Move IP30 timer to request_percpu_irq()
Cc: Marc Zyngier <maz@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20251210082242.360936-4-maz@kernel.org>
References: <20251210082242.360936-4-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176583403166.510.4061205270950577166.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     a1eaca410a3cf533f8005d2959a7a8d9d8979f3e
Gitweb:        https://git.kernel.org/tip/a1eaca410a3cf533f8005d2959a7a8d9d89=
79f3e
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Wed, 10 Dec 2025 08:22:39=20
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 15 Dec 2025 22:20:50 +01:00

MIPS: Move IP30 timer to request_percpu_irq()

Teach the SGI IP30 timer about request_percpu_irq(), which ultimately will
allow for the removal of the antiquated setup_percpu_irq() API.

Signed-off-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://patch.msgid.link/20251210082242.360936-4-maz@kernel.org
---
 arch/mips/include/asm/cevt-r4k.h |  1 -
 arch/mips/kernel/cevt-r4k.c      | 11 -----------
 arch/mips/sgi-ip30/ip30-timer.c  |  5 ++---
 3 files changed, 2 insertions(+), 15 deletions(-)

diff --git a/arch/mips/include/asm/cevt-r4k.h b/arch/mips/include/asm/cevt-r4=
k.h
index 2e13a03..5229eb3 100644
--- a/arch/mips/include/asm/cevt-r4k.h
+++ b/arch/mips/include/asm/cevt-r4k.h
@@ -23,7 +23,6 @@ void mips_event_handler(struct clock_event_device *dev);
 int c0_compare_int_usable(void);
 irqreturn_t c0_compare_interrupt(int, void *);
=20
-extern struct irqaction c0_compare_irqaction;
 extern int cp0_timer_irq_installed;
=20
 #endif /* __ASM_CEVT_R4K_H */
diff --git a/arch/mips/kernel/cevt-r4k.c b/arch/mips/kernel/cevt-r4k.c
index 5f6e9e2..f58325f 100644
--- a/arch/mips/kernel/cevt-r4k.c
+++ b/arch/mips/kernel/cevt-r4k.c
@@ -159,17 +159,6 @@ irqreturn_t c0_compare_interrupt(int irq, void *dev_id)
 	return IRQ_NONE;
 }
=20
-struct irqaction c0_compare_irqaction =3D {
-	.handler =3D c0_compare_interrupt,
-	/*
-	 * IRQF_SHARED: The timer interrupt may be shared with other interrupts
-	 * such as perf counter and FDC interrupts.
-	 */
-	.flags =3D IRQF_PERCPU | IRQF_TIMER | IRQF_SHARED,
-	.name =3D "timer",
-};
-
-
 void mips_event_handler(struct clock_event_device *dev)
 {
 }
diff --git a/arch/mips/sgi-ip30/ip30-timer.c b/arch/mips/sgi-ip30/ip30-timer.c
index 7652f72..294e1f7 100644
--- a/arch/mips/sgi-ip30/ip30-timer.c
+++ b/arch/mips/sgi-ip30/ip30-timer.c
@@ -52,11 +52,10 @@ void __init plat_time_init(void)
 	int irq =3D get_c0_compare_int();
=20
 	cp0_timer_irq_installed =3D 1;
-	c0_compare_irqaction.percpu_dev_id =3D &mips_clockevent_device;
-	c0_compare_irqaction.flags &=3D ~IRQF_SHARED;
 	irq_set_handler(irq, handle_percpu_devid_irq);
 	irq_set_percpu_devid(irq);
-	setup_percpu_irq(irq, &c0_compare_irqaction);
+	WARN_ON(request_percpu_irq(irq, c0_compare_interrupt,
+				   "timer", &mips_clockevent_device));
 	enable_percpu_irq(irq, IRQ_TYPE_NONE);
=20
 	ip30_heart_clocksource_init();

