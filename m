Return-Path: <linux-tip-commits+bounces-3433-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DD8FAA39790
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Feb 2025 10:52:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2190E17551D
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Feb 2025 09:51:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00A502475C8;
	Tue, 18 Feb 2025 09:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AvCvmrLo";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aL2g0AY/"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3BF12451E4;
	Tue, 18 Feb 2025 09:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739872008; cv=none; b=MqKvBpPOu1RYIi0VvKPjrQTdAtANqSthvwzN2LbpxDaVV13q2+9/WvOX6/KgUI6ieQjztkxZx7BcF0IlyoQLsSd1pbk+Y9przDlRoZgm5b+f5uyN2rqMbnpUOWR7mDh+R+3RXWAB7oozY/LX6hl/VvhykYM0p/mMkAttnougyTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739872008; c=relaxed/simple;
	bh=KKWaLP5qpMsw7RydGkFQ2gw3A/cuiQ2yBj1Fo4fRsKI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Fj5/mlktAOkawsy+UQHs7/nxEv/+g7CTmQZrLEXo3wAKeMsapmp7T9smgEsBHQOXrQ0aC9WLxbYcXRMydx43kSDbjldq/OP0g8NlS64Xt4bxFJbsiCnpel428Ct4724kYBx3hxBl5vQaws17DF2i7FlmREpxQim2/BXA3bJgtgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=AvCvmrLo; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=aL2g0AY/; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 18 Feb 2025 09:46:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1739872005;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/pkT/dCu7yNaUEWVDp8GeC82JB12IPGDaNqK/eSURkc=;
	b=AvCvmrLotQKfQS934cF7F3A+HnpLKt2z1affvSO8BbfsmPH3U9/YVnl/q8Q2e3XseSlAwN
	X6H+M6Vq55gtSL0huQ4tR7Ho24FX/prNPZZbEbXz5g5Uid75mn+ykD3sIYhaA/pi8/ujjn
	fbY3QVsO5/96VZivFjaKhnKmv5P3UhEoGu30Xto9kRhcVKnBG9sB9J8/dj24ZKbuRSdtDI
	ko+cCETzkjaHzlry8ES8IaVqtE+KScQvaAjtNzBO45JHXW/x5NLRP9CYOQlcQBMa3Um454
	PUVG+5z+G4on7fGDq/8SP2l7wuLru3lS+TeW+nq12rO2lKnpdwip31sEm7xwjA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1739872005;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/pkT/dCu7yNaUEWVDp8GeC82JB12IPGDaNqK/eSURkc=;
	b=aL2g0AY/gWnRX53hAAleDjPzBgOdL5QM+nq6Uy3/CN9yB+YVcSoIPpM7LRYa47PJrBCJcC
	dhOlsirAD9gwRzCA==
From: "tip-bot2 for Nam Cao" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/cleanups] KVM: s390: Switch to use hrtimer_setup()
Cc: Nam Cao <namcao@linutronix.de>, Thomas Gleixner <tglx@linutronix.de>,
 Christian Borntraeger <borntraeger@linux.ibm.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3C637865c62963fb8cddf6c4368ca12434988a8c27=2E17387?=
 =?utf-8?q?46821=2Egit=2Enamcao=40linutronix=2Ede=3E?=
References: =?utf-8?q?=3C637865c62963fb8cddf6c4368ca12434988a8c27=2E173874?=
 =?utf-8?q?6821=2Egit=2Enamcao=40linutronix=2Ede=3E?=
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173987200472.10177.17967223407419091137.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/cleanups branch of tip:

Commit-ID:     7ff22753d894250aed6048f6d4a5680142b4083f
Gitweb:        https://git.kernel.org/tip/7ff22753d894250aed6048f6d4a5680142b4083f
Author:        Nam Cao <namcao@linutronix.de>
AuthorDate:    Wed, 05 Feb 2025 11:38:47 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 18 Feb 2025 10:32:30 +01:00

KVM: s390: Switch to use hrtimer_setup()

hrtimer_setup() takes the callback function pointer as argument and
initializes the timer completely.

Replace hrtimer_init() and the open coded initialization of
hrtimer::function with the new setup mechanism.

Patch was created by using Coccinelle.

Signed-off-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Christian Borntraeger <borntraeger@linux.ibm.com>
Link: https://lore.kernel.org/all/637865c62963fb8cddf6c4368ca12434988a8c27.1738746821.git.namcao@linutronix.de

---
 arch/s390/kvm/interrupt.c | 3 +--
 arch/s390/kvm/kvm-s390.c  | 4 ++--
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
index 07ff0e1..0f00f8e 100644
--- a/arch/s390/kvm/interrupt.c
+++ b/arch/s390/kvm/interrupt.c
@@ -3174,8 +3174,7 @@ void kvm_s390_gisa_init(struct kvm *kvm)
 	gi->alert.mask = 0;
 	spin_lock_init(&gi->alert.ref_lock);
 	gi->expires = 50 * 1000; /* 50 usec */
-	hrtimer_init(&gi->timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
-	gi->timer.function = gisa_vcpu_kicker;
+	hrtimer_setup(&gi->timer, gisa_vcpu_kicker, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
 	memset(gi->origin, 0, sizeof(struct kvm_s390_gisa));
 	gi->origin->next_alert = (u32)virt_to_phys(gi->origin);
 	VM_EVENT(kvm, 3, "gisa 0x%pK initialized", gi->origin);
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index ebecb96..1066c6a 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -3943,8 +3943,8 @@ static int kvm_s390_vcpu_setup(struct kvm_vcpu *vcpu)
 		if (rc)
 			return rc;
 	}
-	hrtimer_init(&vcpu->arch.ckc_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
-	vcpu->arch.ckc_timer.function = kvm_s390_idle_wakeup;
+	hrtimer_setup(&vcpu->arch.ckc_timer, kvm_s390_idle_wakeup, CLOCK_MONOTONIC,
+		      HRTIMER_MODE_REL);
 
 	vcpu->arch.sie_block->hpid = HPID_KVM;
 

