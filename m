Return-Path: <linux-tip-commits+bounces-7398-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7150EC6B707
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Nov 2025 20:29:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id 8193C29ED4
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Nov 2025 19:29:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B25F02E9ECE;
	Tue, 18 Nov 2025 19:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DUKfX10y";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HGBt69FK"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 130BE2E6100;
	Tue, 18 Nov 2025 19:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763494123; cv=none; b=W+koRr3qK1cgNzoHCtWkvbdduVXB1fYAKVcxISRGu+3FhNlTZe/Kh43UihJgRHFCB1rjIdrQTAAUsm9pS4LaSHRzDTLXTPu6OVyLYKy3qEXaX1IwU2oxPuDWLsbITPp/EmUQjq+aE2mgbBpZ2XDSt+AiBGCXZQ7zP66JwIIEmWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763494123; c=relaxed/simple;
	bh=+VKTzl0xa+UnluE5eAOlqKquceFAhS4LjncakTXTXlA=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=LTkpkj6IU1+7nWQzY/M8E8CfVoD0FecmTJxzhZ+9bKZGHNpMVoW7Oqh3Ge0l42U1Wo+Homfcsa+i7J5OFD9mJCUOTe7j+SQZGVkQ1m/YnscZiCJlyQ66a4xzxG8Kr0j8B6xbjt2dtqOJ6IGVxDX9Iz13g2+/nXl24w1NIS2USpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DUKfX10y; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HGBt69FK; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 18 Nov 2025 19:28:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1763494120;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=ZsH3PpgzvfffDnZcvQnJ/Mx8Yfv/f7Ehg9CL5l/CEo8=;
	b=DUKfX10ym+BdDKVTYw0zjvoz+LryXQNIJSSRRifB/11FjR0jH+1zULgmo64BocTiY/iGEb
	gEfvoFqunRFGT2Fbm9glM/sA6mseymlQ0GwX7ew3T2inNHDZePfvc0HxwFJLmg/Ek7prjs
	6UQIxCk+gKb66F3+5kRu+4IzryIgG73gDhOy+J8OlcgQyB2Hxj/LOrDRkRAVG+V7IskeMq
	APZrblufQy06/PP6AO/Co+owy1PlExHaxszcq+eTdAUdlmYTxMlqNMPI6vtM681xKZwbBM
	YADuMcZnP0YJLzDArxrETOPgaSzBYXVb7gjEeDboU5NiWw1k8bqqegKjMC4Wuw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1763494120;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=ZsH3PpgzvfffDnZcvQnJ/Mx8Yfv/f7Ehg9CL5l/CEo8=;
	b=HGBt69FKywgKJXFVeb/T0smIzhURXaHRKp/9hliDGiS2UNXtwqE56dvFPwMyQQ4uFpsrFf
	A95QEwGc8yxESkDQ==
From: "tip-bot2 for Sohil Mehta" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/kexec: Disable LASS during relocate kernel
Cc: Sohil Mehta <sohil.mehta@intel.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176349411945.498.12587591996047372682.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     731d43750cf8d3c67df7aabc78cc567c6d684111
Gitweb:        https://git.kernel.org/tip/731d43750cf8d3c67df7aabc78cc567c6d6=
84111
Author:        Sohil Mehta <sohil.mehta@intel.com>
AuthorDate:    Tue, 18 Nov 2025 10:29:07 -08:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Tue, 18 Nov 2025 10:38:26 -08:00

x86/kexec: Disable LASS during relocate kernel

The relocate kernel mechanism uses an identity mapping to copy the new
kernel, which leads to a LASS violation when executing from a low
address.

LASS must be disabled after the original CR4 value is saved because
kexec paths that preserve context need to restore CR4.LASS. But,
disabling it along with CET during identity_mapped() is too late. So,
disable LASS immediately after saving CR4, along with PGE, and before
jumping to the identity-mapped page.

Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>
Link: https://patch.msgid.link/20251118182911.2983253-6-sohil.mehta%40intel.c=
om
---
 arch/x86/kernel/relocate_kernel_64.S | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/relocate_kernel_64.S b/arch/x86/kernel/relocate_=
kernel_64.S
index 11e20bb..4ffba68 100644
--- a/arch/x86/kernel/relocate_kernel_64.S
+++ b/arch/x86/kernel/relocate_kernel_64.S
@@ -95,9 +95,12 @@ SYM_CODE_START_NOALIGN(relocate_kernel)
 	/* Leave CR4 in %r13 to enable the right paging mode later. */
 	movq	%cr4, %r13
=20
-	/* Disable global pages immediately to ensure this mapping is RWX */
+	/*
+	 * Disable global pages immediately to ensure this mapping is RWX.
+	 * Disable LASS before jumping to the identity mapped page.
+	 */
 	movq	%r13, %r12
-	andq	$~(X86_CR4_PGE), %r12
+	andq	$~(X86_CR4_PGE | X86_CR4_LASS), %r12
 	movq	%r12, %cr4
=20
 	/* Save %rsp and CRs. */

