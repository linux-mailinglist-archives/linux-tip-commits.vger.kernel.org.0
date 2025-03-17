Return-Path: <linux-tip-commits+bounces-4297-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18D9AA66259
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Mar 2025 00:03:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53B2217AC7D
	for <lists+linux-tip-commits@lfdr.de>; Mon, 17 Mar 2025 23:03:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11C781A7249;
	Mon, 17 Mar 2025 23:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="auYfnhGk";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="+zLC+Hk8"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC9FF14900F;
	Mon, 17 Mar 2025 23:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742252594; cv=none; b=PqIn6j17GBfMbryaWWx8rIdZB96CTolXiiXuiBhV9PRTZp/7vlTIEbrrPevsHfWdgw1jetkTC1xqedT1QhLI1GYJzAgGjZuzs2eUdrin1D6svhCdcmcpNFyLqB5NkQyeO/ESAVa9i9vhHY6xHP0/MfqxUIYMQA7xvUs82YFxAVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742252594; c=relaxed/simple;
	bh=V1OIXrs9CUjf000cBLJK2Je9iZkKCRv2mHPPsfho/Nc=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Am5NbO3p+zCYi3T9YFtXtgZ9NMVB4DZg1mFYasZjYI+PL5E5iH1wUPhoPEmOM3lTeQ2RThYQLHLuLYsg7FchI6JoGSigjs9hYkk+AhyCHZ1GCo4JDLboqugt3cPqiOyUkJu6GGv7fNRL71M3ODkXVtz4bK/Jbd0+/SY9Ae9NqBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=auYfnhGk; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=+zLC+Hk8; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 17 Mar 2025 23:03:05 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742252587;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jeRRP/YAk4qoANrW+AA8uw4nMpTz/q7kbyeAnwmntLE=;
	b=auYfnhGku10DhHcBiddoy+ABDwwA7F0bjo6OSMxzOeNaUXc4gm+AxU6hM0h+DzD3/vXcah
	8d+Eq2zBW0/cpy5XKkY54qfAfL7LJihMzvf8RmaDE45n47vF78ReFnh/QUjnQuTkSCZp84
	5N7QBUAWtR0Zs92tD355FDosAOm3OVa5aowkdWu25N4QMhbKM5qMokXvH5Y9FTbOAsogU7
	Rj2lOojvcQU5Wb+RmRXvUqYGG47Vymucvx9rx90Ftv7geiN/zFvWrD3+RMg3nC2c3z2Nhf
	jCOL+rpMlRmZWPNiTl44KisN4YjIKQyQngZ7bXxLB6veuXDpdSw+ZZ6CJv8kig==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742252587;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jeRRP/YAk4qoANrW+AA8uw4nMpTz/q7kbyeAnwmntLE=;
	b=+zLC+Hk82PXncIxkVyL3+Coq5+WRaK90ScYuzdnHuTHy35SsTAd5rbUkt5LKgBa55mCmrF
	KPvh12Sa7fKbu6CA==
From: "tip-bot2 for Chao Gao" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/fpu] x86/fpu/xstate: Fix inconsistencies in guest FPU xfeatures
Cc: "Chang S. Bae" <chang.seok.bae@intel.com>, Chao Gao <chao.gao@intel.com>,
 Ingo Molnar <mingo@kernel.org>, Andy Lutomirski <luto@kernel.org>,
 "H. Peter Anvin" <hpa@zytor.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Oleg Nesterov <oleg@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
 Juergen Gross <jgross@suse.com>, Stefano Stabellini <sstabellini@kernel.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>,
 Sean Christopherson <seanjc@google.com>,
 David Woodhouse <dwmw2@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250317140613.1761633-1-chao.gao@intel.com>
References: <20250317140613.1761633-1-chao.gao@intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174225258602.14745.15224724000760257268.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/fpu branch of tip:

Commit-ID:     dda366083e5ff307a4a728757db874bbfe7550be
Gitweb:        https://git.kernel.org/tip/dda366083e5ff307a4a728757db874bbfe7550be
Author:        Chao Gao <chao.gao@intel.com>
AuthorDate:    Mon, 17 Mar 2025 22:06:11 +08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 17 Mar 2025 23:52:31 +01:00

x86/fpu/xstate: Fix inconsistencies in guest FPU xfeatures

Guest FPUs manage vCPU FPU states. They are allocated via
fpu_alloc_guest_fpstate() and are resized in fpstate_realloc() when XFD
features are enabled.

Since the introduction of guest FPUs, there have been inconsistencies in
the kernel buffer size and xfeatures:

 1. fpu_alloc_guest_fpstate() uses fpu_user_cfg since its introduction. See:

    69f6ed1d14c6 ("x86/fpu: Provide infrastructure for KVM FPU cleanup")
    36487e6228c4 ("x86/fpu: Prepare guest FPU for dynamically enabled FPU features")

 2. __fpstate_reset() references fpu_kernel_cfg to set storage attributes.

 3. fpu->guest_perm uses fpu_kernel_cfg, affecting fpstate_realloc().

A recent commit in the tip:x86/fpu tree partially addressed the inconsistency
between (1) and (3) by using fpu_kernel_cfg for size calculation in (1),
but left fpu_guest->xfeatures and fpu_guest->perm still referencing
fpu_user_cfg:

  https://lore.kernel.org/all/20250218141045.85201-1-stanspas@amazon.de/

  1937e18cc3cf ("x86/fpu: Fix guest FPU state buffer allocation size")

The inconsistencies within fpu_alloc_guest_fpstate() and across the
mentioned functions cause confusion.

Fix them by using fpu_kernel_cfg consistently in fpu_alloc_guest_fpstate(),
except for fields related to the UABI buffer. Referencing fpu_kernel_cfg
won't impact functionalities, as:

 1. fpu_guest->perm is overwritten shortly in fpu_init_guest_permissions()
    with fpstate->guest_perm, which already uses fpu_kernel_cfg.

 2. fpu_guest->xfeatures is solely used to check if XFD features are enabled.
    Including supervisor xfeatures doesn't affect the check.

Fixes: 36487e6228c4 ("x86/fpu: Prepare guest FPU for dynamically enabled FPU features")
Suggested-by: Chang S. Bae <chang.seok.bae@intel.com>
Signed-off-by: Chao Gao <chao.gao@intel.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: Stefano Stabellini <sstabellini@kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: Sean Christopherson <seanjc@google.com>
Cc: David Woodhouse <dwmw2@infradead.org>
Link: https://lore.kernel.org/r/20250317140613.1761633-1-chao.gao@intel.com
---
 arch/x86/kernel/fpu/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
index 422c98c..1b734a9 100644
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -239,8 +239,8 @@ bool fpu_alloc_guest_fpstate(struct fpu_guest *gfpu)
 	fpstate->is_guest	= true;
 
 	gfpu->fpstate		= fpstate;
-	gfpu->xfeatures		= fpu_user_cfg.default_features;
-	gfpu->perm		= fpu_user_cfg.default_features;
+	gfpu->xfeatures		= fpu_kernel_cfg.default_features;
+	gfpu->perm		= fpu_kernel_cfg.default_features;
 
 	/*
 	 * KVM sets the FP+SSE bits in the XSAVE header when copying FPU state

