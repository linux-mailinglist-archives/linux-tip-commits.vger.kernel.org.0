Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F0203E5A6D
	for <lists+linux-tip-commits@lfdr.de>; Tue, 10 Aug 2021 14:52:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240916AbhHJMwb (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 10 Aug 2021 08:52:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240885AbhHJMw3 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 10 Aug 2021 08:52:29 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9389C061799;
        Tue, 10 Aug 2021 05:52:06 -0700 (PDT)
Date:   Tue, 10 Aug 2021 12:52:02 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628599923;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+eIpb0vOlbpVqVTU7rA2WjdajhZ9TvXLCW4nfI3UtNI=;
        b=eEtYZOWsS1WpyAthUXKhsC2+iqxs4kXyr/czM4qQVVNMB2k/+oVR9heooBTHMv8RgA5Iko
        f5bP9hVa94OZfNnvmtBFLBVg6YrUkVq6oVPn3ECRFMSzXwaqA5uanjk4IbB0ouHnGsasJx
        EPAqStYLA/F2WWvsl6WmQqtfOjwblNQufo0/ZduX7BsAFlLtayyl3FfvxKyJzVb4wKLRoI
        Eh82zaFoh2EfVfulv6O1HNf9789LqwF/iLQXiaq0sDxlEp5yXK6CQSpUPWI6JxHV/8Z416
        UCHCuaA6ZtcasrsezZg1nL/8SbWkmA4X9eCJMr7c68pmuH9oFayJ9r5IT+puWg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628599923;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+eIpb0vOlbpVqVTU7rA2WjdajhZ9TvXLCW4nfI3UtNI=;
        b=BLuBA7iU8+DERR/QqQ5kQaM90NRVtvPECgTgSuppEdNkrZ2IDYhiZVOQ9q1+dddBEJEhWM
        9Eu0mmpIWq9gpQAQ==
From:   "tip-bot2 for Sebastian Andrzej Siewior" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] x86/mmiotrace: Replace deprecated CPU-hotplug functions.
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Karol Herbst <kherbst@redhat.com>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210803141621.780504-7-bigeasy@linutronix.de>
References: <20210803141621.780504-7-bigeasy@linutronix.de>
MIME-Version: 1.0
Message-ID: <162859992216.395.2044972567536937336.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/cleanups branch of tip:

Commit-ID:     77ad320cfb2ac172eeba32a77a388281b003ec17
Gitweb:        https://git.kernel.org/tip/77ad320cfb2ac172eeba32a77a388281b003ec17
Author:        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate:    Tue, 03 Aug 2021 16:15:49 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 10 Aug 2021 14:46:27 +02:00

x86/mmiotrace: Replace deprecated CPU-hotplug functions.

The functions get_online_cpus() and put_online_cpus() have been
deprecated during the CPU hotplug rework. They map directly to
cpus_read_lock() and cpus_read_unlock().

Replace deprecated CPU-hotplug functions with the official version.
The behavior remains unchanged.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Karol Herbst <kherbst@redhat.com>
Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Link: https://lore.kernel.org/r/20210803141621.780504-7-bigeasy@linutronix.de

---
 arch/x86/mm/mmio-mod.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/mm/mmio-mod.c b/arch/x86/mm/mmio-mod.c
index cd768da..933a2eb 100644
--- a/arch/x86/mm/mmio-mod.c
+++ b/arch/x86/mm/mmio-mod.c
@@ -376,12 +376,12 @@ static void enter_uniprocessor(void)
 		goto out;
 	}
 
-	get_online_cpus();
+	cpus_read_lock();
 	cpumask_copy(downed_cpus, cpu_online_mask);
 	cpumask_clear_cpu(cpumask_first(cpu_online_mask), downed_cpus);
 	if (num_online_cpus() > 1)
 		pr_notice("Disabling non-boot CPUs...\n");
-	put_online_cpus();
+	cpus_read_unlock();
 
 	for_each_cpu(cpu, downed_cpus) {
 		err = remove_cpu(cpu);
