Return-Path: <linux-tip-commits+bounces-4105-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DDBF9A5966B
	for <lists+linux-tip-commits@lfdr.de>; Mon, 10 Mar 2025 14:33:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5D5C87A3266
	for <lists+linux-tip-commits@lfdr.de>; Mon, 10 Mar 2025 13:32:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76561374EA;
	Mon, 10 Mar 2025 13:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NFw6lo44";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="09sEgtRZ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E93222423F;
	Mon, 10 Mar 2025 13:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741613582; cv=none; b=NO/4NU8NcKQrBZs1rIFs4AuksGoCftlKhDjp54HZQRNV5Eksr4aFA8hOe8CH57ueurfD+haqZTaTMLncdmI1QrZdArX3GKFVIoYeL7zD7g6qcVtpoFivxfQOf0EsOC7+2epwAqaHJCOIlDljD7oPxkIrYbcjYP+d8gmxoXJRGTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741613582; c=relaxed/simple;
	bh=pPO6jYdwMoqL3V8oJELFQhsA3MHL1bJzSyUQlu1DkWU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=YXTwY/S26mvXcwbfN3ykiLM5mchE5ta1fsE+K5R8nIWhSaQTLOtvi2M7aaLS5BsS/mO0+dDnskadeB4gTdpyfIfDPR/Qoy4W3bzBQols+RQks5YGk9yuReseZC1qsfxwTUsKgjsknfM1MfttgQTSEG/U4GJ1yZJZyy7e2WU4pHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NFw6lo44; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=09sEgtRZ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 10 Mar 2025 13:32:53 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741613577;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fiTYNeL7CB349A2biujNXPhjhq5XSMbGAIrgqUm6BmQ=;
	b=NFw6lo44pl0VKiLznKbhX0PMxjBi1Pe18TbBditsnhCzNh55nDX1NTVs/p80WDvSl4ghFM
	E1YGsjZJixHfKiHrp2ndh8Zcq/h/vb+xdJZkhkxMrIM5WmCKqG7OWR9RVLnf3i6jovdokS
	J4QxMmbgc0oCV8+GXpSPQyjJwHrTeD+j7n3B7GiV2YJQjkf9rmayC5cAI30kkCPYdowbE0
	QsdrPkGwsiMxc3W8mj0PrDTN3LmQdE/4PatoMm8eS1A2zF6ONl5llvKby6MOAYXphysg9/
	zLzLG95CKGjHVS4i4iXDOupqe10JicC5tzGbjWVBBUl22ybWCerp3rmzMeimoA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741613577;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fiTYNeL7CB349A2biujNXPhjhq5XSMbGAIrgqUm6BmQ=;
	b=09sEgtRZxqEo744VyqFCB6O7f6GLwkdRsBCMnjnFsXW97/sOE93PyzKjQ1TYIDmgYk5ZI8
	XK1A78U9+ilKUmAA==
From: "tip-bot2 for Yafang Shao" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/urgent] sched/clock: Don't define sched_clock_irqtime as
 static key
Cc: Dan Carpenter <dan.carpenter@linaro.org>,
 Yafang Shao <laoar.shao@gmail.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Ingo Molnar <mingo@kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250205032438.14668-1-laoar.shao@gmail.com>
References: <20250205032438.14668-1-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174161357383.14745.8770394914047302959.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the sched/urgent branch of tip:

Commit-ID:     f3fa0e40df175acd60b71036b9a1fd62310aec03
Gitweb:        https://git.kernel.org/tip/f3fa0e40df175acd60b71036b9a1fd62310=
aec03
Author:        Yafang Shao <laoar.shao@gmail.com>
AuthorDate:    Wed, 05 Feb 2025 11:24:38 +08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 10 Mar 2025 14:22:58 +01:00

sched/clock: Don't define sched_clock_irqtime as static key

The sched_clock_irqtime was defined as a static key in:

  8722903cbb8f ("sched: Define sched_clock_irqtime as static key")

However, this change introduces a 'sleeping in atomic context' warning:

	arch/x86/kernel/tsc.c:1214 mark_tsc_unstable()
	warn: sleeping in atomic context

As analyzed by Dan, the affected code path is as follows:

vcpu_load() <- disables preempt
-> kvm_arch_vcpu_load()
   -> mark_tsc_unstable() <- sleeps

virt/kvm/kvm_main.c
   166  void vcpu_load(struct kvm_vcpu *vcpu)
   167  {
   168          int cpu =3D get_cpu();
                          ^^^^^^^^^^
This get_cpu() disables preemption.

   169
   170          __this_cpu_write(kvm_running_vcpu, vcpu);
   171          preempt_notifier_register(&vcpu->preempt_notifier);
   172          kvm_arch_vcpu_load(vcpu, cpu);
   173          put_cpu();
   174  }

arch/x86/kvm/x86.c
  4979          if (unlikely(vcpu->cpu !=3D cpu) || kvm_check_tsc_unstable())=
 {
  4980                  s64 tsc_delta =3D !vcpu->arch.last_host_tsc ? 0 :
  4981                                  rdtsc() - vcpu->arch.last_host_tsc;
  4982                  if (tsc_delta < 0)
  4983                          mark_tsc_unstable("KVM discovered backwards T=
SC");

arch/x86/kernel/tsc.c
    1206 void mark_tsc_unstable(char *reason)
    1207 {
    1208         if (tsc_unstable)
    1209                 return;
    1210
    1211         tsc_unstable =3D 1;
    1212         if (using_native_sched_clock())
    1213                 clear_sched_clock_stable();
--> 1214         disable_sched_clock_irqtime();
                 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
kernel/jump_label.c
   245  void static_key_disable(struct static_key *key)
   246  {
   247          cpus_read_lock();
                ^^^^^^^^^^^^^^^^
This lock has a might_sleep() in it which triggers the static checker
warning.

   248          static_key_disable_cpuslocked(key);
   249          cpus_read_unlock();
   250  }

Let revert this change for now as {disable,enable}_sched_clock_irqtime
are used in many places, as pointed out by Sean, including the following:

The code path in clocksource_watchdog():

  clocksource_watchdog()
  |
  -> spin_lock(&watchdog_lock);
     |
     -> __clocksource_unstable()
        |
        -> clocksource.mark_unstable() =3D=3D tsc_cs_mark_unstable()
           |
           -> disable_sched_clock_irqtime()

And the code path in sched_clock_register():

	/* Cannot register a sched_clock with interrupts on */
	local_irq_save(flags);

	...

	/* Enable IRQ time accounting if we have a fast enough sched_clock() */
	if (irqtime > 0 || (irqtime =3D=3D -1 && rate >=3D 1000000))
		enable_sched_clock_irqtime();

	local_irq_restore(flags);

[ lkp@intel.com: reported a build error in the prev version ]
[ mingo: cherry-picked it over into sched/urgent ]

Closes: https://lore.kernel.org/kvm/37a79ba3-9ce0-479c-a5b0-2bd75d573ed3@stan=
ley.mountain/
Fixes: 8722903cbb8f ("sched: Define sched_clock_irqtime as static key")
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Debugged-by: Dan Carpenter <dan.carpenter@linaro.org>
Debugged-by: Sean Christopherson <seanjc@google.com>
Debugged-by: Michal Koutn=C3=BD <mkoutny@suse.com>
Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
Link: https://lkml.kernel.org/r/20250205032438.14668-1-laoar.shao@gmail.com
---
 kernel/sched/cputime.c | 8 ++++----
 kernel/sched/sched.h   | 4 ++--
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/kernel/sched/cputime.c b/kernel/sched/cputime.c
index 5d9143d..6dab485 100644
--- a/kernel/sched/cputime.c
+++ b/kernel/sched/cputime.c
@@ -9,8 +9,6 @@
=20
 #ifdef CONFIG_IRQ_TIME_ACCOUNTING
=20
-DEFINE_STATIC_KEY_FALSE(sched_clock_irqtime);
-
 /*
  * There are no locks covering percpu hardirq/softirq time.
  * They are only modified in vtime_account, on corresponding CPU
@@ -24,14 +22,16 @@ DEFINE_STATIC_KEY_FALSE(sched_clock_irqtime);
  */
 DEFINE_PER_CPU(struct irqtime, cpu_irqtime);
=20
+int sched_clock_irqtime;
+
 void enable_sched_clock_irqtime(void)
 {
-	static_branch_enable(&sched_clock_irqtime);
+	sched_clock_irqtime =3D 1;
 }
=20
 void disable_sched_clock_irqtime(void)
 {
-	static_branch_disable(&sched_clock_irqtime);
+	sched_clock_irqtime =3D 0;
 }
=20
 static void irqtime_account_delta(struct irqtime *irqtime, u64 delta,
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index c8512a9..023b844 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -3259,11 +3259,11 @@ struct irqtime {
 };
=20
 DECLARE_PER_CPU(struct irqtime, cpu_irqtime);
-DECLARE_STATIC_KEY_FALSE(sched_clock_irqtime);
+extern int sched_clock_irqtime;
=20
 static inline int irqtime_enabled(void)
 {
-	return static_branch_likely(&sched_clock_irqtime);
+	return sched_clock_irqtime;
 }
=20
 /*

