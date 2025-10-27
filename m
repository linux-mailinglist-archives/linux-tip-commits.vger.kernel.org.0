Return-Path: <linux-tip-commits+bounces-7016-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A7930C0F53F
	for <lists+linux-tip-commits@lfdr.de>; Mon, 27 Oct 2025 17:34:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5DB844F4EED
	for <lists+linux-tip-commits@lfdr.de>; Mon, 27 Oct 2025 16:33:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28D9B31A541;
	Mon, 27 Oct 2025 16:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="du7xXIpL";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PCpszxFI"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89DB2319843;
	Mon, 27 Oct 2025 16:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761582675; cv=none; b=S9Z+etHB/RljZvcbGXXzcl0AGtuPhdqCmQ6PAU8NkySIclHDRt8rud38xQMuxfZqOYQn8ZoqsJaDuzbiMdcCqVIh+GaKZNE0Eq5et2L4Yg3fWSO1t6cFJ4/V56gmC3/9hKkRQ7e8N+T0QOd7s23u1NRH+SpU6g+oEmc/O+v26OA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761582675; c=relaxed/simple;
	bh=wfkwMS07BERdTGIX0T9f6j5A8Wa6UnPo+nlSDdLvVhI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=fTSSUui0Vs24dH1YJOEk4AtsCSikNeBteA/gpLFdEwrtNddIolZa5allRDdyk0pf4HQ99IQJ5nqKzExBUI+jwsK0b13y5Osi5TRzPDiD8PTe86QVeN9NzNxF3+/LNuC4rPrOML6Udl0WZR/8yN1wSsjNJN9K4SRuLcgWOFuwqak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=du7xXIpL; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PCpszxFI; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 27 Oct 2025 16:31:10 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761582671;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZxprvmLP/ABE9fqjUBVb4hpY/irVHpAPzKqnGZmbS2E=;
	b=du7xXIpL6+OnqGUWG+6PgR4Z0MMTLKXGtEVBgiM7n/Rail0dclz82F8JWsw7PRG1BtXwNf
	HoB1ebghooN2O6PXufincSWCrQ4QUQiujWjXDOBcqP+kw4dOW4R3li8NcWq1ONqwC27O7w
	XWfSgc59ObzLaTqA1y9ktbnuJa9E9uIwlWFWGP3irAhAKBU/IKsXt/RTtyk3RjWxdHRsEk
	4hJlrQ/uzUU7d777uEmBkCcDTnE9jxnU/EfuYZcEYpIlwES99q5Z8TXAohKnDhC51Wd372
	39DZdgKDve6OBXxnn4o1hdgcjlJJCC/7WPz7v+ZquW9jb54IvV5wn+Mq10hFHw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761582671;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZxprvmLP/ABE9fqjUBVb4hpY/irVHpAPzKqnGZmbS2E=;
	b=PCpszxFIo+VIC72vNNaQb4MikBnKqks1UYRuV4I+0ZEq2zuJr5BDC4QFC910T6dpDkUALq
	IpBUWksz0yBQWEAg==
From: "tip-bot2 for Marc Zyngier" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] genirq: Kill handle_percpu_devid_fasteoi_nmi()
Cc: Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251020122944.3074811-12-maz@kernel.org>
References: <20251020122944.3074811-12-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176158267026.2601451.10976746219017543671.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     5ff78c8de9d83ad6fc0553bf8f2edc816385837d
Gitweb:        https://git.kernel.org/tip/5ff78c8de9d83ad6fc0553bf8f2edc81638=
5837d
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Mon, 20 Oct 2025 13:29:28 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 27 Oct 2025 17:16:34 +01:00

genirq: Kill handle_percpu_devid_fasteoi_nmi()

There is no in-tree user of this flow handler anymore, so simply remove it.

Suggested-by: Will Deacon <will@kernel.org>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Will Deacon <will@kernel.org>
Link: https://patch.msgid.link/20251020122944.3074811-12-maz@kernel.org
---
 include/linux/irq.h |  1 -
 kernel/irq/chip.c   | 25 -------------------------
 2 files changed, 26 deletions(-)

diff --git a/include/linux/irq.h b/include/linux/irq.h
index c67e76f..b728c18 100644
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -655,7 +655,6 @@ extern void handle_bad_irq(struct irq_desc *desc);
 extern void handle_nested_irq(unsigned int irq);
=20
 extern void handle_fasteoi_nmi(struct irq_desc *desc);
-extern void handle_percpu_devid_fasteoi_nmi(struct irq_desc *desc);
=20
 extern int irq_chip_compose_msi_msg(struct irq_data *data, struct msi_msg *m=
sg);
 extern int irq_chip_pm_get(struct irq_data *data);
diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
index 3ffa0d8..633e1f6 100644
--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -929,31 +929,6 @@ void handle_percpu_devid_irq(struct irq_desc *desc)
 		chip->irq_eoi(&desc->irq_data);
 }
=20
-/**
- * handle_percpu_devid_fasteoi_nmi - Per CPU local NMI handler with per cpu
- *				     dev ids
- * @desc:	the interrupt description structure for this irq
- *
- * Similar to handle_fasteoi_nmi, but handling the dev_id cookie
- * as a percpu pointer.
- */
-void handle_percpu_devid_fasteoi_nmi(struct irq_desc *desc)
-{
-	struct irq_chip *chip =3D irq_desc_get_chip(desc);
-	struct irqaction *action =3D desc->action;
-	unsigned int irq =3D irq_desc_get_irq(desc);
-	irqreturn_t res;
-
-	__kstat_incr_irqs_this_cpu(desc);
-
-	trace_irq_handler_entry(irq, action);
-	res =3D action->handler(irq, raw_cpu_ptr(action->percpu_dev_id));
-	trace_irq_handler_exit(irq, action, res);
-
-	if (chip->irq_eoi)
-		chip->irq_eoi(&desc->irq_data);
-}
-
 static void
 __irq_do_set_handler(struct irq_desc *desc, irq_flow_handler_t handle,
 		     int is_chained, const char *name)

