Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0DCB328060
	for <lists+linux-tip-commits@lfdr.de>; Mon,  1 Mar 2021 15:11:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236231AbhCAOKZ (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 1 Mar 2021 09:10:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236078AbhCAOKN (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 1 Mar 2021 09:10:13 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B2BFC06178A;
        Mon,  1 Mar 2021 06:09:18 -0800 (PST)
Date:   Mon, 01 Mar 2021 14:09:16 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1614607756;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9qjVtSChjcR1iq5YEcOk8NWkETJKUE9kkUYwehJrtkk=;
        b=liuQaV/wqRB1G9n+wAWNZfrrBiaZLbDblYljsGOoWausE+B3UA5cqt1uCBVgzbPl67aRX6
        uPSmsH/DSrU+2dg2rF2lHVtkNH8H1QR8GgzheurtiMsUdKQeCtQtdK1MLMUzukDM4ZJXoU
        OSO7vhv+KxeeDjnoV16YagfUZgAcC5R0jymSJ/SIFxDXIi0dD3TCCB/qyGF+n01DDWR8XM
        5rIr2meoadI8CHDePbfNjd5EgHuShV01GLS77lOis53OHhEepcyNmAqZLzEDI6OtxYx1A3
        B+mfdCAWKKmWVjTeRbogLrWXEtfcezxkuoh7aMLxJTzVZj3OBJ7r7BVmYLDCbA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1614607756;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9qjVtSChjcR1iq5YEcOk8NWkETJKUE9kkUYwehJrtkk=;
        b=0LdWni6oStzvqeJwcmOIDLWGqQ5uus48XcYL4EBa1AXx10H5ZGUOpMvioLJnFTTv8eQ7qS
        xpZm86syKIIvSwCQ==
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
Message-ID: <161460775627.20312.7773924056141701835.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     b3e3bc34b1e938c6447fa8b646010c4016be7fad
Gitweb:        https://git.kernel.org/tip/b3e3bc34b1e938c6447fa8b646010c4016be7fad
Author:        Juergen Gross <jgross@suse.com>
AuthorDate:    Mon, 01 Mar 2021 11:13:35 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 01 Mar 2021 14:27:58 +01:00

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
