Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BAEE3B6A7C
	for <lists+linux-tip-commits@lfdr.de>; Mon, 28 Jun 2021 23:39:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232207AbhF1VmY (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 28 Jun 2021 17:42:24 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:50334 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232143AbhF1VmX (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 28 Jun 2021 17:42:23 -0400
Date:   Mon, 28 Jun 2021 21:39:55 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1624916396;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=hxmcptiBSS73zbqQvLJ+on5hZc1VJNToy4eM0kSWVc8=;
        b=lxQzzb5hoyliE3VPC4IlJ+4MkKwuS1LADgx8f8VyfMwRfZAzR+0i0+ho7c8hupYQGrQ3CI
        JiRIuYfgPpa5dsTIeAYZ3013LBOO/2UuNdorrE9qR9PfoPStNxTfcpFBJ+nCmTpdUSrZhh
        TPad/3E9mfgrYrZPTLxKsIgO0wWwp6cvb9bNDFXCh5qvdakCbb80qcginz84TuFCwEdtzx
        vvPquL4agkUMV7lwrYPsfTNkuk74JFsmYDKwiqrZv6VPF4xHYNbS3aLYx8qGqGxDCXALmR
        FoqsrcKSpn1jpIbhzjUWyuVejhKtDLku/OPLOXMVInb1M/bqBol18iEGCEMKBQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1624916396;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=hxmcptiBSS73zbqQvLJ+on5hZc1VJNToy4eM0kSWVc8=;
        b=+JmSJeLFvDiJkfvMfGc92APMRTYSC/drtX/Kv19AGnD4pyyNkOvS+hpSPNDV6bk8DZSqkM
        LT7fDgh/LKPzkVBQ==
From:   "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/urgent] sched/core: Disable CONFIG_SCHED_CORE by default
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <162491639559.395.6693668427343777828.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/urgent branch of tip:

Commit-ID:     d2343cb8d154fe20c4499711bb3a9af2095b2b4b
Gitweb:        https://git.kernel.org/tip/d2343cb8d154fe20c4499711bb3a9af2095b2b4b
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Mon, 28 Jun 2021 21:55:16 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 28 Jun 2021 22:43:05 +02:00

sched/core: Disable CONFIG_SCHED_CORE by default

This option at minimum adds extra code to the scheduler - even if
it's default unused - and most users wouldn't want it.

Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/Kconfig.preempt | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/Kconfig.preempt b/kernel/Kconfig.preempt
index bd7c414..5876e30 100644
--- a/kernel/Kconfig.preempt
+++ b/kernel/Kconfig.preempt
@@ -102,7 +102,6 @@ config PREEMPT_DYNAMIC
 
 config SCHED_CORE
 	bool "Core Scheduling for SMT"
-	default y
 	depends on SCHED_SMT
 	help
 	  This option permits Core Scheduling, a means of coordinated task
@@ -115,7 +114,8 @@ config SCHED_CORE
 	   - mitigation of some (not all) SMT side channels;
 	   - limiting SMT interference to improve determinism and/or performance.
 
-	  SCHED_CORE is default enabled when SCHED_SMT is enabled -- when
-	  unused there should be no impact on performance.
+	  SCHED_CORE is default disabled. When it is enabled and unused,
+	  which is the likely usage by Linux distributions, there should
+	  be no measurable impact on performance.
 
 
