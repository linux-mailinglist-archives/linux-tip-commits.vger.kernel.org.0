Return-Path: <linux-tip-commits+bounces-6934-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 71167BE3860
	for <lists+linux-tip-commits@lfdr.de>; Thu, 16 Oct 2025 14:56:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24B21584BF5
	for <lists+linux-tip-commits@lfdr.de>; Thu, 16 Oct 2025 12:55:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B964334381;
	Thu, 16 Oct 2025 12:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JvWRM/Ce";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0vdZHFVC"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F01D305E19;
	Thu, 16 Oct 2025 12:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760619344; cv=none; b=FKPnkFVjzkO0zfULcWAXJW7AzjcPahQAfEiodLpcRquhUUiQTWknYnUxgYG4lmSaIaxYilJtVKliIFo4hB6r5+BZZ+KMbwxKmhBXHMGJT8fV6FLDvCw9pxjKMgvhKqpQaTaNjJlwck/pI1YmbBhtebosZj+qX6GM/mpIpYP3blg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760619344; c=relaxed/simple;
	bh=P0U/lr6Z9iY0i2l+g+z5iLcyv25Jjl3+cs5qYQOESVA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=nC8vp3e8R5BiEJ/Da23zTKXsqogB9vZy6lGzL5HL+gh26pd7EkeEv1X8/z5NvYrg0Slo3DbSN6aJL0Dnzxt6/JgyXpqgEchD0VCZLoN5havI2EUN/cF3JXbTHBEFMGQiPpcHqkKREVrDyhynH+f5/ybmnyze24INicQyLnfBECc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JvWRM/Ce; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0vdZHFVC; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 16 Oct 2025 12:55:37 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1760619340;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GV1ENFZJgPTFlxaC4XEPMITdg/8LuhWsmg0rgytYDYs=;
	b=JvWRM/CerTIU4Y0MiRmtxVj4YXHW0L5GSlpqxMGnGuvXODYkggKyRiYOX81BytoazTxseV
	9DQ2Yk4ofCs3rDiUk/OWcOKv+4bdPC4X/zIlky2YDR8L6t55R4WLWDMPnvnHqiFT9HoRjj
	WDJljJpJ5JmBdrC6zWnK78s33Sl+mSRqIgkQRi9Alr9Z9iW+5NR3jFPU2IQwjnKIlXsclw
	iovaTCM7+zGo52YnOSk5Ck5nAK24w3HcneTijixodZxymdr9+XqJFWCGUNLmYfrC+I/8K7
	W8zZStylPLJjjaxDOXKtTCyD7MtKLYFwXhHIxTkRvGT2H6xF4lBqSK6LyeILcQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1760619340;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GV1ENFZJgPTFlxaC4XEPMITdg/8LuhWsmg0rgytYDYs=;
	b=0vdZHFVCGCPGmkd2dGgion8dKyW/kNKkDZZtcqzm5KZjVyQ+ON102Ykwq13EtVk/MG4L2X
	NiB/d1urffOZmgDg==
From: "tip-bot2 for Samuel Holland" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: irq/drivers] irqchip/riscv-imsic: Inline imsic_vector_from_local_id()
Cc: Samuel Holland <samuel.holland@sifive.com>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251015195712.3813004-4-samuel.holland@sifive.com>
References: <20251015195712.3813004-4-samuel.holland@sifive.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176061933780.709179.15480351186372683197.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the irq/drivers branch of tip:

Commit-ID:     45f8fdcfbf4e49075172cf1a3fd812b90160e903
Gitweb:        https://git.kernel.org/tip/45f8fdcfbf4e49075172cf1a3fd812b9016=
0e903
Author:        Samuel Holland <samuel.holland@sifive.com>
AuthorDate:    Wed, 15 Oct 2025 12:55:14 -07:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 16 Oct 2025 13:12:50 +02:00

irqchip/riscv-imsic: Inline imsic_vector_from_local_id()

This function is only called from one place, which is in the interrupt
handling hot path. Inline it to improve code generation and to take
advantage of this_cpu operations. lpriv and imsic->base_domain can never be
NULL because irq_set_chained_handler() is called after they are allocated.

Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 drivers/irqchip/irq-riscv-imsic-early.c | 11 +++--------
 drivers/irqchip/irq-riscv-imsic-state.c | 10 ----------
 drivers/irqchip/irq-riscv-imsic-state.h |  2 --
 3 files changed, 3 insertions(+), 20 deletions(-)

diff --git a/drivers/irqchip/irq-riscv-imsic-early.c b/drivers/irqchip/irq-ri=
scv-imsic-early.c
index 2c4c682..6bac67c 100644
--- a/drivers/irqchip/irq-riscv-imsic-early.c
+++ b/drivers/irqchip/irq-riscv-imsic-early.c
@@ -91,9 +91,8 @@ static int __init imsic_ipi_domain_init(void) { return 0; }
  */
 static void imsic_handle_irq(struct irq_desc *desc)
 {
+	struct imsic_local_priv *lpriv =3D this_cpu_ptr(imsic->lpriv);
 	struct irq_chip *chip =3D irq_desc_get_chip(desc);
-	int cpu =3D smp_processor_id();
-	struct imsic_vector *vec;
 	unsigned long local_id;
=20
 	/*
@@ -113,16 +112,12 @@ static void imsic_handle_irq(struct irq_desc *desc)
 			continue;
 		}
=20
-		if (unlikely(!imsic->base_domain))
-			continue;
-
-		vec =3D imsic_vector_from_local_id(cpu, local_id);
-		if (!vec) {
+		if (unlikely(local_id > imsic->global.nr_ids)) {
 			pr_warn_ratelimited("vector not found for local ID 0x%lx\n", local_id);
 			continue;
 		}
=20
-		generic_handle_irq(vec->irq);
+		generic_handle_irq(lpriv->vectors[local_id].irq);
 	}
=20
 	chained_irq_exit(chip, desc);
diff --git a/drivers/irqchip/irq-riscv-imsic-state.c b/drivers/irqchip/irq-ri=
scv-imsic-state.c
index 9a499ef..3853680 100644
--- a/drivers/irqchip/irq-riscv-imsic-state.c
+++ b/drivers/irqchip/irq-riscv-imsic-state.c
@@ -434,16 +434,6 @@ void imsic_vector_debug_show_summary(struct seq_file *m,=
 int ind)
 }
 #endif
=20
-struct imsic_vector *imsic_vector_from_local_id(unsigned int cpu, unsigned i=
nt local_id)
-{
-	struct imsic_local_priv *lpriv =3D per_cpu_ptr(imsic->lpriv, cpu);
-
-	if (!lpriv || imsic->global.nr_ids < local_id)
-		return NULL;
-
-	return &lpriv->vectors[local_id];
-}
-
 struct imsic_vector *imsic_vector_alloc(unsigned int irq, const struct cpuma=
sk *mask)
 {
 	struct imsic_vector *vec =3D NULL;
diff --git a/drivers/irqchip/irq-riscv-imsic-state.h b/drivers/irqchip/irq-ri=
scv-imsic-state.h
index 196457f..6332501 100644
--- a/drivers/irqchip/irq-riscv-imsic-state.h
+++ b/drivers/irqchip/irq-riscv-imsic-state.h
@@ -95,8 +95,6 @@ static inline struct imsic_vector *imsic_vector_get_move(st=
ruct imsic_vector *ve
 void imsic_vector_force_move_cleanup(struct imsic_vector *vec);
 void imsic_vector_move(struct imsic_vector *old_vec, struct imsic_vector *ne=
w_vec);
=20
-struct imsic_vector *imsic_vector_from_local_id(unsigned int cpu, unsigned i=
nt local_id);
-
 struct imsic_vector *imsic_vector_alloc(unsigned int irq, const struct cpuma=
sk *mask);
 void imsic_vector_free(struct imsic_vector *vector);
=20

