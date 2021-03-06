Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C46DF32FA08
	for <lists+linux-tip-commits@lfdr.de>; Sat,  6 Mar 2021 12:43:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231174AbhCFLmg (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sat, 6 Mar 2021 06:42:36 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:34268 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230406AbhCFLmZ (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sat, 6 Mar 2021 06:42:25 -0500
Date:   Sat, 06 Mar 2021 11:42:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1615030944;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EOn20dMtpMJdbJU3UovE4frcnkqDklpuKaNeXSDjxiI=;
        b=omdLUi5ud3LsOETcfYFrMcq5iFkn1v4Nus74EhqUdl4xhj+4rdERw64BVX4chz8WD0MBYD
        35LaybRYzmX9tWNLjMStB8iARmdiejRPCGjKXM/Xjz3AlOBsBRMjUN3W6UeZ3hjWpESxjs
        IE5lhDrsQ9SAgUtmy4+uqawMUUkeNIjqqF9vNinVsqXrMRF6veoFi3hfQey4iBg9WMGrMi
        y47njqghIgimkXlMxfimPnFEBTiC4juw0TkRFJHz+J9e6ammRbZQE3dJTJypQ3dmIk7eg+
        HA6lssj/bcsyNkPIjnVijrn9+yEyxgdTZmzY7kp3m76z+s1GqY9XA1Sw/Un4wg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1615030944;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EOn20dMtpMJdbJU3UovE4frcnkqDklpuKaNeXSDjxiI=;
        b=HDJK4zH2PbjXTpI2pPafJuyUqd8jnVFOFOKGym+aigNjjp3ze2SB/RZ1oLTUK7fdYOFx2t
        GW3tslyw5ZFJhYDw==
From:   "tip-bot2 for Sebastian Andrzej Siewior" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] kcov: Remove kcov include from sched.h and move it
 to its users.
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        Andrey Konovalov <andreyknvl@google.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210218173124.iy5iyqv3a4oia4vv@linutronix.de>
References: <20210218173124.iy5iyqv3a4oia4vv@linutronix.de>
MIME-Version: 1.0
Message-ID: <161503094379.398.12330646699386290495.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     183f47fcaa54a5ffe671d990186d330ac8c63b10
Gitweb:        https://git.kernel.org/tip/183f47fcaa54a5ffe671d990186d330ac8c63b10
Author:        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate:    Thu, 18 Feb 2021 18:31:24 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sat, 06 Mar 2021 12:40:21 +01:00

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
Signed-off-by: Ingo Molnar <mingo@kernel.org>
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
