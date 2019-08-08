Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D2EFB8606A
	for <lists+linux-tip-commits@lfdr.de>; Thu,  8 Aug 2019 12:55:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730678AbfHHKzQ (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 8 Aug 2019 06:55:16 -0400
Received: from terminus.zytor.com ([198.137.202.136]:41455 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726721AbfHHKzQ (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 8 Aug 2019 06:55:16 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x78At1Rg3127278
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 8 Aug 2019 03:55:01 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x78At1Rg3127278
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1565261702;
        bh=OihPpjJBcLQtJVDsWd7mWmGuo4B9da2JbRFgAdhG0vY=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=FcmSYF/IeA5YZBeHtqrZynIMyWWw27wm+8iEKa8OKTLM3naWBXQSRtynWeKERL9sM
         hQjV665AXMZtdWqS5K404MEUeFGz5DmXQvb6pofG4XOda6thZXsNpJo/WERvvlyPvP
         n5ZpoqSCp/WImC9BUP6RcRJHwb9TOQc4khc1k8mhfVKm1HnllJjCWnbRd5zhzpyg5D
         5UMRaP1E3kQReui7yMfkClt4qpROvNoJYGUdB7TgD7/muPmmUNfAKw10Ws8IlEuDSh
         WnPu3AuwxBclF8w2bVPhyqRu1jd9N7QMNjfY8NLSrLEflRdgMU2OcypmZWQvQlHohk
         xAUo9j5++4qbw==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x78At1YR3127263;
        Thu, 8 Aug 2019 03:55:01 -0700
Date:   Thu, 8 Aug 2019 03:55:01 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Peter Zijlstra <tipbot@zytor.com>
Message-ID: <tip-5feeb7837a448f659e0aaa19fb446b1d9a4b323a@git.kernel.org>
Cc:     tglx@linutronix.de, mingo@kernel.org, hpa@zytor.com,
        valentin.schneider@arm.com, naravamudan@digitalocean.com,
        aaron.lwe@gmail.com, linux-kernel@vger.kernel.org,
        pauld@redhat.com, peterz@infradead.org, jdesfossez@digitalocean.com
Reply-To: peterz@infradead.org, jdesfossez@digitalocean.com, hpa@zytor.com,
          mingo@kernel.org, tglx@linutronix.de, pauld@redhat.com,
          aaron.lwe@gmail.com, linux-kernel@vger.kernel.org,
          naravamudan@digitalocean.com, valentin.schneider@arm.com
In-Reply-To: <fde3a65ea3091ec6b84dac3c19639f85f452c5d1.1559129225.git.vpillai@digitalocean.com>
References: <fde3a65ea3091ec6b84dac3c19639f85f452c5d1.1559129225.git.vpillai@digitalocean.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:sched/core] sched: Fix kerneldoc comment for
 ia64_set_curr_task
Git-Commit-ID: 5feeb7837a448f659e0aaa19fb446b1d9a4b323a
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
X-Spam-Status: No, score=1.8 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        DATE_IN_FUTURE_96_Q,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_FORGED_REPLYTO autolearn=no autolearn_force=no version=3.4.2
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on terminus.zytor.com
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

Commit-ID:  5feeb7837a448f659e0aaa19fb446b1d9a4b323a
Gitweb:     https://git.kernel.org/tip/5feeb7837a448f659e0aaa19fb446b1d9a4b323a
Author:     Peter Zijlstra <peterz@infradead.org>
AuthorDate: Wed, 29 May 2019 20:36:38 +0000
Committer:  Peter Zijlstra <peterz@infradead.org>
CommitDate: Thu, 8 Aug 2019 09:09:30 +0200

sched: Fix kerneldoc comment for ia64_set_curr_task

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Aaron Lu <aaron.lwe@gmail.com>
Cc: Valentin Schneider <valentin.schneider@arm.com>
Cc: mingo@kernel.org
Cc: Phil Auld <pauld@redhat.com>
Cc: Julien Desfossez <jdesfossez@digitalocean.com>
Cc: Nishanth Aravamudan <naravamudan@digitalocean.com>
Link: https://lkml.kernel.org/r/fde3a65ea3091ec6b84dac3c19639f85f452c5d1.1559129225.git.vpillai@digitalocean.com
---
 kernel/sched/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index b4a44bc84749..9a821ff68502 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6772,7 +6772,7 @@ struct task_struct *curr_task(int cpu)
 
 #ifdef CONFIG_IA64
 /**
- * set_curr_task - set the current task for a given CPU.
+ * ia64_set_curr_task - set the current task for a given CPU.
  * @cpu: the processor in question.
  * @p: the task pointer to set.
  *
