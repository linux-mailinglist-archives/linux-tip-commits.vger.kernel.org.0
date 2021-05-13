Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF5E437F888
	for <lists+linux-tip-commits@lfdr.de>; Thu, 13 May 2021 15:18:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233914AbhEMNTp (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 13 May 2021 09:19:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233949AbhEMNTF (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 13 May 2021 09:19:05 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05EE5C061761;
        Thu, 13 May 2021 06:17:37 -0700 (PDT)
Date:   Thu, 13 May 2021 13:17:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1620911850;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=th7WBRzSVnO3u6U4v2APFdBJksytfWHgV3mR2AbbeeU=;
        b=k+wP4sqfv3EtVMGo6ept8EU7tNNrKaZV9mozVYk5a02I6qpwSDcYuXDwwe1kRV8L/5NfTh
        m7ijBluHe1EV8Exksp+G+EkDYzgk54UNImyuKXckH+0Ua6iXGduFtynmYD90tHj+kRU5dU
        +beVIDNm1Zuqc1tF1F6W0FzM4PoLUYDe9InDeAk6wRgy81b2YWPRgfzwqQsBH9FyzA3mh5
        ovZSxYdJp1USSE86zodRJ7IaumyGcN3rECArCEd+OJSquafasW9GocqSOAGnVvI3d+jQrX
        kADvkwZYXIKjmm5H5NBT/2GE2TvkmbEoTnoTf0vHxP8nkH53BJU5tPBemDVCXw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1620911850;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=th7WBRzSVnO3u6U4v2APFdBJksytfWHgV3mR2AbbeeU=;
        b=plsAajJl5AftsnTTTL+/3kIE917bhPZtde0C/JxpNVkzZ42Ud96SRpPRzKvWwtajOBVXon
        Nhy0E/RuY9C8hsBw==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/nohz] tick/nohz: Evaluate the CPU expression after the
 static key
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210512232924.150322-2-frederic@kernel.org>
References: <20210512232924.150322-2-frederic@kernel.org>
MIME-Version: 1.0
Message-ID: <162091184985.29796.1926500160516806098.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the timers/nohz branch of tip:

Commit-ID:     f105dfec0a951cd0d5bfbfe9dc067ea69f71ad5c
Gitweb:        https://git.kernel.org/tip/f105dfec0a951cd0d5bfbfe9dc067ea69f71ad5c
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Thu, 13 May 2021 01:29:15 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 13 May 2021 14:21:20 +02:00

tick/nohz: Evaluate the CPU expression after the static key

When tick_nohz_full_cpu() is called with smp_processor_id(), the latter
is unconditionally evaluated whether the static key is on or off. It is
not necessary in the off-case though, so make sure the cpu expression
is executed at the last moment.

Illustrate with the following test function:

	int tick_nohz_test(void)
	{
		return tick_nohz_full_cpu(smp_processor_id());
	}

The resulting code before was:

	mov    %gs:0x7eea92d1(%rip),%eax   # smp_processor_id() fetch
	nopl   0x0(%rax,%rax,1)
	xor    %eax,%eax
	retq
	cmpb   $0x0,0x29d393a(%rip)        # <tick_nohz_full_running>
	je     tick_nohz_test+0x29         # jump to below eax clear
	mov    %eax,%eax
	bt     %rax,0x29d3936(%rip)        # <tick_nohz_full_mask>
	setb   %al
	movzbl %al,%eax
	retq
	xor    %eax,%eax
	retq

Now it becomes:

	nopl   0x0(%rax,%rax,1)
	xor    %eax,%eax
	retq
	cmpb   $0x0,0x29d3871(%rip)        # <tick_nohz_full_running>
	je     tick_nohz_test+0x29         # jump to below eax clear
	mov    %gs:0x7eea91f0(%rip),%eax   # smp_processor_id() fetch, after static key
	mov    %eax,%eax
	bt     %rax,0x29d3866(%rip)        # <tick_nohz_full_mask>
	setb   %al
	movzbl %al,%eax
	retq
	xor    %eax,%eax
	retq

Signed-off-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20210512232924.150322-2-frederic@kernel.org
---
 include/linux/tick.h | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/include/linux/tick.h b/include/linux/tick.h
index 7340613..2258984 100644
--- a/include/linux/tick.h
+++ b/include/linux/tick.h
@@ -185,13 +185,17 @@ static inline bool tick_nohz_full_enabled(void)
 	return tick_nohz_full_running;
 }
 
-static inline bool tick_nohz_full_cpu(int cpu)
-{
-	if (!tick_nohz_full_enabled())
-		return false;
-
-	return cpumask_test_cpu(cpu, tick_nohz_full_mask);
-}
+/*
+ * Check if a CPU is part of the nohz_full subset. Arrange for evaluating
+ * the cpu expression (typically smp_processor_id()) _after_ the static
+ * key.
+ */
+#define tick_nohz_full_cpu(_cpu) ({					\
+	bool __ret = false;						\
+	if (tick_nohz_full_enabled())					\
+		__ret = cpumask_test_cpu((_cpu), tick_nohz_full_mask);	\
+	__ret;								\
+})
 
 static inline void tick_nohz_full_add_cpus_to(struct cpumask *mask)
 {
