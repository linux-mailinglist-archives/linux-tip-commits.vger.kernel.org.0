Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1465E3F8386
	for <lists+linux-tip-commits@lfdr.de>; Thu, 26 Aug 2021 10:10:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240451AbhHZIKn (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 26 Aug 2021 04:10:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240449AbhHZIKm (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 26 Aug 2021 04:10:42 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A375C0613CF;
        Thu, 26 Aug 2021 01:09:55 -0700 (PDT)
Date:   Thu, 26 Aug 2021 08:09:53 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1629965393;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Z/AdIC1AX6oJmyljr9eCryOdDbDVDh5fTt3gxmWOIvI=;
        b=gUiDSCTp5q7IumBmrDLM/fxLdahjE0SjH44G2OVsCLN0uX/Ep50r4tT3rc9PEg/p0NRF3Q
        6AyG9pr7IA8zpBWyw8ycdLkl0Wb+rdxaK703GYa91JcM+mb29gWr5+eH0WEO2R2yVJIB+s
        RyPsaUakcRaJk0RQXr8dJ7fbQiaOwETISGvBYmbtXacN7J+L+euZ36SlsfNkKdWNuNo7lE
        AwV84YOXitlOFJ47zHKRzltNZ7CLAa4TljpGQJ4xPOhN7Fy4CUGM2Far49/UiI/tqVzFoB
        b8BAr+sAB9Ec1JBnTNPNKps58yOGywfDKyx+Nhx+ALLRgXkOtQ+hD3LtuuAapg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1629965393;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Z/AdIC1AX6oJmyljr9eCryOdDbDVDh5fTt3gxmWOIvI=;
        b=BE4iWmor2NjMMDGzFXLh3JiwPE0GGnui9LUDeTgGRAKDaNZD6t6zB3K0tv4VCD8DElha2Z
        gIOz4pYBlMGugiDw==
From:   "tip-bot2 for Sebastian Andrzej Siewior" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/hw_breakpoint: Replace deprecated CPU-hotplug functions
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210803141621.780504-12-bigeasy@linutronix.de>
References: <20210803141621.780504-12-bigeasy@linutronix.de>
MIME-Version: 1.0
Message-ID: <162996539301.25758.16910475542342640583.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     ffec09f9c7d7b21b0aff29dd5c3972f4631c0b6b
Gitweb:        https://git.kernel.org/tip/ffec09f9c7d7b21b0aff29dd5c3972f4631c0b6b
Author:        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate:    Tue, 03 Aug 2021 16:15:54 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 26 Aug 2021 09:14:36 +02:00

perf/hw_breakpoint: Replace deprecated CPU-hotplug functions

The functions get_online_cpus() and put_online_cpus() have been
deprecated during the CPU hotplug rework. They map directly to
cpus_read_lock() and cpus_read_unlock().

Replace deprecated CPU-hotplug functions with the official version.
The behavior remains unchanged.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
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
