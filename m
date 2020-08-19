Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6112F249DFB
	for <lists+linux-tip-commits@lfdr.de>; Wed, 19 Aug 2020 14:33:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728289AbgHSMdt (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 19 Aug 2020 08:33:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728223AbgHSMdU (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 19 Aug 2020 08:33:20 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79EB3C061343;
        Wed, 19 Aug 2020 05:33:19 -0700 (PDT)
Date:   Wed, 19 Aug 2020 12:33:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1597840392;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gz8UFoO9G0Yh9/6TrSb8u8gXd0brblx69nGkW5rqEoU=;
        b=K1/KzMTQL5QedjJaPE1qJurZ3ueisJbFZQm/iFt9B2tMYHzEUALU1DIXZWAyMa7g0Rb3uq
        sfgmoMyjVK6ooA8U0zwwUw/lEYwj/7/U/oCgI4mBmDiF7gu9qnowBREkUHs2PKABXPBy6L
        7cxg4xyEIPwEaznrcMt9qibwDb7ZFzvlIHru11tQ6scVwC9e+9hnNU6ff7p9AjiKQ9sT3M
        WuUKSpR0hACcOMbR4RrC0u+UgXftr6jkxgMPQPgfKqT5CKEnFQ7X7yLwq1/gKwtQxKzjkF
        BrEGJLMUV8CUsqDsfkHJMGSTPGKvDA89nRaUYWyGNSDLCp1kp4b85vV75hmcfA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1597840392;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gz8UFoO9G0Yh9/6TrSb8u8gXd0brblx69nGkW5rqEoU=;
        b=WnqpwVgbMoH8q+8fa5O9Kx5r5wibtprfQU43ctxpdyGVSTNPS+GfkC+49Anj7qLMwbiEv6
        /M++KnRQFG+5b4Cw==
From:   "tip-bot2 for James Morse" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cache] x86/resctrl: Use container_of() in delayed_work handlers
Cc:     James Morse <james.morse@arm.com>, Borislav Petkov <bp@suse.de>,
        Reinette Chatre <reinette.chatre@intel.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200708163929.2783-5-james.morse@arm.com>
References: <20200708163929.2783-5-james.morse@arm.com>
MIME-Version: 1.0
Message-ID: <159784039176.3192.15237802095890922512.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/cache branch of tip:

Commit-ID:     f995801ba3a0660cb352c8beb794379c82781ca3
Gitweb:        https://git.kernel.org/tip/f995801ba3a0660cb352c8beb794379c82781ca3
Author:        James Morse <james.morse@arm.com>
AuthorDate:    Wed, 08 Jul 2020 16:39:23 
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Tue, 18 Aug 2020 17:05:08 +02:00

x86/resctrl: Use container_of() in delayed_work handlers

mbm_handle_overflow() and cqm_handle_limbo() are both provided with
the domain's work_struct when called, but use get_domain_from_cpu()
to find the domain, along with the appropriate error handling.

container_of() saves some list walking and bitmap testing, use that
instead.

Signed-off-by: James Morse <james.morse@arm.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Link: https://lkml.kernel.org/r/20200708163929.2783-5-james.morse@arm.com
---
 arch/x86/kernel/cpu/resctrl/monitor.c | 13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index d6b92d7..54dffe5 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -477,19 +477,13 @@ void cqm_handle_limbo(struct work_struct *work)
 	mutex_lock(&rdtgroup_mutex);
 
 	r = &rdt_resources_all[RDT_RESOURCE_L3];
-	d = get_domain_from_cpu(cpu, r);
-
-	if (!d) {
-		pr_warn_once("Failure to get domain for limbo worker\n");
-		goto out_unlock;
-	}
+	d = container_of(work, struct rdt_domain, cqm_limbo.work);
 
 	__check_limbo(d, false);
 
 	if (has_busy_rmid(r, d))
 		schedule_delayed_work_on(cpu, &d->cqm_limbo, delay);
 
-out_unlock:
 	mutex_unlock(&rdtgroup_mutex);
 }
 
@@ -519,10 +513,7 @@ void mbm_handle_overflow(struct work_struct *work)
 		goto out_unlock;
 
 	r = &rdt_resources_all[RDT_RESOURCE_L3];
-
-	d = get_domain_from_cpu(cpu, r);
-	if (!d)
-		goto out_unlock;
+	d = container_of(work, struct rdt_domain, mbm_over.work);
 
 	list_for_each_entry(prgrp, &rdt_all_groups, rdtgroup_list) {
 		mbm_update(r, d, prgrp->mon.rmid);
