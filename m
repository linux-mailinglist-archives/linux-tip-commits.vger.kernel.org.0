Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B22C347264
	for <lists+linux-tip-commits@lfdr.de>; Wed, 24 Mar 2021 08:23:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235886AbhCXHWu (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 24 Mar 2021 03:22:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235829AbhCXHWc (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 24 Mar 2021 03:22:32 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBD02C0613DB;
        Wed, 24 Mar 2021 00:22:31 -0700 (PDT)
Date:   Wed, 24 Mar 2021 07:22:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1616570547;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xExuxbajKnozwYQkd1phRCEtqiLRViNaiB3MpSc/obM=;
        b=Q1mDFTWsysHS70efdiCDfqRPjiBXa7Xm0/5uv4YW76wUFtT8wPsuVTGEdEeb/CfAPdYapn
        xMzhH8S0kr4v4Gu7iLGNOCY2RyOk0XEH6eCiFm+94LTSrwRTzCL0c/JAoLiB43+mPJunK8
        xobAldWqsTjXxfhhatHY50KzXH0TWf1KulbBEMVK9yd3QIxiEEYl+m2xGvMcU0SfVuOdmS
        2Ljs8NVKr3jZB4rVlJk3rsUKuQ0fS5jZ/W/Gx3kzFL7yp1EYaF/EIir93oPOd0bCSlI/Qr
        B9Z6AZoDVMukt9qM91xzPttAJYFoCKelvEKuB1MKE+K+TcrPorSp+H7w0AeMKw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1616570547;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xExuxbajKnozwYQkd1phRCEtqiLRViNaiB3MpSc/obM=;
        b=QqXIWQBD3Vj9WUF/1oCHtneL2xlrAM7zx83rL0uTJuuxJDPFknkvju9bb36PVW1YE+cc1o
        3VmS8fc8BVmrxWCA==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/rtmutex: Restrict the trylock WARN_ON() to debug
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210323213708.908341972@linutronix.de>
References: <20210323213708.908341972@linutronix.de>
MIME-Version: 1.0
Message-ID: <161657054714.398.11163755719025601580.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     3ac7d0ecf0e18b44c2c7dc968ce5afc5beadf17c
Gitweb:        https://git.kernel.org/tip/3ac7d0ecf0e18b44c2c7dc968ce5afc5beadf17c
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 23 Mar 2021 22:30:33 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 24 Mar 2021 08:08:16 +01:00

locking/rtmutex: Restrict the trylock WARN_ON() to debug

The warning as written is expensive and not really required for a
production kernel. Make it depend on rt mutex debugging and use !in_task()
for the condition which generates far better code and gives the same
answer.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20210323213708.908341972@linutronix.de
---
 kernel/locking/rtmutex.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
index bece7aa..d584e32 100644
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -1495,9 +1495,8 @@ int __sched __rt_mutex_futex_trylock(struct rt_mutex *lock)
  *
  * @lock:	the rt_mutex to be locked
  *
- * This function can only be called in thread context. It's safe to
- * call it from atomic regions, but not from hard interrupt or soft
- * interrupt context.
+ * This function can only be called in thread context. It's safe to call it
+ * from atomic regions, but not from hard or soft interrupt context.
  *
  * Returns 1 on success and 0 on contention
  */
@@ -1505,7 +1504,7 @@ int __sched rt_mutex_trylock(struct rt_mutex *lock)
 {
 	int ret;
 
-	if (WARN_ON_ONCE(in_irq() || in_nmi() || in_serving_softirq()))
+	if (IS_ENABLED(CONFIG_RT_MUTEX_DEBUG) && WARN_ON_ONCE(!in_task()))
 		return 0;
 
 	ret = rt_mutex_fasttrylock(lock, rt_mutex_slowtrylock);
