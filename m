Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41D0D32FA86
	for <lists+linux-tip-commits@lfdr.de>; Sat,  6 Mar 2021 13:13:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230521AbhCFMNW (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sat, 6 Mar 2021 07:13:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231133AbhCFMMz (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sat, 6 Mar 2021 07:12:55 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 881E5C06174A;
        Sat,  6 Mar 2021 04:12:55 -0800 (PST)
Date:   Sat, 06 Mar 2021 12:12:53 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1615032774;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=48kPM0f79vSXe1drsieCmgoNMep3siPJdaGAOREFhMQ=;
        b=KSP9sC1dfn7lBUP4oFmuk4cS+P4Nk+QA2HXAcUf48f/4nfqzjkDw7ycdLfSZ9H1mhgke2E
        riXYnl4keXCpZTlGaHuHqlFPWXyqxxuiXU+KEOlSoWWLF7lQ8BmQ53GyZ8fLyA9t8RvR/a
        unjNc4vnSnKFhiQ+8tzGm9dA1IDBm0wEwuHjtfyVx3WbMSkUKSBXs1VIra5wSiBlaH9bf2
        LHtciU13Jhk3vKysG0IZxNtUwoXLsVSekNp957R3xo480OuCSV8xdEQJvjsJb92xH5QnFa
        cK/QWH2jdZA9hphAmmhDJIcHqW3nUT4uHMAq1OsQhKvpo0CcJw6nhh/3MZ8Itg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1615032774;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=48kPM0f79vSXe1drsieCmgoNMep3siPJdaGAOREFhMQ=;
        b=Y2wAMcQXZ3T6fabjBIxQh99b2I3CbZSIqY4enoalfSPkHKoahqUGx6n88thbmaDzQaqZew
        GcMF6PgeXyRy/+AA==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/mm] smp: Micro-optimize smp_call_function_many_cond()
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
        x86@kernel.org
MIME-Version: 1.0
Message-ID: <161503277342.398.3827662830739276370.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/mm branch of tip:

Commit-ID:     d43f17a1da25373580ebb466de7d0641acbf6fd6
Gitweb:        https://git.kernel.org/tip/d43f17a1da25373580ebb466de7d0641acbf6fd6
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Tue, 02 Mar 2021 08:02:43 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sat, 06 Mar 2021 13:00:22 +01:00

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
