Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D0DF2AEB1D
	for <lists+linux-tip-commits@lfdr.de>; Wed, 11 Nov 2020 09:24:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726526AbgKKIYH (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 11 Nov 2020 03:24:07 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:36242 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726318AbgKKIXY (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 11 Nov 2020 03:23:24 -0500
Date:   Wed, 11 Nov 2020 08:23:22 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605083003;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wFhnxBQxV2YYlDmoo+KkM2aehgRnBwF0654L/61Bpmc=;
        b=WzpcM8uuMu1Zh3G0E3fy+mQGVfql6/bg+LwP97zwaCt1XqP0eoOLZcrr5MI6Pp8OFun5Fd
        4zqATz+USgSWndfsvTQcb+sCptjndOCgaTzF3Be3SFItP3/JplWRMzroD9jVYpPFfCwRnk
        5x0oRlrjBeTs5rmklcrFopB9tSnutLfZCQkGrZKls4vbKqrUFmA9FRxsX29+t5KEqXWZJl
        6KUkI0V/hPTpl8/YZVoAZenL4CXffOPaplLOroCuctpeAnMqhmhRiJyUhFnjsRxU4uDWAz
        hZ0410MlvaHMVFxb4oPhThs9HXfKTSC0P86qD6MX/2cOv172Qquhw/7W1g5C8A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605083003;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wFhnxBQxV2YYlDmoo+KkM2aehgRnBwF0654L/61Bpmc=;
        b=Kr9odGZ5wpoMijMXrYk1G1aEOLSLNRNUAfPofkAo45vdPkfT6vnwTtvie9hOFeySEOYcAX
        MXuA0ntcxINwjdDQ==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] workqueue: Manually break affinity on hotplug
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Tejun Heo <tj@kernel.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20201023102346.464718669@infradead.org>
References: <20201023102346.464718669@infradead.org>
MIME-Version: 1.0
Message-ID: <160508300227.11244.8988819805269225901.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     06249738a41a70f2201a148866899f84cbebc45e
Gitweb:        https://git.kernel.org/tip/06249738a41a70f2201a148866899f84cbebc45e
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Fri, 25 Sep 2020 15:45:11 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 10 Nov 2020 18:38:58 +01:00

workqueue: Manually break affinity on hotplug

Don't rely on the scheduler to force break affinity for us -- it will
stop doing that for per-cpu-kthreads.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>
Acked-by: Tejun Heo <tj@kernel.org>
Reviewed-by: Daniel Bristot de Oliveira <bristot@redhat.com>
Link: https://lkml.kernel.org/r/20201023102346.464718669@infradead.org
---
 kernel/workqueue.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 437935e..c71da2a 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -4908,6 +4908,10 @@ static void unbind_workers(int cpu)
 		pool->flags |= POOL_DISASSOCIATED;
 
 		raw_spin_unlock_irq(&pool->lock);
+
+		for_each_pool_worker(worker, pool)
+			WARN_ON_ONCE(set_cpus_allowed_ptr(worker->task, cpu_active_mask) < 0);
+
 		mutex_unlock(&wq_pool_attach_mutex);
 
 		/*
