Return-Path: <linux-tip-commits+bounces-1650-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B7CE92D653
	for <lists+linux-tip-commits@lfdr.de>; Wed, 10 Jul 2024 18:27:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46F291F2251A
	for <lists+linux-tip-commits@lfdr.de>; Wed, 10 Jul 2024 16:27:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21753198838;
	Wed, 10 Jul 2024 16:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PbRp6qdL";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="5HSQZ4CO"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76CC9197A98;
	Wed, 10 Jul 2024 16:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720628751; cv=none; b=cczG5A+6G6mx2vNQhmKL8jGT9ksTL9lVTvbVh49SVslKutpEB7IT9HIEYPQhVCSnNRLrv/PqC7oHQm0oBJiRBmJQAZ7Zhp8IOS+D3MTuX6ns6pLwXPAv+1tt8j5oAdjNpB5cUdg9cjUXIwEq880N/tYL+qA4/0eEgCK7xm1ovsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720628751; c=relaxed/simple;
	bh=0Y3qj22e3K0Kld/CSwEMsIfsu+pYTEwJ30pYP1Ut7Qs=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=BKTGknakl0YEi/VcLayUl3EJorUdx4RA6l4cGkkwJj+FoGh0f0flbmqTXfempHXOMaPjLL4ha7kEIbjalZruEQMwAK+AHreDIH/ZKQEhHqY2x3JK+0Sbr6/9QONEi+oqfJ9ZBOCP2OeB6bIjTybMDOrs4MC6If7EQTdrdzv5X80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PbRp6qdL; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=5HSQZ4CO; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 10 Jul 2024 16:25:47 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1720628747;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Wov75W8cNcEkslzXNFqxcW80J5yMpATb+DrvpwwgSrQ=;
	b=PbRp6qdLsqsufIft30TaOesJHYBS0stu0G1SAYfUlZi5/Mo/6W8LTSUDfQeXnqxNvpZTkL
	E5EUNtn4Vravvy+jE64YzTcuCtS1yj6795kMPIcaPOGZ1fmKE6jCv7R6a7XFvCWGUKpMqN
	kaVgfmplTZUCHwOrtY8c2d1oeUBniC/vymfIrvbX/P12GPXA9/xLYJlj8u+VHSe2DbEKk1
	6PPIvia6eJIele2QcUDryQyf4Yol+NK3QKAZfErlPwcYg0A+YNGe912s3lE4BgmiyVftZ6
	ULtTp/UEzMn2+ZfDwov4yavOxDaKy1qp4IR2ICuzlDq4w7GYZAGFk6EWHVZvWg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1720628747;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Wov75W8cNcEkslzXNFqxcW80J5yMpATb+DrvpwwgSrQ=;
	b=5HSQZ4CO3j3VhpcWY0bnKzJy7EzrYRJbNO6a5wbc1U8tjdDgSGGBmy1zO4aa+O2qcPHRm4
	3V267rwvFRITIAAw==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] genirq/msi: Move msi_device_data to core
Cc: Thomas Gleixner <tglx@linutronix.de>,
 "Anna-Maria Behnsen" <anna-maria@linutronix.de>,
 Shivamurthy Shastri <shivamurthy.shastri@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20240623142236.003295177@linutronix.de>
References: <20240623142236.003295177@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172062874725.2215.17361933640926007842.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     ccde7dc94768b4777402247e1cabb58c2b00f495
Gitweb:        https://git.kernel.org/tip/ccde7dc94768b4777402247e1cabb58c2b00f495
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Sun, 23 Jun 2024 17:19:07 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 10 Jul 2024 18:19:25 +02:00

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

