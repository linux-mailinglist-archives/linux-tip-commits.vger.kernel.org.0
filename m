Return-Path: <linux-tip-commits+bounces-4196-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D0485A5F4CC
	for <lists+linux-tip-commits@lfdr.de>; Thu, 13 Mar 2025 13:46:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6276F19C0EEC
	for <lists+linux-tip-commits@lfdr.de>; Thu, 13 Mar 2025 12:46:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3287324E010;
	Thu, 13 Mar 2025 12:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nE8ZX09V";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WTjyPNT/"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B716F1FAC50;
	Thu, 13 Mar 2025 12:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741869965; cv=none; b=uRhStAJGKFz1HuUfmhPV3fLdyJ2SPNGyPaup8jRfyEyu11NBe0SGqE5HUvi327lJO3Y6BJMJuk4/sZHZyadzJbY8gy4XSuqOQGpL3NcadTlwCkI26eA4GWJzjkQUl2H9t22mfhizcYHRoAfUHyTGwJCy5lTfNuuzk63hSRx+INo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741869965; c=relaxed/simple;
	bh=qxndFUZ0995ivdAeUKljJ+YX17oLEJ/3PqcdibEtKtU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=gHhGd0CF+W8LBzYFn0U8eyqKPoQVZBoiWxOU67s1Pb9EHQIBtov9IlhDkAKXIbUTurxe76rOsZDlJnvzPuX3n/KyFZfxBc0JqyIG2yUzlEuu8W3aWjI1KtzD10ugL2UfFpzLOMWQOyoecAIWdLzSvhB0E30feBEMfB8h83hDXkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nE8ZX09V; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WTjyPNT/; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 13 Mar 2025 12:45:56 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741869960;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Zm3G8ZcMlovMIdNEHfpSYw/oicmU1TDHVBDx0u1h0f8=;
	b=nE8ZX09Va8CDwFdwTcsrEmXWqSGiUoLdd2FDJsRh67rE5UN9OjaM28IXSDkeJKNwRd0lyU
	OLKbwD1QaUb+vvbFb/Z4Wj7tsZ7zAPGSNiYnpg71FaZ11OhFujq6J0fHoufynIa5fi4dWS
	qyyJlDlpkXJLaM5wnErsk86py6gysiOyRFVsBmI3qCt0De1XuGhU0PR2xx587szM5iDdUk
	sdZ2zGYeVwLZJ730r21DvwbSIPHfp0Y3Inb8bQwElqaacKZNfNVCMBXlf1lvzHB6Jq5hQ8
	s+ERgyrTDPDNpqPWmvISeI5/7Y5haFitSHffR4lMqlWaGtnnnkT55vFSxKI6hA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741869960;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Zm3G8ZcMlovMIdNEHfpSYw/oicmU1TDHVBDx0u1h0f8=;
	b=WTjyPNT/qRVHRErdGerEOPu7i49yCMuyGaIjyQsdBVop8n/lX7UZ4b/IVFjotI3O2YfEV4
	hmEGChLDtPopgGDw==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/msi] genirq/msi: Make a few functions static
Cc: Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250309084110.204054172@linutronix.de>
References: <20250309084110.204054172@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174186995610.14745.8917886531875410170.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/msi branch of tip:

Commit-ID:     537625233537179cb2e8293b2c0dc9c989363f41
Gitweb:        https://git.kernel.org/tip/537625233537179cb2e8293b2c0dc9c989363f41
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Sun, 09 Mar 2025 09:41:42 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 13 Mar 2025 13:35:33 +01:00

genirq/msi: Make a few functions static

None of these functions are used outside of the MSI core.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20250309084110.204054172@linutronix.de
---
 include/linux/msi.h |  5 -----
 kernel/irq/msi.c    | 40 +++++++---------------------------------
 2 files changed, 7 insertions(+), 38 deletions(-)

diff --git a/include/linux/msi.h b/include/linux/msi.h
index b10093c..df2dd63 100644
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -81,7 +81,6 @@ struct device_attribute;
 struct irq_domain;
 struct irq_affinity_desc;
 
-void __get_cached_msi_msg(struct msi_desc *entry, struct msi_msg *msg);
 #ifdef CONFIG_GENERIC_MSI_IRQ
 void get_cached_msi_msg(unsigned int irq, struct msi_msg *msg);
 #else
@@ -603,8 +602,6 @@ void msi_remove_device_irq_domain(struct device *dev, unsigned int domid);
 bool msi_match_device_irq_domain(struct device *dev, unsigned int domid,
 				 enum irq_domain_bus_token bus_token);
 
-int msi_domain_alloc_irqs_range_locked(struct device *dev, unsigned int domid,
-				       unsigned int first, unsigned int last);
 int msi_domain_alloc_irqs_range(struct device *dev, unsigned int domid,
 				unsigned int first, unsigned int last);
 int msi_domain_alloc_irqs_all_locked(struct device *dev, unsigned int domid, int nirqs);
@@ -613,8 +610,6 @@ struct msi_map msi_domain_alloc_irq_at(struct device *dev, unsigned int domid, u
 				       const struct irq_affinity_desc *affdesc,
 				       union msi_instance_cookie *cookie);
 
-void msi_domain_free_irqs_range_locked(struct device *dev, unsigned int domid,
-				       unsigned int first, unsigned int last);
 void msi_domain_free_irqs_range(struct device *dev, unsigned int domid,
 				unsigned int first, unsigned int last);
 void msi_domain_free_irqs_all_locked(struct device *dev, unsigned int domid);
diff --git a/kernel/irq/msi.c b/kernel/irq/msi.c
index fa92882..57e6421 100644
--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -270,16 +270,11 @@ fail:
 	return ret;
 }
 
-void __get_cached_msi_msg(struct msi_desc *entry, struct msi_msg *msg)
-{
-	*msg = entry->msg;
-}
-
 void get_cached_msi_msg(unsigned int irq, struct msi_msg *msg)
 {
 	struct msi_desc *entry = irq_get_msi_desc(irq);
 
-	__get_cached_msi_msg(entry, msg);
+	*msg = entry->msg;
 }
 EXPORT_SYMBOL_GPL(get_cached_msi_msg);
 
@@ -1352,21 +1347,17 @@ static int msi_domain_alloc_locked(struct device *dev, struct msi_ctrl *ctrl)
 }
 
 /**
- * msi_domain_alloc_irqs_range_locked - Allocate interrupts from a MSI interrupt domain
+ * msi_domain_alloc_irqs_range - Allocate interrupts from a MSI interrupt domain
  * @dev:	Pointer to device struct of the device for which the interrupts
  *		are allocated
  * @domid:	Id of the interrupt domain to operate on
  * @first:	First index to allocate (inclusive)
  * @last:	Last index to allocate (inclusive)
  *
- * Must be invoked from within a msi_lock_descs() / msi_unlock_descs()
- * pair. Use this for MSI irqdomains which implement their own descriptor
- * allocation/free.
- *
  * Return: %0 on success or an error code.
  */
-int msi_domain_alloc_irqs_range_locked(struct device *dev, unsigned int domid,
-				       unsigned int first, unsigned int last)
+int msi_domain_alloc_irqs_range(struct device *dev, unsigned int domid,
+				unsigned int first, unsigned int last)
 {
 	struct msi_ctrl ctrl = {
 		.domid	= domid,
@@ -1374,27 +1365,10 @@ int msi_domain_alloc_irqs_range_locked(struct device *dev, unsigned int domid,
 		.last	= last,
 		.nirqs	= last + 1 - first,
 	};
-
-	return msi_domain_alloc_locked(dev, &ctrl);
-}
-
-/**
- * msi_domain_alloc_irqs_range - Allocate interrupts from a MSI interrupt domain
- * @dev:	Pointer to device struct of the device for which the interrupts
- *		are allocated
- * @domid:	Id of the interrupt domain to operate on
- * @first:	First index to allocate (inclusive)
- * @last:	Last index to allocate (inclusive)
- *
- * Return: %0 on success or an error code.
- */
-int msi_domain_alloc_irqs_range(struct device *dev, unsigned int domid,
-				unsigned int first, unsigned int last)
-{
 	int ret;
 
 	msi_lock_descs(dev);
-	ret = msi_domain_alloc_irqs_range_locked(dev, domid, first, last);
+	ret = msi_domain_alloc_locked(dev, &ctrl);
 	msi_unlock_descs(dev);
 	return ret;
 }
@@ -1618,8 +1592,8 @@ static void msi_domain_free_locked(struct device *dev, struct msi_ctrl *ctrl)
  * @first:	First index to free (inclusive)
  * @last:	Last index to free (inclusive)
  */
-void msi_domain_free_irqs_range_locked(struct device *dev, unsigned int domid,
-				       unsigned int first, unsigned int last)
+static void msi_domain_free_irqs_range_locked(struct device *dev, unsigned int domid,
+					      unsigned int first, unsigned int last)
 {
 	struct msi_ctrl ctrl = {
 		.domid	= domid,

