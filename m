Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0369127871A
	for <lists+linux-tip-commits@lfdr.de>; Fri, 25 Sep 2020 14:24:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728508AbgIYMYH (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 25 Sep 2020 08:24:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728450AbgIYMX7 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 25 Sep 2020 08:23:59 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 740B2C0613D3;
        Fri, 25 Sep 2020 05:23:59 -0700 (PDT)
Date:   Fri, 25 Sep 2020 12:23:56 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1601036637;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tJ9J2h+/ugn5IQJR3E5DTUKo+BvsAsyFbUvgBqLn6bs=;
        b=IQ05FXBoO679cytAXM/lKWtSW5udO4izXM+D1kzHXpogrf4ANux6wM1gaEnJew9kIkrfho
        E8925Lg0qgdE+pBVTkv77I6YooDXN2zwFf1APz+KM4yJJdtrJziajcT6/cdUY9XbzCVd64
        VCQ/n1swP5wmdg2N0dZ+/AFrpxVqaMnmVhjgtQYlaH27cT3WjDH2+jZanV5W/Y1jPovzlI
        p2a9iOY9QM8VxhYHCCuNhzAhotUbI/DdFMOdxUJVDe2xLNMxDoMmRsByG3TRyPd76KLP+7
        rnZzH3lsjgdQxXD97IB+rp+n/8/GT/Cjps7v6HH24yD5JIWkd8qe4a0UMNMNug==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1601036637;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tJ9J2h+/ugn5IQJR3E5DTUKo+BvsAsyFbUvgBqLn6bs=;
        b=zrlKQUdsNbSRHh0GxOi7qqf5XpQsc8TQaNxZ27QSs9wYZOeZuBuhXiZG5CtE7ProRPy2CC
        9i7r53Ty8lGVxsCQ==
From:   "tip-bot2 for Kim Phillips" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/amd/uncore: Prepare to scale for more
 attributes that vary per family
Cc:     Kim Phillips <kim.phillips@amd.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200921144330.6331-2-kim.phillips@amd.com>
References: <20200921144330.6331-2-kim.phillips@amd.com>
MIME-Version: 1.0
Message-ID: <160103663674.7002.13030455125185995340.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     06f2c24584f31bc16129643bfb8239a1af82a17f
Gitweb:        https://git.kernel.org/tip/06f2c24584f31bc16129643bfb8239a1af82a17f
Author:        Kim Phillips <kim.phillips@amd.com>
AuthorDate:    Mon, 21 Sep 2020 09:43:27 -05:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 24 Sep 2020 15:55:49 +02:00

perf/amd/uncore: Prepare to scale for more attributes that vary per family

Replace AMD_FORMAT_ATTR with the more apropos DEFINE_UNCORE_FORMAT_ATTR
stolen from arch/x86/events/intel/uncore.h.  This way we can clearly
see the bit-variants of each of the attributes that want to have
the same name across families.

Also unroll AMD_ATTRIBUTE because we are going to separately add
new attributes that differ between DF and L3.

Also clean up the if-Family 17h-else logic in amd_uncore_init.

This is basically a rewrite of commit da6adaea2b7e
("perf/x86/amd/uncore: Update sysfs attributes for Family17h processors").

No functional changes.

Tested F17h+ /sys/bus/event_source/devices/amd_{l3,df}/format/*
content remains unchanged:

/sys/bus/event_source/devices/amd_l3/format/event:config:0-7
/sys/bus/event_source/devices/amd_l3/format/umask:config:8-15
/sys/bus/event_source/devices/amd_df/format/event:config:0-7,32-35,59-60
/sys/bus/event_source/devices/amd_df/format/umask:config:8-15

Signed-off-by: Kim Phillips <kim.phillips@amd.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20200921144330.6331-2-kim.phillips@amd.com
---
 arch/x86/events/amd/uncore.c | 111 ++++++++++++++++++----------------
 1 file changed, 61 insertions(+), 50 deletions(-)

diff --git a/arch/x86/events/amd/uncore.c b/arch/x86/events/amd/uncore.c
index e7e61c8..15c7982 100644
--- a/arch/x86/events/amd/uncore.c
+++ b/arch/x86/events/amd/uncore.c
@@ -262,47 +262,60 @@ static struct attribute_group amd_uncore_attr_group = {
 	.attrs = amd_uncore_attrs,
 };
 
-/*
- * Similar to PMU_FORMAT_ATTR but allowing for format_attr to be assigned based
- * on family
- */
-#define AMD_FORMAT_ATTR(_dev, _name, _format)				     \
-static ssize_t								     \
-_dev##_show##_name(struct device *dev,					     \
-		struct device_attribute *attr,				     \
-		char *page)						     \
-{									     \
-	BUILD_BUG_ON(sizeof(_format) >= PAGE_SIZE);			     \
-	return sprintf(page, _format "\n");				     \
-}									     \
-static struct device_attribute format_attr_##_dev##_name = __ATTR_RO(_dev);
-
-/* Used for each uncore counter type */
-#define AMD_ATTRIBUTE(_name)						     \
-static struct attribute *amd_uncore_format_attr_##_name[] = {		     \
-	&format_attr_event_##_name.attr,				     \
-	&format_attr_umask.attr,					     \
-	NULL,								     \
-};									     \
-static struct attribute_group amd_uncore_format_group_##_name = {	     \
-	.name = "format",						     \
-	.attrs = amd_uncore_format_attr_##_name,			     \
-};									     \
-static const struct attribute_group *amd_uncore_attr_groups_##_name[] = {    \
-	&amd_uncore_attr_group,						     \
-	&amd_uncore_format_group_##_name,				     \
-	NULL,								     \
+#define DEFINE_UNCORE_FORMAT_ATTR(_var, _name, _format)			\
+static ssize_t __uncore_##_var##_show(struct kobject *kobj,		\
+				struct kobj_attribute *attr,		\
+				char *page)				\
+{									\
+	BUILD_BUG_ON(sizeof(_format) >= PAGE_SIZE);			\
+	return sprintf(page, _format "\n");				\
+}									\
+static struct kobj_attribute format_attr_##_var =			\
+	__ATTR(_name, 0444, __uncore_##_var##_show, NULL)
+
+DEFINE_UNCORE_FORMAT_ATTR(event12,	event,		"config:0-7,32-35");
+DEFINE_UNCORE_FORMAT_ATTR(event14,	event,		"config:0-7,32-35,59-60"); /* F17h+ DF */
+DEFINE_UNCORE_FORMAT_ATTR(event8,	event,		"config:0-7");		   /* F17h+ L3 */
+DEFINE_UNCORE_FORMAT_ATTR(umask,	umask,		"config:8-15");
+
+static struct attribute *amd_uncore_df_format_attr[] = {
+	&format_attr_event12.attr, /* event14 if F17h+ */
+	&format_attr_umask.attr,
+	NULL,
+};
+
+static struct attribute *amd_uncore_l3_format_attr[] = {
+	&format_attr_event12.attr, /* event8 if F17h+ */
+	&format_attr_umask.attr,
+	NULL,
+};
+
+static struct attribute_group amd_uncore_df_format_group = {
+	.name = "format",
+	.attrs = amd_uncore_df_format_attr,
+};
+
+static struct attribute_group amd_uncore_l3_format_group = {
+	.name = "format",
+	.attrs = amd_uncore_l3_format_attr,
 };
 
-AMD_FORMAT_ATTR(event, , "config:0-7,32-35");
-AMD_FORMAT_ATTR(umask, , "config:8-15");
-AMD_FORMAT_ATTR(event, _df, "config:0-7,32-35,59-60");
-AMD_FORMAT_ATTR(event, _l3, "config:0-7");
-AMD_ATTRIBUTE(df);
-AMD_ATTRIBUTE(l3);
+static const struct attribute_group *amd_uncore_df_attr_groups[] = {
+	&amd_uncore_attr_group,
+	&amd_uncore_df_format_group,
+	NULL,
+};
+
+static const struct attribute_group *amd_uncore_l3_attr_groups[] = {
+	&amd_uncore_attr_group,
+	&amd_uncore_l3_format_group,
+	NULL,
+};
 
 static struct pmu amd_nb_pmu = {
 	.task_ctx_nr	= perf_invalid_context,
+	.attr_groups	= amd_uncore_df_attr_groups,
+	.name		= "amd_nb",
 	.event_init	= amd_uncore_event_init,
 	.add		= amd_uncore_add,
 	.del		= amd_uncore_del,
@@ -314,6 +327,8 @@ static struct pmu amd_nb_pmu = {
 
 static struct pmu amd_llc_pmu = {
 	.task_ctx_nr	= perf_invalid_context,
+	.attr_groups	= amd_uncore_l3_attr_groups,
+	.name		= "amd_l2",
 	.event_init	= amd_uncore_event_init,
 	.add		= amd_uncore_add,
 	.del		= amd_uncore_del,
@@ -517,6 +532,8 @@ static int amd_uncore_cpu_dead(unsigned int cpu)
 
 static int __init amd_uncore_init(void)
 {
+	struct attribute **df_attr = amd_uncore_df_format_attr;
+	struct attribute **l3_attr = amd_uncore_l3_format_attr;
 	int ret = -ENODEV;
 
 	if (boot_cpu_data.x86_vendor != X86_VENDOR_AMD &&
@@ -526,6 +543,8 @@ static int __init amd_uncore_init(void)
 	if (!boot_cpu_has(X86_FEATURE_TOPOEXT))
 		return -ENODEV;
 
+	num_counters_nb	= NUM_COUNTERS_NB;
+	num_counters_llc = NUM_COUNTERS_L2;
 	if (boot_cpu_data.x86 >= 0x17) {
 		/*
 		 * For F17h and above, the Northbridge counters are
@@ -533,27 +552,16 @@ static int __init amd_uncore_init(void)
 		 * counters are supported too. The PMUs are exported
 		 * based on family as either L2 or L3 and NB or DF.
 		 */
-		num_counters_nb		  = NUM_COUNTERS_NB;
 		num_counters_llc	  = NUM_COUNTERS_L3;
 		amd_nb_pmu.name		  = "amd_df";
 		amd_llc_pmu.name	  = "amd_l3";
-		format_attr_event_df.show = &event_show_df;
-		format_attr_event_l3.show = &event_show_l3;
 		l3_mask			  = true;
-	} else {
-		num_counters_nb		  = NUM_COUNTERS_NB;
-		num_counters_llc	  = NUM_COUNTERS_L2;
-		amd_nb_pmu.name		  = "amd_nb";
-		amd_llc_pmu.name	  = "amd_l2";
-		format_attr_event_df	  = format_attr_event;
-		format_attr_event_l3	  = format_attr_event;
-		l3_mask			  = false;
 	}
 
-	amd_nb_pmu.attr_groups	= amd_uncore_attr_groups_df;
-	amd_llc_pmu.attr_groups = amd_uncore_attr_groups_l3;
-
 	if (boot_cpu_has(X86_FEATURE_PERFCTR_NB)) {
+		if (boot_cpu_data.x86 >= 0x17)
+			*df_attr = &format_attr_event14.attr;
+
 		amd_uncore_nb = alloc_percpu(struct amd_uncore *);
 		if (!amd_uncore_nb) {
 			ret = -ENOMEM;
@@ -570,6 +578,9 @@ static int __init amd_uncore_init(void)
 	}
 
 	if (boot_cpu_has(X86_FEATURE_PERFCTR_LLC)) {
+		if (boot_cpu_data.x86 >= 0x17)
+			*l3_attr = &format_attr_event8.attr;
+
 		amd_uncore_llc = alloc_percpu(struct amd_uncore *);
 		if (!amd_uncore_llc) {
 			ret = -ENOMEM;
