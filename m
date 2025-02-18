Return-Path: <linux-tip-commits+bounces-3431-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 684B3A3979F
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Feb 2025 10:53:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AE8F27A4516
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Feb 2025 09:50:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46276246323;
	Tue, 18 Feb 2025 09:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="exbkx+cb";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="7gQtZXL7"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65FD3243960;
	Tue, 18 Feb 2025 09:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739872007; cv=none; b=u25ACEqAP92emfOLl2CD0Sind2YHgu+5cICyn/ZbNhQQKen43QHUrUdDRdMbA087I7GGR069OCaPyRz3wjX0qPi5QLoAn25qqXQmzTQjU3VXUUFF16o+6isA3MVWrOv9zQxTUnRlO1EqSO/NV3LyjW5kgm8SK3gKUnfW8Stb4cA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739872007; c=relaxed/simple;
	bh=R4WdYp4KUJhuvR0pqtvVNo0WSPqGT8Aqag8wB6Jt8VU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=VefmaF+gmCw2sUdDklaIzMPHnvsNhehy3ImwU3H8QSkl2Q0DZFaTYgxBqwGPjgnaNTMiFgb+frQUhXLRLPmeODH7PGn3sCPJIHA8F/gGEwLKHITo+fGfmucmq+rOCSzj/cMbTquGBzx6NS27f9eJ73CVQ4NYGopINKIJ8d29Ass=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=exbkx+cb; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=7gQtZXL7; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 18 Feb 2025 09:46:43 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1739872003;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/zP2PWLJ/aoF4Uu4jx9TMRvpVV/5Qd93OglewsGp5c0=;
	b=exbkx+cbq9M2LHjqQ9zdwni0b33trXcpnujDherr4tV53xaPasxUaLQmPT71CGKD3Le2HW
	/qt0+8SDAIjEEBdEhwJbWAvoGXA+HYTqWmjPl5WjdsrNwYah9EpHP8TgC04wtkBkpFvBcA
	XsbVQIgRqr8w/icdx+1jgAGLENiQvN90d+zl5NSy/pe6fY9O+EaxYiKeOGhQgN7gbcGB2E
	JrHuDa4vQB3+JgzqC3fM3sU0gP9dhv1W616rjiW/N46+FcVPrb1wmd/MGccnf6rjGNZkF2
	7pFtkT0Jq/hKH+YFZmnKKYlUZzVWiMQBiMl8v8myn0I7WRlGVkEoBkY4RO0r2Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1739872003;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/zP2PWLJ/aoF4Uu4jx9TMRvpVV/5Qd93OglewsGp5c0=;
	b=7gQtZXL7ZZnzFvXhOITwiQJCst8xMaVP3sWaR9D2Uk78dhwojM4J/Jt1i0RO9m0GySkKS5
	KXbPMTniDyOQnqBA==
From: "tip-bot2 for Nam Cao" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/cleanups] KVM: arm64: Switch to use hrtimer_setup()
Cc: Nam Cao <namcao@linutronix.de>, Thomas Gleixner <tglx@linutronix.de>,
 Marc Zyngier <maz@kernel.org>, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3C59f527713562ad491df7c216eeee0378e0eb2402=2E17387?=
 =?utf-8?q?46821=2Egit=2Enamcao=40linutronix=2Ede=3E?=
References: =?utf-8?q?=3C59f527713562ad491df7c216eeee0378e0eb2402=2E173874?=
 =?utf-8?q?6821=2Egit=2Enamcao=40linutronix=2Ede=3E?=
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173987200336.10177.14980244755318411952.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/cleanups branch of tip:

Commit-ID:     7e5fd922c1464bd0678491f470844884af56f810
Gitweb:        https://git.kernel.org/tip/7e5fd922c1464bd0678491f470844884af56f810
Author:        Nam Cao <namcao@linutronix.de>
AuthorDate:    Wed, 05 Feb 2025 11:38:49 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 18 Feb 2025 10:32:31 +01:00

KVM: arm64: Switch to use hrtimer_setup()

hrtimer_setup() takes the callback function pointer as argument and
initializes the timer completely.

Replace hrtimer_init() and the open coded initialization of
hrtimer::function with the new setup mechanism.

Signed-off-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/all/59f527713562ad491df7c216eeee0378e0eb2402.1738746821.git.namcao@linutronix.de

---
 arch/arm64/kvm/arch_timer.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/kvm/arch_timer.c b/arch/arm64/kvm/arch_timer.c
index 70802e4..5133dcb 100644
--- a/arch/arm64/kvm/arch_timer.c
+++ b/arch/arm64/kvm/arch_timer.c
@@ -1070,8 +1070,7 @@ static void timer_context_init(struct kvm_vcpu *vcpu, int timerid)
 	else
 		ctxt->offset.vm_offset = &kvm->arch.timer_data.poffset;
 
-	hrtimer_init(&ctxt->hrtimer, CLOCK_MONOTONIC, HRTIMER_MODE_ABS_HARD);
-	ctxt->hrtimer.function = kvm_hrtimer_expire;
+	hrtimer_setup(&ctxt->hrtimer, kvm_hrtimer_expire, CLOCK_MONOTONIC, HRTIMER_MODE_ABS_HARD);
 
 	switch (timerid) {
 	case TIMER_PTIMER:
@@ -1098,8 +1097,8 @@ void kvm_timer_vcpu_init(struct kvm_vcpu *vcpu)
 		timer_set_offset(vcpu_ptimer(vcpu), 0);
 	}
 
-	hrtimer_init(&timer->bg_timer, CLOCK_MONOTONIC, HRTIMER_MODE_ABS_HARD);
-	timer->bg_timer.function = kvm_bg_timer_expire;
+	hrtimer_setup(&timer->bg_timer, kvm_bg_timer_expire, CLOCK_MONOTONIC,
+		      HRTIMER_MODE_ABS_HARD);
 }
 
 void kvm_timer_init_vm(struct kvm *kvm)

