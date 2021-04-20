Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC52736568D
	for <lists+linux-tip-commits@lfdr.de>; Tue, 20 Apr 2021 12:46:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231808AbhDTKrS (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 20 Apr 2021 06:47:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231651AbhDTKrR (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 20 Apr 2021 06:47:17 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5285C06174A;
        Tue, 20 Apr 2021 03:46:45 -0700 (PDT)
Date:   Tue, 20 Apr 2021 10:46:43 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1618915604;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=B4llrK+JCpLTIotqAYqDWtVVp9zOKApfOtbN+TY6GIk=;
        b=B1aEWw0x6ava1P9TVlXzsX8CxXMio/MjdIbBo+8e+GJmQphjD7o7Yo1x8n/YKht6j3/TBJ
        bh6LKf0gBEk6uA6dNF3p/7Z6TZoqawWxty2NACfj+m/8vmPb7Q3Mi8iVewJrLSgYhi9uQg
        UWLTTRnYz7p8XcgP3e99xLhmxl2+Enr4x4FtRILYq0XAoaTZIPYsKNivMvXhRJEsyo4nk1
        XvKZrZVrrvP7E3iH7fc9mzx8fSYMV3Yz2A2uG9pYdmgrMdjld0ybigXPQoczt87TEjEY4k
        O+u8I8AqnJqwM+ZBwyeHUBlJpGKePtzCAb5GiyfcGDYMhtibCppNCfqBvOXRUg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1618915604;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=B4llrK+JCpLTIotqAYqDWtVVp9zOKApfOtbN+TY6GIk=;
        b=fG+uNW8Ly9efWM6951RjUN7z4aVVxsU5tB0qRlXBc7Tt6WLHbS+aLvQIbDZ0yNg0rxdfVC
        wNlyYq/gZhMNErDQ==
From:   "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86: Add structures for the attributes of Hybrid PMUs
Cc:     Kan Liang <kan.liang@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Andi Kleen <ak@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <1618237865-33448-18-git-send-email-kan.liang@linux.intel.com>
References: <1618237865-33448-18-git-send-email-kan.liang@linux.intel.com>
MIME-Version: 1.0
Message-ID: <161891560361.29796.6013328590594444170.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     a9c81ccdf52dd73a20178c40bca34cf52991fdea
Gitweb:        https://git.kernel.org/tip/a9c81ccdf52dd73a20178c40bca34cf52991fdea
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Mon, 12 Apr 2021 07:30:57 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 19 Apr 2021 20:03:28 +02:00

perf/x86: Add structures for the attributes of Hybrid PMUs

Hybrid PMUs have different events and formats. In theory, Hybrid PMU
specific attributes should be maintained in the dedicated struct
x86_hybrid_pmu, but it wastes space because the events and formats are
similar among Hybrid PMUs.

To reduce duplication, all hybrid PMUs will share a group of attributes
in the following patch. To distinguish an attribute from different
Hybrid PMUs, a PMU aware attribute structure is introduced. A PMU type
is required for the attribute structure. The type is internal usage. It
is not visible in the sysfs API.

Hybrid PMUs may support the same event name, but with different event
encoding, e.g., the mem-loads event on an Atom PMU has different event
encoding from a Core PMU. It brings issue if two attributes are
created for them. Current sysfs_update_group finds an attribute by
searching the attr name (aka event name). If two attributes have the
same event name, the first attribute will be replaced.
To address the issue, only one attribute is created for the event. The
event_str is extended and stores event encodings from all Hybrid PMUs.
Each event encoding is divided by ";". The order of the event encodings
must follow the order of the hybrid PMU index. The event_str is internal
usage as well. When a user wants to show the attribute of a Hybrid PMU,
only the corresponding part of the string is displayed.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Link: https://lkml.kernel.org/r/1618237865-33448-18-git-send-email-kan.liang@linux.intel.com
---
 arch/x86/events/core.c       | 43 +++++++++++++++++++++++++++++++++++-
 arch/x86/events/perf_event.h | 19 +++++++++++++++-
 include/linux/perf_event.h   | 12 ++++++++++-
 3 files changed, 74 insertions(+)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index bd465a8..37ab109 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -1860,6 +1860,49 @@ ssize_t events_ht_sysfs_show(struct device *dev, struct device_attribute *attr,
 			pmu_attr->event_str_noht);
 }
 
+ssize_t events_hybrid_sysfs_show(struct device *dev,
+				 struct device_attribute *attr,
+				 char *page)
+{
+	struct perf_pmu_events_hybrid_attr *pmu_attr =
+		container_of(attr, struct perf_pmu_events_hybrid_attr, attr);
+	struct x86_hybrid_pmu *pmu;
+	const char *str, *next_str;
+	int i;
+
+	if (hweight64(pmu_attr->pmu_type) == 1)
+		return sprintf(page, "%s", pmu_attr->event_str);
+
+	/*
+	 * Hybrid PMUs may support the same event name, but with different
+	 * event encoding, e.g., the mem-loads event on an Atom PMU has
+	 * different event encoding from a Core PMU.
+	 *
+	 * The event_str includes all event encodings. Each event encoding
+	 * is divided by ";". The order of the event encodings must follow
+	 * the order of the hybrid PMU index.
+	 */
+	pmu = container_of(dev_get_drvdata(dev), struct x86_hybrid_pmu, pmu);
+
+	str = pmu_attr->event_str;
+	for (i = 0; i < x86_pmu.num_hybrid_pmus; i++) {
+		if (!(x86_pmu.hybrid_pmu[i].cpu_type & pmu_attr->pmu_type))
+			continue;
+		if (x86_pmu.hybrid_pmu[i].cpu_type & pmu->cpu_type) {
+			next_str = strchr(str, ';');
+			if (next_str)
+				return snprintf(page, next_str - str + 1, "%s", str);
+			else
+				return sprintf(page, "%s", str);
+		}
+		str = strchr(str, ';');
+		str++;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(events_hybrid_sysfs_show);
+
 EVENT_ATTR(cpu-cycles,			CPU_CYCLES		);
 EVENT_ATTR(instructions,		INSTRUCTIONS		);
 EVENT_ATTR(cache-references,		CACHE_REFERENCES	);
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index 4282ce4..e2be927 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -979,6 +979,22 @@ static struct perf_pmu_events_ht_attr event_attr_##v = {		\
 	.event_str_ht	= ht,						\
 }
 
+#define EVENT_ATTR_STR_HYBRID(_name, v, str, _pmu)			\
+static struct perf_pmu_events_hybrid_attr event_attr_##v = {		\
+	.attr		= __ATTR(_name, 0444, events_hybrid_sysfs_show, NULL),\
+	.id		= 0,						\
+	.event_str	= str,						\
+	.pmu_type	= _pmu,						\
+}
+
+#define FORMAT_HYBRID_PTR(_id) (&format_attr_hybrid_##_id.attr.attr)
+
+#define FORMAT_ATTR_HYBRID(_name, _pmu)					\
+static struct perf_pmu_format_hybrid_attr format_attr_hybrid_##_name = {\
+	.attr		= __ATTR_RO(_name),				\
+	.pmu_type	= _pmu,						\
+}
+
 struct pmu *x86_get_pmu(unsigned int cpu);
 extern struct x86_pmu x86_pmu __read_mostly;
 
@@ -1149,6 +1165,9 @@ ssize_t events_sysfs_show(struct device *dev, struct device_attribute *attr,
 			  char *page);
 ssize_t events_ht_sysfs_show(struct device *dev, struct device_attribute *attr,
 			  char *page);
+ssize_t events_hybrid_sysfs_show(struct device *dev,
+				 struct device_attribute *attr,
+				 char *page);
 
 static inline bool fixed_counter_disabled(int i, struct pmu *pmu)
 {
diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 8989b2b..61b3851 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -1549,6 +1549,18 @@ struct perf_pmu_events_ht_attr {
 	const char				*event_str_noht;
 };
 
+struct perf_pmu_events_hybrid_attr {
+	struct device_attribute			attr;
+	u64					id;
+	const char				*event_str;
+	u64					pmu_type;
+};
+
+struct perf_pmu_format_hybrid_attr {
+	struct device_attribute			attr;
+	u64					pmu_type;
+};
+
 ssize_t perf_event_sysfs_show(struct device *dev, struct device_attribute *attr,
 			      char *page);
 
