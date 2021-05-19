Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55C04388943
	for <lists+linux-tip-commits@lfdr.de>; Wed, 19 May 2021 10:21:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244880AbhESIWp (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 19 May 2021 04:22:45 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:37578 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244833AbhESIWo (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 19 May 2021 04:22:44 -0400
Date:   Wed, 19 May 2021 08:21:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1621412484;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HIw8dnu53pFwZ5xA7SOe8Tp9vdPkPt+jkQnOLpPAFsY=;
        b=SqXwHIbk+FmvBPKIqHlp3BIEHI7JHOI+3lkn4Z99cDZWmma5AHrkfc1vUz0TRVAMg5awt5
        4P21OK0Qwzxki2ES6BLJ3jkrNHWU69SPJH2ujqdY04FEoQ0xcqoF49cLPZzmLe7YrzhfJv
        hpCyvCja6dLvxZS5lcUPBDYRU4A3plAfBxR9etwFDGkTy4qMRR+Ajnd4PZJG3WKNKRdCwv
        yEGAni3Y30jvt9wal8KgiezWyR0oPt/XYxE0RHdM1clN8jVBS9dY0BlhpfRnntQmPl5W6o
        8JpjAKbrjbJFiDUimhSpFZbfp1rPYprHb7s2XQ0Zvk3HNV3wXFYaD0L9kQoTiA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1621412484;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HIw8dnu53pFwZ5xA7SOe8Tp9vdPkPt+jkQnOLpPAFsY=;
        b=tT/ZdnNCbww4tRYkvgCtjy4GypnT1dgnENK3zR/Be7408K5seB2HmStCe3UC0UAmZt/04X
        IBbmqlNBkEVvTuAQ==
From:   "tip-bot2 for Alexander Antonov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/intel/uncore: Generalize I/O stacks to PMON
 mapping procedure
Cc:     Alexander Antonov <alexander.antonov@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Kan Liang <kan.liang@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210426131614.16205-2-alexander.antonov@linux.intel.com>
References: <20210426131614.16205-2-alexander.antonov@linux.intel.com>
MIME-Version: 1.0
Message-ID: <162141248376.29796.1780181718595225295.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     f471fac77b41a2573c7b677ef790bf18a0e64195
Gitweb:        https://git.kernel.org/tip/f471fac77b41a2573c7b677ef790bf18a0e64195
Author:        Alexander Antonov <alexander.antonov@linux.intel.com>
AuthorDate:    Mon, 26 Apr 2021 16:16:12 +03:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 18 May 2021 12:53:56 +02:00

perf/x86/intel/uncore: Generalize I/O stacks to PMON mapping procedure

Currently I/O stacks to IIO PMON mapping is available on Skylake servers
only and need to make code more general to easily enable further platforms.
So, introduce get_topology() callback in struct intel_uncore_type which
allows to move common code to separate function and make mapping procedure
more general.

Signed-off-by: Alexander Antonov <alexander.antonov@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
Link: https://lkml.kernel.org/r/20210426131614.16205-2-alexander.antonov@linux.intel.com
---
 arch/x86/events/intel/uncore.h       |  1 +
 arch/x86/events/intel/uncore_snbep.c | 26 ++++++++++++++++++++------
 2 files changed, 21 insertions(+), 6 deletions(-)

diff --git a/arch/x86/events/intel/uncore.h b/arch/x86/events/intel/uncore.h
index 2917910..187d728 100644
--- a/arch/x86/events/intel/uncore.h
+++ b/arch/x86/events/intel/uncore.h
@@ -92,6 +92,7 @@ struct intel_uncore_type {
 	/*
 	 * Optional callbacks for managing mapping of Uncore units to PMONs
 	 */
+	int (*get_topology)(struct intel_uncore_type *type);
 	int (*set_mapping)(struct intel_uncore_type *type);
 	void (*cleanup_mapping)(struct intel_uncore_type *type);
 };
diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/uncore_snbep.c
index 63f0972..02e36a3 100644
--- a/arch/x86/events/intel/uncore_snbep.c
+++ b/arch/x86/events/intel/uncore_snbep.c
@@ -3680,12 +3680,19 @@ static inline u8 skx_iio_stack(struct intel_uncore_pmu *pmu, int die)
 }
 
 static umode_t
-skx_iio_mapping_visible(struct kobject *kobj, struct attribute *attr, int die)
+pmu_iio_mapping_visible(struct kobject *kobj, struct attribute *attr,
+			 int die, int zero_bus_pmu)
 {
 	struct intel_uncore_pmu *pmu = dev_to_uncore_pmu(kobj_to_dev(kobj));
 
-	/* Root bus 0x00 is valid only for die 0 AND pmu_idx = 0. */
-	return (!skx_iio_stack(pmu, die) && pmu->pmu_idx) ? 0 : attr->mode;
+	return (!skx_iio_stack(pmu, die) && pmu->pmu_idx != zero_bus_pmu) ? 0 : attr->mode;
+}
+
+static umode_t
+skx_iio_mapping_visible(struct kobject *kobj, struct attribute *attr, int die)
+{
+	/* Root bus 0x00 is valid only for pmu_idx = 0. */
+	return pmu_iio_mapping_visible(kobj, attr, die, 0);
 }
 
 static ssize_t skx_iio_mapping_show(struct device *dev,
@@ -3770,7 +3777,8 @@ static const struct attribute_group *skx_iio_attr_update[] = {
 	NULL,
 };
 
-static int skx_iio_set_mapping(struct intel_uncore_type *type)
+static int
+pmu_iio_set_mapping(struct intel_uncore_type *type, struct attribute_group *ag)
 {
 	char buf[64];
 	int ret;
@@ -3778,7 +3786,7 @@ static int skx_iio_set_mapping(struct intel_uncore_type *type)
 	struct attribute **attrs = NULL;
 	struct dev_ext_attribute *eas = NULL;
 
-	ret = skx_iio_get_topology(type);
+	ret = type->get_topology(type);
 	if (ret < 0)
 		goto clear_attr_update;
 
@@ -3805,7 +3813,7 @@ static int skx_iio_set_mapping(struct intel_uncore_type *type)
 		eas[die].var = (void *)die;
 		attrs[die] = &eas[die].attr.attr;
 	}
-	skx_iio_mapping_group.attrs = attrs;
+	ag->attrs = attrs;
 
 	return 0;
 err:
@@ -3819,6 +3827,11 @@ clear_attr_update:
 	return ret;
 }
 
+static int skx_iio_set_mapping(struct intel_uncore_type *type)
+{
+	return pmu_iio_set_mapping(type, &skx_iio_mapping_group);
+}
+
 static void skx_iio_cleanup_mapping(struct intel_uncore_type *type)
 {
 	struct attribute **attr = skx_iio_mapping_group.attrs;
@@ -3849,6 +3862,7 @@ static struct intel_uncore_type skx_uncore_iio = {
 	.ops			= &skx_uncore_iio_ops,
 	.format_group		= &skx_uncore_iio_format_group,
 	.attr_update		= skx_iio_attr_update,
+	.get_topology		= skx_iio_get_topology,
 	.set_mapping		= skx_iio_set_mapping,
 	.cleanup_mapping	= skx_iio_cleanup_mapping,
 };
