Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4811359D3F
	for <lists+linux-tip-commits@lfdr.de>; Fri,  9 Apr 2021 13:24:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233826AbhDILY4 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 9 Apr 2021 07:24:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233564AbhDILYy (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 9 Apr 2021 07:24:54 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18B21C061762;
        Fri,  9 Apr 2021 04:24:42 -0700 (PDT)
Date:   Fri, 09 Apr 2021 11:24:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1617967480;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YrXftU0Qt4zqxSmsgB0ODqvqiRGxTA294PIhqyDqA4A=;
        b=DIy6x+DNFNlph4OF3ITdO9zL0QpJqxr39Ughu3bQUiX1V4ekOTIZBhqHxchf4xA55XCHR0
        FpDyqTowRhEajAY4b+QCSt7b+RMtNNLtxNye+Uow3jRLipsr90df4I0win+/+Y6l8syguV
        iGn8hiI/+JkZDS2213Hcbbldah32a9i8Jw0Retvnu71+oBBI0mPgl0CVNx5xPDAzEEciyu
        FaRHFOHPIZVGlwSKkEXLimm8U3shfVZvWQVVCeAG3//RmBCRXE5Ur5fc5YwI9Q17Bd2BBP
        YqwxfZGhYR3t9qWp+BdC4WH06IEM+MnCp6+Ec9j7AYT/FYgbkwd85lp7RY5+UQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1617967480;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YrXftU0Qt4zqxSmsgB0ODqvqiRGxTA294PIhqyDqA4A=;
        b=5hZdlenH8CBxX3Wwuqv8wNXL4J3AOIM5Q9vnrF/mnqD7duU4vIfbt19y9x51tmzV0uhlXn
        txdL5BH/c7P4cTDw==
From:   "tip-bot2 for Josh Hunt" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] psi: allow unprivileged users with CAP_SYS_RESOURCE
 to write psi files
Cc:     Josh Hunt <johunt@akamai.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210402025833.27599-1-johunt@akamai.com>
References: <20210402025833.27599-1-johunt@akamai.com>
MIME-Version: 1.0
Message-ID: <161796748008.29796.10035394186165880913.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     6db12ee0456d0e369c7b59788d46e15a56ad0294
Gitweb:        https://git.kernel.org/tip/6db12ee0456d0e369c7b59788d46e15a56ad0294
Author:        Josh Hunt <johunt@akamai.com>
AuthorDate:    Thu, 01 Apr 2021 22:58:33 -04:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 08 Apr 2021 23:09:44 +02:00

psi: allow unprivileged users with CAP_SYS_RESOURCE to write psi files

Currently only root can write files under /proc/pressure. Relax this to
allow tasks running as unprivileged users with CAP_SYS_RESOURCE to be
able to write to these files.

Signed-off-by: Josh Hunt <johunt@akamai.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
Link: https://lkml.kernel.org/r/20210402025833.27599-1-johunt@akamai.com
---
 kernel/sched/psi.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
index b1b00e9..d1212f1 100644
--- a/kernel/sched/psi.c
+++ b/kernel/sched/psi.c
@@ -1061,19 +1061,27 @@ static int psi_cpu_show(struct seq_file *m, void *v)
 	return psi_show(m, &psi_system, PSI_CPU);
 }
 
+static int psi_open(struct file *file, int (*psi_show)(struct seq_file *, void *))
+{
+	if (file->f_mode & FMODE_WRITE && !capable(CAP_SYS_RESOURCE))
+		return -EPERM;
+
+	return single_open(file, psi_show, NULL);
+}
+
 static int psi_io_open(struct inode *inode, struct file *file)
 {
-	return single_open(file, psi_io_show, NULL);
+	return psi_open(file, psi_io_show);
 }
 
 static int psi_memory_open(struct inode *inode, struct file *file)
 {
-	return single_open(file, psi_memory_show, NULL);
+	return psi_open(file, psi_memory_show);
 }
 
 static int psi_cpu_open(struct inode *inode, struct file *file)
 {
-	return single_open(file, psi_cpu_show, NULL);
+	return psi_open(file, psi_cpu_show);
 }
 
 struct psi_trigger *psi_trigger_create(struct psi_group *group,
@@ -1353,9 +1361,9 @@ static int __init psi_proc_init(void)
 {
 	if (psi_enable) {
 		proc_mkdir("pressure", NULL);
-		proc_create("pressure/io", 0, NULL, &psi_io_proc_ops);
-		proc_create("pressure/memory", 0, NULL, &psi_memory_proc_ops);
-		proc_create("pressure/cpu", 0, NULL, &psi_cpu_proc_ops);
+		proc_create("pressure/io", 0666, NULL, &psi_io_proc_ops);
+		proc_create("pressure/memory", 0666, NULL, &psi_memory_proc_ops);
+		proc_create("pressure/cpu", 0666, NULL, &psi_cpu_proc_ops);
 	}
 	return 0;
 }
