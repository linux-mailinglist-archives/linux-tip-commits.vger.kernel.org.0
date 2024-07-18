Return-Path: <linux-tip-commits+bounces-1709-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 99BF49351A8
	for <lists+linux-tip-commits@lfdr.de>; Thu, 18 Jul 2024 20:39:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E67C2B2295B
	for <lists+linux-tip-commits@lfdr.de>; Thu, 18 Jul 2024 18:39:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65B981459E9;
	Thu, 18 Jul 2024 18:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LsooWIU2";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xgWBsXnr"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B94F113AA26;
	Thu, 18 Jul 2024 18:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721327941; cv=none; b=pnfN+QkaWF2mL3S5YjMBdlW2z0xgioB9KbH6pl4nmnxdC8qLtWKu4QkSEB0ENTCtPZutDM1/189Lw4uXCgI1aJA7ILXwXg/Gc7l9eziPnmcYFK8ahknSMuu+WzP6uojniZH0SlbG6aGwl3jILAQ6iHuwQS/wBeM8dnzyJ0ef1Z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721327941; c=relaxed/simple;
	bh=PFDb0XaKxBxhrXVfo6QyDAgxkWL5BIEpWPe8hwEppwU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=qIyHpDknGxXjRSKtMozczGIH4OKx/rDhFIMDmwrZl+/fvwbu54f/BZcAJAkuD71D/WNWVthK/dxsHkyMxB4Sqjl26CpkuRNd8mNi683qRE+mSPqqRhYX5NDooqMkTiJRjt51kNvEym1lFcdBN7tr5ZuPgkchfn14vwfl7hX4kME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LsooWIU2; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xgWBsXnr; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 18 Jul 2024 18:38:57 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1721327938;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=d/2gB3MkmG3B8m+qHgJX7yPfsuQAY/c9dJKfACnbmW4=;
	b=LsooWIU2rffpdtzF7428lg4iNcLmkC4sR3U8k07fybT14lr83aP08bwZrZ9JBuAiqz2eNv
	XHrGJkX6O1ke+gy2MmsANpIDX3X9AWlQFzH49q+5mgp6I9czALLkHA09ov7F4JbjjAkF/G
	wJ/Wn+Hl7IBATnbkNlEmSEFYGYRCypb6JseVXFbFzyXAJ0QWs6pgI3eoEERBkOySinGfgJ
	Y0TKZshSZrOvzYxju5F0Jf3pfVQR1FZkfOLiINFdg9bGaAyUCW9Q9B1Qbl+OeA6wGJnEhY
	1ca+XwqybEN64igSf8xqLdmqm9D+ocPAVITpG/+kbeU07ATU5TGUOPIrn8SeGQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1721327938;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=d/2gB3MkmG3B8m+qHgJX7yPfsuQAY/c9dJKfACnbmW4=;
	b=xgWBsXnrAXUAC9C7AQVxyPikQQ2vL3ZNQUHnv/0eFCQS2U/QOpefIFBbNyFHr8GuRfPJtC
	To4LFJuqjAAY4DCA==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/msi] genirq/msi: Move msi_device_data to core
Cc: Thomas Gleixner <tglx@linutronix.de>,
 "Anna-Maria Behnsen" <anna-maria@linutronix.de>,
 Shivamurthy Shastri <shivamurthy.shastri@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240623142236.003295177@linutronix.de>
References: <20240623142236.003295177@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172132793781.2215.18117333031245077596.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/msi branch of tip:

Commit-ID:     2fdda02a8749fdaff5621c96aaf24a61d2f8c5a2
Gitweb:        https://git.kernel.org/tip/2fdda02a8749fdaff5621c96aaf24a61d2f8c5a2
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Sun, 23 Jun 2024 17:19:07 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 18 Jul 2024 20:31:21 +02:00

genirq/msi: Move msi_device_data to core

Now that the platform MSI hack is gone, nothing needs to know about struct
msi_device_data outside of the core code.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Signed-off-by: Shivamurthy Shastri <shivamurthy.shastri@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20240623142236.003295177@linutronix.de



---
 include/linux/msi.h | 18 ------------------
 kernel/irq/msi.c    | 20 ++++++++++++++++++--
 2 files changed, 18 insertions(+), 20 deletions(-)

diff --git a/include/linux/msi.h b/include/linux/msi.h
index 4c3462a..369367e 100644
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -21,11 +21,7 @@
 #include <linux/irqdomain_defs.h>
 #include <linux/cpumask.h>
 #include <linux/msi_api.h>
-#include <linux/xarray.h>
-#include <linux/mutex.h>
-#include <linux/list.h>
 #include <linux/irq.h>
-#include <linux/bits.h>
 
 #include <asm/msi.h>
 
@@ -227,20 +223,6 @@ struct msi_dev_domain {
 	struct irq_domain	*domain;
 };
 
-/**
- * msi_device_data - MSI per device data
- * @properties:		MSI properties which are interesting to drivers
- * @mutex:		Mutex protecting the MSI descriptor store
- * @__domains:		Internal data for per device MSI domains
- * @__iter_idx:		Index to search the next entry for iterators
- */
-struct msi_device_data {
-	unsigned long			properties;
-	struct mutex			mutex;
-	struct msi_dev_domain		__domains[MSI_MAX_DEVICE_IRQDOMAINS];
-	unsigned long			__iter_idx;
-};
-
 int msi_setup_device_data(struct device *dev);
 
 void msi_lock_descs(struct device *dev);
diff --git a/kernel/irq/msi.c b/kernel/irq/msi.c
index 8314b1d..5fa0547 100644
--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -8,18 +8,34 @@
  * This file contains common code to support Message Signaled Interrupts for
  * PCI compatible and non PCI compatible devices.
  */
-#include <linux/types.h>
 #include <linux/device.h>
 #include <linux/irq.h>
 #include <linux/irqdomain.h>
 #include <linux/msi.h>
+#include <linux/mutex.h>
+#include <linux/pci.h>
 #include <linux/slab.h>
 #include <linux/sysfs.h>
-#include <linux/pci.h>
+#include <linux/types.h>
+#include <linux/xarray.h>
 
 #include "internals.h"
 
 /**
+ * struct msi_device_data - MSI per device data
+ * @properties:		MSI properties which are interesting to drivers
+ * @mutex:		Mutex protecting the MSI descriptor store
+ * @__domains:		Internal data for per device MSI domains
+ * @__iter_idx:		Index to search the next entry for iterators
+ */
+struct msi_device_data {
+	unsigned long			properties;
+	struct mutex			mutex;
+	struct msi_dev_domain		__domains[MSI_MAX_DEVICE_IRQDOMAINS];
+	unsigned long			__iter_idx;
+};
+
+/**
  * struct msi_ctrl - MSI internal management control structure
  * @domid:	ID of the domain on which management operations should be done
  * @first:	First (hardware) slot index to operate on

