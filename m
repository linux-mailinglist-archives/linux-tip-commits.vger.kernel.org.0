Return-Path: <linux-tip-commits+bounces-2016-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DFF7694C109
	for <lists+linux-tip-commits@lfdr.de>; Thu,  8 Aug 2024 17:24:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A66B3284ADA
	for <lists+linux-tip-commits@lfdr.de>; Thu,  8 Aug 2024 15:24:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D9CD192B83;
	Thu,  8 Aug 2024 15:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Uw9V5Rks";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="690/5mNq"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38736191F9D;
	Thu,  8 Aug 2024 15:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723130511; cv=none; b=jEelSieFeAFCX+8cmEWd62EOhO5rgPRyoV0gBKjNTD7Er6Wo7VgsuVYS6Mk4JNKLjQrVZK/jzkIQuxaAoNux+nLIfjFz72RWycZTbJ6OpCPbax4Ko4dchDXFcYpY8BG+PJwHaYyxJvYyXneFL94Dq9gkXc/wFl6/DEnzr8DFOqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723130511; c=relaxed/simple;
	bh=ZjKrxyOqozoGabv+vmtXQMi4QvO0qrFpgpNvqNi/dzQ=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=OapVr4i/JPTAMdfpewA477m63t6d/IqkLhzPgOR2AALTp2dHJflgwW1AvQa6zYp62oy95ddwhudGbWwg6eQPo3zdDZDGeePFgrXmmQq0ZwPUyI5pAZtYw6kKtIRnRzoA/ekzq8oFxkJ3PpfrRe4sA+NdP3mdH8HfyGy1Lf6OBys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Uw9V5Rks; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=690/5mNq; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 08 Aug 2024 15:21:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1723130507;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=RufXN+h3k32UhBLiBxP7Fq2VxEHTGofOtYYZC44mn98=;
	b=Uw9V5Rks7Bsqu2pRjAeoR/LnpokiQ2A/oIHiIgC3g6c++A+IP9swa5EazpkO+oQ9Dq1RfP
	wkiSVj+ImD9i2Ca6nZftvmvkNGFyqFZdzfl9jUvNKhuB3zv/DQ3iYlGR0bMSv3QigGit2h
	f+Jwo28Ry4eSVcN2n0oiOJ8JTJ1dRFszKhdTc6aTP9XvZCvSVXu82MpFwz5bJYU7LHCngG
	kG3g1jLSAsCfB3q2MATaJAFcn7sDTDjx9Y2Mh631lNglf5leLhS17Pq5ByasaOg7ql40sh
	2KDNQMqdX8bK80+P/bewHiyFIfQEqapb7n8YoZReAPukQs9Bmud4h3L/4mQx9A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1723130507;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=RufXN+h3k32UhBLiBxP7Fq2VxEHTGofOtYYZC44mn98=;
	b=690/5mNqsgCgi5lzES4PG6mfE8Vkw22v0RJBf+rRAAvqSZNAyfuxHRVqATCCH6/exOksaw
	7c1sOg9oG+Q6EqCg==
From: tip-bot2 for Marek =?utf-8?q?Beh=C3=BAn?= <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] irqchip/armada-370-xp: Drop IPI_DOORBELL_START and
 rename IPI_DOORBELL_END
Cc: kabel@kernel.org, Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org, maz@kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172313050690.2215.69881915655707659.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     3431392d5e8a7d420c06048260d521c1dd08e931
Gitweb:        https://git.kernel.org/tip/3431392d5e8a7d420c06048260d521c1dd0=
8e931
Author:        Marek Beh=C3=BAn <kabel@kernel.org>
AuthorDate:    Wed, 07 Aug 2024 18:40:53 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 08 Aug 2024 17:15:00 +02:00

irqchip/armada-370-xp: Drop IPI_DOORBELL_START and rename IPI_DOORBELL_END

Drop IPI_DOORBELL_START since it is not used and rename IPI_DOORBELL_END
to IPI_DOORBELL_NR.

Signed-off-by: Marek Beh=C3=BAn <kabel@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

---
 drivers/irqchip/irq-armada-370-xp.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/irqchip/irq-armada-370-xp.c b/drivers/irqchip/irq-armada=
-370-xp.c
index b11612a..9a431d0 100644
--- a/drivers/irqchip/irq-armada-370-xp.c
+++ b/drivers/irqchip/irq-armada-370-xp.c
@@ -136,8 +136,7 @@
 #define MPIC_MAX_PER_CPU_IRQS			28
=20
 /* IPI and MSI interrupt definitions for IPI platforms */
-#define IPI_DOORBELL_START			0
-#define IPI_DOORBELL_END			8
+#define IPI_DOORBELL_NR				8
 #define IPI_DOORBELL_MASK			GENMASK(7, 0)
 #define PCI_MSI_DOORBELL_START			16
 #define PCI_MSI_DOORBELL_NR			16
@@ -452,7 +451,7 @@ static const struct irq_domain_ops mpic_ipi_domain_ops =
=3D {
=20
 static void mpic_ipi_resume(void)
 {
-	for (irq_hw_number_t i =3D 0; i < IPI_DOORBELL_END; i++) {
+	for (irq_hw_number_t i =3D 0; i < IPI_DOORBELL_NR; i++) {
 		unsigned int virq =3D irq_find_mapping(mpic_ipi_domain, i);
 		struct irq_data *d;
=20
@@ -468,17 +467,17 @@ static __init int mpic_ipi_init(struct device_node *nod=
e)
 {
 	int base_ipi;
=20
-	mpic_ipi_domain =3D irq_domain_create_linear(of_node_to_fwnode(node), IPI_D=
OORBELL_END,
+	mpic_ipi_domain =3D irq_domain_create_linear(of_node_to_fwnode(node), IPI_D=
OORBELL_NR,
 						   &mpic_ipi_domain_ops, NULL);
 	if (WARN_ON(!mpic_ipi_domain))
 		return -ENOMEM;
=20
 	irq_domain_update_bus_token(mpic_ipi_domain, DOMAIN_BUS_IPI);
-	base_ipi =3D irq_domain_alloc_irqs(mpic_ipi_domain, IPI_DOORBELL_END, NUMA_=
NO_NODE, NULL);
+	base_ipi =3D irq_domain_alloc_irqs(mpic_ipi_domain, IPI_DOORBELL_NR, NUMA_N=
O_NODE, NULL);
 	if (WARN_ON(!base_ipi))
 		return -ENOMEM;
=20
-	set_smp_ipi_range(base_ipi, IPI_DOORBELL_END);
+	set_smp_ipi_range(base_ipi, IPI_DOORBELL_NR);
=20
 	return 0;
 }
@@ -627,7 +626,7 @@ static void mpic_handle_ipi_irq(void)
 	cause =3D readl_relaxed(per_cpu_int_base + MPIC_IN_DRBEL_CAUSE);
 	cause &=3D IPI_DOORBELL_MASK;
=20
-	for_each_set_bit(i, &cause, IPI_DOORBELL_END)
+	for_each_set_bit(i, &cause, IPI_DOORBELL_NR)
 		generic_handle_domain_irq(mpic_ipi_domain, i);
 }
 #else

