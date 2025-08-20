Return-Path: <linux-tip-commits+bounces-6285-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F0A7B2D902
	for <lists+linux-tip-commits@lfdr.de>; Wed, 20 Aug 2025 11:48:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 863985C5BF3
	for <lists+linux-tip-commits@lfdr.de>; Wed, 20 Aug 2025 09:43:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAF362E9749;
	Wed, 20 Aug 2025 09:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="krIlKTuW";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1nc6XEy7"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECC422E973C;
	Wed, 20 Aug 2025 09:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755682750; cv=none; b=G3ltdUfU7tZ2uHaZ67ok+ua7y8la8L37CMEltThoGaXtn2yoafFaFeQogFAheY3pQWe1Q+PPflb0xi0CWLNEM8B9L5lH1zruHkGmynfVY+PBztrbPyb7QAS3nA6nFSVXhncsMeU1kFsADu7XEgkut1Ha6d1Q7NmCGzQLVpEJwuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755682750; c=relaxed/simple;
	bh=x8JvmP4J5yNBLJtF9gEy1EdPnL8gBelhgC329rigACA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=kI6U4ZIgBaRbm162v+LkpfbCO23NUHxsTg92zpB0xk9N95s94IEKrZe6cLqWteRk1m4R+u9Jo0MpGx33I0AYpHCZ+KVMttf66KqAZ+GFbLRGmS/4Yqs9u/8SJc7yUm9xLPKeY0R0cnJwXsRHowB6u0quagUMRi3hLJw2e2qywKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=krIlKTuW; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1nc6XEy7; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 20 Aug 2025 09:39:05 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1755682747;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yksXEKnIUgPzX0NMPD7EWy5Bf6TTc47BKXxPLgz13Lc=;
	b=krIlKTuWTeVvbMXMivkYJm+jePaI3abE8mR9epQBH/bPYHJo9RgrzKEkUP7kZfispbKqjn
	IygxItRPE57nVWUtuSYkpUa0W2Sw8c5m6wc4q/SJ8Sb/N+FYk/8f7z4TPK2yd+XN6u78iv
	ZH9vZhbp+ItxxuLIKSACcOzneDKBFUt7IjJcfu9Sm8blQyvWJtkb3p7kmEQPA/eAPNzSYt
	WNtG1J5h0lZCwnVuxVeUOK6HT+ACFuakiPtGFzvt7xL/Ff1saOq7VEztAgFPc2C8SQVqJD
	pt3y27Wj391RZhTei7CiMqJvDiUigSgBO3QD0ODpf/YMIw9x3a+JyKozUvBrLw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1755682747;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yksXEKnIUgPzX0NMPD7EWy5Bf6TTc47BKXxPLgz13Lc=;
	b=1nc6XEy7oP0PAZbcZZl5/os+dGE5uyJOmpRjl4v7xI95+knpVp4E1u3ssJOqextuSaDOmt
	GIpmdLIkmh58JVAg==
From: "tip-bot2 for Sean Christopherson" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86/fred: KVM: VMX: Always use FRED for IRQs when
 CONFIG_X86_FRED=y
Cc: Peter Zijlstra <peterz@infradead.org>,
 Sean Christopherson <seanjc@google.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250714103441.381946911@infradead.org>
References: <20250714103441.381946911@infradead.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175568274580.1420.5035691547576445624.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     28d11e4548b75d0960429344f12d5f6cc9cee25b
Gitweb:        https://git.kernel.org/tip/28d11e4548b75d0960429344f12d5f6cc9c=
ee25b
Author:        Sean Christopherson <seanjc@google.com>
AuthorDate:    Thu, 01 May 2025 11:10:39 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 18 Aug 2025 14:23:08 +02:00

x86/fred: KVM: VMX: Always use FRED for IRQs when CONFIG_X86_FRED=3Dy

Now that FRED provides C-code entry points for handling IRQs, use the
FRED infrastructure for forwarding IRQs even if FRED is fully
disabled, e.g. isn't supported in hardware. Avoiding the non-FRED
assembly trampolines into the IDT handlers for IRQs eliminates the
associated non-CFI indirect call (KVM performs a CALL by doing a
lookup on the IDT using the IRQ vector).

Keep NMIs on the legacy IDT path, as the FRED NMI entry code relies on
FRED's architectural behavior with respect to NMI blocking, i.e. doesn't
jump through the myriad hoops needed to deal with IRET "unexpectedly"
unmasking NMIs.  KVM's NMI path already makes a direct CALL to C-code,
i.e. isn't problematic for CFI.  KVM does make a short detour through
assembly code to build the stack frame, but the "FRED entry from KVM"
path does the same.

Force FRED for 64-bit kernels if KVM_INTEL is enabled, as the benefits of
eliminating the IRQ trampoline usage far outwieghts the code overhead for
FRED.

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20250714103441.381946911@infradead.org
---
 arch/x86/kvm/Kconfig   | 1 +
 arch/x86/kvm/vmx/vmx.c | 8 +++++++-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/Kconfig b/arch/x86/kvm/Kconfig
index 2c86673..b92ef11 100644
--- a/arch/x86/kvm/Kconfig
+++ b/arch/x86/kvm/Kconfig
@@ -97,6 +97,7 @@ config KVM_INTEL
 	depends on KVM && IA32_FEAT_CTL
 	select KVM_GENERIC_PRIVATE_MEM if INTEL_TDX_HOST
 	select KVM_GENERIC_MEMORY_ATTRIBUTES if INTEL_TDX_HOST
+	select X86_FRED if X86_64
 	help
 	  Provides support for KVM on processors equipped with Intel's VT
 	  extensions, a.k.a. Virtual Machine Extensions (VMX).
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index aa157fe..f7f6c04 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -6913,8 +6913,14 @@ static void handle_external_interrupt_irqoff(struct kv=
m_vcpu *vcpu,
 	    "unexpected VM-Exit interrupt info: 0x%x", intr_info))
 		return;
=20
+	/*
+	 * Invoke the kernel's IRQ handler for the vector.  Use the FRED path
+	 * when it's available even if FRED isn't fully enabled, e.g. even if
+	 * FRED isn't supported in hardware, in order to avoid the indirect
+	 * CALL in the non-FRED path.
+	 */
 	kvm_before_interrupt(vcpu, KVM_HANDLING_IRQ);
-	if (cpu_feature_enabled(X86_FEATURE_FRED))
+	if (IS_ENABLED(CONFIG_X86_FRED))
 		fred_entry_from_kvm(EVENT_TYPE_EXTINT, vector);
 	else
 		vmx_do_interrupt_irqoff(gate_offset((gate_desc *)host_idt_base + vector));

