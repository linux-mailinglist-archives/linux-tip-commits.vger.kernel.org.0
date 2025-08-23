Return-Path: <linux-tip-commits+bounces-6323-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CC36B32B61
	for <lists+linux-tip-commits@lfdr.de>; Sat, 23 Aug 2025 19:51:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50B3058797D
	for <lists+linux-tip-commits@lfdr.de>; Sat, 23 Aug 2025 17:51:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B95FF213E89;
	Sat, 23 Aug 2025 17:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QH2jvMs6";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="z1fbEupo"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3429A14B977;
	Sat, 23 Aug 2025 17:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755971457; cv=none; b=MajZd+jeIxN+ggIh6GtJ5L4+Tj2kymRd8GQPiFPMUlkA7t6LCwuGzX7Z4Gp/qfykd4yLAsMpaqdfr0Sd9+kXQSW4OZwiMexwanv016PgBCbp1GHpDZYi2ulSzqLHH60WD14PjOPdtNrDyVbV4Z9ZLRchUnATyH+JivqBrAd1Rpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755971457; c=relaxed/simple;
	bh=txzlLeYiPpB99xDmZQRsO/J4/cTOU3DJxupm2sLARdQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=bLpBttRLYCBwcIaund7Rj0KDnkFoSL/ggoj+lJxvlrU3Lb87D6VCFBhhXPbUPhoRX6HAPgbC3MK5rmR367vgZh2zK1LfiKR/JBgjmVbKzyqJBLiv2FYTcIPmOR+gFdAvMXphEPslPOEJZY2fspevW9FsmRm87WDKmwcM40TK3lE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QH2jvMs6; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=z1fbEupo; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 23 Aug 2025 17:50:48 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1755971452;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Uc4K79MJ5uZqd7GnSFfTQgT4k222vGcOr7FsmAft/Eg=;
	b=QH2jvMs6gP5deJ+ScfdK1O6G6IwMKSQUBow6DYzZMIgQ5oENCvp+AHs3V7HrHwPXfJf//i
	JSHfXBL2d253r6+4GvZz9hh5SSB2vegMYKwyLSktYVq81taFu4K+FXFXJTnrbYzP+PmhyF
	ELSvqJv9fQayjlHyi+dQaeEKu9cEm9VyOPrJjtqQfmvemMqw6vYZJ0/ObOAqpmDUFNdVfa
	RTtJ/Aot5UwhOwpcOBa4jwrlmSqMhE5mrq7ni6sD3Sg54MLC0yYKR5rgf4J7JgqkkjVDNA
	PJo0KIz/T5t2UI2luSyazUBjp5xKQdVbMfFBuU6rRyblEM9qIyGE8ZA//PQY+Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1755971452;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Uc4K79MJ5uZqd7GnSFfTQgT4k222vGcOr7FsmAft/Eg=;
	b=z1fbEupo7x3gYMz6sGIRD73EG/bNOXWjYWwQdiUsTlYK5tLQ7Au80zA/gm6Dy7T0BOU51U
	rvqhQh9ywnFqLbDQ==
From: "tip-bot2 for Sebastian Andrzej Siewior" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] genirq: Remove GENERIC_IRQ_LEGACY
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20250814165949.hvtP03r4@linutronix.de>
References: <20250814165949.hvtP03r4@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175597144887.1420.4853522268284047883.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     3c716487936aa54083c130d46ad5747769695e09
Gitweb:        https://git.kernel.org/tip/3c716487936aa54083c130d46ad57477696=
95e09
Author:        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate:    Thu, 14 Aug 2025 18:59:49 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sat, 23 Aug 2025 19:46:04 +02:00

genirq: Remove GENERIC_IRQ_LEGACY

IA64 is gone and with it the last GENERIC_IRQ_LEGACY user.

Remove GENERIC_IRQ_LEGACY.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20250814165949.hvtP03r4@linutronix.de

---
 include/linux/irq.h  | 4 ----
 kernel/irq/Kconfig   | 4 ----
 kernel/irq/irqdesc.c | 7 -------
 3 files changed, 15 deletions(-)

diff --git a/include/linux/irq.h b/include/linux/irq.h
index 1d6b606..c9bcdbf 100644
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -976,10 +976,6 @@ static inline void irq_free_desc(unsigned int irq)
 	irq_free_descs(irq, 1);
 }
=20
-#ifdef CONFIG_GENERIC_IRQ_LEGACY
-void irq_init_desc(unsigned int irq);
-#endif
-
 /**
  * struct irq_chip_regs - register offsets for struct irq_gci
  * @enable:	Enable register offset to reg_base
diff --git a/kernel/irq/Kconfig b/kernel/irq/Kconfig
index 1da5e9d..3667364 100644
--- a/kernel/irq/Kconfig
+++ b/kernel/irq/Kconfig
@@ -6,10 +6,6 @@ menu "IRQ subsystem"
 config MAY_HAVE_SPARSE_IRQ
        bool
=20
-# Legacy support, required for itanic
-config GENERIC_IRQ_LEGACY
-       bool
-
 # Enable the generic irq autoprobe mechanism
 config GENERIC_IRQ_PROBE
 	bool
diff --git a/kernel/irq/irqdesc.c b/kernel/irq/irqdesc.c
index b64c57b..db714d3 100644
--- a/kernel/irq/irqdesc.c
+++ b/kernel/irq/irqdesc.c
@@ -653,13 +653,6 @@ void irq_mark_irq(unsigned int irq)
 	irq_insert_desc(irq, irq_desc + irq);
 }
=20
-#ifdef CONFIG_GENERIC_IRQ_LEGACY
-void irq_init_desc(unsigned int irq)
-{
-	free_desc(irq);
-}
-#endif
-
 #endif /* !CONFIG_SPARSE_IRQ */
=20
 int handle_irq_desc(struct irq_desc *desc)

