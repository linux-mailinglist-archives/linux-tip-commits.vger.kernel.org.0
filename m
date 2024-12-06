Return-Path: <linux-tip-commits+bounces-2998-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B55029E6BBE
	for <lists+linux-tip-commits@lfdr.de>; Fri,  6 Dec 2024 11:19:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6BD952864F5
	for <lists+linux-tip-commits@lfdr.de>; Fri,  6 Dec 2024 10:19:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93F98200129;
	Fri,  6 Dec 2024 10:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xSDR8Vdr";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hDCZtly0"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D71C51FF7CD;
	Fri,  6 Dec 2024 10:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733480208; cv=none; b=jvlrMg1t3TASYAE/lsIpBBgkKyfTPSQ4nZtPLnHLGXRG91WdQaifOEQO0/gRJag+iM3PRbuNAQtIHocoH3DL/eSzBfekiDtQheTSxwDOfeCqU/Pdu6iJVojTgVAz/mFzoPWfd+U7QtP3nHeUbfaZSi9/mHSsDjB0o7nQQ2xiwAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733480208; c=relaxed/simple;
	bh=7tjcdLwFbck+6uWrCAnauobe+OKp5R+orRz4HQIXFV8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=MAlHqXlUnUZ3l7gjDxb1d0d2Rh7QzZrwynfCmNpkh6kCUdGiptNPufuMe3Hv5h60vIR5bu6CKBlU1siNbL6j7XWP0O7dfeCm0xIpUMrUXBIhH59iw0VeWF2gb3mehRbgxkVYuO1AyYQkTeUwTqk4FKqv3nDAh19zHvS5sR70x4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xSDR8Vdr; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hDCZtly0; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 06 Dec 2024 10:16:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1733480205;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YelidcceJDY1jFKcaJrKWDyjoOotHLoKmAJKudOtklM=;
	b=xSDR8Vdr9IIacibebQxv+i+X6oVH/ZOeAz8UvUyoE5DZMpn6sBnyv1JqvDZSD+k4ervrlg
	cQf1zucq6e/Yu+yARw3EWEgImRjv1nRpffhlPa77L3XBL0t/zdSg5Rcakkv+AHQ/GJeKZG
	xnjpgqPJnthn0Unbvf3YzS0+t/djSqU4YPqQomrLKu1oQeLwKxS3MrdAG85h+Ji5vtMe+k
	GqGA8jPYKF8N1GlAQ46yHGBrHWs2dPPBS7vwXn6tKoxK8TXe+vdPahDd7RSeoGHViqwjaK
	zQcEt6gJ0jrqDkCDXKpkgicr35FCahYIrGlPGEY/kzCITjYCCa5LSMdbKPeFAw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1733480205;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YelidcceJDY1jFKcaJrKWDyjoOotHLoKmAJKudOtklM=;
	b=hDCZtly0f5C2qDy1TRxUTCZyl1yYVmBux/jXoPNEMBwAln++EBifJI6XSrOlxildqredop
	eVgiUNQb6PONFGBA==
From: "tip-bot2 for David Woodhouse" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/boot] x86/kexec: Eliminate writes through kernel mapping of
 relocate_kernel page
Cc: David Woodhouse <dwmw@amazon.co.uk>, Ingo Molnar <mingo@kernel.org>,
 Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
 Dave Young <dyoung@redhat.com>, Eric Biederman <ebiederm@xmission.com>,
 Ard Biesheuvel <ardb@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20241205153343.3275139-12-dwmw2@infradead.org>
References: <20241205153343.3275139-12-dwmw2@infradead.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173348020432.412.4181302913869370440.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/boot branch of tip:

Commit-ID:     b7155dfd4999211247cce40be2665c71235ab094
Gitweb:        https://git.kernel.org/tip/b7155dfd4999211247cce40be2665c71235ab094
Author:        David Woodhouse <dwmw@amazon.co.uk>
AuthorDate:    Thu, 05 Dec 2024 15:05:17 
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 06 Dec 2024 10:42:00 +01:00

x86/kexec: Eliminate writes through kernel mapping of relocate_kernel page

All writes to the relocate_kernel control page are now done *after* the
%cr3 switch via simple %rip-relative addressing, which means the DATA()
macro with its pointer arithmetic can also now be removed.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Baoquan He <bhe@redhat.com>
Cc: Vivek Goyal <vgoyal@redhat.com>
Cc: Dave Young <dyoung@redhat.com>
Cc: Eric Biederman <ebiederm@xmission.com>
Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Link: https://lore.kernel.org/r/20241205153343.3275139-12-dwmw2@infradead.org
---
 arch/x86/kernel/relocate_kernel_64.S | 29 +++++++++++++--------------
 1 file changed, 14 insertions(+), 15 deletions(-)

diff --git a/arch/x86/kernel/relocate_kernel_64.S b/arch/x86/kernel/relocate_kernel_64.S
index d52c3bb..739041c 100644
--- a/arch/x86/kernel/relocate_kernel_64.S
+++ b/arch/x86/kernel/relocate_kernel_64.S
@@ -61,21 +61,24 @@ SYM_CODE_START_NOALIGN(relocate_kernel)
 	pushq %r15
 	pushf
 
-	movq	%rsp, saved_rsp(%rip)
-	movq	%cr0, %rax
-	movq	%rax, saved_cr0(%rip)
-	movq	%cr3, %rax
-	movq	%rax, saved_cr3(%rip)
-	movq	%cr4, %rax
-	movq	%rax, saved_cr4(%rip)
-
-	/* Save CR4. Required to enable the right paging mode later. */
-	movq	%rax, %r13
-
 	/* zero out flags, and disable interrupts */
 	pushq $0
 	popfq
 
+	/* Switch to the identity mapped page tables */
+	movq	%cr3, %rax
+	movq	kexec_pa_table_page(%rip), %r9
+	movq	%r9, %cr3
+
+	/* Save %rsp and CRs. */
+	movq    %rsp, saved_rsp(%rip)
+	movq	%rax, saved_cr3(%rip)
+	movq	%cr0, %rax
+	movq	%rax, saved_cr0(%rip)
+	/* Leave CR4 in %r13 to enable the right paging mode later. */
+	movq	%cr4, %r13
+	movq	%r13, saved_cr4(%rip)
+
 	/* Save SME active flag */
 	movq	%r8, %r12
 
@@ -85,10 +88,6 @@ SYM_CODE_START_NOALIGN(relocate_kernel)
 	/* Save the preserve_context to %r11 as swap_pages clobbers %rcx. */
 	movq	%rcx, %r11
 
-	/* Switch to the identity mapped page tables */
-	movq	kexec_pa_table_page(%rip), %r9
-	movq	%r9, %cr3
-
 	/* Physical address of control page */
 	movq    %rsi, %r8
 

