Return-Path: <linux-tip-commits+bounces-1436-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 273B190C849
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Jun 2024 13:04:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 289791C210D5
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Jun 2024 11:04:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF4083DAC04;
	Tue, 18 Jun 2024 09:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Ttef78io";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="/9xP7R82"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C907921C185;
	Tue, 18 Jun 2024 09:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718703904; cv=none; b=oBeeNK+k8yHZRqStT6GNEKdpxilmJXmO8vdR0difozgmHSLD4ClTPFDXFgUC2QZ3FhbdKsnW9JQ/lNEcq0htAXZGXpW4OBLfjkKMDz2olhFrA07T2AiAjfthgXh1/aB+dKfYcJ6nIY1sYtCLOjI0Mj88UA1NJbi/kC3TDn+Q08Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718703904; c=relaxed/simple;
	bh=pdYhDX3pLnEWLN13B065fcnQIebsHe7t9AIecjf1djI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=bmJLABFq4JrFF3pn8+D0kdAsKF3AMvV+cwGOzdbvUMFFfxMDu7T4NEWu6sThLBuO6TI/rIepW+JBSKzZ3nljBL1toNt+DNZMcNAG8CrYRt0tbV9wRtvTrayy7juOJC8TmxNAY9I4qsW/Cc6mOWe9qtFronelL86ZzNgsX2g+vz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Ttef78io; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=/9xP7R82; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 18 Jun 2024 09:44:58 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1718703898;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yCoJIiyB8JkxVxyC15Wo/ru7r64/x4ezR9yVsyd56vg=;
	b=Ttef78io1U5Cyh4Tv8VlqZx6DYY3ipJVuiTYZZa9cad1L2ksPao/y1WLWIV7tpqIPv7Rwz
	/OcVz5JvftmOm0EDZfWBy6+j2kYSbJyqlMicoXYnHrE1nKI/nFw982qlQblimcW/iT9olk
	sALdb89/WI6LYR5H/aLWsLVCDj2fkVTHKsSnGB55uinU4gbgzxzwXzz3T67BwLl6HyYhLN
	e+3hf7kHxoCGnh/JDIGw0OOm+kFbUXQHot82/pCS30inaazJgPtOyuipqiUnxE7NWPdfeA
	zPMGr1nSixF5uNH+pT5fHGVDKDvMeObA1GFZMthMXu/e8G1niaL9ydPhwan5BQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1718703898;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yCoJIiyB8JkxVxyC15Wo/ru7r64/x4ezR9yVsyd56vg=;
	b=/9xP7R82OWNP0B4N9t+NuvPJtbBxXectxzg7vRTuvuLyX6WDo9qY2EqS/G7oVmiNGNTttz
	AYv7WWsfKiZWEKAQ==
From: "tip-bot2 for Tom Lendacky" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/sev] x86/sev: Take advantage of configfs visibility support in TSM
Cc: Dan Williams <dan.j.williams@intel.com>,
 Tom Lendacky <thomas.lendacky@amd.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>,
 Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3C8873c45d0c8abc35aaf01d7833a55788a6905727=2E17176?=
 =?utf-8?q?00736=2Egit=2Ethomas=2Elendacky=40amd=2Ecom=3E?=
References: =?utf-8?q?=3C8873c45d0c8abc35aaf01d7833a55788a6905727=2E171760?=
 =?utf-8?q?0736=2Egit=2Ethomas=2Elendacky=40amd=2Ecom=3E?=
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171870389831.10875.15165987492961592792.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/sev branch of tip:

Commit-ID:     20dfee95936413708701eb151f419597fdd9d948
Gitweb:        https://git.kernel.org/tip/20dfee95936413708701eb151f419597fdd9d948
Author:        Tom Lendacky <thomas.lendacky@amd.com>
AuthorDate:    Wed, 05 Jun 2024 10:18:54 -05:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 17 Jun 2024 20:42:57 +02:00

x86/sev: Take advantage of configfs visibility support in TSM

The TSM attestation report support provides multiple configfs attribute
types (both for standard and binary attributes) to allow for additional
attributes to be displayed for SNP as compared to TDX. With the ability
to hide attributes via configfs, consolidate the multiple attribute groups
into a single standard attribute group and a single binary attribute
group. Modify the TDX support to hide the attributes that were previously
"hidden" as a result of registering the selective attribute groups.

Co-developed-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Link: https://lore.kernel.org/r/8873c45d0c8abc35aaf01d7833a55788a6905727.1717600736.git.thomas.lendacky@amd.com
---
 drivers/virt/coco/sev-guest/sev-guest.c |  3 +-
 drivers/virt/coco/tdx-guest/tdx-guest.c | 26 ++++++-
 drivers/virt/coco/tsm.c                 | 86 +++++++++++-------------
 include/linux/tsm.h                     | 38 ++++++++---
 4 files changed, 100 insertions(+), 53 deletions(-)

diff --git a/drivers/virt/coco/sev-guest/sev-guest.c b/drivers/virt/coco/sev-guest/sev-guest.c
index 3560b3a..0c70a38 100644
--- a/drivers/virt/coco/sev-guest/sev-guest.c
+++ b/drivers/virt/coco/sev-guest/sev-guest.c
@@ -23,6 +23,7 @@
 #include <linux/sockptr.h>
 #include <linux/cleanup.h>
 #include <linux/uuid.h>
+#include <linux/configfs.h>
 #include <uapi/linux/sev-guest.h>
 #include <uapi/linux/psp-sev.h>
 
@@ -982,7 +983,7 @@ static int __init sev_guest_probe(struct platform_device *pdev)
 	/* Set the privlevel_floor attribute based on the vmpck_id */
 	sev_tsm_ops.privlevel_floor = vmpck_id;
 
-	ret = tsm_register(&sev_tsm_ops, snp_dev, &tsm_report_extra_type);
+	ret = tsm_register(&sev_tsm_ops, snp_dev);
 	if (ret)
 		goto e_free_cert_data;
 
diff --git a/drivers/virt/coco/tdx-guest/tdx-guest.c b/drivers/virt/coco/tdx-guest/tdx-guest.c
index 1253bf7..2acba56 100644
--- a/drivers/virt/coco/tdx-guest/tdx-guest.c
+++ b/drivers/virt/coco/tdx-guest/tdx-guest.c
@@ -249,6 +249,28 @@ done:
 	return ret;
 }
 
+static bool tdx_report_attr_visible(int n)
+{
+	switch (n) {
+	case TSM_REPORT_GENERATION:
+	case TSM_REPORT_PROVIDER:
+		return true;
+	}
+
+	return false;
+}
+
+static bool tdx_report_bin_attr_visible(int n)
+{
+	switch (n) {
+	case TSM_REPORT_INBLOB:
+	case TSM_REPORT_OUTBLOB:
+		return true;
+	}
+
+	return false;
+}
+
 static long tdx_guest_ioctl(struct file *file, unsigned int cmd,
 			    unsigned long arg)
 {
@@ -281,6 +303,8 @@ MODULE_DEVICE_TABLE(x86cpu, tdx_guest_ids);
 static const struct tsm_ops tdx_tsm_ops = {
 	.name = KBUILD_MODNAME,
 	.report_new = tdx_report_new,
+	.report_attr_visible = tdx_report_attr_visible,
+	.report_bin_attr_visible = tdx_report_bin_attr_visible,
 };
 
 static int __init tdx_guest_init(void)
@@ -301,7 +325,7 @@ static int __init tdx_guest_init(void)
 		goto free_misc;
 	}
 
-	ret = tsm_register(&tdx_tsm_ops, NULL, NULL);
+	ret = tsm_register(&tdx_tsm_ops, NULL);
 	if (ret)
 		goto free_quote;
 
diff --git a/drivers/virt/coco/tsm.c b/drivers/virt/coco/tsm.c
index d1c2db8..7db534b 100644
--- a/drivers/virt/coco/tsm.c
+++ b/drivers/virt/coco/tsm.c
@@ -14,7 +14,6 @@
 
 static struct tsm_provider {
 	const struct tsm_ops *ops;
-	const struct config_item_type *type;
 	void *data;
 } provider;
 static DECLARE_RWSEM(tsm_rwsem);
@@ -252,34 +251,18 @@ static ssize_t tsm_report_auxblob_read(struct config_item *cfg, void *buf,
 }
 CONFIGFS_BIN_ATTR_RO(tsm_report_, auxblob, NULL, TSM_OUTBLOB_MAX);
 
-#define TSM_DEFAULT_ATTRS() \
-	&tsm_report_attr_generation, \
-	&tsm_report_attr_provider
-
 static struct configfs_attribute *tsm_report_attrs[] = {
-	TSM_DEFAULT_ATTRS(),
-	NULL,
-};
-
-static struct configfs_attribute *tsm_report_extra_attrs[] = {
-	TSM_DEFAULT_ATTRS(),
-	&tsm_report_attr_privlevel,
-	&tsm_report_attr_privlevel_floor,
+	[TSM_REPORT_GENERATION] = &tsm_report_attr_generation,
+	[TSM_REPORT_PROVIDER] = &tsm_report_attr_provider,
+	[TSM_REPORT_PRIVLEVEL] = &tsm_report_attr_privlevel,
+	[TSM_REPORT_PRIVLEVEL_FLOOR] = &tsm_report_attr_privlevel_floor,
 	NULL,
 };
 
-#define TSM_DEFAULT_BIN_ATTRS() \
-	&tsm_report_attr_inblob, \
-	&tsm_report_attr_outblob
-
 static struct configfs_bin_attribute *tsm_report_bin_attrs[] = {
-	TSM_DEFAULT_BIN_ATTRS(),
-	NULL,
-};
-
-static struct configfs_bin_attribute *tsm_report_bin_extra_attrs[] = {
-	TSM_DEFAULT_BIN_ATTRS(),
-	&tsm_report_attr_auxblob,
+	[TSM_REPORT_INBLOB] = &tsm_report_attr_inblob,
+	[TSM_REPORT_OUTBLOB] = &tsm_report_attr_outblob,
+	[TSM_REPORT_AUXBLOB] = &tsm_report_attr_auxblob,
 	NULL,
 };
 
@@ -297,21 +280,44 @@ static struct configfs_item_operations tsm_report_item_ops = {
 	.release = tsm_report_item_release,
 };
 
-const struct config_item_type tsm_report_default_type = {
-	.ct_owner = THIS_MODULE,
-	.ct_bin_attrs = tsm_report_bin_attrs,
-	.ct_attrs = tsm_report_attrs,
-	.ct_item_ops = &tsm_report_item_ops,
+static bool tsm_report_is_visible(struct config_item *item,
+				  struct configfs_attribute *attr, int n)
+{
+	guard(rwsem_read)(&tsm_rwsem);
+	if (!provider.ops)
+		return false;
+
+	if (!provider.ops->report_attr_visible)
+		return true;
+
+	return provider.ops->report_attr_visible(n);
+}
+
+static bool tsm_report_is_bin_visible(struct config_item *item,
+				      struct configfs_bin_attribute *attr, int n)
+{
+	guard(rwsem_read)(&tsm_rwsem);
+	if (!provider.ops)
+		return false;
+
+	if (!provider.ops->report_bin_attr_visible)
+		return true;
+
+	return provider.ops->report_bin_attr_visible(n);
+}
+
+static struct configfs_group_operations tsm_report_attr_group_ops = {
+	.is_visible = tsm_report_is_visible,
+	.is_bin_visible = tsm_report_is_bin_visible,
 };
-EXPORT_SYMBOL_GPL(tsm_report_default_type);
 
-const struct config_item_type tsm_report_extra_type = {
+static const struct config_item_type tsm_report_type = {
 	.ct_owner = THIS_MODULE,
-	.ct_bin_attrs = tsm_report_bin_extra_attrs,
-	.ct_attrs = tsm_report_extra_attrs,
+	.ct_bin_attrs = tsm_report_bin_attrs,
+	.ct_attrs = tsm_report_attrs,
 	.ct_item_ops = &tsm_report_item_ops,
+	.ct_group_ops = &tsm_report_attr_group_ops,
 };
-EXPORT_SYMBOL_GPL(tsm_report_extra_type);
 
 static struct config_item *tsm_report_make_item(struct config_group *group,
 						const char *name)
@@ -326,7 +332,7 @@ static struct config_item *tsm_report_make_item(struct config_group *group,
 	if (!state)
 		return ERR_PTR(-ENOMEM);
 
-	config_item_init_type_name(&state->cfg, name, provider.type);
+	config_item_init_type_name(&state->cfg, name, &tsm_report_type);
 	return &state->cfg;
 }
 
@@ -353,16 +359,10 @@ static struct configfs_subsystem tsm_configfs = {
 	.su_mutex = __MUTEX_INITIALIZER(tsm_configfs.su_mutex),
 };
 
-int tsm_register(const struct tsm_ops *ops, void *priv,
-		 const struct config_item_type *type)
+int tsm_register(const struct tsm_ops *ops, void *priv)
 {
 	const struct tsm_ops *conflict;
 
-	if (!type)
-		type = &tsm_report_default_type;
-	if (!(type == &tsm_report_default_type || type == &tsm_report_extra_type))
-		return -EINVAL;
-
 	guard(rwsem_write)(&tsm_rwsem);
 	conflict = provider.ops;
 	if (conflict) {
@@ -372,7 +372,6 @@ int tsm_register(const struct tsm_ops *ops, void *priv,
 
 	provider.ops = ops;
 	provider.data = priv;
-	provider.type = type;
 	return 0;
 }
 EXPORT_SYMBOL_GPL(tsm_register);
@@ -384,7 +383,6 @@ int tsm_unregister(const struct tsm_ops *ops)
 		return -EBUSY;
 	provider.ops = NULL;
 	provider.data = NULL;
-	provider.type = NULL;
 	return 0;
 }
 EXPORT_SYMBOL_GPL(tsm_unregister);
diff --git a/include/linux/tsm.h b/include/linux/tsm.h
index 50c5769..30d9d27 100644
--- a/include/linux/tsm.h
+++ b/include/linux/tsm.h
@@ -43,11 +43,39 @@ struct tsm_report {
 };
 
 /**
+ * enum tsm_attr_index - index used to reference report attributes
+ * @TSM_REPORT_GENERATION: index of the report generation number attribute
+ * @TSM_REPORT_PROVIDER: index of the provider name attribute
+ * @TSM_REPORT_PRIVLEVEL: index of the desired privilege level attribute
+ * @TSM_REPORT_PRIVLEVEL_FLOOR: index of the minimum allowed privileg level attribute
+ */
+enum tsm_attr_index {
+	TSM_REPORT_GENERATION,
+	TSM_REPORT_PROVIDER,
+	TSM_REPORT_PRIVLEVEL,
+	TSM_REPORT_PRIVLEVEL_FLOOR,
+};
+
+/**
+ * enum tsm_bin_attr_index - index used to reference binary report attributes
+ * @TSM_REPORT_INBLOB: index of the binary report input attribute
+ * @TSM_REPORT_OUTBLOB: index of the binary report output attribute
+ * @TSM_REPORT_AUXBLOB: index of the binary auxiliary data attribute
+ */
+enum tsm_bin_attr_index {
+	TSM_REPORT_INBLOB,
+	TSM_REPORT_OUTBLOB,
+	TSM_REPORT_AUXBLOB,
+};
+
+/**
  * struct tsm_ops - attributes and operations for tsm instances
  * @name: tsm id reflected in /sys/kernel/config/tsm/report/$report/provider
  * @privlevel_floor: convey base privlevel for nested scenarios
  * @report_new: Populate @report with the report blob and auxblob
  * (optional), return 0 on successful population, or -errno otherwise
+ * @report_attr_visible: show or hide a report attribute entry
+ * @report_bin_attr_visible: show or hide a report binary attribute entry
  *
  * Implementation specific ops, only one is expected to be registered at
  * a time i.e. only one of "sev-guest", "tdx-guest", etc.
@@ -56,14 +84,10 @@ struct tsm_ops {
 	const char *name;
 	unsigned int privlevel_floor;
 	int (*report_new)(struct tsm_report *report, void *data);
+	bool (*report_attr_visible)(int n);
+	bool (*report_bin_attr_visible)(int n);
 };
 
-extern const struct config_item_type tsm_report_default_type;
-
-/* publish @privlevel, @privlevel_floor, and @auxblob attributes */
-extern const struct config_item_type tsm_report_extra_type;
-
-int tsm_register(const struct tsm_ops *ops, void *priv,
-		 const struct config_item_type *type);
+int tsm_register(const struct tsm_ops *ops, void *priv);
 int tsm_unregister(const struct tsm_ops *ops);
 #endif /* __TSM_H */

