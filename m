Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF2313E7D89
	for <lists+linux-tip-commits@lfdr.de>; Tue, 10 Aug 2021 18:33:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229997AbhHJQdc (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 10 Aug 2021 12:33:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229798AbhHJQdb (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 10 Aug 2021 12:33:31 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F618C0613C1;
        Tue, 10 Aug 2021 09:33:09 -0700 (PDT)
Date:   Tue, 10 Aug 2021 16:33:06 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628613187;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=P5j31cs9i6lVMQeFWSZeqlFmezsgc9fp7i45IBW/pqc=;
        b=Nt6VMD0WyggXyH/o/qgjzRtoAkUJ4siBogBtTtahfIl+se28fA11x8yFOh02Q3+DLT73lG
        CCHeRHzjnwz2aq8s11oSf4aZXTkyMXAUsQSdg01YugiRe6vt87MvM15ySBIijdWli6pIAU
        eJJS7FtT33UvGOPlFS/vU/Kb5CtZ8sRSOpSYRwXBKgRlPTkvHQV7oSJGo73mFyFg75azxo
        q5n/naIV8cDYZr+6zCIUi3h3P84w2H4YKzkWjZBgwsGLT9tOJTm3O6WV3J6woPrJGqPZtm
        apmfOwsOfIuOnaQgGRX9N/+mCltN1B41KhJrLtRwZpQBlPcCForFzSuHdmOJ7A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628613187;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=P5j31cs9i6lVMQeFWSZeqlFmezsgc9fp7i45IBW/pqc=;
        b=vg/zCRK+TbDedFjlyhWEF/4ggk3v1wFVad1PRgMbcJfnTD+WL7NHvqwyiRDlFEnKfoGvEd
        8HHXorXMw8YaAMDg==
From:   "tip-bot2 for Dongli Zhang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: smp/core] cpu/hotplug: Add debug printks for hotplug callback failures
Cc:     Dongli Zhang <dongli.zhang@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Qais Yousef <qais.yousef@arm.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210409055316.1709-1-dongli.zhang@oracle.com>
References: <20210409055316.1709-1-dongli.zhang@oracle.com>
MIME-Version: 1.0
Message-ID: <162861318629.395.16160423295474407641.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the smp/core branch of tip:

Commit-ID:     ebca71a8c96f0af2ba482489ecc64d88979cd825
Gitweb:        https://git.kernel.org/tip/ebca71a8c96f0af2ba482489ecc64d88979cd825
Author:        Dongli Zhang <dongli.zhang@oracle.com>
AuthorDate:    Thu, 08 Apr 2021 22:53:16 -07:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 10 Aug 2021 18:31:32 +02:00

cpu/hotplug: Add debug printks for hotplug callback failures

CPU hotplug callbacks can fail and cause a rollback to the previous
state. These failures are silent and therefore hard to debug.

Add pr_debug() to the up and down paths which provide information about the
error code, the CPU and the failed state. The debug printks can be enabled
via kernel command line or sysfs.

[ tglx: Adopt to current mainline, massage printk and changelog ]

Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Qais Yousef <qais.yousef@arm.com>
Link: https://lore.kernel.org/r/20210409055316.1709-1-dongli.zhang@oracle.com

---
 kernel/cpu.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/kernel/cpu.c b/kernel/cpu.c
index 7ef28e1..192e43a 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -692,6 +692,10 @@ static int cpuhp_up_callbacks(unsigned int cpu, struct cpuhp_cpu_state *st,
 
 	ret = cpuhp_invoke_callback_range(true, cpu, st, target);
 	if (ret) {
+		pr_debug("CPU UP failed (%d) CPU %u state %s (%d)\n",
+			 ret, cpu, cpuhp_get_step(st->state)->name,
+			 st->state);
+
 		cpuhp_reset_state(st, prev_state);
 		if (can_rollback_cpu(st))
 			WARN_ON(cpuhp_invoke_callback_range(false, cpu, st,
@@ -1091,6 +1095,9 @@ static int cpuhp_down_callbacks(unsigned int cpu, struct cpuhp_cpu_state *st,
 
 	ret = cpuhp_invoke_callback_range(false, cpu, st, target);
 	if (ret) {
+		pr_debug("CPU DOWN failed (%d) CPU %u state %s (%d)\n",
+			 ret, cpu, cpuhp_get_step(st->state)->name,
+			 st->state);
 
 		cpuhp_reset_state(st, prev_state);
 
