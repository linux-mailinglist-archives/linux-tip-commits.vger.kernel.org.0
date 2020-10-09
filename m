Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78428288F5C
	for <lists+linux-tip-commits@lfdr.de>; Fri,  9 Oct 2020 19:03:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389858AbgJIRB1 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 9 Oct 2020 13:01:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389922AbgJIRBZ (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 9 Oct 2020 13:01:25 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DF4AC0613D5;
        Fri,  9 Oct 2020 10:01:25 -0700 (PDT)
Date:   Fri, 09 Oct 2020 17:01:22 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1602262883;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=relbtBN8xcHuMYae2c1edjz62s5tANEt5Wp32dPTSU8=;
        b=WMgjooF+zWiqxC18mmZXOGTXRnycQ1Wv2SVG+zFlcWdSuDdgRz9JYA7fowmdcxTd0iTg2Q
        BJh3Ph7ydaA49GyRP7qMLdqDDQvdnDcPCO519Ct4e9BQ6OdE7tp0/c4taFn6WGvmLnYRb2
        dCe/RVYFB1O2w2THNYmCzrI2Z5tNLq6FW1IVTTKpssMPshR3qBXfe/TtBPJJiX+1ZTA2pF
        ZZfdA2EidvWf83CgvsAafVC2Z8L8G4PgnjENwHnK5ctzBBJa+xBTNkbyIzky+pyGlRex3G
        oLrECrwhbmW/kDuJKxFYVfs9FXSwSnIOqeDT3+ZD2hc/pgbM/nEzk9X0s9TbXw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1602262883;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=relbtBN8xcHuMYae2c1edjz62s5tANEt5Wp32dPTSU8=;
        b=+Ok6qMrB77uKHl8ZWscuwFUFVjgQVwCUd86bz3+lQBoZABB4qiGJfEIKfcHpV6tXHu8Y9l
        mDF94vSN0RWkOPAQ==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] preempt: Remove PREEMPT_COUNT from Kconfig
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <160226288277.7002.16410590808693640013.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     b705984b529003265404866b9c9edf6d24d46aa1
Gitweb:        https://git.kernel.org/tip/b705984b529003265404866b9c9edf6d24d46aa1
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 14 Sep 2020 19:40:22 +02:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Thu, 01 Oct 2020 09:05:16 -07:00

preempt: Remove PREEMPT_COUNT from Kconfig

All conditionals and irritations are gone.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/Kconfig.preempt | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/kernel/Kconfig.preempt b/kernel/Kconfig.preempt
index 3f4712f..120b63f 100644
--- a/kernel/Kconfig.preempt
+++ b/kernel/Kconfig.preempt
@@ -74,8 +74,5 @@ config PREEMPT_RT
 
 endchoice
 
-config PREEMPT_COUNT
-       def_bool y
-
 config PREEMPTION
        bool
