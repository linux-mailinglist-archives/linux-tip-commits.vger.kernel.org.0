Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35CC132FA4C
	for <lists+linux-tip-commits@lfdr.de>; Sat,  6 Mar 2021 12:55:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230429AbhCFLzS (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sat, 6 Mar 2021 06:55:18 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:34748 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230311AbhCFLyh (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sat, 6 Mar 2021 06:54:37 -0500
Date:   Sat, 06 Mar 2021 11:54:35 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1615031676;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NMv5rnBdR/DnhOqUMxgcS8gutRvsoz5d8ENmQUPZ0I8=;
        b=ZOb/sujcoGBMq3I3OBTGqOoWO5r3UpBFEvgCJDsuBSpE8ceLI6QkyksAnG9Lb6Exqd9HJZ
        nnDu70zkrDBPtop35Opy3iS8iVLRpFIsWAuuC116q+1upC5FskMyZgRLFngR9th7nr3Fle
        g6mVgGVAYDMRxBc841OjdJn9/c+J/NhDtuPdTmlEkNNlUJpkffLq8eHhTzW863x8lvs84q
        60fmLjdO6xipFwOKTOaufsNmNtjWjOf1s5vhGbl86EmWB+qsWoKiQg3tQR/6vKAFTv8rzO
        oJUH415zX5wJ8JjVnyTT+57YeEcORgoK7NfxDnH0LZDsaEa40xlYCQLaRo/Pbw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1615031676;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NMv5rnBdR/DnhOqUMxgcS8gutRvsoz5d8ENmQUPZ0I8=;
        b=5lXqNOZY+85FTsDdVvaKljx5mavkD5tQqzdID0B4VszoCNOQLQ5Q1GfQMriNsIjhRCl7uk
        +BEcyNt3VX/BYuAw==
From:   "tip-bot2 for Juergen Gross" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/csd_lock: Prepare more CSD lock debugging
Cc:     Juergen Gross <jgross@suse.com>, Ingo Molnar <mingo@kernel.org>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20210301101336.7797-3-jgross@suse.com>
References: <20210301101336.7797-3-jgross@suse.com>
MIME-Version: 1.0
Message-ID: <161503167554.398.5010872943457820511.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     de7b09ef658d637eed0584eaba30884e409aef31
Gitweb:        https://git.kernel.org/tip/de7b09ef658d637eed0584eaba30884e409aef31
Author:        Juergen Gross <jgross@suse.com>
AuthorDate:    Mon, 01 Mar 2021 11:13:35 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sat, 06 Mar 2021 12:49:48 +01:00

locking/csd_lock: Prepare more CSD lock debugging

In order to be able to easily add more CSD lock debugging data to
struct call_function_data->csd move the call_single_data_t element
into a sub-structure.

Signed-off-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20210301101336.7797-3-jgross@suse.com
---
 kernel/smp.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/kernel/smp.c b/kernel/smp.c
index d5f0b21..6d7e6db 100644
--- a/kernel/smp.c
+++ b/kernel/smp.c
@@ -31,8 +31,12 @@
 
 #define CSD_TYPE(_csd)	((_csd)->node.u_flags & CSD_FLAG_TYPE_MASK)
 
+struct cfd_percpu {
+	call_single_data_t	csd;
+};
+
 struct call_function_data {
-	call_single_data_t	__percpu *csd;
+	struct cfd_percpu	__percpu *pcpu;
 	cpumask_var_t		cpumask;
 	cpumask_var_t		cpumask_ipi;
 };
@@ -55,8 +59,8 @@ int smpcfd_prepare_cpu(unsigned int cpu)
 		free_cpumask_var(cfd->cpumask);
 		return -ENOMEM;
 	}
-	cfd->csd = alloc_percpu(call_single_data_t);
-	if (!cfd->csd) {
+	cfd->pcpu = alloc_percpu(struct cfd_percpu);
+	if (!cfd->pcpu) {
 		free_cpumask_var(cfd->cpumask);
 		free_cpumask_var(cfd->cpumask_ipi);
 		return -ENOMEM;
@@ -71,7 +75,7 @@ int smpcfd_dead_cpu(unsigned int cpu)
 
 	free_cpumask_var(cfd->cpumask);
 	free_cpumask_var(cfd->cpumask_ipi);
-	free_percpu(cfd->csd);
+	free_percpu(cfd->pcpu);
 	return 0;
 }
 
@@ -694,7 +698,7 @@ static void smp_call_function_many_cond(const struct cpumask *mask,
 
 	cpumask_clear(cfd->cpumask_ipi);
 	for_each_cpu(cpu, cfd->cpumask) {
-		call_single_data_t *csd = per_cpu_ptr(cfd->csd, cpu);
+		call_single_data_t *csd = &per_cpu_ptr(cfd->pcpu, cpu)->csd;
 
 		if (cond_func && !cond_func(cpu, info))
 			continue;
@@ -719,7 +723,7 @@ static void smp_call_function_many_cond(const struct cpumask *mask,
 		for_each_cpu(cpu, cfd->cpumask) {
 			call_single_data_t *csd;
 
-			csd = per_cpu_ptr(cfd->csd, cpu);
+			csd = &per_cpu_ptr(cfd->pcpu, cpu)->csd;
 			csd_lock_wait(csd);
 		}
 	}
