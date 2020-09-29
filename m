Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2598A27BE92
	for <lists+linux-tip-commits@lfdr.de>; Tue, 29 Sep 2020 09:57:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727754AbgI2H5S (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 29 Sep 2020 03:57:18 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:44402 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727674AbgI2H4y (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 29 Sep 2020 03:56:54 -0400
Date:   Tue, 29 Sep 2020 07:56:52 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1601366212;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=U7CfbqTIu4ffuB5Vk25yLn8JniTSOZFWZqsZFDKP7Fs=;
        b=u+FXIle1pdoHwLi9Ush6KJCEcTsEd8tNis5pePfTQoRqzl4QVfZ7wawc815yaUsM9JJrXk
        lDNGmp1xo3t8RcFWYwXovVB4wP5jJQX0VOnCpZv9rrZ30oKBg+Lia2GVOQqDOs2dXDsvFc
        BZASb4cG+fe5zOekJYU3FLVFQaJ7EJFFMXaWCTVInC68FDWYO+B0PuNo5zuiS1w1Gvy5EH
        Y+tGGMzTiJQjHmoPCE8wy+6emezf5/HAZ13nm11znUuL1SWR7Vjzdgq+PMZkMnli+Wb515
        YRCxxIoqtntm3mcJ46xOXn1zzCGWLM6RbF679piarMYc7v1mrQqw2GoWlkYIsQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1601366212;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=U7CfbqTIu4ffuB5Vk25yLn8JniTSOZFWZqsZFDKP7Fs=;
        b=L9iCT9JwGGLNEhfvYNl5lTLZbr5ncxKM1o5wD97NFPROJreH8CS1sMtun8V9kA5HzXkrMY
        rMHaXJa8A4WkADAw==
From:   "tip-bot2 for Daniel Bristot de Oliveira" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/rt: Disable RT_RUNTIME_SHARE by default
Cc:     Daniel Bristot de Oliveira <bristot@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Wei Wang <wvw@google.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <b776ab46817e3db5d8ef79175fa0d71073c051c7.1600697903.git.bristot@redhat.com>
References: <b776ab46817e3db5d8ef79175fa0d71073c051c7.1600697903.git.bristot@redhat.com>
MIME-Version: 1.0
Message-ID: <160136621203.7002.9402784269901680382.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     2586af1ac187f6b3a50930a4e33497074e81762d
Gitweb:        https://git.kernel.org/tip/2586af1ac187f6b3a50930a4e33497074e81762d
Author:        Daniel Bristot de Oliveira <bristot@redhat.com>
AuthorDate:    Mon, 21 Sep 2020 16:39:49 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 25 Sep 2020 14:23:24 +02:00

sched/rt: Disable RT_RUNTIME_SHARE by default

The RT_RUNTIME_SHARE sched feature enables the sharing of rt_runtime
between CPUs, allowing a CPU to run a real-time task up to 100% of the
time while leaving more space for non-real-time tasks to run on the CPU
that lend rt_runtime.

The problem is that a CPU can easily borrow enough rt_runtime to allow
a spinning rt-task to run forever, starving per-cpu tasks like kworkers,
which are non-real-time by design.

This patch disables RT_RUNTIME_SHARE by default, avoiding this problem.
The feature will still be present for users that want to enable it,
though.

Signed-off-by: Daniel Bristot de Oliveira <bristot@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Wei Wang <wvw@google.com>
Link: https://lkml.kernel.org/r/b776ab46817e3db5d8ef79175fa0d71073c051c7.1600697903.git.bristot@redhat.com
---
 kernel/sched/features.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/features.h b/kernel/sched/features.h
index 7481cd9..68d369c 100644
--- a/kernel/sched/features.h
+++ b/kernel/sched/features.h
@@ -77,7 +77,7 @@ SCHED_FEAT(WARN_DOUBLE_CLOCK, false)
 SCHED_FEAT(RT_PUSH_IPI, true)
 #endif
 
-SCHED_FEAT(RT_RUNTIME_SHARE, true)
+SCHED_FEAT(RT_RUNTIME_SHARE, false)
 SCHED_FEAT(LB_MIN, false)
 SCHED_FEAT(ATTACH_AGE_LOAD, true)
 
