Return-Path: <linux-tip-commits+bounces-2819-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AE179BFC2C
	for <lists+linux-tip-commits@lfdr.de>; Thu,  7 Nov 2024 03:02:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C2601C209D1
	for <lists+linux-tip-commits@lfdr.de>; Thu,  7 Nov 2024 02:02:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 804D8198841;
	Thu,  7 Nov 2024 01:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EHNFM49R";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rg9MnRvj"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0C81194C77;
	Thu,  7 Nov 2024 01:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730944790; cv=none; b=g2YtUZ/HE0x3YLqiAfNcDUlWV4qOPaPQsmgozZz5elByFen7lBE2sCY3nLMdFI6ak2Cd3Uz99KRuuN0d4xQPlACpzri71qj4iBYJReQ11qXRp1pGcmLabp7zmfvfsbmK8VyiW2FmKdPJK6MnaJLmAa9woY+//Qb1HFM4qhOd6bA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730944790; c=relaxed/simple;
	bh=EAuU+MMavEhD91ajb6fCuYB2eqIXnlOVgA8L0Rb3lLI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=sbQRBZCsz0+IHdigf2wQef/+Ec/XJ6Rzu6JHuzB/z/t9WOBLotg1FrW9yAPb9dTrKlaPmQ4etu6sidpMQ/OO+7QA1cO3z1KkpKwVFSjwavXfZ+BIqAkaQLn6R0wU2fSMt0J26llcq+6h3vHq7rE4FCgxBHfdM3ig01HcLdfLa7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=EHNFM49R; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rg9MnRvj; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 07 Nov 2024 01:59:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730944787;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=d0iTNozT/HjWUrZUkYjXJ6YN8aO2t6/Cd9Lxdeh6Mmk=;
	b=EHNFM49Rn5rX6MSymGmGMR+8sZec+rBx10/8/7qEU29BhQVd4qh+zxzoEY0Xo28Ho6+L+b
	Kp/UpqFgkg0NK7esfdZwQdiVSpOJwG+/YOtmfLddmZ7BC/XjQNfATsk0cCQuKCHV2LXccs
	a1TkhUK2TCvhLL4puDeaO+YQDgHREuDASXWwny4gngJLnsUbMBruA9BmRDW2YWZJRYm+wT
	bMudb47Z2aypUVu5FDkMlm/UfB+NO2oMf92Ieuz3+oei1QOsl3QGlMeznBlbopHyCUiHPN
	xtWlDVnoPPY0op8w8ohrXRFPyUfpDrqJhImehhKBBUTs+OaJ3DmWPpYfXaPVlA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730944787;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=d0iTNozT/HjWUrZUkYjXJ6YN8aO2t6/Cd9Lxdeh6Mmk=;
	b=rg9MnRvjVH0cV8Zt0BZXmp+kl3q7ZuFVtfe03NBRvRLvP+1+ADHIsEkCIe1mFu9THaqNwo
	9tadR+MkPtd0meDA==
From: "tip-bot2 for Nam Cao" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: timers/core] KVM: x86/xen: Initialize hrtimer in kvm_xen_init_vcpu()
Cc: Nam Cao <namcao@linutronix.de>, Thomas Gleixner <tglx@linutronix.de>,
 Sean Christopherson <seanjc@google.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3C9c33c7224d97d08f4fa30d3cc8687981c1d3e953=2E17303?=
 =?utf-8?q?86209=2Egit=2Enamcao=40linutronix=2Ede=3E?=
References: =?utf-8?q?=3C9c33c7224d97d08f4fa30d3cc8687981c1d3e953=2E173038?=
 =?utf-8?q?6209=2Egit=2Enamcao=40linutronix=2Ede=3E?=
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173094478619.32228.10266134843777025555.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     f6e12766c52dc8e7032fe51d4ef33320b475775e
Gitweb:        https://git.kernel.org/tip/f6e12766c52dc8e7032fe51d4ef33320b475775e
Author:        Nam Cao <namcao@linutronix.de>
AuthorDate:    Thu, 31 Oct 2024 16:14:17 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 07 Nov 2024 02:47:05 +01:00

KVM: x86/xen: Initialize hrtimer in kvm_xen_init_vcpu()

The hrtimer is initialized in the KVM_XEN_VCPU_SET_ATTR ioctl. That caused
problem in the past, because the hrtimer can be initialized multiple times,
which was fixed by commit af735db31285 ("KVM: x86/xen: Initialize Xen timer
only once"). This commit avoids initializing the timer multiple times by
checking the field 'function' of struct hrtimer to determine if it has
already been initialized.

This is not required and in the way to make the function field private.

Move the hrtimer initialization into kvm_xen_init_vcpu() so that it will
only be initialized once.

Signed-off-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Sean Christopherson <seanjc@google.com>
Link: https://lore.kernel.org/all/9c33c7224d97d08f4fa30d3cc8687981c1d3e953.1730386209.git.namcao@linutronix.de

---
 arch/x86/kvm/xen.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/arch/x86/kvm/xen.c b/arch/x86/kvm/xen.c
index 622fe24..a909b81 100644
--- a/arch/x86/kvm/xen.c
+++ b/arch/x86/kvm/xen.c
@@ -263,13 +263,6 @@ static void kvm_xen_stop_timer(struct kvm_vcpu *vcpu)
 	atomic_set(&vcpu->arch.xen.timer_pending, 0);
 }
 
-static void kvm_xen_init_timer(struct kvm_vcpu *vcpu)
-{
-	hrtimer_init(&vcpu->arch.xen.timer, CLOCK_MONOTONIC,
-		     HRTIMER_MODE_ABS_HARD);
-	vcpu->arch.xen.timer.function = xen_timer_callback;
-}
-
 static void kvm_xen_update_runstate_guest(struct kvm_vcpu *v, bool atomic)
 {
 	struct kvm_vcpu_xen *vx = &v->arch.xen;
@@ -1070,9 +1063,6 @@ int kvm_xen_vcpu_set_attr(struct kvm_vcpu *vcpu, struct kvm_xen_vcpu_attr *data)
 			break;
 		}
 
-		if (!vcpu->arch.xen.timer.function)
-			kvm_xen_init_timer(vcpu);
-
 		/* Stop the timer (if it's running) before changing the vector */
 		kvm_xen_stop_timer(vcpu);
 		vcpu->arch.xen.timer_virq = data->u.timer.port;
@@ -2235,6 +2225,8 @@ void kvm_xen_init_vcpu(struct kvm_vcpu *vcpu)
 	vcpu->arch.xen.poll_evtchn = 0;
 
 	timer_setup(&vcpu->arch.xen.poll_timer, cancel_evtchn_poll, 0);
+	hrtimer_init(&vcpu->arch.xen.timer, CLOCK_MONOTONIC, HRTIMER_MODE_ABS_HARD);
+	vcpu->arch.xen.timer.function = xen_timer_callback;
 
 	kvm_gpc_init(&vcpu->arch.xen.runstate_cache, vcpu->kvm);
 	kvm_gpc_init(&vcpu->arch.xen.runstate2_cache, vcpu->kvm);

