Return-Path: <linux-tip-commits+bounces-7711-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 203B2CBFF82
	for <lists+linux-tip-commits@lfdr.de>; Mon, 15 Dec 2025 22:38:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6740830562CC
	for <lists+linux-tip-commits@lfdr.de>; Mon, 15 Dec 2025 21:35:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 446A732F74B;
	Mon, 15 Dec 2025 21:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sv5aK5pO";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ezr+Opig"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D4EF32E6AA;
	Mon, 15 Dec 2025 21:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765834037; cv=none; b=WavT/UvqP1VBVX6teeonxbyt+HjrkiqKmbmxyYTrmbgoRH8HFsGuemkNfZlOa0YkkgUfG0yTsC4YcP59Bqml2cXRdunrt6UVLSWQRUdLe+8vBecMr5xAyI0QLpV1RA51o/n8/N7prz4pz2UYnzGNVDifpaj8hVS903iGERsAYEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765834037; c=relaxed/simple;
	bh=Lkbn4bs0l5F6QA7CrhOLtVA1FocRE5t+gWUh77/hQWk=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=bOqp9ukn/0nQx6P/6OZ+kPsGUt016e1FVfBfl26p19Z1PJoQ35Pi6N6o7qJo6yNW/v21Ddgiho2LpysMOq/NqUes7ntbB/QEQg/YDvn1hq7cFAB4Vui65o8EQheEqre06BApVIEX8dpksJCA1Se6T2+XaThmYzJb9m8120j/Dt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sv5aK5pO; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ezr+Opig; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 15 Dec 2025 21:27:12 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1765834033;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3HVMCSiQIlnVB9WOT5KyhqwemzIiXpLbdzblDlmQCvs=;
	b=sv5aK5pO127BWwXzHRhQTvcRdnPfDP+I8E0yUMhqZhwE2SZmFqHGnQvZ7sZkhnWzAUzPIg
	86+5ZRZNZLqBZb4IeO4vJbQarIOQOkuEs+NjRkTsEUGssSO8kRmvCCXoJd/1wPyPR6kDT/
	OSPMftT0MqLEOuwOFjbtIV7ElRgD+QvOuzRe5RggsWcTXJ9JFct4ZsoUQyUuFNMCGlY6VL
	U/BD624ZKvMtLY8yPnkOHeKvU6Su4dMuP8ilgAI/uaZcQNRsnhFDnuc2jP3sfT2diW5GyH
	iiPBOB4Cj8X8PG5nAWlYdMWxcahjt25RaqEj82tpuV4+SwBLz6UvRuqXiT/wHw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1765834033;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3HVMCSiQIlnVB9WOT5KyhqwemzIiXpLbdzblDlmQCvs=;
	b=ezr+OpigYhSlsiC5Tx5iF8HXZpZVw6HKbFtXcAjVtMpgLSXtUPe0zRsa8zOfd9HZWI3HEr
	LYoAZOuS2chnhHDw==
From: "tip-bot2 for Marc Zyngier" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] genirq: Remove __request_percpu_irq() helper
Cc: Marc Zyngier <maz@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Jinjie Ruan <ruanjinjie@huawei.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251210082242.360936-3-maz@kernel.org>
References: <20251210082242.360936-3-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176583403273.510.18431899926615679614.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     e9b624ea31cc957b3a7798f89c20a80a8cbb0b73
Gitweb:        https://git.kernel.org/tip/e9b624ea31cc957b3a7798f89c20a80a8cb=
b0b73
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Wed, 10 Dec 2025 08:22:38=20
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 15 Dec 2025 22:20:50 +01:00

genirq: Remove __request_percpu_irq() helper

With the IRQ timing stuff being gone, there is no need to specify a flag
when requesting a percpu interrupt. Not only IRQF_TIMER was the only flag
(set of flags actually) allowed, but nobody ever passed it.

Get rid of __request_percpu_irq(), which was only getting 0 as flags, and
promote request_percpu_irq_affinity() as its replacement.

Signed-off-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Jinjie Ruan <ruanjinjie@huawei.com>
Link: https://patch.msgid.link/20251210082242.360936-3-maz@kernel.org
---
 include/linux/interrupt.h | 18 ++++--------------
 kernel/irq/manage.c       | 15 +++++----------
 2 files changed, 9 insertions(+), 24 deletions(-)

diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
index 44e335b..00c01b0 100644
--- a/include/linux/interrupt.h
+++ b/include/linux/interrupt.h
@@ -181,9 +181,8 @@ request_any_context_irq(unsigned int irq, irq_handler_t h=
andler,
 			unsigned long flags, const char *name, void *dev_id);
=20
 extern int __must_check
-__request_percpu_irq(unsigned int irq, irq_handler_t handler,
-		     unsigned long flags, const char *devname,
-		     const cpumask_t *affinity, void __percpu *percpu_dev_id);
+request_percpu_irq_affinity(unsigned int irq, irq_handler_t handler, const c=
har *devname,
+			    const cpumask_t *affinity, void __percpu *percpu_dev_id);
=20
 extern int __must_check
 request_nmi(unsigned int irq, irq_handler_t handler, unsigned long flags,
@@ -193,17 +192,8 @@ static inline int __must_check
 request_percpu_irq(unsigned int irq, irq_handler_t handler,
 		   const char *devname, void __percpu *percpu_dev_id)
 {
-	return __request_percpu_irq(irq, handler, 0,
-				    devname, NULL, percpu_dev_id);
-}
-
-static inline int __must_check
-request_percpu_irq_affinity(unsigned int irq, irq_handler_t handler,
-			    const char *devname, const cpumask_t *affinity,
-			    void __percpu *percpu_dev_id)
-{
-	return __request_percpu_irq(irq, handler, 0,
-				    devname, affinity, percpu_dev_id);
+	return request_percpu_irq_affinity(irq, handler, devname,
+					   NULL, percpu_dev_id);
 }
=20
 extern int __must_check
diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index 7b25ffc..4d0b326 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -2510,10 +2510,9 @@ struct irqaction *create_percpu_irqaction(irq_handler_=
t handler, unsigned long f
 }
=20
 /**
- * __request_percpu_irq - allocate a percpu interrupt line
+ * request_percpu_irq_affinity - allocate a percpu interrupt line
  * @irq:	Interrupt line to allocate
  * @handler:	Function to be called when the IRQ occurs.
- * @flags:	Interrupt type flags (IRQF_TIMER only)
  * @devname:	An ascii name for the claiming device
  * @affinity:	A cpumask describing the target CPUs for this interrupt
  * @dev_id:	A percpu cookie passed back to the handler function
@@ -2526,9 +2525,8 @@ struct irqaction *create_percpu_irqaction(irq_handler_t=
 handler, unsigned long f
  * the handler gets called with the interrupted CPU's instance of
  * that variable.
  */
-int __request_percpu_irq(unsigned int irq, irq_handler_t handler,
-			 unsigned long flags, const char *devname,
-			 const cpumask_t *affinity, void __percpu *dev_id)
+int request_percpu_irq_affinity(unsigned int irq, irq_handler_t handler, con=
st char *devname,
+				const cpumask_t *affinity, void __percpu *dev_id)
 {
 	struct irqaction *action;
 	struct irq_desc *desc;
@@ -2542,10 +2540,7 @@ int __request_percpu_irq(unsigned int irq, irq_handler=
_t handler,
 	    !irq_settings_is_per_cpu_devid(desc))
 		return -EINVAL;
=20
-	if (flags && flags !=3D IRQF_TIMER)
-		return -EINVAL;
-
-	action =3D create_percpu_irqaction(handler, flags, devname, affinity, dev_i=
d);
+	action =3D create_percpu_irqaction(handler, 0, devname, affinity, dev_id);
 	if (!action)
 		return -ENOMEM;
=20
@@ -2564,7 +2559,7 @@ int __request_percpu_irq(unsigned int irq, irq_handler_=
t handler,
=20
 	return retval;
 }
-EXPORT_SYMBOL_GPL(__request_percpu_irq);
+EXPORT_SYMBOL_GPL(request_percpu_irq_affinity);
=20
 /**
  * request_percpu_nmi - allocate a percpu interrupt line for NMI delivery

