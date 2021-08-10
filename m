Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1582B3E5AA4
	for <lists+linux-tip-commits@lfdr.de>; Tue, 10 Aug 2021 15:04:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241088AbhHJNFA (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 10 Aug 2021 09:05:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241082AbhHJNFA (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 10 Aug 2021 09:05:00 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D96BC0613D3;
        Tue, 10 Aug 2021 06:04:38 -0700 (PDT)
Date:   Tue, 10 Aug 2021 13:04:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628600675;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ohNlUPaCg+7iU7Dok+8hrnQRHcDVe2ZHoNGzMH2LBTs=;
        b=pqi73+oiOBVS68C9uifqMXO9QXh4tYLPqLBgwCtb2ILMutKU5HgtVCEESE1DIbHdmDgGmK
        KIVlUID/l/IPWSjxPh1BBvuG6MymgaJ7rGdjVVMt7JhZnmZIkpVqRwW+h9ZJCj2vbFcUH3
        qH8OM518El09qAokWfOdPX4As62QEDBO67+9u8RldgNZXe7W1NqpEd7WOtQy9gtALv1qFQ
        QlBTyF9aFel/kfzsVXiUoaNAw075oIhFA6+1k/sGsABSCTlmYtzSA+ckCa9SQ7a/LTmaAu
        t2vUoXvmG3sr5bdm+lIgGpEHLUq5F2giHcGGzrHyctb5xU9NgYeZA5YL00eL+g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628600675;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ohNlUPaCg+7iU7Dok+8hrnQRHcDVe2ZHoNGzMH2LBTs=;
        b=Z8gGAvOb8BxjllxR+M9zaFMzDNd/tm8LJd5q2d92dle+jf6tuP9AnaIGSwuqZPZMtOQ9wv
        ESGJJKUOZxVn+NCg==
From:   "tip-bot2 for Sebastian Andrzej Siewior" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/hw_breakpoint: Replace deprecated CPU-hotplug
 functions.
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210803141621.780504-12-bigeasy@linutronix.de>
References: <20210803141621.780504-12-bigeasy@linutronix.de>
MIME-Version: 1.0
Message-ID: <162860067460.395.10174321015684125894.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     b28a32083bfa485f516c8b08c5d6050ff5aef3fb
Gitweb:        https://git.kernel.org/tip/b28a32083bfa485f516c8b08c5d6050ff5aef3fb
Author:        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate:    Tue, 03 Aug 2021 16:15:54 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 10 Aug 2021 15:00:26 +02:00

perf/hw_breakpoint: Replace deprecated CPU-hotplug functions.

The functions get_online_cpus() and put_online_cpus() have been
deprecated during the CPU hotplug rework. They map directly to
cpus_read_lock() and cpus_read_unlock().

Replace deprecated CPU-hotplug functions with the official version.
The behavior remains unchanged.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20210803141621.780504-12-bigeasy@linutronix.de

---
 kernel/events/hw_breakpoint.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/events/hw_breakpoint.c b/kernel/events/hw_breakpoint.c
index 8359734..f32320a 100644
--- a/kernel/events/hw_breakpoint.c
+++ b/kernel/events/hw_breakpoint.c
@@ -568,7 +568,7 @@ register_wide_hw_breakpoint(struct perf_event_attr *attr,
 	if (!cpu_events)
 		return (void __percpu __force *)ERR_PTR(-ENOMEM);
 
-	get_online_cpus();
+	cpus_read_lock();
 	for_each_online_cpu(cpu) {
 		bp = perf_event_create_kernel_counter(attr, cpu, NULL,
 						      triggered, context);
@@ -579,7 +579,7 @@ register_wide_hw_breakpoint(struct perf_event_attr *attr,
 
 		per_cpu(*cpu_events, cpu) = bp;
 	}
-	put_online_cpus();
+	cpus_read_unlock();
 
 	if (likely(!err))
 		return cpu_events;
