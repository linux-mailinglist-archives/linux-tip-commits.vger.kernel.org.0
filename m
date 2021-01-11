Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9439F2F1088
	for <lists+linux-tip-commits@lfdr.de>; Mon, 11 Jan 2021 11:52:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729512AbhAKKu7 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 11 Jan 2021 05:50:59 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:37944 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729276AbhAKKux (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 11 Jan 2021 05:50:53 -0500
Date:   Mon, 11 Jan 2021 10:50:08 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1610362209;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=G/n3hDKcZpF5HD2TgAvXu3ZbdawIkPcUNQtQvBVSYuw=;
        b=CwZJVTwpAk0cElyqTTROCVBsK7dJuC8/+hsYRlLdFeMaQRRV7i19CO4/b0aCe+OvP2/5n3
        3AhDL/StcsVcDbMrlzcbFDKLjbmU0uMUC0OFhzaKY9v/7b0Ej/HQAvJIrY/1oQLntw/u4B
        R3DSrkWujEwx2n54T1k6ESCdOe4fp3QS1e+3P3iRjtLdovWi6x35n4TtlrxRD7FBPNyUEQ
        PEf8yFVduBgp0mqNXqHzOvCfMgRGt7MNkTiE6z1Ow/1DJqtFweA9ff5WexQeJX4Mje52BZ
        fdoERISKi24kxwrXMQU13DXiM3UedDS9syVLL9vVNrkvAsEHC6McRSdbHLLZdg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1610362209;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=G/n3hDKcZpF5HD2TgAvXu3ZbdawIkPcUNQtQvBVSYuw=;
        b=AnSY9fliONn/qBoiExOtRiH9yi4IVMw1fl4bN4+C0XGTkeMQJaQ8HAhuUiKtp/+yLhZj3p
        3g1WDe9yr3S8IQCw==
From:   "tip-bot2 for Valentin Schneider" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cache] x86/resctrl: Apply READ_ONCE/WRITE_ONCE to
 task_struct.{rmid,closid}
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Borislav Petkov <bp@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3C9921fda88ad81afb9885b517fbe864a2bc7c35a9=2E16082?=
 =?utf-8?q?43147=2Egit=2Ereinette=2Echatre=40intel=2Ecom=3E?=
References: =?utf-8?q?=3C9921fda88ad81afb9885b517fbe864a2bc7c35a9=2E160824?=
 =?utf-8?q?3147=2Egit=2Ereinette=2Echatre=40intel=2Ecom=3E?=
MIME-Version: 1.0
Message-ID: <161036220889.414.7823554165094952734.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/cache branch of tip:

Commit-ID:     6d3b47ddffed70006cf4ba360eef61e9ce097d8f
Gitweb:        https://git.kernel.org/tip/6d3b47ddffed70006cf4ba360eef61e9ce097d8f
Author:        Valentin Schneider <valentin.schneider@arm.com>
AuthorDate:    Thu, 17 Dec 2020 14:31:21 -08:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Mon, 11 Jan 2021 11:43:23 +01:00

x86/resctrl: Apply READ_ONCE/WRITE_ONCE to task_struct.{rmid,closid}

A CPU's current task can have its {closid, rmid} fields read locally
while they are being concurrently written to from another CPU.
This can happen anytime __resctrl_sched_in() races with either
__rdtgroup_move_task() or rdt_move_group_tasks().

Prevent load / store tearing for those accesses by giving them the
READ_ONCE() / WRITE_ONCE() treatment.

Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/9921fda88ad81afb9885b517fbe864a2bc7c35a9.1608243147.git.reinette.chatre@intel.com
---
 arch/x86/include/asm/resctrl.h         | 11 +++++++----
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 10 +++++-----
 2 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/arch/x86/include/asm/resctrl.h b/arch/x86/include/asm/resctrl.h
index 0760306..d60ed06 100644
--- a/arch/x86/include/asm/resctrl.h
+++ b/arch/x86/include/asm/resctrl.h
@@ -56,19 +56,22 @@ static void __resctrl_sched_in(void)
 	struct resctrl_pqr_state *state = this_cpu_ptr(&pqr_state);
 	u32 closid = state->default_closid;
 	u32 rmid = state->default_rmid;
+	u32 tmp;
 
 	/*
 	 * If this task has a closid/rmid assigned, use it.
 	 * Else use the closid/rmid assigned to this cpu.
 	 */
 	if (static_branch_likely(&rdt_alloc_enable_key)) {
-		if (current->closid)
-			closid = current->closid;
+		tmp = READ_ONCE(current->closid);
+		if (tmp)
+			closid = tmp;
 	}
 
 	if (static_branch_likely(&rdt_mon_enable_key)) {
-		if (current->rmid)
-			rmid = current->rmid;
+		tmp = READ_ONCE(current->rmid);
+		if (tmp)
+			rmid = tmp;
 	}
 
 	if (closid != state->cur_closid || rmid != state->cur_rmid) {
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 37f37df..f9190ad 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -563,11 +563,11 @@ static int __rdtgroup_move_task(struct task_struct *tsk,
 	 */
 
 	if (rdtgrp->type == RDTCTRL_GROUP) {
-		tsk->closid = rdtgrp->closid;
-		tsk->rmid = rdtgrp->mon.rmid;
+		WRITE_ONCE(tsk->closid, rdtgrp->closid);
+		WRITE_ONCE(tsk->rmid, rdtgrp->mon.rmid);
 	} else if (rdtgrp->type == RDTMON_GROUP) {
 		if (rdtgrp->mon.parent->closid == tsk->closid) {
-			tsk->rmid = rdtgrp->mon.rmid;
+			WRITE_ONCE(tsk->rmid, rdtgrp->mon.rmid);
 		} else {
 			rdt_last_cmd_puts("Can't move task to different control group\n");
 			return -EINVAL;
@@ -2310,8 +2310,8 @@ static void rdt_move_group_tasks(struct rdtgroup *from, struct rdtgroup *to,
 	for_each_process_thread(p, t) {
 		if (!from || is_closid_match(t, from) ||
 		    is_rmid_match(t, from)) {
-			t->closid = to->closid;
-			t->rmid = to->mon.rmid;
+			WRITE_ONCE(t->closid, to->closid);
+			WRITE_ONCE(t->rmid, to->mon.rmid);
 
 			/*
 			 * If the task is on a CPU, set the CPU in the mask.
