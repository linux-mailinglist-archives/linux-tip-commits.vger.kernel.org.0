Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39BDB32B062
	for <lists+linux-tip-commits@lfdr.de>; Wed,  3 Mar 2021 04:43:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352287AbhCCDhx (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 2 Mar 2021 22:37:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378858AbhCBJDa (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 2 Mar 2021 04:03:30 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0E6AC0617AA;
        Tue,  2 Mar 2021 01:01:58 -0800 (PST)
Date:   Tue, 02 Mar 2021 09:01:56 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1614675716;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wtfTOSmNlg+RGCXYXdF48/1pcUyHTx/mrCajOMG+Mv4=;
        b=kFqUpJSboeIXsJsPFnV8WLdQzmA+20MrGeaXND+iTMefYYhxKSZTRW3YpGH3yZFQ+CcSHW
        EBqSseu6M0IOKcl+YMaVoQCghiEvw0x07lenIZ01Ei0tR+zEoWT+/Kh+1qqTac6kjqQcyp
        UZFWssPLMl0EZUXs1GU3OH0ZXzgPFuHA+MR4f2baVBfj5U5ui041FtA4299AGxwJgoQXZd
        8LXK+8tScCfxVjQwRFKEVza/P5g0/0pNYS0CKzCk0I5RhBhMeTrb+3IWg2+8MJqzTf/opj
        kqqxRvOuGBdXHJ3h+Eyfo+2TYmzdtDye97WHPnCs9lSSt92Se3vjRaRLg+amsQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1614675716;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wtfTOSmNlg+RGCXYXdF48/1pcUyHTx/mrCajOMG+Mv4=;
        b=ttcLh9utv0lUvdrg9KTQPbDda80bUpp+FMEuZFeBVL10vYzvpYsz5hw4+hStw1HR+Jn58e
        64zOse1+so5s8FCQ==
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
Message-ID: <161467571626.20312.16737329930821436697.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     eae7a59d5a1e9bcf9804bcbd006ddce5cf72f8f4
Gitweb:        https://git.kernel.org/tip/eae7a59d5a1e9bcf9804bcbd006ddce5cf72f8f4
Author:        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate:    Thu, 18 Feb 2021 18:31:24 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 01 Mar 2021 18:17:22 +01:00

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
 include/linux/kcov.h  | 1 +
 include/linux/sched.h | 1 -
 net/core/skbuff.c     | 1 +
 net/mac80211/iface.c  | 1 +
 net/mac80211/rx.c     | 1 +
 5 files changed, 4 insertions(+), 1 deletion(-)

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
