Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB5763974F0
	for <lists+linux-tip-commits@lfdr.de>; Tue,  1 Jun 2021 16:05:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234265AbhFAOGl (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 1 Jun 2021 10:06:41 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33174 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234206AbhFAOGk (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 1 Jun 2021 10:06:40 -0400
Date:   Tue, 01 Jun 2021 14:04:57 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1622556298;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rYC9ZduJnAjuxjdLWAeAQnaSva6G2B+jOPkc7wyTFOY=;
        b=SGc8aCWzbWV1eBXFYkbzxj55GJIDuoyBJ1TTgScwuwAPoVBxaBDksl9uVfkFxdrjWeP+MQ
        Av+0bCwPG3t7XBPPF9ysOsOGm7NDycCx21m7xWpM37puU5CBhFhE2Vxw/HikBgyS1evbYT
        ux0WfC4hv8jK94Zvap8w9BMH1Oj4Ju/uDMCPbDsIOSrJSUjJgOrzpviPC36lZNNOO337gu
        p1i6/2iOVoRZpSADoM9T6YU4/rGGzsTJhRlpxZpObqG6mNiwG8QZNWc4G9am1iaYRgzVb+
        zZPOcX1gOuP6Oh6zmVmmVmSEMOKn+wf2iVWW9H9Fcl3OaT1UU/ZTW+JZGrd5Fg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1622556298;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rYC9ZduJnAjuxjdLWAeAQnaSva6G2B+jOPkc7wyTFOY=;
        b=YtfrKRWFRSudy2wXh4rU+7Ok5+D2lq9JbJ0OIlV8USAtwmPne3BJurPdswvBoOEdvpMo6o
        bFx9JLaBlMcFU1DA==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched: Add CONFIG_SCHED_CORE help text
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Hugh Dickins <hughd@google.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <YKyhtwhEgvtUDOyl@hirez.programming.kicks-ass.net>
References: <YKyhtwhEgvtUDOyl@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Message-ID: <162255629757.29796.5663233849330605967.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     7b419f47facd286c6723daca6ad69ec355473f78
Gitweb:        https://git.kernel.org/tip/7b419f47facd286c6723daca6ad69ec355473f78
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Tue, 25 May 2021 08:53:28 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 01 Jun 2021 16:00:10 +02:00

sched: Add CONFIG_SCHED_CORE help text

Hugh noted that the SCHED_CORE Kconfig option could do with a help
text.

Requested-by: Hugh Dickins <hughd@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
Acked-by: Hugh Dickins <hughd@google.com>
Link: https://lkml.kernel.org/r/YKyhtwhEgvtUDOyl@hirez.programming.kicks-ass.net
---
 kernel/Kconfig.preempt | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/kernel/Kconfig.preempt b/kernel/Kconfig.preempt
index ea1e333..bd7c414 100644
--- a/kernel/Kconfig.preempt
+++ b/kernel/Kconfig.preempt
@@ -104,4 +104,18 @@ config SCHED_CORE
 	bool "Core Scheduling for SMT"
 	default y
 	depends on SCHED_SMT
+	help
+	  This option permits Core Scheduling, a means of coordinated task
+	  selection across SMT siblings. When enabled -- see
+	  prctl(PR_SCHED_CORE) -- task selection ensures that all SMT siblings
+	  will execute a task from the same 'core group', forcing idle when no
+	  matching task is found.
+
+	  Use of this feature includes:
+	   - mitigation of some (not all) SMT side channels;
+	   - limiting SMT interference to improve determinism and/or performance.
+
+	  SCHED_CORE is default enabled when SCHED_SMT is enabled -- when
+	  unused there should be no impact on performance.
+
 
