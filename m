Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49DD33E115F
	for <lists+linux-tip-commits@lfdr.de>; Thu,  5 Aug 2021 11:34:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239260AbhHEJew (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 5 Aug 2021 05:34:52 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:41660 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237464AbhHEJeu (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 5 Aug 2021 05:34:50 -0400
Date:   Thu, 05 Aug 2021 09:34:35 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628156076;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MCPHILnnBf7at1s3n4owaliRhZjOxHKLxJXSuJMZkYc=;
        b=FFH/hH5ktzS7ZmHtsOsWwUUxqH0xtlk4YicL7hFRYLhbV5klChAXlirXAdGLJc1aJ3HiMF
        TNIpUPVxOaawBdpreHBtuU/SqrkdBTwn8mYKuV7ATx3ENLyDERjAV5WVS2+T1B28/LhNj1
        JihxhPSYYR6oNMSBtHIWwyYZGijmXIg0p0B/bAIxiWuyjOvvTqRWLzuYuIYR+WauOm5nJO
        DDVMDDguGTwg4QFmEDcpMKq6l4W+e7x0xDtku28lCEmwiOAniOMNeh3Dx8947jLd1FfFbe
        7Zqhn8fO6/u5Y4UTEm3XrEvXejcc2IH+d6hko/xjIFmy54H57IXIcULO6NYwww==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628156076;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MCPHILnnBf7at1s3n4owaliRhZjOxHKLxJXSuJMZkYc=;
        b=2fLPs4T71abZxahuy5HR/oVAayztbGiGqBVsdqMEcT1sV6i1TY7g1CcSgDpZQNmqMa2xRA
        aUZmhPUIabNLDXBQ==
From:   "tip-bot2 for Quentin Perret" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched: Don't report SCHED_FLAG_SUGOV in sched_getattr()
Cc:     Quentin Perret <qperret@google.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210727101103.2729607-3-qperret@google.com>
References: <20210727101103.2729607-3-qperret@google.com>
MIME-Version: 1.0
Message-ID: <162815607530.395.9529872932900083627.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     7ad721bf10718a4e480a27ded8bb16b8f6feb2d1
Gitweb:        https://git.kernel.org/tip/7ad721bf10718a4e480a27ded8bb16b8f6feb2d1
Author:        Quentin Perret <qperret@google.com>
AuthorDate:    Tue, 27 Jul 2021 11:11:02 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 04 Aug 2021 15:16:44 +02:00

sched: Don't report SCHED_FLAG_SUGOV in sched_getattr()

SCHED_FLAG_SUGOV is supposed to be a kernel-only flag that userspace
cannot interact with. However, sched_getattr() currently reports it
in sched_flags if called on a sugov worker even though it is not
actually defined in a UAPI header. To avoid this, make sure to
clean-up the sched_flags field in sched_getattr() before returning to
userspace.

Signed-off-by: Quentin Perret <qperret@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20210727101103.2729607-3-qperret@google.com
---
 kernel/sched/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 6c562ad..314f70d 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -7530,6 +7530,7 @@ SYSCALL_DEFINE4(sched_getattr, pid_t, pid, struct sched_attr __user *, uattr,
 		kattr.sched_priority = p->rt_priority;
 	else
 		kattr.sched_nice = task_nice(p);
+	kattr.sched_flags &= SCHED_FLAG_ALL;
 
 #ifdef CONFIG_UCLAMP_TASK
 	/*
