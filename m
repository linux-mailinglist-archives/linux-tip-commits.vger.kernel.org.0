Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E571E27FF70
	for <lists+linux-tip-commits@lfdr.de>; Thu,  1 Oct 2020 14:46:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732173AbgJAMqy (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 1 Oct 2020 08:46:54 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:35552 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731993AbgJAMqx (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 1 Oct 2020 08:46:53 -0400
Date:   Thu, 01 Oct 2020 12:46:50 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1601556411;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YIMGF7IMxliYtE6naXjW3YcVrnCqmp9ZAntLgNtEnTw=;
        b=oGhKalmp3Jlhk3CI/UZTFbb6sCLwnjSoZKvghmUmNFQViTy51v0DY7y7/LBbzeKrhO2qzo
        exhvRFOroWZvpyy1tcf6C2UJjVrCeJGZ0jcZS8wQ6A/7V3dk/1GvCEtxxppEWwfurB9WWs
        OBM5/byReeATmpr2N2T1bvBi2VDUHpFUjuoDEcjIvd6wpxJAK90krX30ldPWTkp6wwPPh0
        pzgpYNmp2wC2crKUA9AhdR9TU6lqDp/eav+BK2bHbfNOBcFC81Hkm8CyQWURzmx7fuDq4+
        Jw3Z/oZVxQCpS6Z8C7uN8Y6tpBpvGVrpmPiOsiwkXU2qtShPn83LDrMwKoFmsw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1601556411;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YIMGF7IMxliYtE6naXjW3YcVrnCqmp9ZAntLgNtEnTw=;
        b=TvSjWZxVIgv/MsM+cqSOHolVdfT+bU4ckGjLT1oz/v5bb0SzKGgnN4qSnMdhuvjg/3XzBn
        xq9DJlPDpJYTuDCA==
From:   "tip-bot2 for Libing Zhou" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/misc] x86/nmi: Fix nmi_handle() duration miscalculation
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Libing Zhou <libing.zhou@nokia-sbell.com>,
        Borislav Petkov <bp@suse.de>,
        Changbin Du <changbin.du@gmail.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200820025641.44075-1-libing.zhou@nokia-sbell.com>
References: <20200820025641.44075-1-libing.zhou@nokia-sbell.com>
MIME-Version: 1.0
Message-ID: <160155641006.7002.1092577567276501633.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/misc branch of tip:

Commit-ID:     f94c91f7ba3ba7de2bc8aa31be28e1abb22f849e
Gitweb:        https://git.kernel.org/tip/f94c91f7ba3ba7de2bc8aa31be28e1abb22f849e
Author:        Libing Zhou <libing.zhou@nokia-sbell.com>
AuthorDate:    Thu, 20 Aug 2020 10:56:41 +08:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Thu, 01 Oct 2020 14:42:08 +02:00

x86/nmi: Fix nmi_handle() duration miscalculation

When nmi_check_duration() is checking the time an NMI handler took to
execute, the whole_msecs value used should be read from the @duration
argument, not from the ->max_duration, the latter being used to store
the current maximal duration.

 [ bp: Rewrite commit message. ]

Fixes: 248ed51048c4 ("x86/nmi: Remove irq_work from the long duration NMI handler")
Suggested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Libing Zhou <libing.zhou@nokia-sbell.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: Changbin Du <changbin.du@gmail.com>
Link: https://lkml.kernel.org/r/20200820025641.44075-1-libing.zhou@nokia-sbell.com
---
 arch/x86/kernel/nmi.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/nmi.c b/arch/x86/kernel/nmi.c
index 4fc9954..4738166 100644
--- a/arch/x86/kernel/nmi.c
+++ b/arch/x86/kernel/nmi.c
@@ -102,7 +102,6 @@ fs_initcall(nmi_warning_debugfs);
 
 static void nmi_check_duration(struct nmiaction *action, u64 duration)
 {
-	u64 whole_msecs = READ_ONCE(action->max_duration);
 	int remainder_ns, decimal_msecs;
 
 	if (duration < nmi_longest_ns || duration < action->max_duration)
@@ -110,12 +109,12 @@ static void nmi_check_duration(struct nmiaction *action, u64 duration)
 
 	action->max_duration = duration;
 
-	remainder_ns = do_div(whole_msecs, (1000 * 1000));
+	remainder_ns = do_div(duration, (1000 * 1000));
 	decimal_msecs = remainder_ns / 1000;
 
 	printk_ratelimited(KERN_INFO
 		"INFO: NMI handler (%ps) took too long to run: %lld.%03d msecs\n",
-		action->handler, whole_msecs, decimal_msecs);
+		action->handler, duration, decimal_msecs);
 }
 
 static int nmi_handle(unsigned int type, struct pt_regs *regs)
