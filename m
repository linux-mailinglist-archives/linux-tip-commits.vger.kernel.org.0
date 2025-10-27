Return-Path: <linux-tip-commits+bounces-7023-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 19915C0F5B7
	for <lists+linux-tip-commits@lfdr.de>; Mon, 27 Oct 2025 17:37:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A438189664E
	for <lists+linux-tip-commits@lfdr.de>; Mon, 27 Oct 2025 16:35:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2620B31D756;
	Mon, 27 Oct 2025 16:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zs0wGgKI";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QqkNVD/A"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5899F31D381;
	Mon, 27 Oct 2025 16:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761582684; cv=none; b=k20Tgjm/IZsHkBsCq+aE/rjeUdMSiCsnC4TWwlug2Tq4pP/jIKS6LYNgWMBZkbJlK6pOKC+NAgWbfBpE+uaAfcBvOCqvrDE6CG3sTOqPfbm6qLNjLtosis8zm1ydwapPb8DqQ4w3xhNzwQDm1Ow+sElYw6i5gG9+Ntoxr6OE3YQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761582684; c=relaxed/simple;
	bh=PKwuQ7Jv6l8/chybfg4pcWmUOgaPel3Uq4CN+eeOTOA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Zh/F58eKOyDRq2ldHhU3AYW9FfQtscDzp2f9cX947WpIT8YXiBQmKb+m3PKDEwWmjZdVjVo5pngJl7PsZyPbsnouKHiSHTxQhyjMAH2S3+3PTC1mfYn98zFLmaO/Y8v9hUS1QZtVvDaUFYFkPL50FbrXsBZ4NSzYWHTOhFZJ2Qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zs0wGgKI; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QqkNVD/A; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 27 Oct 2025 16:31:18 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761582680;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1GPCNC80BLWnZERPVAk9jla+BYjSinaPNgooEuH3Xg8=;
	b=zs0wGgKIPHAwkQXyfE1Bi+6ZgWH3DLyRqQF2r5sEQYMt3Ls9i07ZMQtCGg3bLoX5tTDPp7
	hvpnhomnYtJfY8OqYt8ItN4Byz1MpPDFTJPGkwHpFpD5ogRmzG66arS4OIf31WiwZ5nMld
	FX7MrMKs7rowBQoF7zveIWttGpD7CtCBZWM/cshjAs1RuL3fCndFqNKwFmEGkpI5wWuZNu
	ih2485U8rN+PMaeSOhcMbTBHhnb4s/9W7UKIoSXM/jFYrVLYAya9r4CgpdcNvtOXh/Q/gd
	y0hgFAbhZhAlrzwS9Uy98Zs/+bomQPBfS8W35ZBmtm4LCaO9S75ArFlQStgurw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761582680;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1GPCNC80BLWnZERPVAk9jla+BYjSinaPNgooEuH3Xg8=;
	b=QqkNVD/An89ubY6GrqO/7WilLQgtf1jUhuvCz41nkk5LmP4LSWXq1zB3cIbP2xefrFEGx1
	C0KTxkDuk/OWItBQ==
From: "tip-bot2 for Marc Zyngier" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] platform: Add firmware-agnostic irq and affinity
 retrieval interface
Cc: Marc Zyngier <maz@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Will Deacon <will@kernel.org>, Jonathan Cameron <jonathan.cameron@huawei.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20251020122944.3074811-5-maz@kernel.org>
References: <20251020122944.3074811-5-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176158267889.2601451.2164762950459031449.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     0d5daa938c94b8b9183e9b257a88dc0929d59409
Gitweb:        https://git.kernel.org/tip/0d5daa938c94b8b9183e9b257a88dc0929d=
59409
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Mon, 20 Oct 2025 13:29:21 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 27 Oct 2025 17:16:32 +01:00

platform: Add firmware-agnostic irq and affinity retrieval interface

Expand platform_get_irq_optional() to also return an affinity if available,
renaming it to platform_get_irq_affinity() in the process.

platform_get_irq_optional() is preserved with its current semantics by
calling into the new helper with a NULL affinity pointer.

Signed-off-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Will Deacon <will@kernel.org>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Link: https://patch.msgid.link/20251020122944.3074811-5-maz@kernel.org
---
 drivers/base/platform.c         | 71 +++++++++++++++++++++++++-------
 include/linux/platform_device.h |  2 +-
 2 files changed, 58 insertions(+), 15 deletions(-)

diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index 0945034..b45d41b 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -150,25 +150,37 @@ devm_platform_ioremap_resource_byname(struct platform_d=
evice *pdev,
 EXPORT_SYMBOL_GPL(devm_platform_ioremap_resource_byname);
 #endif /* CONFIG_HAS_IOMEM */
=20
+static const struct cpumask *get_irq_affinity(struct platform_device *dev,
+					      unsigned int num)
+{
+	const struct cpumask *mask =3D NULL;
+#ifndef CONFIG_SPARC
+	struct fwnode_handle *fwnode =3D dev_fwnode(&dev->dev);
+
+	if (is_of_node(fwnode))
+		mask =3D of_irq_get_affinity(to_of_node(fwnode), num);
+	else if (is_acpi_device_node(fwnode))
+		mask =3D acpi_irq_get_affinity(ACPI_HANDLE_FWNODE(fwnode), num);
+#endif
+
+	return mask ?: cpu_possible_mask;
+}
+
 /**
- * platform_get_irq_optional - get an optional IRQ for a device
- * @dev: platform device
- * @num: IRQ number index
+ * platform_get_irq_affinity - get an optional IRQ and its affinity for a de=
vice
+ * @dev:	platform device
+ * @num:	interrupt number index
+ * @affinity:	optional cpumask pointer to get the affinity of a per-cpu inte=
rrupt
  *
- * Gets an IRQ for a platform device. Device drivers should check the return
- * value for errors so as to not pass a negative integer value to the
- * request_irq() APIs. This is the same as platform_get_irq(), except that it
- * does not print an error message if an IRQ can not be obtained.
- *
- * For example::
- *
- *		int irq =3D platform_get_irq_optional(pdev, 0);
- *		if (irq < 0)
- *			return irq;
+ * Gets an interupt for a platform device. Device drivers should check the
+ * return value for errors so as to not pass a negative integer value to
+ * the request_irq() APIs. Optional affinity information is provided in the
+ * affinity pointer if available, and NULL otherwise.
  *
- * Return: non-zero IRQ number on success, negative error number on failure.
+ * Return: non-zero interrupt number on success, negative error number on fa=
ilure.
  */
-int platform_get_irq_optional(struct platform_device *dev, unsigned int num)
+int platform_get_irq_affinity(struct platform_device *dev, unsigned int num,
+			      const struct cpumask **affinity)
 {
 	int ret;
 #ifdef CONFIG_SPARC
@@ -236,8 +248,37 @@ out_not_found:
 out:
 	if (WARN(!ret, "0 is an invalid IRQ number\n"))
 		return -EINVAL;
+
+	if (ret > 0 && affinity)
+		*affinity =3D get_irq_affinity(dev, num);
+
 	return ret;
 }
+EXPORT_SYMBOL_GPL(platform_get_irq_affinity);
+
+/**
+ * platform_get_irq_optional - get an optional interrupt for a device
+ * @dev:	platform device
+ * @num:	interrupt number index
+ *
+ * Gets an interrupt for a platform device. Device drivers should check the
+ * return value for errors so as to not pass a negative integer value to
+ * the request_irq() APIs. This is the same as platform_get_irq(), except
+ * that it does not print an error message if an interrupt can not be
+ * obtained.
+ *
+ * For example::
+ *
+ *		int irq =3D platform_get_irq_optional(pdev, 0);
+ *		if (irq < 0)
+ *			return irq;
+ *
+ * Return: non-zero interrupt number on success, negative error number on fa=
ilure.
+ */
+int platform_get_irq_optional(struct platform_device *dev, unsigned int num)
+{
+	return platform_get_irq_affinity(dev, num, NULL);
+}
 EXPORT_SYMBOL_GPL(platform_get_irq_optional);
=20
 /**
diff --git a/include/linux/platform_device.h b/include/linux/platform_device.h
index 074754c..ad66333 100644
--- a/include/linux/platform_device.h
+++ b/include/linux/platform_device.h
@@ -102,6 +102,8 @@ devm_platform_ioremap_resource_byname(struct platform_dev=
ice *pdev,
=20
 extern int platform_get_irq(struct platform_device *, unsigned int);
 extern int platform_get_irq_optional(struct platform_device *, unsigned int);
+extern int platform_get_irq_affinity(struct platform_device *, unsigned int,
+				     const struct cpumask **);
 extern int platform_irq_count(struct platform_device *);
 extern int devm_platform_get_irqs_affinity(struct platform_device *dev,
 					   struct irq_affinity *affd,

