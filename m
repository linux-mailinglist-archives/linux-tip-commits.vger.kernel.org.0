Return-Path: <linux-tip-commits+bounces-3432-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42F0EA397A6
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Feb 2025 10:53:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 16CE57A18E3
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Feb 2025 09:50:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DCA7246351;
	Tue, 18 Feb 2025 09:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Pv3DEA7T";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zGrFOXAx"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3744224293E;
	Tue, 18 Feb 2025 09:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739872008; cv=none; b=uOPlR8kFr6Wbr/U4y16Huwfz7qiQqwT58b1vMQ1PgQElmCvZRYnnFDDoOBHuhBFzYoGZGwsA8Ny1HwA7knXFxj7zy1AneATzGQbUB/NuOD6KScL7CKiWT33a6O0Yozhq8zvPLJ5NZyvjZPTlnsK3cHxdpxqwb/t1qp8tw920iSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739872008; c=relaxed/simple;
	bh=yjhsvxZQF32whkO95HuGmOcYLoPM6f5E7L3iAMCRK+8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Xbds90HUf8yKM7Ojva0xcQE5pOJL6JYlzCM6hg3A+g21ciwryPmu8WssB6CUeJumAR9b7byvw77Mx3KsiJtnQkW07fY3YvGTKZ5MzTVMoCHL4fkqXS3mJsQ7loMLGxDopWt6MZseuxsxqyQiCMEQy7zH4DBKhWuvRBMPnLSL564=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Pv3DEA7T; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zGrFOXAx; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 18 Feb 2025 09:46:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1739872004;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JpGLSbqkzi3avefJx20EAdFvqnshby1DUslyQTBjJAc=;
	b=Pv3DEA7TSNVw6JDCPFh1huf/eWwjHquSyer9JHQ49q8edNYTAs2YNtIytP/t6XhgGuN58S
	bd3aZiYSBRfWsa7SkbgihUKoJ5S0O/BrYuIwZljE9Wr80JlurjMCvPc8s9bUvf16Mgd53N
	HFfjzZiTYd1mmRofiJo5IRFOI4IT3nOo6+J56f3ySKSrXtceA0wlrMpWiNOteGz4z6Xcf1
	JlUr+9KL1mZC03ShRRgOMAzgLFQ2fDVpYWpJDoXN93+g+j51h/ig4H9L235/7rfiUUc9c4
	9oO4gZ2D4fX8W7sX5QOcJ9VFCcylNfSeUUeN5zwS4qypasGIVWEt6EXPCM5tUg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1739872004;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JpGLSbqkzi3avefJx20EAdFvqnshby1DUslyQTBjJAc=;
	b=zGrFOXAxSSzjb1dpMx/1oBmQVbk77iLVS0Ul/Vt3Ux0znouh5SgZw/xrmhJjeFQ/+KTRct
	CQdlAtSCPGoz8kCw==
From: "tip-bot2 for Nam Cao" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/cleanups] KVM: x86: Switch to use hrtimer_setup()
Cc: Nam Cao <namcao@linutronix.de>, Thomas Gleixner <tglx@linutronix.de>,
 Sean Christopherson <seanjc@google.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3C5051cfe7ed48ef9913bf2583eeca6795cb53d6ae=2E17387?=
 =?utf-8?q?46821=2Egit=2Enamcao=40linutronix=2Ede=3E?=
References: =?utf-8?q?=3C5051cfe7ed48ef9913bf2583eeca6795cb53d6ae=2E173874?=
 =?utf-8?q?6821=2Egit=2Enamcao=40linutronix=2Ede=3E?=
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173987200407.10177.277675039782103723.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/cleanups branch of tip:

Commit-ID:     7764b9dd174c3e529e4445f0100e49a0d981a39b
Gitweb:        https://git.kernel.org/tip/7764b9dd174c3e529e4445f0100e49a0d981a39b
Author:        Nam Cao <namcao@linutronix.de>
AuthorDate:    Wed, 05 Feb 2025 11:38:48 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 18 Feb 2025 10:32:31 +01:00

KVM: x86: Switch to use hrtimer_setup()

hrtimer_setup() takes the callback function pointer as argument and
initializes the timer completely.

Replace hrtimer_init() and the open coded initialization of
hrtimer::function with the new setup mechanism.

Patch was created by using Coccinelle.

Signed-off-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Sean Christopherson <seanjc@google.com>
Link: https://lore.kernel.org/all/5051cfe7ed48ef9913bf2583eeca6795cb53d6ae.1738746821.git.namcao@linutronix.de

---
 arch/x86/kvm/hyperv.c     | 3 +--
 arch/x86/kvm/i8254.c      | 3 +--
 arch/x86/kvm/lapic.c      | 5 ++---
 arch/x86/kvm/vmx/nested.c | 5 ++---
 arch/x86/kvm/xen.c        | 4 ++--
 5 files changed, 8 insertions(+), 12 deletions(-)

diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
index 6ebeb6c..24f0318 100644
--- a/arch/x86/kvm/hyperv.c
+++ b/arch/x86/kvm/hyperv.c
@@ -952,8 +952,7 @@ static void stimer_init(struct kvm_vcpu_hv_stimer *stimer, int timer_index)
 {
 	memset(stimer, 0, sizeof(*stimer));
 	stimer->index = timer_index;
-	hrtimer_init(&stimer->timer, CLOCK_MONOTONIC, HRTIMER_MODE_ABS);
-	stimer->timer.function = stimer_timer_callback;
+	hrtimer_setup(&stimer->timer, stimer_timer_callback, CLOCK_MONOTONIC, HRTIMER_MODE_ABS);
 	stimer_prepare_msg(stimer);
 }
 
diff --git a/arch/x86/kvm/i8254.c b/arch/x86/kvm/i8254.c
index d7ab878..739aa6c 100644
--- a/arch/x86/kvm/i8254.c
+++ b/arch/x86/kvm/i8254.c
@@ -690,8 +690,7 @@ struct kvm_pit *kvm_create_pit(struct kvm *kvm, u32 flags)
 	pit->kvm = kvm;
 
 	pit_state = &pit->pit_state;
-	hrtimer_init(&pit_state->timer, CLOCK_MONOTONIC, HRTIMER_MODE_ABS);
-	pit_state->timer.function = pit_timer_fn;
+	hrtimer_setup(&pit_state->timer, pit_timer_fn, CLOCK_MONOTONIC, HRTIMER_MODE_ABS);
 
 	pit_state->irq_ack_notifier.gsi = 0;
 	pit_state->irq_ack_notifier.irq_acked = kvm_pit_ack_irq;
diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
index a009c94..eb56cd9 100644
--- a/arch/x86/kvm/lapic.c
+++ b/arch/x86/kvm/lapic.c
@@ -2921,9 +2921,8 @@ int kvm_create_lapic(struct kvm_vcpu *vcpu)
 
 	apic->nr_lvt_entries = kvm_apic_calc_nr_lvt_entries(vcpu);
 
-	hrtimer_init(&apic->lapic_timer.timer, CLOCK_MONOTONIC,
-		     HRTIMER_MODE_ABS_HARD);
-	apic->lapic_timer.timer.function = apic_timer_fn;
+	hrtimer_setup(&apic->lapic_timer.timer, apic_timer_fn, CLOCK_MONOTONIC,
+		      HRTIMER_MODE_ABS_HARD);
 	if (lapic_timer_advance)
 		apic->lapic_timer.timer_advance_ns = LAPIC_TIMER_ADVANCE_NS_INIT;
 
diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index 8a7af02..ca18c3e 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -5316,9 +5316,8 @@ static int enter_vmx_operation(struct kvm_vcpu *vcpu)
 	if (enable_shadow_vmcs && !alloc_shadow_vmcs(vcpu))
 		goto out_shadow_vmcs;
 
-	hrtimer_init(&vmx->nested.preemption_timer, CLOCK_MONOTONIC,
-		     HRTIMER_MODE_ABS_PINNED);
-	vmx->nested.preemption_timer.function = vmx_preemption_timer_fn;
+	hrtimer_setup(&vmx->nested.preemption_timer, vmx_preemption_timer_fn, CLOCK_MONOTONIC,
+		      HRTIMER_MODE_ABS_PINNED);
 
 	vmx->nested.vpid02 = allocate_vpid();
 
diff --git a/arch/x86/kvm/xen.c b/arch/x86/kvm/xen.c
index a909b81..1ac738d 100644
--- a/arch/x86/kvm/xen.c
+++ b/arch/x86/kvm/xen.c
@@ -2225,8 +2225,8 @@ void kvm_xen_init_vcpu(struct kvm_vcpu *vcpu)
 	vcpu->arch.xen.poll_evtchn = 0;
 
 	timer_setup(&vcpu->arch.xen.poll_timer, cancel_evtchn_poll, 0);
-	hrtimer_init(&vcpu->arch.xen.timer, CLOCK_MONOTONIC, HRTIMER_MODE_ABS_HARD);
-	vcpu->arch.xen.timer.function = xen_timer_callback;
+	hrtimer_setup(&vcpu->arch.xen.timer, xen_timer_callback, CLOCK_MONOTONIC,
+		      HRTIMER_MODE_ABS_HARD);
 
 	kvm_gpc_init(&vcpu->arch.xen.runstate_cache, vcpu->kvm);
 	kvm_gpc_init(&vcpu->arch.xen.runstate2_cache, vcpu->kvm);

