Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B94932C7B6
	for <lists+linux-tip-commits@lfdr.de>; Thu,  4 Mar 2021 02:11:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376282AbhCDAck (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 3 Mar 2021 19:32:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1843021AbhCCKYb (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 3 Mar 2021 05:24:31 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 782DDC08EC87;
        Wed,  3 Mar 2021 01:49:41 -0800 (PST)
Date:   Wed, 03 Mar 2021 09:49:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1614764980;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bv5If5aKkmKrvwapua3MrOf7KZ9MkEG8vbkFDJ7p3WU=;
        b=i+83FaMNipnWtWaWMXhxHayNTMGnBv8hYUqDT7ypXtHvNOVWAxczph1QOytsCkg3+u8aqE
        DE59x2IVPSdxLYEboM/59a9CJJn6Moz0qgsKqJx9lZak77QABDZZw/FMlpSEplAGaKHzLJ
        MslT0r+GfD6EnMp3G3lh3APDAtfZtlkN3j9VSBzuBtnyJjuu4fPuC4pN+zmGRYrbvx0LyH
        7D+kjmk8A18CQ2jXRRXk5GaWa6uo/Gb3HjtdczEdVbsNDyWYCveW3NAGokWkBjOrDYdtlV
        6w6Vq6kBtUwd95Yc1C7fiXkCZhYLPr2LPzgjSdjfuTz6NZ/NEBCwOnDRzfIciA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1614764980;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bv5If5aKkmKrvwapua3MrOf7KZ9MkEG8vbkFDJ7p3WU=;
        b=0jqb4/YOtCDJZ8muPWCdGrsxO6+TEyRCC7ptQ68UMbzJR4020WmT/dl2zL2Edq1/BoDQzs
        Ajz+uBhZ7O6tZVBw==
From:   "tip-bot2 for Sebastian Andrzej Siewior" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] kcov: Remove kcov include from sched.h and move it
 to its users.
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        Andrey Konovalov <andreyknvl@google.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210218173124.iy5iyqv3a4oia4vv@linutronix.de>
References: <20210218173124.iy5iyqv3a4oia4vv@linutronix.de>
MIME-Version: 1.0
Message-ID: <161476497944.20312.6366820795221202396.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     4c7ee75cccbf0635cbec6528ae7fff4b7bc549fa
Gitweb:        https://git.kernel.org/tip/4c7ee75cccbf0635cbec6528ae7fff4b7bc549fa
Author:        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate:    Thu, 18 Feb 2021 18:31:24 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 03 Mar 2021 10:32:47 +01:00

kcov: Remove kcov include from sched.h and move it to its users.

The recent addition of in_serving_softirq() to kconv.h results in
compile failure on PREEMPT_RT because it requires
task_struct::softirq_disable_cnt. This is not available if kconv.h is
included from sched.h.

It is not needed to include kconv.h from sched.h. All but the net/ user
already include the kconv header file.

Move the include of the kconv.h header from sched.h it its users.
Additionally include sched.h from kconv.h to ensure that everything
task_struct related is available.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Johannes Berg <johannes@sipsolutions.net>
Acked-by: Andrey Konovalov <andreyknvl@google.com>
Link: https://lkml.kernel.org/r/20210218173124.iy5iyqv3a4oia4vv@linutronix.de
---
 drivers/usb/usbip/usbip_common.h | 1 +
 include/linux/kcov.h             | 1 +
 include/linux/sched.h            | 1 -
 net/core/skbuff.c                | 1 +
 net/mac80211/iface.c             | 1 +
 net/mac80211/rx.c                | 1 +
 6 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/usbip/usbip_common.h b/drivers/usb/usbip/usbip_common.h
index d60ce17..a7dd6c6 100644
--- a/drivers/usb/usbip/usbip_common.h
+++ b/drivers/usb/usbip/usbip_common.h
@@ -18,6 +18,7 @@
 #include <linux/usb.h>
 #include <linux/wait.h>
 #include <linux/sched/task.h>
+#include <linux/kcov.h>
 #include <uapi/linux/usbip.h>
 
 #undef pr_fmt
diff --git a/include/linux/kcov.h b/include/linux/kcov.h
index 4e3037d..55dc338 100644
--- a/include/linux/kcov.h
+++ b/include/linux/kcov.h
@@ -2,6 +2,7 @@
 #ifndef _LINUX_KCOV_H
 #define _LINUX_KCOV_H
 
+#include <linux/sched.h>
 #include <uapi/linux/kcov.h>
 
 struct task_struct;
diff --git a/include/linux/sched.h b/include/linux/sched.h
index ef00bb2..cf245bc 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -14,7 +14,6 @@
 #include <linux/pid.h>
 #include <linux/sem.h>
 #include <linux/shm.h>
-#include <linux/kcov.h>
 #include <linux/mutex.h>
 #include <linux/plist.h>
 #include <linux/hrtimer.h>
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 545a472..420f23c 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -60,6 +60,7 @@
 #include <linux/prefetch.h>
 #include <linux/if_vlan.h>
 #include <linux/mpls.h>
+#include <linux/kcov.h>
 
 #include <net/protocol.h>
 #include <net/dst.h>
diff --git a/net/mac80211/iface.c b/net/mac80211/iface.c
index b80c9b0..c127deb 100644
--- a/net/mac80211/iface.c
+++ b/net/mac80211/iface.c
@@ -15,6 +15,7 @@
 #include <linux/if_arp.h>
 #include <linux/netdevice.h>
 #include <linux/rtnetlink.h>
+#include <linux/kcov.h>
 #include <net/mac80211.h>
 #include <net/ieee80211_radiotap.h>
 #include "ieee80211_i.h"
diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
index c1343c0..62047e9 100644
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -17,6 +17,7 @@
 #include <linux/etherdevice.h>
 #include <linux/rcupdate.h>
 #include <linux/export.h>
+#include <linux/kcov.h>
 #include <linux/bitops.h>
 #include <net/mac80211.h>
 #include <net/ieee80211_radiotap.h>
