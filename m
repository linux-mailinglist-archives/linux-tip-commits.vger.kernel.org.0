Return-Path: <linux-tip-commits+bounces-6335-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 191C4B32F3B
	for <lists+linux-tip-commits@lfdr.de>; Sun, 24 Aug 2025 13:06:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C91751B263BB
	for <lists+linux-tip-commits@lfdr.de>; Sun, 24 Aug 2025 11:06:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D972F27D786;
	Sun, 24 Aug 2025 11:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mCXKFmUM";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uMdUT4VD"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A4AE257836;
	Sun, 24 Aug 2025 11:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756033581; cv=none; b=Sbv4X06mhayBG0rSmKyO4SSYGYlVkX4X3gKyY+qnDisJ3oQwP27J5/h3NJ34cBEO1RrYtmhM/J2ZeaBeoDSlsFI5ozwRlmNnjeQRlO5GzPospfgOvNkEwUpjxILP38C3nUmtJGelK4429Ly7htNWVqsK0mfKDP8dBBrZWJlKXnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756033581; c=relaxed/simple;
	bh=84KNwSgXjJkOaHAuv0Q93GPY0XaATXyaEz1gETvBZho=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Nl7cZqKBUz7DEENAfpv2rcyPzybMgPoaUS1lyNeQZUM/q3vjF9WlwII0bLH2g+ngeUtIJPx7T9I9As9mN7r0AtFnQnPuONuRykyoIepntMDtgh2qM+IIAQgtM/kYShYT5zFgqhh16STa9OM4UAaCYs/RjnC2vSHCMD3aRVD2LlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mCXKFmUM; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uMdUT4VD; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sun, 24 Aug 2025 11:06:15 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1756033577;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MXWvizYW2qL44uYnYLB+P86tlHlv+1VAjG3QXoA2Abc=;
	b=mCXKFmUMonnPnEytWeHahoNl/i0w6bPyTu3I8zOy/DOugiM7jko/xtJfg2mEZKYY7qQciU
	XHD0jwayQz9jVkNW+QxG3QMnvgTH3RenNf/ZwduNzIz1437xQ/El57atFrvMzOlLJl+u1N
	2f2u3kARB8lUaR2M2XZa90PnXv0WwTI2Bnfx4Z7uzJ3afKEWD/okY6nSq6rQZ0zMbOvwfV
	36HEVJE7VCl4Dr+k3TysG6/23i0hoOVT/G7a4lJYocBVvPlfZ/ddbpDkap0IRYtiDhbdOt
	gTYOO++DrfJfSa79UbNKjXBLfgB9BuN6OMcHdCPdKdbObCY7o/PNZWKUkyCbig==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1756033577;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MXWvizYW2qL44uYnYLB+P86tlHlv+1VAjG3QXoA2Abc=;
	b=uMdUT4VDuu5pr6EkzpHLk46BzDcXhtgQ64IDsuZ4LgpG/gvDcqtTRfLcsPlAB4nmb8jAmW
	Fhm+w/fDcq/47ODA==
From: "tip-bot2 for Pan Chuang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: irq/core] genirq/devres: Add error handling in devm_request_*_irq()
Cc: Yangtao Li <frank.li@vivo.com>, Pan Chuang <panchuang@vivo.com>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20250805092922.135500-2-panchuang@vivo.com>
References: <20250805092922.135500-2-panchuang@vivo.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175603357604.1420.7104360767892405362.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     55b48e23f5c4b6f5ca9b7ab09599b17dcf501c10
Gitweb:        https://git.kernel.org/tip/55b48e23f5c4b6f5ca9b7ab09599b17dcf5=
01c10
Author:        Pan Chuang <panchuang@vivo.com>
AuthorDate:    Tue, 05 Aug 2025 17:29:22 +08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sun, 24 Aug 2025 13:00:45 +02:00

genirq/devres: Add error handling in devm_request_*_irq()

devm_request_threaded_irq() and devm_request_any_context_irq() currently
don't print any error message when interrupt registration fails.

This forces each driver to implement redundant error logging - over 2,000
lines of error messages exist across drivers. Additionally, when
upper-layer functions propagate these errors without logging, critical
debugging information is lost.

Add devm_request_result() helper to unify error reporting via dev_err_probe(),

Use it in devm_request_threaded_irq() and devm_request_any_context_irq()
printing device name, IRQ number, handler functions, and error code on failure
automatically.

Co-developed-by: Yangtao Li <frank.li@vivo.com>
Signed-off-by: Yangtao Li <frank.li@vivo.com>
Signed-off-by: Pan Chuang <panchuang@vivo.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20250805092922.135500-2-panchuang@vivo.com

---
 kernel/irq/devres.c | 127 +++++++++++++++++++++++++++++--------------
 1 file changed, 87 insertions(+), 40 deletions(-)

diff --git a/kernel/irq/devres.c b/kernel/irq/devres.c
index eb16a58..b411886 100644
--- a/kernel/irq/devres.c
+++ b/kernel/irq/devres.c
@@ -30,29 +30,22 @@ static int devm_irq_match(struct device *dev, void *res, =
void *data)
 	return this->irq =3D=3D match->irq && this->dev_id =3D=3D match->dev_id;
 }
=20
-/**
- *	devm_request_threaded_irq - allocate an interrupt line for a managed devi=
ce
- *	@dev: device to request interrupt for
- *	@irq: Interrupt line to allocate
- *	@handler: Function to be called when the IRQ occurs
- *	@thread_fn: function to be called in a threaded interrupt context. NULL
- *		    for devices which handle everything in @handler
- *	@irqflags: Interrupt type flags
- *	@devname: An ascii name for the claiming device, dev_name(dev) if NULL
- *	@dev_id: A cookie passed back to the handler function
- *
- *	Except for the extra @dev argument, this function takes the
- *	same arguments and performs the same function as
- *	request_threaded_irq().  IRQs requested with this function will be
- *	automatically freed on driver detach.
- *
- *	If an IRQ allocated with this function needs to be freed
- *	separately, devm_free_irq() must be used.
- */
-int devm_request_threaded_irq(struct device *dev, unsigned int irq,
-			      irq_handler_t handler, irq_handler_t thread_fn,
-			      unsigned long irqflags, const char *devname,
-			      void *dev_id)
+static int devm_request_result(struct device *dev, int rc, unsigned int irq,
+			       irq_handler_t handler, irq_handler_t thread_fn,
+			       const char *devname)
+{
+	if (rc >=3D 0)
+		return rc;
+
+	return dev_err_probe(dev, rc, "request_irq(%u) %ps %ps %s\n",
+			     irq, handler, thread_fn, devname ? : "");
+}
+
+static int __devm_request_threaded_irq(struct device *dev, unsigned int irq,
+				       irq_handler_t handler,
+				       irq_handler_t thread_fn,
+				       unsigned long irqflags,
+				       const char *devname, void *dev_id)
 {
 	struct irq_devres *dr;
 	int rc;
@@ -78,28 +71,48 @@ int devm_request_threaded_irq(struct device *dev, unsigne=
d int irq,
=20
 	return 0;
 }
-EXPORT_SYMBOL(devm_request_threaded_irq);
=20
 /**
- *	devm_request_any_context_irq - allocate an interrupt line for a managed d=
evice
- *	@dev: device to request interrupt for
- *	@irq: Interrupt line to allocate
- *	@handler: Function to be called when the IRQ occurs
- *	@irqflags: Interrupt type flags
- *	@devname: An ascii name for the claiming device, dev_name(dev) if NULL
- *	@dev_id: A cookie passed back to the handler function
+ * devm_request_threaded_irq - allocate an interrupt line for a managed devi=
ce with error logging
+ * @dev:	Device to request interrupt for
+ * @irq:	Interrupt line to allocate
+ * @handler:	Function to be called when the interrupt occurs
+ * @thread_fn:	Function to be called in a threaded interrupt context. NULL
+ *		for devices which handle everything in @handler
+ * @irqflags:	Interrupt type flags
+ * @devname:	An ascii name for the claiming device, dev_name(dev) if NULL
+ * @dev_id:	A cookie passed back to the handler function
  *
- *	Except for the extra @dev argument, this function takes the
- *	same arguments and performs the same function as
- *	request_any_context_irq().  IRQs requested with this function will be
- *	automatically freed on driver detach.
+ * Except for the extra @dev argument, this function takes the same
+ * arguments and performs the same function as request_threaded_irq().
+ * Interrupts requested with this function will be automatically freed on
+ * driver detach.
+ *
+ * If an interrupt allocated with this function needs to be freed
+ * separately, devm_free_irq() must be used.
+ *
+ * When the request fails, an error message is printed with contextual
+ * information (device name, interrupt number, handler functions and
+ * error code). Don't add extra error messages at the call sites.
  *
- *	If an IRQ allocated with this function needs to be freed
- *	separately, devm_free_irq() must be used.
+ * Return: 0 on success or a negative error number.
  */
-int devm_request_any_context_irq(struct device *dev, unsigned int irq,
-			      irq_handler_t handler, unsigned long irqflags,
-			      const char *devname, void *dev_id)
+int devm_request_threaded_irq(struct device *dev, unsigned int irq,
+			      irq_handler_t handler, irq_handler_t thread_fn,
+			      unsigned long irqflags, const char *devname,
+			      void *dev_id)
+{
+	int rc =3D __devm_request_threaded_irq(dev, irq, handler, thread_fn,
+					     irqflags, devname, dev_id);
+
+	return devm_request_result(dev, rc, irq, handler, thread_fn, devname);
+}
+EXPORT_SYMBOL(devm_request_threaded_irq);
+
+static int __devm_request_any_context_irq(struct device *dev, unsigned int i=
rq,
+					  irq_handler_t handler,
+					  unsigned long irqflags,
+					  const char *devname, void *dev_id)
 {
 	struct irq_devres *dr;
 	int rc;
@@ -124,6 +137,40 @@ int devm_request_any_context_irq(struct device *dev, uns=
igned int irq,
=20
 	return rc;
 }
+
+/**
+ * devm_request_any_context_irq - allocate an interrupt line for a managed d=
evice with error logging
+ * @dev:	Device to request interrupt for
+ * @irq:	Interrupt line to allocate
+ * @handler:	Function to be called when the interrupt occurs
+ * @irqflags:	Interrupt type flags
+ * @devname:	An ascii name for the claiming device, dev_name(dev) if NULL
+ * @dev_id:	A cookie passed back to the handler function
+ *
+ * Except for the extra @dev argument, this function takes the same
+ * arguments and performs the same function as request_any_context_irq().
+ * Interrupts requested with this function will be automatically freed on
+ * driver detach.
+ *
+ * If an interrupt allocated with this function needs to be freed
+ * separately, devm_free_irq() must be used.
+ *
+ * When the request fails, an error message is printed with contextual
+ * information (device name, interrupt number, handler functions and
+ * error code). Don't add extra error messages at the call sites.
+ *
+ * Return: IRQC_IS_HARDIRQ or IRQC_IS_NESTED on success, or a negative error
+ * number.
+ */
+int devm_request_any_context_irq(struct device *dev, unsigned int irq,
+				 irq_handler_t handler, unsigned long irqflags,
+				 const char *devname, void *dev_id)
+{
+	int rc =3D __devm_request_any_context_irq(dev, irq, handler, irqflags,
+						devname, dev_id);
+
+	return devm_request_result(dev, rc, irq, handler, NULL, devname);
+}
 EXPORT_SYMBOL(devm_request_any_context_irq);
=20
 /**

