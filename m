Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FD923E7D40
	for <lists+linux-tip-commits@lfdr.de>; Tue, 10 Aug 2021 18:14:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234054AbhHJQPE (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 10 Aug 2021 12:15:04 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:44526 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233697AbhHJQPD (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 10 Aug 2021 12:15:03 -0400
Date:   Tue, 10 Aug 2021 16:14:38 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628612079;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EfSkqEWB2iL7ol++AoUyQUkD1YwKKukEj+prXFTL7LU=;
        b=2Epjrz5wqerpi1xBkIzxMvunjvCEmwYSrAHK93wk+gmwPL2xz3Ig+9RqCFczSpuaNU33El
        8kurzUzdU+3G2uOn8rGkqyMngY3U+RxdlerSiUBV9lmyilvu0O6OZI5JwirvWhrMKJnIPP
        /BYRGy6xowLoYaB9XfLzqnQGk/Jy/5xQYiPkgqIZpwIbkzCLuwvPm/+PTg2UUS0gfXW64u
        8hcKlV1n6xR0Z8Vl6KRkCJMkW839quMiI/TzoCwwyUBBKRtRh2ZDYGzcpwKxLrbTz4IWeU
        z9ZoK8c35Cep5B8ylV5MguCM2HbBfP07ykU0qJEeqt4jvgQO5T5M+RPFCr5UXA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628612079;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EfSkqEWB2iL7ol++AoUyQUkD1YwKKukEj+prXFTL7LU=;
        b=dx5Fx7mjKnRNtMO5yG4rIkcsKeqrq+m2yUATDGIOnObmWlXaq1DjqUGoVeUGqShudGBT2n
        TcVilGyz7463MGAA==
From:   "tip-bot2 for YueHaibing" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: smp/core] cpu/hotplug: Use DEVICE_ATTR_*() macro
Cc:     YueHaibing <yuehaibing@huawei.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210527141105.2312-1-yuehaibing@huawei.com>
References: <20210527141105.2312-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Message-ID: <162861207895.395.8410422606147143430.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the smp/core branch of tip:

Commit-ID:     1782dc87b2edcf3a6c350ead748a8941b5835975
Gitweb:        https://git.kernel.org/tip/1782dc87b2edcf3a6c350ead748a8941b5835975
Author:        YueHaibing <yuehaibing@huawei.com>
AuthorDate:    Thu, 27 May 2021 22:11:05 +08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 10 Aug 2021 18:11:12 +02:00

cpu/hotplug: Use DEVICE_ATTR_*() macro

Use DEVICE_ATTR_*() helper instead of plain DEVICE_ATTR,
which makes the code a bit shorter and easier to read.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20210527141105.2312-1-yuehaibing@huawei.com
---
 kernel/cpu.c | 50 +++++++++++++++++++++++---------------------------
 1 file changed, 23 insertions(+), 27 deletions(-)

diff --git a/kernel/cpu.c b/kernel/cpu.c
index 62fb67e..7ef28e1 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -2249,18 +2249,17 @@ int cpuhp_smt_enable(void)
 #endif
 
 #if defined(CONFIG_SYSFS) && defined(CONFIG_HOTPLUG_CPU)
-static ssize_t show_cpuhp_state(struct device *dev,
-				struct device_attribute *attr, char *buf)
+static ssize_t state_show(struct device *dev,
+			  struct device_attribute *attr, char *buf)
 {
 	struct cpuhp_cpu_state *st = per_cpu_ptr(&cpuhp_state, dev->id);
 
 	return sprintf(buf, "%d\n", st->state);
 }
-static DEVICE_ATTR(state, 0444, show_cpuhp_state, NULL);
+static DEVICE_ATTR_RO(state);
 
-static ssize_t write_cpuhp_target(struct device *dev,
-				  struct device_attribute *attr,
-				  const char *buf, size_t count)
+static ssize_t target_store(struct device *dev, struct device_attribute *attr,
+			    const char *buf, size_t count)
 {
 	struct cpuhp_cpu_state *st = per_cpu_ptr(&cpuhp_state, dev->id);
 	struct cpuhp_step *sp;
@@ -2298,19 +2297,17 @@ out:
 	return ret ? ret : count;
 }
 
-static ssize_t show_cpuhp_target(struct device *dev,
-				 struct device_attribute *attr, char *buf)
+static ssize_t target_show(struct device *dev,
+			   struct device_attribute *attr, char *buf)
 {
 	struct cpuhp_cpu_state *st = per_cpu_ptr(&cpuhp_state, dev->id);
 
 	return sprintf(buf, "%d\n", st->target);
 }
-static DEVICE_ATTR(target, 0644, show_cpuhp_target, write_cpuhp_target);
-
+static DEVICE_ATTR_RW(target);
 
-static ssize_t write_cpuhp_fail(struct device *dev,
-				struct device_attribute *attr,
-				const char *buf, size_t count)
+static ssize_t fail_store(struct device *dev, struct device_attribute *attr,
+			  const char *buf, size_t count)
 {
 	struct cpuhp_cpu_state *st = per_cpu_ptr(&cpuhp_state, dev->id);
 	struct cpuhp_step *sp;
@@ -2359,15 +2356,15 @@ static ssize_t write_cpuhp_fail(struct device *dev,
 	return count;
 }
 
-static ssize_t show_cpuhp_fail(struct device *dev,
-			       struct device_attribute *attr, char *buf)
+static ssize_t fail_show(struct device *dev,
+			 struct device_attribute *attr, char *buf)
 {
 	struct cpuhp_cpu_state *st = per_cpu_ptr(&cpuhp_state, dev->id);
 
 	return sprintf(buf, "%d\n", st->fail);
 }
 
-static DEVICE_ATTR(fail, 0644, show_cpuhp_fail, write_cpuhp_fail);
+static DEVICE_ATTR_RW(fail);
 
 static struct attribute *cpuhp_cpu_attrs[] = {
 	&dev_attr_state.attr,
@@ -2382,7 +2379,7 @@ static const struct attribute_group cpuhp_cpu_attr_group = {
 	NULL
 };
 
-static ssize_t show_cpuhp_states(struct device *dev,
+static ssize_t states_show(struct device *dev,
 				 struct device_attribute *attr, char *buf)
 {
 	ssize_t cur, res = 0;
@@ -2401,7 +2398,7 @@ static ssize_t show_cpuhp_states(struct device *dev,
 	mutex_unlock(&cpuhp_state_mutex);
 	return res;
 }
-static DEVICE_ATTR(states, 0444, show_cpuhp_states, NULL);
+static DEVICE_ATTR_RO(states);
 
 static struct attribute *cpuhp_cpu_root_attrs[] = {
 	&dev_attr_states.attr,
@@ -2474,28 +2471,27 @@ static const char *smt_states[] = {
 	[CPU_SMT_NOT_IMPLEMENTED]	= "notimplemented",
 };
 
-static ssize_t
-show_smt_control(struct device *dev, struct device_attribute *attr, char *buf)
+static ssize_t control_show(struct device *dev,
+			    struct device_attribute *attr, char *buf)
 {
 	const char *state = smt_states[cpu_smt_control];
 
 	return snprintf(buf, PAGE_SIZE - 2, "%s\n", state);
 }
 
-static ssize_t
-store_smt_control(struct device *dev, struct device_attribute *attr,
-		  const char *buf, size_t count)
+static ssize_t control_store(struct device *dev, struct device_attribute *attr,
+			     const char *buf, size_t count)
 {
 	return __store_smt_control(dev, attr, buf, count);
 }
-static DEVICE_ATTR(control, 0644, show_smt_control, store_smt_control);
+static DEVICE_ATTR_RW(control);
 
-static ssize_t
-show_smt_active(struct device *dev, struct device_attribute *attr, char *buf)
+static ssize_t active_show(struct device *dev,
+			   struct device_attribute *attr, char *buf)
 {
 	return snprintf(buf, PAGE_SIZE - 2, "%d\n", sched_smt_active());
 }
-static DEVICE_ATTR(active, 0444, show_smt_active, NULL);
+static DEVICE_ATTR_RO(active);
 
 static struct attribute *cpuhp_smt_attrs[] = {
 	&dev_attr_control.attr,
