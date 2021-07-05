Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 612203BB853
	for <lists+linux-tip-commits@lfdr.de>; Mon,  5 Jul 2021 09:54:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230114AbhGEH4Y (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 5 Jul 2021 03:56:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230135AbhGEH4S (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 5 Jul 2021 03:56:18 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 286ECC061574;
        Mon,  5 Jul 2021 00:53:42 -0700 (PDT)
Date:   Mon, 05 Jul 2021 07:53:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1625471620;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OVWulFJKlV8gxR6jQnyhRL8Xi4oUEVu9RdP4fWArloQ=;
        b=zpxdsSuaGiD5D8pbCKF6IAdLpCp9rtTyU/OP58GIUuwkTiVSk0bTgXy0cLqR4q/qSu24Qj
        UVl1tVpx/gtkpVgry4msGzbOChTq5Hi2aFhyO3VEsQIAJXJQTp9x5iPFnPbAMWA5YoFAzx
        3LNbkcm9YV1TqxRzWkJZlnTcY0irH8HKRl/AsIBafuz6D0WAeeSBPRRtIZdyhJjYXKhqb0
        hU8fQfmdXoD3BiuwLjVk/y8r7wg8AFT9lLhDgPYmWtB4x537Lw6ICx01VOjTmUJWnBTzRt
        2biWFheZ6JGJ9KaC993HAA4LAgPUVv6aZsRDRR6BnJFbF41GpICXwmBqfEMKIg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1625471620;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OVWulFJKlV8gxR6jQnyhRL8Xi4oUEVu9RdP4fWArloQ=;
        b=olz5PRpOwbcOUrGBagYLzijFtKr9xL2CY3Hs2ssq3vMq2U1dyYhg0NNH6HOOh8sliS9XYm
        AY80Pc/qeT73f8BQ==
From:   "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/intel/uncore: Add alias PMU name
Cc:     Kan Liang <kan.liang@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Andi Kleen <ak@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <1625087320-194204-13-git-send-email-kan.liang@linux.intel.com>
References: <1625087320-194204-13-git-send-email-kan.liang@linux.intel.com>
MIME-Version: 1.0
Message-ID: <162547162006.395.10269328522339927548.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     8053f2d752e2936f494ede62766a6c9e9fb674f2
Gitweb:        https://git.kernel.org/tip/8053f2d752e2936f494ede62766a6c9e9fb674f2
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Wed, 30 Jun 2021 14:08:36 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 02 Jul 2021 15:58:40 +02:00

perf/x86/intel/uncore: Add alias PMU name

A perf PMU may have two PMU names. For example, Intel Sapphire Rapids
server supports the discovery mechanism. Without the platform-specific
support, an uncore PMU is named by a type ID plus a box ID, e.g.,
uncore_type_0_0, because the real name of the uncore PMU cannot be
retrieved from the discovery table. With the platform-specific support
later, perf has the mapping information from a type ID to a specific
uncore unit. Just like the previous platforms, the uncore PMU is named
by the real PMU name, e.g., uncore_cha_0. The user scripts which work
well with the old numeric name may not work anymore.

Add a new attribute "alias" to indicate the old numeric name. The
following userspace perf tool patch will handle both names. The user
scripts should work properly with the updated perf tool.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Link: https://lore.kernel.org/r/1625087320-194204-13-git-send-email-kan.liang@linux.intel.com
---
 Documentation/ABI/testing/sysfs-bus-event_source-devices-uncore | 13 +++++++++++++
 arch/x86/events/intel/uncore.c                                  | 19 +++++++++++++------
 arch/x86/events/intel/uncore.h                                  |  1 +
 arch/x86/events/intel/uncore_snbep.c                            | 28 +++++++++++++++++++++++++++-
 4 files changed, 54 insertions(+), 7 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-event_source-devices-uncore

diff --git a/Documentation/ABI/testing/sysfs-bus-event_source-devices-uncore b/Documentation/ABI/testing/sysfs-bus-event_source-devices-uncore
new file mode 100644
index 0000000..b56e8f0
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-bus-event_source-devices-uncore
@@ -0,0 +1,13 @@
+What:		/sys/bus/event_source/devices/uncore_*/alias
+Date:		June 2021
+KernelVersion:	5.15
+Contact:	Linux kernel mailing list <linux-kernel@vger.kernel.org>
+Description:	Read-only.  An attribute to describe the alias name of
+		the uncore PMU if an alias exists on some platforms.
+		The 'perf(1)' tool should treat both names the same.
+		They both can be used to access the uncore PMU.
+
+		Example:
+
+		$ cat /sys/devices/uncore_cha_2/alias
+		uncore_type_0_2
diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
index b941cee..c72e368 100644
--- a/arch/x86/events/intel/uncore.c
+++ b/arch/x86/events/intel/uncore.c
@@ -842,6 +842,18 @@ static const struct attribute_group uncore_pmu_attr_group = {
 	.attrs = uncore_pmu_attrs,
 };
 
+void uncore_get_alias_name(char *pmu_name, struct intel_uncore_pmu *pmu)
+{
+	struct intel_uncore_type *type = pmu->type;
+
+	if (type->num_boxes == 1)
+		sprintf(pmu_name, "uncore_type_%u", type->type_id);
+	else {
+		sprintf(pmu_name, "uncore_type_%u_%d",
+			type->type_id, type->box_ids[pmu->pmu_idx]);
+	}
+}
+
 static void uncore_get_pmu_name(struct intel_uncore_pmu *pmu)
 {
 	struct intel_uncore_type *type = pmu->type;
@@ -851,12 +863,7 @@ static void uncore_get_pmu_name(struct intel_uncore_pmu *pmu)
 	 * Use uncore_type_&typeid_&boxid as name.
 	 */
 	if (!type->name) {
-		if (type->num_boxes == 1)
-			sprintf(pmu->name, "uncore_type_%u", type->type_id);
-		else {
-			sprintf(pmu->name, "uncore_type_%u_%d",
-				type->type_id, type->box_ids[pmu->pmu_idx]);
-		}
+		uncore_get_alias_name(pmu->name, pmu);
 		return;
 	}
 
diff --git a/arch/x86/events/intel/uncore.h b/arch/x86/events/intel/uncore.h
index fa0e938..b968798 100644
--- a/arch/x86/events/intel/uncore.h
+++ b/arch/x86/events/intel/uncore.h
@@ -561,6 +561,7 @@ struct event_constraint *
 uncore_get_constraint(struct intel_uncore_box *box, struct perf_event *event);
 void uncore_put_constraint(struct intel_uncore_box *box, struct perf_event *event);
 u64 uncore_shared_reg_config(struct intel_uncore_box *box, int idx);
+void uncore_get_alias_name(char *pmu_name, struct intel_uncore_pmu *pmu);
 
 extern struct intel_uncore_type *empty_uncore[];
 extern struct intel_uncore_type **uncore_msr_uncores;
diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/uncore_snbep.c
index 1b9ab8e..d0d02e0 100644
--- a/arch/x86/events/intel/uncore_snbep.c
+++ b/arch/x86/events/intel/uncore_snbep.c
@@ -5587,6 +5587,26 @@ static const struct attribute_group spr_uncore_chabox_format_group = {
 	.attrs = spr_uncore_cha_formats_attr,
 };
 
+static ssize_t alias_show(struct device *dev,
+			  struct device_attribute *attr,
+			  char *buf)
+{
+	struct intel_uncore_pmu *pmu = dev_to_uncore_pmu(dev);
+	char pmu_name[UNCORE_PMU_NAME_LEN];
+
+	uncore_get_alias_name(pmu_name, pmu);
+	return sysfs_emit(buf, "%s\n", pmu_name);
+}
+
+static DEVICE_ATTR_RO(alias);
+
+static struct attribute *uncore_alias_attrs[] = {
+	&dev_attr_alias.attr,
+	NULL
+};
+
+ATTRIBUTE_GROUPS(uncore_alias);
+
 static struct intel_uncore_type spr_uncore_chabox = {
 	.name			= "cha",
 	.event_mask		= SPR_CHA_PMON_EVENT_MASK,
@@ -5594,6 +5614,7 @@ static struct intel_uncore_type spr_uncore_chabox = {
 	.num_shared_regs	= 1,
 	.ops			= &spr_uncore_chabox_ops,
 	.format_group		= &spr_uncore_chabox_format_group,
+	.attr_update		= uncore_alias_groups,
 };
 
 static struct intel_uncore_type spr_uncore_iio = {
@@ -5601,6 +5622,7 @@ static struct intel_uncore_type spr_uncore_iio = {
 	.event_mask		= SNBEP_PMON_RAW_EVENT_MASK,
 	.event_mask_ext		= SNR_IIO_PMON_RAW_EVENT_MASK_EXT,
 	.format_group		= &snr_uncore_iio_format_group,
+	.attr_update		= uncore_alias_groups,
 };
 
 static struct attribute *spr_uncore_raw_formats_attr[] = {
@@ -5620,7 +5642,8 @@ static const struct attribute_group spr_uncore_raw_format_group = {
 #define SPR_UNCORE_COMMON_FORMAT()				\
 	.event_mask		= SNBEP_PMON_RAW_EVENT_MASK,	\
 	.event_mask_ext		= SPR_RAW_EVENT_MASK_EXT,	\
-	.format_group		= &spr_uncore_raw_format_group
+	.format_group		= &spr_uncore_raw_format_group,	\
+	.attr_update		= uncore_alias_groups
 
 static struct intel_uncore_type spr_uncore_irp = {
 	SPR_UNCORE_COMMON_FORMAT(),
@@ -5635,6 +5658,7 @@ static struct intel_uncore_type spr_uncore_m2pcie = {
 
 static struct intel_uncore_type spr_uncore_pcu = {
 	.name			= "pcu",
+	.attr_update		= uncore_alias_groups,
 };
 
 static void spr_uncore_mmio_enable_event(struct intel_uncore_box *box,
@@ -5760,6 +5784,8 @@ static void uncore_type_customized_copy(struct intel_uncore_type *to_type,
 		to_type->event_descs = from_type->event_descs;
 	if (from_type->format_group)
 		to_type->format_group = from_type->format_group;
+	if (from_type->attr_update)
+		to_type->attr_update = from_type->attr_update;
 }
 
 static struct intel_uncore_type **
