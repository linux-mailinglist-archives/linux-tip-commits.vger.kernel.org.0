Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C661288F67
	for <lists+linux-tip-commits@lfdr.de>; Fri,  9 Oct 2020 19:03:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389999AbgJIRBl (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 9 Oct 2020 13:01:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389973AbgJIRBb (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 9 Oct 2020 13:01:31 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58EEEC0613D7;
        Fri,  9 Oct 2020 10:01:31 -0700 (PDT)
Date:   Fri, 09 Oct 2020 17:01:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1602262889;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=dl6bWOeNvDMJEmrzVygAD+18R4nb/SFMZF/6yau/mC0=;
        b=lgni7+HVI3dHMiGQM7Pxlfp9JO94ezup5mdVxBVpmQ3QteFOlxkjQowLPOP6Tss7jkTXFB
        gTmCjyM8SVJUSUDJsiiVBkZMBzZ0i72bwatrD0IoI9C7bm1oviFSfjI2GjUlOeEEQeVUYf
        Rs8criQMcvvwWa76AxNNCbl6pCJ9biRszLoh2Zu7WaDjOxmNkDPR1Pr283NDcUKpPnX9dt
        DQhx2OHMjUrpIVbhIcDO624CYzN/d1yoNGZ2jml8GRjNvAfB/PTZMI95qxTaDgo7pvON3a
        AjmwUOz0h4t2fo/zjZMVNhu64Pe21dLHyqvm3FIGpzUMkVbSeHqKoO2+2NYhSQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1602262889;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=dl6bWOeNvDMJEmrzVygAD+18R4nb/SFMZF/6yau/mC0=;
        b=g6BMF/I4rSkiDMtioWGt62dIdTHpQLNV1T2OdEyuDfRCmtzR+hCHHGAZVM11nOQW1nuAkM
        nfGX97L/id1Tx0CQ==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] lib/debug: Remove pointless ARCH_NO_PREEMPT dependencies
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <160226288912.7002.16299812541183928186.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     45015f8840baa8a99f5161d42fc1ca070d534365
Gitweb:        https://git.kernel.org/tip/45015f8840baa8a99f5161d42fc1ca070d534365
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 14 Sep 2020 20:35:55 +02:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Fri, 25 Sep 2020 11:24:14 -07:00

lib/debug: Remove pointless ARCH_NO_PREEMPT dependencies

ARCH_NO_PREEMPT disables the selection of CONFIG_PREEMPT_VOLUNTARY and
CONFIG_PREEMPT, but architectures which set this config option still
support preempt count for hard and softirq accounting.

There is absolutely no reason to prevent lockdep from using the preempt
counter nor is there a reason to prevent the enablement of
CONFIG_DEBUG_ATOMIC_SLEEP on such architectures.

Remove the dependencies.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 lib/Kconfig.debug | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index e068c3c..f50fbcf 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1161,7 +1161,7 @@ config PROVE_LOCKING
 	select DEBUG_RWSEMS
 	select DEBUG_WW_MUTEX_SLOWPATH
 	select DEBUG_LOCK_ALLOC
-	select PREEMPT_COUNT if !ARCH_NO_PREEMPT
+	select PREEMPT_COUNT
 	select TRACE_IRQFLAGS
 	default n
 	help
@@ -1323,7 +1323,6 @@ config DEBUG_ATOMIC_SLEEP
 	bool "Sleep inside atomic section checking"
 	select PREEMPT_COUNT
 	depends on DEBUG_KERNEL
-	depends on !ARCH_NO_PREEMPT
 	help
 	  If you say Y here, various routines which may sleep will become very
 	  noisy if they are called inside atomic sections: when a spinlock is
