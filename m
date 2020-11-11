Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26ACB2AEB09
	for <lists+linux-tip-commits@lfdr.de>; Wed, 11 Nov 2020 09:23:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726432AbgKKIXl (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 11 Nov 2020 03:23:41 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:36242 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726376AbgKKIX3 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 11 Nov 2020 03:23:29 -0500
Date:   Wed, 11 Nov 2020 08:23:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605083007;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uAgjSp2j4ExFJA8oR5i/nCtb9LCLDSoCAcTAVFx12cE=;
        b=nLuFE9f8q9+pTZqurem8vDTpJUQZ+Uc0t35z0FV517yBU8aU4CdeMB3h+u2DWPAWKZpWU+
        oV/Nc+Vq1V23W362toN73LeSIlJn3SOzT0VQ9S7mXSkkAamkXpLmnYzDLJsp/KR+Padt5I
        Ctq9jiF5A7YK2m9y+1WO41m/iVErxVgt0mueLwOGjqjRv9L8PyMWCIiwVr8o9l/YynnNcB
        CR0xrz12+qvatIttqI/+3FpBa1FM7pkZO0lDFQokmQ5f5trTSIIrbbe2GX9omGxgyND945
        MD57RoE6sqtHCcYDCMgpQRdkTMF3mczO7bWCwuv0ZZhzcIS3VgHd5qyPcnfLyg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605083007;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uAgjSp2j4ExFJA8oR5i/nCtb9LCLDSoCAcTAVFx12cE=;
        b=4SogBABDK0M8UuvKtAxeI8YppYPjX5p4Dt8MK1GjyjiOox2Qd9YszBRb8Zj1dt0NkQ/RsK
        xx2QL4qAOnyyQ0Cg==
From:   "tip-bot2 for Colin Ian King" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/urgent] sched/debug: Fix memory corruption caused by
 multiple small reads of flags
Cc:     Jeff Bastian <jbastian@redhat.com>,
        Colin Ian King <colin.king@canonical.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20201029151103.373410-1-colin.king@canonical.com>
References: <20201029151103.373410-1-colin.king@canonical.com>
MIME-Version: 1.0
Message-ID: <160508300664.11244.13448102071248830397.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/urgent branch of tip:

Commit-ID:     8d4d9c7b4333abccb3bf310d76ef7ea2edb9828f
Gitweb:        https://git.kernel.org/tip/8d4d9c7b4333abccb3bf310d76ef7ea2edb9828f
Author:        Colin Ian King <colin.king@canonical.com>
AuthorDate:    Thu, 29 Oct 2020 15:11:03 
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 10 Nov 2020 18:38:49 +01:00

sched/debug: Fix memory corruption caused by multiple small reads of flags

Reading /proc/sys/kernel/sched_domain/cpu*/domain0/flags mutliple times
with small reads causes oopses with slub corruption issues because the kfree is
free'ing an offset from a previous allocation. Fix this by adding in a new
pointer 'buf' for the allocation and kfree and use the temporary pointer tmp
to handle memory copies of the buf offsets.

Fixes: 5b9f8ff7b320 ("sched/debug: Output SD flag names rather than their values")
Reported-by: Jeff Bastian <jbastian@redhat.com>
Signed-off-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>
Link: https://lkml.kernel.org/r/20201029151103.373410-1-colin.king@canonical.com
---
 kernel/sched/debug.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index 0655524..2357921 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -251,7 +251,7 @@ static int sd_ctl_doflags(struct ctl_table *table, int write,
 	unsigned long flags = *(unsigned long *)table->data;
 	size_t data_size = 0;
 	size_t len = 0;
-	char *tmp;
+	char *tmp, *buf;
 	int idx;
 
 	if (write)
@@ -269,17 +269,17 @@ static int sd_ctl_doflags(struct ctl_table *table, int write,
 		return 0;
 	}
 
-	tmp = kcalloc(data_size + 1, sizeof(*tmp), GFP_KERNEL);
-	if (!tmp)
+	buf = kcalloc(data_size + 1, sizeof(*buf), GFP_KERNEL);
+	if (!buf)
 		return -ENOMEM;
 
 	for_each_set_bit(idx, &flags, __SD_FLAG_CNT) {
 		char *name = sd_flag_debug[idx].name;
 
-		len += snprintf(tmp + len, strlen(name) + 2, "%s ", name);
+		len += snprintf(buf + len, strlen(name) + 2, "%s ", name);
 	}
 
-	tmp += *ppos;
+	tmp = buf + *ppos;
 	len -= *ppos;
 
 	if (len > *lenp)
@@ -294,7 +294,7 @@ static int sd_ctl_doflags(struct ctl_table *table, int write,
 	*lenp = len;
 	*ppos += len;
 
-	kfree(tmp);
+	kfree(buf);
 
 	return 0;
 }
