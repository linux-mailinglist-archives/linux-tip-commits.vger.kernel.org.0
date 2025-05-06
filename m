Return-Path: <linux-tip-commits+bounces-5258-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A6CE8AAC0A6
	for <lists+linux-tip-commits@lfdr.de>; Tue,  6 May 2025 12:01:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57B9D1C24FAD
	for <lists+linux-tip-commits@lfdr.de>; Tue,  6 May 2025 10:01:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 612B0277803;
	Tue,  6 May 2025 10:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="M1XAp5+C";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CwwNwgIv"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7178A27585E;
	Tue,  6 May 2025 10:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746525639; cv=none; b=ZB8VCMnx7+xeyvwm3R57XgK5EDqeMzGzgQcZXMqIiDdf7FIMORs4B3RSdrWj4qCYLGgEisKMZhKJ23Gz8zkOxfLpRTKh9MdRa/8UrgpPVZPjIJRxfgEJSovc/H8prgwmw/HYLDjlCPPPqaMOk3YsWu48a8uI5m1GR5RhN8528Uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746525639; c=relaxed/simple;
	bh=LcBMFkhasJc971Tz04TX1N3XqhKT5s31zVenJZH5N88=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=kqrcegZCV/D7bjugpJaNRtJ3QYGPQd+fxtc7F0FAgWah9zxsRRGdHPPHTNt9mIpWRLC3mXkCuOQWElWKMtpRQQ1glIs7lFpc6dplUmFdU1GW4DgMRdHZuz8JUsbBh37zoAalh8jh4ZbYrXJToaZta4hVCVWI0vH8vdsTJM92cmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=M1XAp5+C; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CwwNwgIv; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 06 May 2025 10:00:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746525635;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zcmS+q78ENUBjWEzIBDQ84QsT8wWNZGNer2Dnj1RXp4=;
	b=M1XAp5+CFIhrok+ZLNA4H78VxQ+42xpR9W+99SfEnYBjpR3Ozbm/HI1eqK/OEPQTbNE0wJ
	pxOnGFHi+NXICcZ+EqSFRo9gF2l4zXHnP3kMuqzElrVxUd8/xaXYwwErlT+v2xCrK3KZjr
	6RHsbDrnhNfH0rgc+S9u3ajeYt8DCVWoZ2B9RZmxg0KGNT3mkIutbxd/nEkpwBgg95nHJx
	ejxHWhhIaLTKehggFafGpJbaYgtyWSFr+LoEDpezT8r2SAqFuZApg/89a1t+KpFz7AsaKn
	jcdLEQysgK45y4RwQTQjJi0XN7ICxt0Z/AxNf7Q+9lw2rn+CpiOoTJtvdYB2Sw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746525635;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zcmS+q78ENUBjWEzIBDQ84QsT8wWNZGNer2Dnj1RXp4=;
	b=CwwNwgIvKFC+PEMmnEm7owDYQHi06YXcT2PYNk9/soaRMW0fp+RyRYYP18yUo8DV8ICrfi
	qqDhwSU7tv0rkpCw==
From: "tip-bot2 for Chao Gao" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/fpu] x86/fpu: Drop @perm from guest pseudo FPU container
Cc: Maxim Levitsky <mlevitsk@redhat.com>, Chao Gao <chao.gao@intel.com>,
 Ingo Molnar <mingo@kernel.org>, "Chang S. Bae" <chang.seok.bae@intel.com>,
 Andy Lutomirski <luto@kernel.org>, David Woodhouse <dwmw2@infradead.org>,
 Eric Biggers <ebiggers@google.com>, Fenghua Yu <fenghua.yu@intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>, Kees Cook <kees@kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Mitchell Levy <levymitchell0@gmail.com>, Oleg Nesterov <oleg@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Samuel Holland <samuel.holland@sifive.com>,
 Sean Christopherson <seanjc@google.com>,
 Vitaly Kuznetsov <vkuznets@redhat.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250506093740.2864458-3-chao.gao@intel.com>
References: <20250506093740.2864458-3-chao.gao@intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174652563422.406.4328703554427720603.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/fpu branch of tip:

Commit-ID:     32d5fa804dc9bd7cf6651a1378ba616d332e7444
Gitweb:        https://git.kernel.org/tip/32d5fa804dc9bd7cf6651a1378ba616d332e7444
Author:        Chao Gao <chao.gao@intel.com>
AuthorDate:    Tue, 06 May 2025 17:36:07 +08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 06 May 2025 11:52:22 +02:00

x86/fpu: Drop @perm from guest pseudo FPU container

Remove @perm from the guest pseudo FPU container. The field is
initialized during allocation and never used later.

Rename fpu_init_guest_permissions() to show that its sole purpose is to
lock down guest permissions.

Suggested-by: Maxim Levitsky <mlevitsk@redhat.com>
Signed-off-by: Chao Gao <chao.gao@intel.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Chang S. Bae <chang.seok.bae@intel.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: David Woodhouse <dwmw2@infradead.org>
Cc: Eric Biggers <ebiggers@google.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Kees Cook <kees@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mitchell Levy <levymitchell0@gmail.com>
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Samuel Holland <samuel.holland@sifive.com>
Cc: Sean Christopherson <seanjc@google.com>
Cc: Vitaly Kuznetsov <vkuznets@redhat.com>
Link: https://lore.kernel.org/kvm/af972fe5981b9e7101b64de43c7be0a8cc165323.camel@redhat.com/
Link: https://lore.kernel.org/r/20250506093740.2864458-3-chao.gao@intel.com
---
 arch/x86/include/asm/fpu/types.h | 7 -------
 arch/x86/kernel/fpu/core.c       | 7 ++-----
 2 files changed, 2 insertions(+), 12 deletions(-)

diff --git a/arch/x86/include/asm/fpu/types.h b/arch/x86/include/asm/fpu/types.h
index e64db0e..1c94121 100644
--- a/arch/x86/include/asm/fpu/types.h
+++ b/arch/x86/include/asm/fpu/types.h
@@ -536,13 +536,6 @@ struct fpu_guest {
 	u64				xfeatures;
 
 	/*
-	 * @perm:			xfeature bitmap of features which are
-	 *				permitted to be enabled for the guest
-	 *				vCPU.
-	 */
-	u64				perm;
-
-	/*
 	 * @xfd_err:			Save the guest value.
 	 */
 	u64				xfd_err;
diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
index 105b1b8..1cda5b7 100644
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -212,7 +212,7 @@ void fpu_reset_from_exception_fixup(void)
 #if IS_ENABLED(CONFIG_KVM)
 static void __fpstate_reset(struct fpstate *fpstate, u64 xfd);
 
-static void fpu_init_guest_permissions(struct fpu_guest *gfpu)
+static void fpu_lock_guest_permissions(void)
 {
 	struct fpu_state_perm *fpuperm;
 	u64 perm;
@@ -228,8 +228,6 @@ static void fpu_init_guest_permissions(struct fpu_guest *gfpu)
 	WRITE_ONCE(fpuperm->__state_perm, perm | FPU_GUEST_PERM_LOCKED);
 
 	spin_unlock_irq(&current->sighand->siglock);
-
-	gfpu->perm = perm & ~FPU_GUEST_PERM_LOCKED;
 }
 
 bool fpu_alloc_guest_fpstate(struct fpu_guest *gfpu)
@@ -250,7 +248,6 @@ bool fpu_alloc_guest_fpstate(struct fpu_guest *gfpu)
 
 	gfpu->fpstate		= fpstate;
 	gfpu->xfeatures		= fpu_kernel_cfg.default_features;
-	gfpu->perm		= fpu_kernel_cfg.default_features;
 
 	/*
 	 * KVM sets the FP+SSE bits in the XSAVE header when copying FPU state
@@ -265,7 +262,7 @@ bool fpu_alloc_guest_fpstate(struct fpu_guest *gfpu)
 	if (WARN_ON_ONCE(fpu_user_cfg.default_size > gfpu->uabi_size))
 		gfpu->uabi_size = fpu_user_cfg.default_size;
 
-	fpu_init_guest_permissions(gfpu);
+	fpu_lock_guest_permissions();
 
 	return true;
 }

