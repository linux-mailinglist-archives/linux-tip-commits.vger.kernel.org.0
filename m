Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98478437AF5
	for <lists+linux-tip-commits@lfdr.de>; Fri, 22 Oct 2021 18:31:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233509AbhJVQeF (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 22 Oct 2021 12:34:05 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:40350 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233483AbhJVQeE (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 22 Oct 2021 12:34:04 -0400
Date:   Fri, 22 Oct 2021 16:31:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1634920306;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=6v61k7tjwWa46bRa3CV/1r1ipNhwUkoBuRqYqZtjPuY=;
        b=uf+ZQutT3JhhK8o4bWl+k5Q4YIMMLjGtIglyrdyH/ZBGRKY19LFPWKD+/Ym91jfYc97wb9
        FmWDn3VdXG2OcFukdn1fes8/co4tEmw5RLKrJdMsiBzR91Nu0lw9eQ0nYmY9mbHzFaTRKK
        o9OiXcvRwBkIdW7UZR+NumEPOP/+mAdl1znkTngCfMPW9E/5Qjr3ccREwuq+oYpnledM7j
        JUhrC3E1P86uLWoL2ykwBg+RBSmjUCIh1OTRqEgetRAU5r+RwHZcjajWlenuE0/zG4DFGL
        Y9n7tnw11rE4lrNLZEfsNYRtkzGUZzzAU3cr+zso/eyx/jYzmwl68QbQAOKD2g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1634920306;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=6v61k7tjwWa46bRa3CV/1r1ipNhwUkoBuRqYqZtjPuY=;
        b=ZIl8eHIRh/TUQC41Cz6eecqh+TFssRDcACWjE3ITNN+3I//MaeE7AvmFKm8YvMoT79qx+D
        4VkZwJixe+uWGsDw==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched,x86: Fix L2 cache mask
Cc:     Tom Lendacky <thomas.lendacky@amd.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <163492030498.626.18148681011754446836.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     55409ac5c371c6403012d5f4df5e7c6cf0e7dce6
Gitweb:        https://git.kernel.org/tip/55409ac5c371c6403012d5f4df5e7c6cf0e7dce6
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Fri, 22 Oct 2021 17:49:53 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 22 Oct 2021 18:21:28 +02:00

sched,x86: Fix L2 cache mask

Currently AMD/Hygon do not populate l2c_id, this means that for SMT
enabled systems they report an L2 per thread. This is ofcourse not
true but was harmless so far.

However, since commit: 66558b730f25 ("sched: Add cluster scheduler
level for x86") the scheduler topology setup requires:

  SMT <= L2 <= LLC

Which leads to noisy warnings and possibly weird behaviour on affected
chips.

Therefore change the topology generation such that if l2c_id is not
populated it follows the SMT topology, thereby satisfying the
constraint.

Fixes: 66558b730f25 ("sched: Add cluster scheduler level for x86")
Reported-by: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Tom Lendacky <thomas.lendacky@amd.com>
---
 arch/x86/kernel/smpboot.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index 5094ab0..f80f459 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -470,9 +470,9 @@ static bool match_l2c(struct cpuinfo_x86 *c, struct cpuinfo_x86 *o)
 {
 	int cpu1 = c->cpu_index, cpu2 = o->cpu_index;
 
-	/* Do not match if we do not have a valid APICID for cpu: */
+	/* If the arch didn't set up l2c_id, fall back to SMT */
 	if (per_cpu(cpu_l2c_id, cpu1) == BAD_APICID)
-		return false;
+		return match_smt(c, o);
 
 	/* Do not match if L2 cache id does not match: */
 	if (per_cpu(cpu_l2c_id, cpu1) != per_cpu(cpu_l2c_id, cpu2))
