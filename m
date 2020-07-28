Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 858C2230A0B
	for <lists+linux-tip-commits@lfdr.de>; Tue, 28 Jul 2020 14:29:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729587AbgG1M3J (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 28 Jul 2020 08:29:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729399AbgG1M3I (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 28 Jul 2020 08:29:08 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9867C061794;
        Tue, 28 Jul 2020 05:29:08 -0700 (PDT)
Date:   Tue, 28 Jul 2020 12:29:06 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1595939346;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rI4p+p7PY7+lEZb3eDxP0kJaacGlY/NLIZWz8rMV/U0=;
        b=pxHNeRZMrsEPfLylenuhN1fExrnCQ0qPz3SaOsEsOZegNt41iewnDDt8ho2OHEYlUn413o
        k1OUpgqsVaIO0hpVh+PArT0lm2WxdLUuLpx2ZBbMAwIOqkQ7DRCCDI8BahhZ4fXEVlJHou
        CSw4/VZDrmW2aNYgDi5fhM9JeYrmkeqFVx5yu1NkMEGUsfg0/hbwDP1GQpK99sXjNIZtPw
        +qR71ssImI9rzvvoxCPjkDyBSCuK/YYHRbC5H0KJnJ2KFSQxT2FLQI9ehvwPuB5OsBuXeZ
        QJzNkn61Cwdc+IMbUwXJ4+PvWEiSRE90HQJewEe1xJENlR+blz+oohLY8dguFQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1595939346;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rI4p+p7PY7+lEZb3eDxP0kJaacGlY/NLIZWz8rMV/U0=;
        b=1/iTDsNn4RKNat2rjRmQFmA+grMMFd6i9da5lBH++p+yMnDeKLH4xGv3LarMjIXRIW0JLk
        C2vJZpMRT0cSs+DA==
From:   "tip-bot2 for Masami Hiramatsu" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] kprobes: Remove unnecessary module_mutex locking
 from kprobe_optimizer()
Cc:     Ingo Molnar <mingo@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200728163400.e00b09c594763349f99ce6cb@kernel.org>
References: <20200728163400.e00b09c594763349f99ce6cb@kernel.org>
MIME-Version: 1.0
Message-ID: <159593934624.4006.4213436208654596958.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     112a0e4171e111e963aada3fe790c71accf4d705
Gitweb:        https://git.kernel.org/tip/112a0e4171e111e963aada3fe790c71accf4d705
Author:        Masami Hiramatsu <mhiramat@kernel.org>
AuthorDate:    Tue, 28 Jul 2020 16:34:00 +09:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 28 Jul 2020 13:19:05 +02:00

kprobes: Remove unnecessary module_mutex locking from kprobe_optimizer()

Since we already lock both kprobe_mutex and text_mutex in the optimizer,
text will not be changed and the module unloading will be stopped
inside kprobes_module_callback().

The mutex_lock() has originally been introduced to avoid conflict with text modification,
at that point we didn't hold text_mutex.

But after:

  f1c6ece23729 ("kprobes: Fix potential deadlock in kprobe_optimizer()")

We started holding the text_mutex and don't need the modules mutex anyway.

So remove the module_mutex locking.

[ mingo: Amended the changelog. ]

Suggested-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Link: https://lore.kernel.org/r/20200728163400.e00b09c594763349f99ce6cb@kernel.org
---
 kernel/kprobes.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index 146c648..e87679a 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -598,8 +598,6 @@ static void kprobe_optimizer(struct work_struct *work)
 	mutex_lock(&kprobe_mutex);
 	cpus_read_lock();
 	mutex_lock(&text_mutex);
-	/* Lock modules while optimizing kprobes */
-	mutex_lock(&module_mutex);
 
 	/*
 	 * Step 1: Unoptimize kprobes and collect cleaned (unused and disarmed)
@@ -624,7 +622,6 @@ static void kprobe_optimizer(struct work_struct *work)
 	/* Step 4: Free cleaned kprobes after quiesence period */
 	do_free_cleaned_kprobes();
 
-	mutex_unlock(&module_mutex);
 	mutex_unlock(&text_mutex);
 	cpus_read_unlock();
 
