Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE41B23429B
	for <lists+linux-tip-commits@lfdr.de>; Fri, 31 Jul 2020 11:25:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732504AbgGaJXf (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 31 Jul 2020 05:23:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732495AbgGaJXe (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 31 Jul 2020 05:23:34 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19DB7C061574;
        Fri, 31 Jul 2020 02:23:34 -0700 (PDT)
Date:   Fri, 31 Jul 2020 09:23:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1596187412;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=72nAweuq/43kiAUAzQosSH0gNW7dXBQIkqWdjz7M944=;
        b=Zl9c6CTpDkD6n60piNa3RvIlmJQvUh2ElD+q0I3dVSBTTG3hUEurG+AM23/cpQuvteyIpC
        FiophbmetWgJtMOSNOfQdztRMEMH9NXUrw4s7kzy18vq/0MCIkGEOrM32Sixj1+js7qicd
        xl0FBzz4mSOGmE90e6pcDnuDq/hvTXAYcPKXL/D7M19MnRHkKyShImnDZnJAhsmPh0VVj9
        tRwQaVpJ8BXiGs2odlmiw+InBI8FxCccMoVfKIfJufBHhaECsrNHHvow/3/zZmCB/uvfhO
        jZoO3BK3lmya/iZLgscb5NHBgXbojYzl7MC2cVv6vcB7D6l6ta17WCalKz5Ktg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1596187412;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=72nAweuq/43kiAUAzQosSH0gNW7dXBQIkqWdjz7M944=;
        b=G4YPz63aQyNGYFPY+EZ9jgVcKvlW3ZRSHZ1/hhzpWn/FnyPW+In9Hu5mt4G/QrriYi+v94
        L6TnGzquihDzcfCQ==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcu: Remove initialized but unused rnp from check_slow_task()
Cc:     kbuild test robot <lkp@intel.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <159618741193.4006.6113264412191066133.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     55fbe86ef303bc8ab040e579fba34a750c08200e
Gitweb:        https://git.kernel.org/tip/55fbe86ef303bc8ab040e579fba34a750c08200e
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Tue, 19 May 2020 15:02:02 -07:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 29 Jun 2020 11:58:50 -07:00

rcu: Remove initialized but unused rnp from check_slow_task()

This commit removes the variable rnp from check_slow_task(), which
is defined, assigned to, but not otherwise used.

Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree_stall.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
index 2768ce6..d203f82 100644
--- a/kernel/rcu/tree_stall.h
+++ b/kernel/rcu/tree_stall.h
@@ -237,14 +237,12 @@ struct rcu_stall_chk_rdr {
  */
 static bool check_slow_task(struct task_struct *t, void *arg)
 {
-	struct rcu_node *rnp;
 	struct rcu_stall_chk_rdr *rscrp = arg;
 
 	if (task_curr(t))
 		return false; // It is running, so decline to inspect it.
 	rscrp->nesting = t->rcu_read_lock_nesting;
 	rscrp->rs = t->rcu_read_unlock_special;
-	rnp = t->rcu_blocked_node;
 	rscrp->on_blkd_list = !list_empty(&t->rcu_node_entry);
 	return true;
 }
