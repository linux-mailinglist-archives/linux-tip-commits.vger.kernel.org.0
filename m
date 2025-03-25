Return-Path: <linux-tip-commits+bounces-4508-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 346B4A6ECB2
	for <lists+linux-tip-commits@lfdr.de>; Tue, 25 Mar 2025 10:39:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E61CF7A308F
	for <lists+linux-tip-commits@lfdr.de>; Tue, 25 Mar 2025 09:38:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BE62257AF6;
	Tue, 25 Mar 2025 09:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UFTU9J/N";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="THI0wL4D"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA719257430;
	Tue, 25 Mar 2025 09:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742895395; cv=none; b=inSddUsLOa2KmfT7FICNqcQdxEwOXeZDZNPUOlstYCezWarCH7qNQ+ZFSviSpCTRFXz9s2muLSyJuft/UMTiKTuYrEcMvo2CKOJERjs4QAk0pf6XUrsqIVyCRM54vGMOyfpWQ9zy+zHcz1qizevCzUJrqwklkC9L9JvgwqSA2Dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742895395; c=relaxed/simple;
	bh=pnR3CndA1WK+rh1s3HDz+IkkMCrEEdzVuyQya2kj1bc=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=PCmq9Tcb/C30tBmJgOhJux/ov6JCMgi33ww8OVXF+9/t239xlDvwf+RadTp4CFHsl+6DQC64S+DV+kUAt9VSZkNIYoFHmMOzTVmeqAtUn9WGNmK1adfz3bblKH6bJmA2QJzsMvjEjoD8aquxqBuxIn1Ilr0LUjCQ0bVn12DZovg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UFTU9J/N; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=THI0wL4D; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 25 Mar 2025 09:36:30 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742895391;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p4SE+Ts1FOIr2Y9KagBN5uOjcvfSbtlKIdAkhxWhUvc=;
	b=UFTU9J/Nj7wFItD30Brzg166TaHnyF5qow/shmUoXe75uKREfBNVvUdW13rW9w6fZeV7Bu
	RSLTDqXAOyaiPS9VH9GpDW8dYw6o+XGCjr5pcpIhVezVODvWYEnG6vDP1ELRw7/ZYhvAmF
	dSO5rJsm6fg800dEIYZqaLct7WplUIDEcJrwt6ptgX97XWzAfagqmCXX1HtclpHG/gV5Yt
	qqiYn59J8klKOy9HzIIySpu5koq1vY2JrAaDTM4qjddhEwb3OBbtjM/C/Hic20pA6WgJYk
	YG93Kyjj9r7Gs0CLJG0Qgolg6xTFvWV2CpB9vGcxtUV0z6USQg7Fil2J7A4WJw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742895391;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p4SE+Ts1FOIr2Y9KagBN5uOjcvfSbtlKIdAkhxWhUvc=;
	b=THI0wL4DRMg6lacE3cVOel0wv96KrA3v1n1D2cXT90jmdj7jNoVhdLBsBN5x0+WdR5DyMg
	wGRnc13XfJE5sZAg==
From: "tip-bot2 for Ahmed S. Darwish" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/cacheinfo: Move AMD cache_disable_0/1 handling to
 separate file
Cc: "Ahmed S. Darwish" <darwi@linutronix.de>, Ingo Molnar <mingo@kernel.org>,
 "H. Peter Anvin" <hpa@zytor.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250324133324.23458-14-darwi@linutronix.de>
References: <20250324133324.23458-14-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174289539024.14745.14150812839476422033.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     365e960d296ef9f36b20971aa4854ce07817a9bb
Gitweb:        https://git.kernel.org/tip/365e960d296ef9f36b20971aa4854ce07817a9bb
Author:        Ahmed S. Darwish <darwi@linutronix.de>
AuthorDate:    Mon, 24 Mar 2025 14:33:08 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 25 Mar 2025 10:22:39 +01:00

x86/cacheinfo: Move AMD cache_disable_0/1 handling to separate file

Parent commit decoupled amd_northbridge out of _cpuid4_info_regs, where
it was merely "parked" there until ci_info_init() can store it in the
private pointer of the <linux/cacheinfo.h> API.

Given that decoupling, move the AMD-specific L3 cache_disable_0/1 sysfs
code from the generic (and already extremely convoluted) x86/cacheinfo
code into its own file.

Compile the file only if CONFIG_AMD_NB and CONFIG_SYSFS are both
enabled, which mirrors the existing logic.

Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/r/20250324133324.23458-14-darwi@linutronix.de
---
 arch/x86/kernel/cpu/Makefile            |   3 +-
 arch/x86/kernel/cpu/amd_cache_disable.c | 301 +++++++++++++++++++++++-
 arch/x86/kernel/cpu/cacheinfo.c         | 298 +-----------------------
 arch/x86/kernel/cpu/cpu.h               |   9 +-
 4 files changed, 313 insertions(+), 298 deletions(-)
 create mode 100644 arch/x86/kernel/cpu/amd_cache_disable.c

diff --git a/arch/x86/kernel/cpu/Makefile b/arch/x86/kernel/cpu/Makefile
index 4efdf5c..3a39396 100644
--- a/arch/x86/kernel/cpu/Makefile
+++ b/arch/x86/kernel/cpu/Makefile
@@ -38,6 +38,9 @@ obj-y					+= intel.o tsx.o
 obj-$(CONFIG_PM)			+= intel_epb.o
 endif
 obj-$(CONFIG_CPU_SUP_AMD)		+= amd.o
+ifeq ($(CONFIG_AMD_NB)$(CONFIG_SYSFS),yy)
+obj-y					+= amd_cache_disable.o
+endif
 obj-$(CONFIG_CPU_SUP_HYGON)		+= hygon.o
 obj-$(CONFIG_CPU_SUP_CYRIX_32)		+= cyrix.o
 obj-$(CONFIG_CPU_SUP_CENTAUR)		+= centaur.o
diff --git a/arch/x86/kernel/cpu/amd_cache_disable.c b/arch/x86/kernel/cpu/amd_cache_disable.c
new file mode 100644
index 0000000..6d53aee
--- /dev/null
+++ b/arch/x86/kernel/cpu/amd_cache_disable.c
@@ -0,0 +1,301 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * AMD L3 cache_disable_{0,1} sysfs handling
+ * Documentation/ABI/testing/sysfs-devices-system-cpu
+ */
+
+#include <linux/cacheinfo.h>
+#include <linux/capability.h>
+#include <linux/pci.h>
+#include <linux/sysfs.h>
+
+#include <asm/amd_nb.h>
+
+#include "cpu.h"
+
+/*
+ * L3 cache descriptors
+ */
+static void amd_calc_l3_indices(struct amd_northbridge *nb)
+{
+	struct amd_l3_cache *l3 = &nb->l3_cache;
+	unsigned int sc0, sc1, sc2, sc3;
+	u32 val = 0;
+
+	pci_read_config_dword(nb->misc, 0x1C4, &val);
+
+	/* calculate subcache sizes */
+	l3->subcaches[0] = sc0 = !(val & BIT(0));
+	l3->subcaches[1] = sc1 = !(val & BIT(4));
+
+	if (boot_cpu_data.x86 == 0x15) {
+		l3->subcaches[0] = sc0 += !(val & BIT(1));
+		l3->subcaches[1] = sc1 += !(val & BIT(5));
+	}
+
+	l3->subcaches[2] = sc2 = !(val & BIT(8))  + !(val & BIT(9));
+	l3->subcaches[3] = sc3 = !(val & BIT(12)) + !(val & BIT(13));
+
+	l3->indices = (max(max3(sc0, sc1, sc2), sc3) << 10) - 1;
+}
+
+/*
+ * check whether a slot used for disabling an L3 index is occupied.
+ * @l3: L3 cache descriptor
+ * @slot: slot number (0..1)
+ *
+ * @returns: the disabled index if used or negative value if slot free.
+ */
+static int amd_get_l3_disable_slot(struct amd_northbridge *nb, unsigned int slot)
+{
+	unsigned int reg = 0;
+
+	pci_read_config_dword(nb->misc, 0x1BC + slot * 4, &reg);
+
+	/* check whether this slot is activated already */
+	if (reg & (3UL << 30))
+		return reg & 0xfff;
+
+	return -1;
+}
+
+static ssize_t show_cache_disable(struct cacheinfo *ci, char *buf, unsigned int slot)
+{
+	int index;
+	struct amd_northbridge *nb = ci->priv;
+
+	index = amd_get_l3_disable_slot(nb, slot);
+	if (index >= 0)
+		return sprintf(buf, "%d\n", index);
+
+	return sprintf(buf, "FREE\n");
+}
+
+#define SHOW_CACHE_DISABLE(slot)					\
+static ssize_t								\
+cache_disable_##slot##_show(struct device *dev,				\
+			    struct device_attribute *attr, char *buf)	\
+{									\
+	struct cacheinfo *ci = dev_get_drvdata(dev);			\
+	return show_cache_disable(ci, buf, slot);			\
+}
+
+SHOW_CACHE_DISABLE(0)
+SHOW_CACHE_DISABLE(1)
+
+static void amd_l3_disable_index(struct amd_northbridge *nb, int cpu,
+				 unsigned int slot, unsigned long idx)
+{
+	int i;
+
+	idx |= BIT(30);
+
+	/*
+	 *  disable index in all 4 subcaches
+	 */
+	for (i = 0; i < 4; i++) {
+		u32 reg = idx | (i << 20);
+
+		if (!nb->l3_cache.subcaches[i])
+			continue;
+
+		pci_write_config_dword(nb->misc, 0x1BC + slot * 4, reg);
+
+		/*
+		 * We need to WBINVD on a core on the node containing the L3
+		 * cache which indices we disable therefore a simple wbinvd()
+		 * is not sufficient.
+		 */
+		wbinvd_on_cpu(cpu);
+
+		reg |= BIT(31);
+		pci_write_config_dword(nb->misc, 0x1BC + slot * 4, reg);
+	}
+}
+
+/*
+ * disable a L3 cache index by using a disable-slot
+ *
+ * @l3:    L3 cache descriptor
+ * @cpu:   A CPU on the node containing the L3 cache
+ * @slot:  slot number (0..1)
+ * @index: index to disable
+ *
+ * @return: 0 on success, error status on failure
+ */
+static int amd_set_l3_disable_slot(struct amd_northbridge *nb, int cpu,
+				   unsigned int slot, unsigned long index)
+{
+	int ret = 0;
+
+	/*  check if @slot is already used or the index is already disabled */
+	ret = amd_get_l3_disable_slot(nb, slot);
+	if (ret >= 0)
+		return -EEXIST;
+
+	if (index > nb->l3_cache.indices)
+		return -EINVAL;
+
+	/* check whether the other slot has disabled the same index already */
+	if (index == amd_get_l3_disable_slot(nb, !slot))
+		return -EEXIST;
+
+	amd_l3_disable_index(nb, cpu, slot, index);
+
+	return 0;
+}
+
+static ssize_t store_cache_disable(struct cacheinfo *ci, const char *buf,
+				   size_t count, unsigned int slot)
+{
+	struct amd_northbridge *nb = ci->priv;
+	unsigned long val = 0;
+	int cpu, err = 0;
+
+	if (!capable(CAP_SYS_ADMIN))
+		return -EPERM;
+
+	cpu = cpumask_first(&ci->shared_cpu_map);
+
+	if (kstrtoul(buf, 10, &val) < 0)
+		return -EINVAL;
+
+	err = amd_set_l3_disable_slot(nb, cpu, slot, val);
+	if (err) {
+		if (err == -EEXIST)
+			pr_warn("L3 slot %d in use/index already disabled!\n",
+				   slot);
+		return err;
+	}
+	return count;
+}
+
+#define STORE_CACHE_DISABLE(slot)					\
+static ssize_t								\
+cache_disable_##slot##_store(struct device *dev,			\
+			     struct device_attribute *attr,		\
+			     const char *buf, size_t count)		\
+{									\
+	struct cacheinfo *ci = dev_get_drvdata(dev);			\
+	return store_cache_disable(ci, buf, count, slot);		\
+}
+
+STORE_CACHE_DISABLE(0)
+STORE_CACHE_DISABLE(1)
+
+static ssize_t subcaches_show(struct device *dev, struct device_attribute *attr,
+			      char *buf)
+{
+	struct cacheinfo *ci = dev_get_drvdata(dev);
+	int cpu = cpumask_first(&ci->shared_cpu_map);
+
+	return sprintf(buf, "%x\n", amd_get_subcaches(cpu));
+}
+
+static ssize_t subcaches_store(struct device *dev,
+			       struct device_attribute *attr,
+			       const char *buf, size_t count)
+{
+	struct cacheinfo *ci = dev_get_drvdata(dev);
+	int cpu = cpumask_first(&ci->shared_cpu_map);
+	unsigned long val;
+
+	if (!capable(CAP_SYS_ADMIN))
+		return -EPERM;
+
+	if (kstrtoul(buf, 16, &val) < 0)
+		return -EINVAL;
+
+	if (amd_set_subcaches(cpu, val))
+		return -EINVAL;
+
+	return count;
+}
+
+static DEVICE_ATTR_RW(cache_disable_0);
+static DEVICE_ATTR_RW(cache_disable_1);
+static DEVICE_ATTR_RW(subcaches);
+
+static umode_t cache_private_attrs_is_visible(struct kobject *kobj,
+					      struct attribute *attr, int unused)
+{
+	struct device *dev = kobj_to_dev(kobj);
+	struct cacheinfo *ci = dev_get_drvdata(dev);
+	umode_t mode = attr->mode;
+
+	if (!ci->priv)
+		return 0;
+
+	if ((attr == &dev_attr_subcaches.attr) &&
+	    amd_nb_has_feature(AMD_NB_L3_PARTITIONING))
+		return mode;
+
+	if ((attr == &dev_attr_cache_disable_0.attr ||
+	     attr == &dev_attr_cache_disable_1.attr) &&
+	    amd_nb_has_feature(AMD_NB_L3_INDEX_DISABLE))
+		return mode;
+
+	return 0;
+}
+
+static struct attribute_group cache_private_group = {
+	.is_visible = cache_private_attrs_is_visible,
+};
+
+static void init_amd_l3_attrs(void)
+{
+	static struct attribute **amd_l3_attrs;
+	int n = 1;
+
+	if (amd_l3_attrs) /* already initialized */
+		return;
+
+	if (amd_nb_has_feature(AMD_NB_L3_INDEX_DISABLE))
+		n += 2;
+	if (amd_nb_has_feature(AMD_NB_L3_PARTITIONING))
+		n += 1;
+
+	amd_l3_attrs = kcalloc(n, sizeof(*amd_l3_attrs), GFP_KERNEL);
+	if (!amd_l3_attrs)
+		return;
+
+	n = 0;
+	if (amd_nb_has_feature(AMD_NB_L3_INDEX_DISABLE)) {
+		amd_l3_attrs[n++] = &dev_attr_cache_disable_0.attr;
+		amd_l3_attrs[n++] = &dev_attr_cache_disable_1.attr;
+	}
+	if (amd_nb_has_feature(AMD_NB_L3_PARTITIONING))
+		amd_l3_attrs[n++] = &dev_attr_subcaches.attr;
+
+	cache_private_group.attrs = amd_l3_attrs;
+}
+
+const struct attribute_group *cache_get_priv_group(struct cacheinfo *ci)
+{
+	struct amd_northbridge *nb = ci->priv;
+
+	if (ci->level < 3 || !nb)
+		return NULL;
+
+	if (nb && nb->l3_cache.indices)
+		init_amd_l3_attrs();
+
+	return &cache_private_group;
+}
+
+struct amd_northbridge *amd_init_l3_cache(int index)
+{
+	struct amd_northbridge *nb;
+	int node;
+
+	/* only for L3, and not in virtualized environments */
+	if (index < 3)
+		return NULL;
+
+	node = topology_amd_node_id(smp_processor_id());
+	nb = node_to_amd_nb(node);
+	if (nb && !nb->l3_cache.indices)
+		amd_calc_l3_indices(nb);
+
+	return nb;
+}
diff --git a/arch/x86/kernel/cpu/cacheinfo.c b/arch/x86/kernel/cpu/cacheinfo.c
index 8c2b51b..ea6fba9 100644
--- a/arch/x86/kernel/cpu/cacheinfo.c
+++ b/arch/x86/kernel/cpu/cacheinfo.c
@@ -9,12 +9,9 @@
  */
 
 #include <linux/cacheinfo.h>
-#include <linux/capability.h>
 #include <linux/cpu.h>
 #include <linux/cpuhotplug.h>
-#include <linux/pci.h>
 #include <linux/stop_machine.h>
-#include <linux/sysfs.h>
 
 #include <asm/amd_nb.h>
 #include <asm/cacheinfo.h>
@@ -300,301 +297,6 @@ amd_cpuid4(int index, union _cpuid4_leaf_eax *eax,
 		(ebx->split.ways_of_associativity + 1) - 1;
 }
 
-#if defined(CONFIG_AMD_NB) && defined(CONFIG_SYSFS)
-
-/*
- * L3 cache descriptors
- */
-static void amd_calc_l3_indices(struct amd_northbridge *nb)
-{
-	struct amd_l3_cache *l3 = &nb->l3_cache;
-	unsigned int sc0, sc1, sc2, sc3;
-	u32 val = 0;
-
-	pci_read_config_dword(nb->misc, 0x1C4, &val);
-
-	/* calculate subcache sizes */
-	l3->subcaches[0] = sc0 = !(val & BIT(0));
-	l3->subcaches[1] = sc1 = !(val & BIT(4));
-
-	if (boot_cpu_data.x86 == 0x15) {
-		l3->subcaches[0] = sc0 += !(val & BIT(1));
-		l3->subcaches[1] = sc1 += !(val & BIT(5));
-	}
-
-	l3->subcaches[2] = sc2 = !(val & BIT(8))  + !(val & BIT(9));
-	l3->subcaches[3] = sc3 = !(val & BIT(12)) + !(val & BIT(13));
-
-	l3->indices = (max(max3(sc0, sc1, sc2), sc3) << 10) - 1;
-}
-
-/*
- * check whether a slot used for disabling an L3 index is occupied.
- * @l3: L3 cache descriptor
- * @slot: slot number (0..1)
- *
- * @returns: the disabled index if used or negative value if slot free.
- */
-static int amd_get_l3_disable_slot(struct amd_northbridge *nb, unsigned slot)
-{
-	unsigned int reg = 0;
-
-	pci_read_config_dword(nb->misc, 0x1BC + slot * 4, &reg);
-
-	/* check whether this slot is activated already */
-	if (reg & (3UL << 30))
-		return reg & 0xfff;
-
-	return -1;
-}
-
-static ssize_t show_cache_disable(struct cacheinfo *ci, char *buf, unsigned int slot)
-{
-	int index;
-	struct amd_northbridge *nb = ci->priv;
-
-	index = amd_get_l3_disable_slot(nb, slot);
-	if (index >= 0)
-		return sprintf(buf, "%d\n", index);
-
-	return sprintf(buf, "FREE\n");
-}
-
-#define SHOW_CACHE_DISABLE(slot)					\
-static ssize_t								\
-cache_disable_##slot##_show(struct device *dev,				\
-			    struct device_attribute *attr, char *buf)	\
-{									\
-	struct cacheinfo *ci = dev_get_drvdata(dev);			\
-	return show_cache_disable(ci, buf, slot);			\
-}
-SHOW_CACHE_DISABLE(0)
-SHOW_CACHE_DISABLE(1)
-
-static void amd_l3_disable_index(struct amd_northbridge *nb, int cpu,
-				 unsigned slot, unsigned long idx)
-{
-	int i;
-
-	idx |= BIT(30);
-
-	/*
-	 *  disable index in all 4 subcaches
-	 */
-	for (i = 0; i < 4; i++) {
-		u32 reg = idx | (i << 20);
-
-		if (!nb->l3_cache.subcaches[i])
-			continue;
-
-		pci_write_config_dword(nb->misc, 0x1BC + slot * 4, reg);
-
-		/*
-		 * We need to WBINVD on a core on the node containing the L3
-		 * cache which indices we disable therefore a simple wbinvd()
-		 * is not sufficient.
-		 */
-		wbinvd_on_cpu(cpu);
-
-		reg |= BIT(31);
-		pci_write_config_dword(nb->misc, 0x1BC + slot * 4, reg);
-	}
-}
-
-/*
- * disable a L3 cache index by using a disable-slot
- *
- * @l3:    L3 cache descriptor
- * @cpu:   A CPU on the node containing the L3 cache
- * @slot:  slot number (0..1)
- * @index: index to disable
- *
- * @return: 0 on success, error status on failure
- */
-static int amd_set_l3_disable_slot(struct amd_northbridge *nb, int cpu,
-			    unsigned slot, unsigned long index)
-{
-	int ret = 0;
-
-	/*  check if @slot is already used or the index is already disabled */
-	ret = amd_get_l3_disable_slot(nb, slot);
-	if (ret >= 0)
-		return -EEXIST;
-
-	if (index > nb->l3_cache.indices)
-		return -EINVAL;
-
-	/* check whether the other slot has disabled the same index already */
-	if (index == amd_get_l3_disable_slot(nb, !slot))
-		return -EEXIST;
-
-	amd_l3_disable_index(nb, cpu, slot, index);
-
-	return 0;
-}
-
-static ssize_t store_cache_disable(struct cacheinfo *ci, const char *buf,
-				   size_t count, unsigned int slot)
-{
-	unsigned long val = 0;
-	int cpu, err = 0;
-	struct amd_northbridge *nb = ci->priv;
-
-	if (!capable(CAP_SYS_ADMIN))
-		return -EPERM;
-
-	cpu = cpumask_first(&ci->shared_cpu_map);
-
-	if (kstrtoul(buf, 10, &val) < 0)
-		return -EINVAL;
-
-	err = amd_set_l3_disable_slot(nb, cpu, slot, val);
-	if (err) {
-		if (err == -EEXIST)
-			pr_warn("L3 slot %d in use/index already disabled!\n",
-				   slot);
-		return err;
-	}
-	return count;
-}
-
-#define STORE_CACHE_DISABLE(slot)					\
-static ssize_t								\
-cache_disable_##slot##_store(struct device *dev,			\
-			     struct device_attribute *attr,		\
-			     const char *buf, size_t count)		\
-{									\
-	struct cacheinfo *ci = dev_get_drvdata(dev);			\
-	return store_cache_disable(ci, buf, count, slot);		\
-}
-STORE_CACHE_DISABLE(0)
-STORE_CACHE_DISABLE(1)
-
-static ssize_t subcaches_show(struct device *dev,
-			      struct device_attribute *attr, char *buf)
-{
-	struct cacheinfo *ci = dev_get_drvdata(dev);
-	int cpu = cpumask_first(&ci->shared_cpu_map);
-
-	return sprintf(buf, "%x\n", amd_get_subcaches(cpu));
-}
-
-static ssize_t subcaches_store(struct device *dev,
-			       struct device_attribute *attr,
-			       const char *buf, size_t count)
-{
-	struct cacheinfo *ci = dev_get_drvdata(dev);
-	int cpu = cpumask_first(&ci->shared_cpu_map);
-	unsigned long val;
-
-	if (!capable(CAP_SYS_ADMIN))
-		return -EPERM;
-
-	if (kstrtoul(buf, 16, &val) < 0)
-		return -EINVAL;
-
-	if (amd_set_subcaches(cpu, val))
-		return -EINVAL;
-
-	return count;
-}
-
-static DEVICE_ATTR_RW(cache_disable_0);
-static DEVICE_ATTR_RW(cache_disable_1);
-static DEVICE_ATTR_RW(subcaches);
-
-static umode_t
-cache_private_attrs_is_visible(struct kobject *kobj,
-			       struct attribute *attr, int unused)
-{
-	struct device *dev = kobj_to_dev(kobj);
-	struct cacheinfo *ci = dev_get_drvdata(dev);
-	umode_t mode = attr->mode;
-
-	if (!ci->priv)
-		return 0;
-
-	if ((attr == &dev_attr_subcaches.attr) &&
-	    amd_nb_has_feature(AMD_NB_L3_PARTITIONING))
-		return mode;
-
-	if ((attr == &dev_attr_cache_disable_0.attr ||
-	     attr == &dev_attr_cache_disable_1.attr) &&
-	    amd_nb_has_feature(AMD_NB_L3_INDEX_DISABLE))
-		return mode;
-
-	return 0;
-}
-
-static struct attribute_group cache_private_group = {
-	.is_visible = cache_private_attrs_is_visible,
-};
-
-static void init_amd_l3_attrs(void)
-{
-	int n = 1;
-	static struct attribute **amd_l3_attrs;
-
-	if (amd_l3_attrs) /* already initialized */
-		return;
-
-	if (amd_nb_has_feature(AMD_NB_L3_INDEX_DISABLE))
-		n += 2;
-	if (amd_nb_has_feature(AMD_NB_L3_PARTITIONING))
-		n += 1;
-
-	amd_l3_attrs = kcalloc(n, sizeof(*amd_l3_attrs), GFP_KERNEL);
-	if (!amd_l3_attrs)
-		return;
-
-	n = 0;
-	if (amd_nb_has_feature(AMD_NB_L3_INDEX_DISABLE)) {
-		amd_l3_attrs[n++] = &dev_attr_cache_disable_0.attr;
-		amd_l3_attrs[n++] = &dev_attr_cache_disable_1.attr;
-	}
-	if (amd_nb_has_feature(AMD_NB_L3_PARTITIONING))
-		amd_l3_attrs[n++] = &dev_attr_subcaches.attr;
-
-	cache_private_group.attrs = amd_l3_attrs;
-}
-
-const struct attribute_group *
-cache_get_priv_group(struct cacheinfo *ci)
-{
-	struct amd_northbridge *nb = ci->priv;
-
-	if (ci->level < 3 || !nb)
-		return NULL;
-
-	if (nb && nb->l3_cache.indices)
-		init_amd_l3_attrs();
-
-	return &cache_private_group;
-}
-
-static struct amd_northbridge *amd_init_l3_cache(int index)
-{
-	struct amd_northbridge *nb;
-	int node;
-
-	/* only for L3, and not in virtualized environments */
-	if (index < 3)
-		return NULL;
-
-	node = topology_amd_node_id(smp_processor_id());
-	nb = node_to_amd_nb(node);
-	if (nb && !nb->l3_cache.indices)
-		amd_calc_l3_indices(nb);
-
-	return nb;
-}
-#else
-static struct amd_northbridge *amd_init_l3_cache(int index)
-{
-	return NULL;
-}
-#endif  /* CONFIG_AMD_NB && CONFIG_SYSFS */
-
 /*
  * Fill passed _cpuid4_info_regs structure.
  * Intel-only code paths should pass NULL for the amd_northbridge
diff --git a/arch/x86/kernel/cpu/cpu.h b/arch/x86/kernel/cpu/cpu.h
index 51deb60..bc38b2d 100644
--- a/arch/x86/kernel/cpu/cpu.h
+++ b/arch/x86/kernel/cpu/cpu.h
@@ -75,6 +75,15 @@ extern void check_null_seg_clears_base(struct cpuinfo_x86 *c);
 void cacheinfo_amd_init_llc_id(struct cpuinfo_x86 *c, u16 die_id);
 void cacheinfo_hygon_init_llc_id(struct cpuinfo_x86 *c);
 
+#if defined(CONFIG_AMD_NB) && defined(CONFIG_SYSFS)
+struct amd_northbridge *amd_init_l3_cache(int index);
+#else
+static inline struct amd_northbridge *amd_init_l3_cache(int index)
+{
+	return NULL;
+}
+#endif
+
 unsigned int aperfmperf_get_khz(int cpu);
 void cpu_select_mitigations(void);
 

