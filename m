Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A6EF32B094
	for <lists+linux-tip-commits@lfdr.de>; Wed,  3 Mar 2021 04:43:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235722AbhCCDjI (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 2 Mar 2021 22:39:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1577826AbhCBJzc (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 2 Mar 2021 04:55:32 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A72F0C06121D;
        Tue,  2 Mar 2021 01:54:48 -0800 (PST)
Date:   Tue, 02 Mar 2021 09:54:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1614678887;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=o5fRt0fkW8r3H74UHvCkdfOMOqabka4CfbA4sJRiIo4=;
        b=Bes0xDfbdg95dSXhO+U8FkepJh5Xfutn2Yph1hfRqbUITUfZ3l10KrhkzL2fFN1MsBbQMx
        4ZKvPSnC3MucsXgRgPz3yMUipcO3FRFpVfDHigE7PlKXDYYahmxIV9sOV4QEL+VN2kqfzO
        aDlFdisKftrFP1IIMC3R3kqDxySYw7Dr5rGxIF6y5V9q6pKUfPMk305qECgB/QVQuIYGiM
        Mx4UaGCgG3Uv+cvW7wa5EpseM4urDzVaxCWpzWfGCqRUQlUtZX95dZ7g0N4E5oVEv63Oj1
        qnkDuzFZW2HvMIPuvZ2RiNGwbPANY6R673pJ7ymf95G6FxzKcMiI1cAY3FLDHw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1614678887;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=o5fRt0fkW8r3H74UHvCkdfOMOqabka4CfbA4sJRiIo4=;
        b=nQ+J+Mn1i82HhRPxw7/SXuxI+iJ+uykd7FFlj6YTodGQv/pQecclRSmpDn2lgf2vx3jNSY
        JshdM+CzSH0iA7AQ==
From:   "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/mm] smp: Micro-optimize smp_call_function_many_cond()
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
        x86@kernel.org
MIME-Version: 1.0
Message-ID: <161467888606.20312.2057210831067843812.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/mm branch of tip:

Commit-ID:     dd75cba56151cb3b9dc7eac0221c9b1967f6ddb5
Gitweb:        https://git.kernel.org/tip/dd75cba56151cb3b9dc7eac0221c9b1967f6ddb5
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Tue, 02 Mar 2021 08:02:43 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 02 Mar 2021 09:09:59 +01:00

smp: Micro-optimize smp_call_function_many_cond()

Call the generic send_call_function_single_ipi() function, which
will avoid the IPI when @last_cpu is idle.

Signed-off-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/smp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/smp.c b/kernel/smp.c
index b6375d7..af0d51d 100644
--- a/kernel/smp.c
+++ b/kernel/smp.c
@@ -694,7 +694,7 @@ static void smp_call_function_many_cond(const struct cpumask *mask,
 		 * provided mask.
 		 */
 		if (nr_cpus == 1)
-			arch_send_call_function_single_ipi(last_cpu);
+			send_call_function_single_ipi(last_cpu);
 		else if (likely(nr_cpus > 1))
 			arch_send_call_function_ipi_mask(cfd->cpumask_ipi);
 	}
