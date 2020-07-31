Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCCDD2342EB
	for <lists+linux-tip-commits@lfdr.de>; Fri, 31 Jul 2020 11:27:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732139AbgGaJ1B (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 31 Jul 2020 05:27:01 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:56476 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732402AbgGaJXP (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 31 Jul 2020 05:23:15 -0400
Date:   Fri, 31 Jul 2020 09:23:13 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1596187393;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=Ps+wi6/GEwDM4g13RRDQn2qglgbsxy6g1tAgD+sKb18=;
        b=IP4OPtYeztCbcPJ1vdLOOZ5qkC8aDIMRHPjhKILm9jrl0CT+ALTP4WwH4ohc/1yxZQ/n2i
        W9Rh8sWoXFYHiCtTr+TpUMQPZVMUPI7ARrLplOeRaFqbcQZDSCtpfONXVgnbBbrWTTkSC8
        YB6JUgDiglCw6F07gb6rguY22CGGaMl3GHor0G/4BVIFx0uFzAPCsxiyTqlOGEF0oru26u
        IqGSnkcj4ZUe9k0gZ9VOkPo1ARYEUHWwRETL3FJQ/fiU33nPYOLlVDGO5AuoHv5SCkO2K+
        AwPhY6RX/mYXPCQL8MF7A4z0bkwedvijheF7OPEP/zLG5mC3qocN7g7QaqqhqQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1596187393;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=Ps+wi6/GEwDM4g13RRDQn2qglgbsxy6g1tAgD+sKb18=;
        b=CJ0NU8CT58qI2QSJ95atglUMRLaZMjiSFGFrzbopt8QfTvOqF6Nno7SZ5YrK3h6k+NdTvw
        qt8G6sFg+6JEVPAg==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcu-tasks: Make rcu_tasks_postscan() be static
Cc:     kbuild test robot <lkp@intel.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <159618739323.4006.6625252484111206095.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     04a3c5aa7a8cb2ce97f9beb627ba742bc8b0fe03
Gitweb:        https://git.kernel.org/tip/04a3c5aa7a8cb2ce97f9beb627ba742bc8b0fe03
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Thu, 28 May 2020 19:27:06 -07:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 29 Jun 2020 12:00:22 -07:00

rcu-tasks: Make rcu_tasks_postscan() be static

The rcu_tasks_postscan() function is not used outside of RCU's tasks.h
file, so this commit makes it be static.

Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tasks.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index 91fee81..da200e5 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -402,7 +402,7 @@ static void rcu_tasks_pertask(struct task_struct *t, struct list_head *hop)
 }
 
 /* Processing between scanning taskslist and draining the holdout list. */
-void rcu_tasks_postscan(struct list_head *hop)
+static void rcu_tasks_postscan(struct list_head *hop)
 {
 	/*
 	 * Wait for tasks that are in the process of exiting.  This
