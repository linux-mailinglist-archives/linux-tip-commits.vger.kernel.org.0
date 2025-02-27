Return-Path: <linux-tip-commits+bounces-3693-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14951A479D5
	for <lists+linux-tip-commits@lfdr.de>; Thu, 27 Feb 2025 11:12:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6EFC16D91C
	for <lists+linux-tip-commits@lfdr.de>; Thu, 27 Feb 2025 10:12:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CD2A228C99;
	Thu, 27 Feb 2025 10:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0VbBTHoK";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="r8FHE2aZ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6887227E95;
	Thu, 27 Feb 2025 10:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740651126; cv=none; b=Dzkldvlsp9Sw3nUiO0keXfqNcnbBT/oBngIMcVL7dBG6JvV3M9MoGCJFLpBd+E/i/Ln7EQgggJxV9TCDrywtaSmsm9QB5tMHzMr6BW2A57CeRpdWOOJyIcO7hp42IYhzYAG1J6P5jxmAmj5u3oE5YKn3m+wIg9rJ+FG02tStDJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740651126; c=relaxed/simple;
	bh=M3IVmp1X48Qur/nm7YWPxeTUnXkyi6c3YThmUo0fQoY=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=AWMhwtxhp/Oa7Yz2pykAt6v63Z7btU+HtisWp6mYxQVVa5L7ANPoF2dmMZbP7/pn7XHLn8NVNYFu4vMJVYne2Hoh42LdhLIAdB2xM2RqxbO8Xh0KzTs4RyEa3kcyCX8vNcsWUenU60d/D3bgY1qB4z8oIhZLO2Iv6vK6DG8nvyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0VbBTHoK; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=r8FHE2aZ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 27 Feb 2025 10:12:01 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740651122;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7Zpb+CVQyeBv/KciRXHY8GgN1KETZq8gywEVqjdJlGQ=;
	b=0VbBTHoK8wYbyjOKMvxDcZz3XFYx30HFqH6LYIm+5vCOwd4xEe8f60+SsgZ9uKafoyUrYR
	Tnij8CHXI/hF85YW2vWoEdyFHa1ZUYy+mPqVO6Jl3F+Xjn+vME8oPbVk2yE4UoM7wLJtSG
	rvs0RlcUl9BxZj03uWqt4H9PmnVpN5b8JHhi5vev8/DCbYCFm5ZV63bsQ7fVTeftVTAf0C
	gu+30nvLeU8rP6n3DuMpXhHQDmlBDirgDJHxl0C/6jO7vf7CCritXaDA++nIjpfzoIWOi0
	EmjdPWgSpTkHGCyCH0UGv0IAbGiivyRgeDs5I9sFKhPSZwF9F4T4y5Kl6NhqJA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740651122;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7Zpb+CVQyeBv/KciRXHY8GgN1KETZq8gywEVqjdJlGQ=;
	b=r8FHE2aZcPm/CKlZ6HSooIJV7SxG6Im5BgxzzxDPZmEjeSGt/kxJKfr4S/3ZbZsuBpePou
	xyEwj1/NewGdhLBw==
From: "tip-bot2 for Yosry Ahmed" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/bugs] KVM: nVMX: Always use IBPB to properly virtualize IBRS
Cc: Yosry Ahmed <yosry.ahmed@linux.dev>, Ingo Molnar <mingo@kernel.org>,
 Jim Mattson <jmattson@google.com>, Josh Poimboeuf <jpoimboe@kernel.org>,
 Sean Christopherson <seanjc@google.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250227012712.3193063-6-yosry.ahmed@linux.dev>
References: <20250227012712.3193063-6-yosry.ahmed@linux.dev>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174065112192.10177.13367372055996559360.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/bugs branch of tip:

Commit-ID:     8c4f28cd81fe86033918eec69d5280b532c05842
Gitweb:        https://git.kernel.org/tip/8c4f28cd81fe86033918eec69d5280b532c05842
Author:        Yosry Ahmed <yosry.ahmed@linux.dev>
AuthorDate:    Thu, 27 Feb 2025 01:27:11 
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 27 Feb 2025 10:57:21 +01:00

KVM: nVMX: Always use IBPB to properly virtualize IBRS

On synthesized nested VM-exits in VMX, an IBPB is performed if IBRS is
advertised to the guest to properly provide separate prediction domains
for L1 and L2. However, this is currently conditional on
X86_FEATURE_USE_IBPB, which depends on the host spectre_v2_user
mitigation.

In short, if spectre_v2_user=no, IBRS is not virtualized correctly and
L1 becomes susceptible to attacks from L2. Fix this by performing the
IBPB regardless of X86_FEATURE_USE_IBPB.

Fixes: 2e7eab81425a ("KVM: VMX: Execute IBPB on emulated VM-exit when guest has IBRS")
Signed-off-by: Yosry Ahmed <yosry.ahmed@linux.dev>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Jim Mattson <jmattson@google.com>
Acked-by: Josh Poimboeuf <jpoimboe@kernel.org>
Acked-by: Sean Christopherson <seanjc@google.com>
Link: https://lore.kernel.org/r/20250227012712.3193063-6-yosry.ahmed@linux.dev
---
 arch/x86/kvm/vmx/nested.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index 1df427a..8a7af02 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -5026,8 +5026,7 @@ void nested_vmx_vmexit(struct kvm_vcpu *vcpu, u32 vm_exit_reason,
 	 * doesn't isolate different VMCSs, i.e. in this case, doesn't provide
 	 * separate modes for L2 vs L1.
 	 */
-	if (guest_cpu_cap_has(vcpu, X86_FEATURE_SPEC_CTRL) &&
-	    cpu_feature_enabled(X86_FEATURE_USE_IBPB))
+	if (guest_cpu_cap_has(vcpu, X86_FEATURE_SPEC_CTRL))
 		indirect_branch_prediction_barrier();
 
 	/* Update any VMCS fields that might have changed while L2 ran */

