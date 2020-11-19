Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 939872B8F86
	for <lists+linux-tip-commits@lfdr.de>; Thu, 19 Nov 2020 11:00:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726287AbgKSJzF (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 19 Nov 2020 04:55:05 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:60864 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726105AbgKSJzF (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 19 Nov 2020 04:55:05 -0500
Date:   Thu, 19 Nov 2020 09:55:01 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605779702;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=V3r71N0aZOQGsOS8m8FFhpMbIvdAX/Eyvmj3TGx/Z88=;
        b=KnZQ4anXVhG4xQM9bXR9r+/TUcYz8z1J56PgysfFO+HrfT5m6e27KIDRpdJvq9oY25LXMc
        xLjA+pgw1AiH2CPP70gqnMUWEzy2CjNDIr9ntXQjIAq9vkdC3Hik98thf/yHo8nQ/wQF7Z
        nqiPUVfz/OgRpBHHbgNyLTZjR/EuerD/dgkQn7w+/CU0nrHLhdZ+RJA1t7Zz6mDxooMK8I
        pc/AmjiggNZ1NgJ/P6MxgV9oTJDml9HQ/5fiGmQRk/FElUdVZGMRyPirHs+PLoTLssQBlF
        m8a7QRdcbcVa5OmvF+2leEElEFjUe/+POZTZbur7jbhXuY67tc56wWrpYu8oew==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605779702;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=V3r71N0aZOQGsOS8m8FFhpMbIvdAX/Eyvmj3TGx/Z88=;
        b=lXtYV5LnOh6NQFGXnzVKHgIad/q8f1QarDPr/joqXopRRrttgoLzCgZ0XXstDyGa1gsRKb
        Jwv7RBTNlVOL50BA==
From:   "tip-bot2 for Sami Tolvanen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf/x86: fix sysfs type mismatches
Cc:     Sedat Dilek <sedat.dilek@gmail.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Kees Cook <keescook@chromium.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20201113183126.1239404-1-samitolvanen@google.com>
References: <20201113183126.1239404-1-samitolvanen@google.com>
MIME-Version: 1.0
Message-ID: <160577970173.11244.12158409592760098153.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     ebd19fc372e3e78bf165f230e7c084e304441c08
Gitweb:        https://git.kernel.org/tip/ebd19fc372e3e78bf165f230e7c084e304441c08
Author:        Sami Tolvanen <samitolvanen@google.com>
AuthorDate:    Fri, 13 Nov 2020 10:31:26 -08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 17 Nov 2020 13:15:38 +01:00

perf/x86: fix sysfs type mismatches

This change switches rapl to use PMU_FORMAT_ATTR, and fixes two other
macros to use device_attribute instead of kobj_attribute to avoid
callback type mismatches that trip indirect call checking with Clang's
Control-Flow Integrity (CFI).

Reported-by: Sedat Dilek <sedat.dilek@gmail.com>
Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Kees Cook <keescook@chromium.org>
Link: https://lkml.kernel.org/r/20201113183126.1239404-1-samitolvanen@google.com
---
 arch/x86/events/intel/cstate.c |  6 +++---
 arch/x86/events/intel/uncore.c |  4 ++--
 arch/x86/events/intel/uncore.h | 12 ++++++------
 arch/x86/events/rapl.c         | 14 +-------------
 4 files changed, 12 insertions(+), 24 deletions(-)

diff --git a/arch/x86/events/intel/cstate.c b/arch/x86/events/intel/cstate.c
index 442e1ed..4eb7ee5 100644
--- a/arch/x86/events/intel/cstate.c
+++ b/arch/x86/events/intel/cstate.c
@@ -107,14 +107,14 @@
 MODULE_LICENSE("GPL");
 
 #define DEFINE_CSTATE_FORMAT_ATTR(_var, _name, _format)		\
-static ssize_t __cstate_##_var##_show(struct kobject *kobj,	\
-				struct kobj_attribute *attr,	\
+static ssize_t __cstate_##_var##_show(struct device *dev,	\
+				struct device_attribute *attr,	\
 				char *page)			\
 {								\
 	BUILD_BUG_ON(sizeof(_format) >= PAGE_SIZE);		\
 	return sprintf(page, _format "\n");			\
 }								\
-static struct kobj_attribute format_attr_##_var =		\
+static struct device_attribute format_attr_##_var =		\
 	__ATTR(_name, 0444, __cstate_##_var##_show, NULL)
 
 static ssize_t cstate_get_attr_cpumask(struct device *dev,
diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
index 86d012b..80d52cb 100644
--- a/arch/x86/events/intel/uncore.c
+++ b/arch/x86/events/intel/uncore.c
@@ -94,8 +94,8 @@ end:
 	return map;
 }
 
-ssize_t uncore_event_show(struct kobject *kobj,
-			  struct kobj_attribute *attr, char *buf)
+ssize_t uncore_event_show(struct device *dev,
+			  struct device_attribute *attr, char *buf)
 {
 	struct uncore_event_desc *event =
 		container_of(attr, struct uncore_event_desc, attr);
diff --git a/arch/x86/events/intel/uncore.h b/arch/x86/events/intel/uncore.h
index 83d2a7d..9efea15 100644
--- a/arch/x86/events/intel/uncore.h
+++ b/arch/x86/events/intel/uncore.h
@@ -157,7 +157,7 @@ struct intel_uncore_box {
 #define UNCORE_BOX_FLAG_CFL8_CBOX_MSR_OFFS	2
 
 struct uncore_event_desc {
-	struct kobj_attribute attr;
+	struct device_attribute attr;
 	const char *config;
 };
 
@@ -179,8 +179,8 @@ struct pci2phy_map {
 struct pci2phy_map *__find_pci2phy_map(int segment);
 int uncore_pcibus_to_physid(struct pci_bus *bus);
 
-ssize_t uncore_event_show(struct kobject *kobj,
-			  struct kobj_attribute *attr, char *buf);
+ssize_t uncore_event_show(struct device *dev,
+			  struct device_attribute *attr, char *buf);
 
 static inline struct intel_uncore_pmu *dev_to_uncore_pmu(struct device *dev)
 {
@@ -201,14 +201,14 @@ extern int __uncore_max_dies;
 }
 
 #define DEFINE_UNCORE_FORMAT_ATTR(_var, _name, _format)			\
-static ssize_t __uncore_##_var##_show(struct kobject *kobj,		\
-				struct kobj_attribute *attr,		\
+static ssize_t __uncore_##_var##_show(struct device *dev,		\
+				struct device_attribute *attr,		\
 				char *page)				\
 {									\
 	BUILD_BUG_ON(sizeof(_format) >= PAGE_SIZE);			\
 	return sprintf(page, _format "\n");				\
 }									\
-static struct kobj_attribute format_attr_##_var =			\
+static struct device_attribute format_attr_##_var =			\
 	__ATTR(_name, 0444, __uncore_##_var##_show, NULL)
 
 static inline bool uncore_pmc_fixed(int idx)
diff --git a/arch/x86/events/rapl.c b/arch/x86/events/rapl.c
index 7c0120e..7dbbeaa 100644
--- a/arch/x86/events/rapl.c
+++ b/arch/x86/events/rapl.c
@@ -93,18 +93,6 @@ static const char *const rapl_domain_names[NR_RAPL_DOMAINS] __initconst = {
  * any other bit is reserved
  */
 #define RAPL_EVENT_MASK	0xFFULL
-
-#define DEFINE_RAPL_FORMAT_ATTR(_var, _name, _format)		\
-static ssize_t __rapl_##_var##_show(struct kobject *kobj,	\
-				struct kobj_attribute *attr,	\
-				char *page)			\
-{								\
-	BUILD_BUG_ON(sizeof(_format) >= PAGE_SIZE);		\
-	return sprintf(page, _format "\n");			\
-}								\
-static struct kobj_attribute format_attr_##_var =		\
-	__ATTR(_name, 0444, __rapl_##_var##_show, NULL)
-
 #define RAPL_CNTR_WIDTH 32
 
 #define RAPL_EVENT_ATTR_STR(_name, v, str)					\
@@ -441,7 +429,7 @@ static struct attribute_group rapl_pmu_events_group = {
 	.attrs = attrs_empty,
 };
 
-DEFINE_RAPL_FORMAT_ATTR(event, event, "config:0-7");
+PMU_FORMAT_ATTR(event, "config:0-7");
 static struct attribute *rapl_formats_attr[] = {
 	&format_attr_event.attr,
 	NULL,
