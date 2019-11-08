Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 761A5F5A4B
	for <lists+linux-tip-commits@lfdr.de>; Fri,  8 Nov 2019 22:47:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732876AbfKHVlw convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 8 Nov 2019 16:41:52 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:52713 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732101AbfKHVlv (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 8 Nov 2019 16:41:51 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iTC0b-0004QZ-SH; Fri, 08 Nov 2019 22:41:34 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 5FE331C0315;
        Fri,  8 Nov 2019 22:41:33 +0100 (CET)
Date:   Fri, 08 Nov 2019 21:41:33 -0000
From:   "tip-bot2 for Qais Yousef" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/urgent] sched/core: Fix compilation error when cgroup not
 selected
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Qais Yousef <qais.yousef@arm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Patrick Bellasi <patrick.bellasi@matbug.net>,
        Mel Gorman <mgorman@suse.de>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Ben Segall <bsegall@google.com>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20191105112212.596-1-qais.yousef@arm.com>
References: <20191105112212.596-1-qais.yousef@arm.com>
MIME-Version: 1.0
Message-ID: <157324929309.29376.17659204577341601254.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/urgent branch of tip:

Commit-ID:     e3b8b6a0d12cccf772113d6b5c1875192186fbd4
Gitweb:        https://git.kernel.org/tip/e3b8b6a0d12cccf772113d6b5c1875192186fbd4
Author:        Qais Yousef <qais.yousef@arm.com>
AuthorDate:    Tue, 05 Nov 2019 11:22:12 
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 08 Nov 2019 22:34:14 +01:00

sched/core: Fix compilation error when cgroup not selected

When cgroup is disabled the following compilation error was hit

	kernel/sched/core.c: In function ‘uclamp_update_active_tasks’:
	kernel/sched/core.c:1081:23: error: storage size of ‘it’ isn’t known
	  struct css_task_iter it;
			       ^~
	kernel/sched/core.c:1084:2: error: implicit declaration of function ‘css_task_iter_start’; did you mean ‘__sg_page_iter_start’? [-Werror=implicit-function-declaration]
	  css_task_iter_start(css, 0, &it);
	  ^~~~~~~~~~~~~~~~~~~
	  __sg_page_iter_start
	kernel/sched/core.c:1085:14: error: implicit declaration of function ‘css_task_iter_next’; did you mean ‘__sg_page_iter_next’? [-Werror=implicit-function-declaration]
	  while ((p = css_task_iter_next(&it))) {
		      ^~~~~~~~~~~~~~~~~~
		      __sg_page_iter_next
	kernel/sched/core.c:1091:2: error: implicit declaration of function ‘css_task_iter_end’; did you mean ‘get_task_cred’? [-Werror=implicit-function-declaration]
	  css_task_iter_end(&it);
	  ^~~~~~~~~~~~~~~~~
	  get_task_cred
	kernel/sched/core.c:1081:23: warning: unused variable ‘it’ [-Wunused-variable]
	  struct css_task_iter it;
			       ^~
	cc1: some warnings being treated as errors
	make[2]: *** [kernel/sched/core.o] Error 1

Fix by protetion uclamp_update_active_tasks() with
CONFIG_UCLAMP_TASK_GROUP

Fixes: babbe170e053 ("sched/uclamp: Update CPU's refcount on TG's clamp changes")
Reported-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Qais Yousef <qais.yousef@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Patrick Bellasi <patrick.bellasi@matbug.net>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Ben Segall <bsegall@google.com>
Link: https://lkml.kernel.org/r/20191105112212.596-1-qais.yousef@arm.com
---
 kernel/sched/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index dd05a37..afd4d80 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1073,6 +1073,7 @@ uclamp_update_active(struct task_struct *p, enum uclamp_id clamp_id)
 	task_rq_unlock(rq, p, &rf);
 }
 
+#ifdef CONFIG_UCLAMP_TASK_GROUP
 static inline void
 uclamp_update_active_tasks(struct cgroup_subsys_state *css,
 			   unsigned int clamps)
@@ -1091,7 +1092,6 @@ uclamp_update_active_tasks(struct cgroup_subsys_state *css,
 	css_task_iter_end(&it);
 }
 
-#ifdef CONFIG_UCLAMP_TASK_GROUP
 static void cpu_util_update_eff(struct cgroup_subsys_state *css);
 static void uclamp_update_root_tg(void)
 {
