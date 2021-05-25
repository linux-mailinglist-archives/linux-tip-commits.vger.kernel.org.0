Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 473AA390574
	for <lists+linux-tip-commits@lfdr.de>; Tue, 25 May 2021 17:30:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231164AbhEYPbh (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 25 May 2021 11:31:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230433AbhEYPbg (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 25 May 2021 11:31:36 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6723C061574;
        Tue, 25 May 2021 08:30:06 -0700 (PDT)
Date:   Tue, 25 May 2021 15:30:04 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1621956605;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Jk28wF7bJNAUbXuhXTnF8/DFyhoWPv9sjLmtfmyg60M=;
        b=YcMcYEZPcF3DZBp8Il6CLJp7eM7PUm2zTBtRKuX9hKWn7eCQM+ZqFx/KtW7HxNCF3LjeNV
        rFVWkE5HACNWOl6tb2OXWkS7e/Gxdzv7piX/5VrOMDZVxSVPu7BedMusKczJf2w4diGkYM
        thP9k92trl089k1FgV+oVkdhW98lyYcy+AUrZ4Bu3FsEWu+yToXVKeFC0uky44eRAmefcZ
        P4tJT5Eijd+hixdtPmFSkX++O1pGzovxtv4LD7CY1qXWMApMfSdBlIjlRvgdhd8f9GUWIc
        zNyulQTwAZcv4jgsRKJ7GEaz6vFVxbAhBB2PKFdZASpnMPKhIj0RPzr7ZW6Bdw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1621956605;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Jk28wF7bJNAUbXuhXTnF8/DFyhoWPv9sjLmtfmyg60M=;
        b=E0Tk9XqWEw6xY2OnhRL5qFP7EercuT/PQn8XqbVuAKo7FFfkKLdOqi1IpDpt8yIV/zh7Fa
        08GYv9a9S7cU70DQ==
From:   "tip-bot2 for Yuan ZhaoXiong" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: smp/core] cpu/hotplug: Simplify access to percpu cpuhp_state
Cc:     Yuan ZhaoXiong <yuanzhaoxiong@baidu.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Valentin Schneider <valentin.schneider@arm.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <1621776690-13264-1-git-send-email-yuanzhaoxiong@baidu.com>
References: <1621776690-13264-1-git-send-email-yuanzhaoxiong@baidu.com>
MIME-Version: 1.0
Message-ID: <162195660432.29796.7925067914385420402.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the smp/core branch of tip:

Commit-ID:     130708331bc6b03a3c3a78599333faddfebbd0f3
Gitweb:        https://git.kernel.org/tip/130708331bc6b03a3c3a78599333faddfebbd0f3
Author:        Yuan ZhaoXiong <yuanzhaoxiong@baidu.com>
AuthorDate:    Sun, 23 May 2021 21:31:30 +08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 25 May 2021 17:24:52 +02:00

cpu/hotplug: Simplify access to percpu cpuhp_state

It is unnecessary to invoke per_cpu_ptr() everytime to access cpuhp_state.
Use the available pointer instead.

Signed-off-by: Yuan ZhaoXiong <yuanzhaoxiong@baidu.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>
Link: https://lore.kernel.org/r/1621776690-13264-1-git-send-email-yuanzhaoxiong@baidu.com

---
 kernel/cpu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/cpu.c b/kernel/cpu.c
index e538518..2942cb4 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -961,7 +961,7 @@ static int takedown_cpu(unsigned int cpu)
 	int err;
 
 	/* Park the smpboot threads */
-	kthread_park(per_cpu_ptr(&cpuhp_state, cpu)->thread);
+	kthread_park(st->thread);
 
 	/*
 	 * Prevent irq alloc/free while the dying cpu reorganizes the
@@ -977,7 +977,7 @@ static int takedown_cpu(unsigned int cpu)
 		/* CPU refused to die */
 		irq_unlock_sparse();
 		/* Unpark the hotplug thread so we can rollback there */
-		kthread_unpark(per_cpu_ptr(&cpuhp_state, cpu)->thread);
+		kthread_unpark(st->thread);
 		return err;
 	}
 	BUG_ON(cpu_online(cpu));
