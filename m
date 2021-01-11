Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 529A02F1083
	for <lists+linux-tip-commits@lfdr.de>; Mon, 11 Jan 2021 11:52:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729401AbhAKKuw (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 11 Jan 2021 05:50:52 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:37950 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729385AbhAKKuw (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 11 Jan 2021 05:50:52 -0500
Date:   Mon, 11 Jan 2021 10:50:09 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1610362210;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=i7S6GZ26sfw12rFOt6xjFGPLED/HPnzmoZmf9p0iX6I=;
        b=dM/imFD9S5HQ1RCSgsd9jRBXdNqVq+UlF+mHnqiqQ6IUlm3mL0PhLyIlz9Cf/+sLGTz9Vo
        XXb4KUztJ5PI+7bmR76yMW0JoFgFxJXlca154p538Mo1quv6sA+4ghQPU/gDs10wVSKi35
        /PrtVrVvsYpKMcmi5uVtkVWxuiEHOdEym5h1zY0w7sNuHFcroggcI43rDjxJVX21OSiKRk
        F+5S7EGpTgVBZIskfmZ+lEdWhP8PydEfLYFBTCoPXesN3Xq0x4DZU7mUsS9nbjPqWsl/LL
        FuwOUnj+q/HHRsgDx0Le4SDXSbVyDpc7sjSb7IoVpzMRAT6wxcz6NQZ0/XsIdA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1610362210;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=i7S6GZ26sfw12rFOt6xjFGPLED/HPnzmoZmf9p0iX6I=;
        b=zRzBaPvJCzNe+PaEtCswe1QpYqlsn0uaJ82pYYWbY5g6NiAx4CFuj8FcUpsNe7OIGStKsU
        14B+V5ZZQp1Z8NCQ==
From:   "tip-bot2 for Reinette Chatre" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cache] x86/resctrl: Use task_curr() instead of
 task_struct->on_cpu to prevent unnecessary IPI
Cc:     James Morse <james.morse@arm.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Borislav Petkov <bp@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3Ce9e68ce1441a73401e08b641cc3b9a3cf13fe6d4=2E16082?=
 =?utf-8?q?43147=2Egit=2Ereinette=2Echatre=40intel=2Ecom=3E?=
References: =?utf-8?q?=3Ce9e68ce1441a73401e08b641cc3b9a3cf13fe6d4=2E160824?=
 =?utf-8?q?3147=2Egit=2Ereinette=2Echatre=40intel=2Ecom=3E?=
MIME-Version: 1.0
Message-ID: <161036220932.414.7291518717313407438.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/cache branch of tip:

Commit-ID:     e0ad6dc8969f790f14bddcfd7ea284b7e5f88a16
Gitweb:        https://git.kernel.org/tip/e0ad6dc8969f790f14bddcfd7ea284b7e5f88a16
Author:        Reinette Chatre <reinette.chatre@intel.com>
AuthorDate:    Thu, 17 Dec 2020 14:31:20 -08:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Mon, 11 Jan 2021 11:34:45 +01:00

x86/resctrl: Use task_curr() instead of task_struct->on_cpu to prevent unnecessary IPI

James reported in [1] that there could be two tasks running on the same CPU
with task_struct->on_cpu set. Using task_struct->on_cpu as a test if a task
is running on a CPU may thus match the old task for a CPU while the
scheduler is running and IPI it unnecessarily.

task_curr() is the correct helper to use. While doing so move the #ifdef
check of the CONFIG_SMP symbol to be a C conditional used to determine
if this helper should be used to ensure the code is always checked for
correctness by the compiler.

[1] https://lore.kernel.org/lkml/a782d2f3-d2f6-795f-f4b1-9462205fd581@arm.com

Reported-by: James Morse <james.morse@arm.com>
Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/e9e68ce1441a73401e08b641cc3b9a3cf13fe6d4.1608243147.git.reinette.chatre@intel.com
---
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 460f3e0..37f37df 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -2313,19 +2313,15 @@ static void rdt_move_group_tasks(struct rdtgroup *from, struct rdtgroup *to,
 			t->closid = to->closid;
 			t->rmid = to->mon.rmid;
 
-#ifdef CONFIG_SMP
 			/*
-			 * This is safe on x86 w/o barriers as the ordering
-			 * of writing to task_cpu() and t->on_cpu is
-			 * reverse to the reading here. The detection is
-			 * inaccurate as tasks might move or schedule
-			 * before the smp function call takes place. In
-			 * such a case the function call is pointless, but
+			 * If the task is on a CPU, set the CPU in the mask.
+			 * The detection is inaccurate as tasks might move or
+			 * schedule before the smp function call takes place.
+			 * In such a case the function call is pointless, but
 			 * there is no other side effect.
 			 */
-			if (mask && t->on_cpu)
+			if (IS_ENABLED(CONFIG_SMP) && mask && task_curr(t))
 				cpumask_set_cpu(task_cpu(t), mask);
-#endif
 		}
 	}
 	read_unlock(&tasklist_lock);
