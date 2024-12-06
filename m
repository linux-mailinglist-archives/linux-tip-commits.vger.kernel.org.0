Return-Path: <linux-tip-commits+bounces-3006-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A31699E6BE7
	for <lists+linux-tip-commits@lfdr.de>; Fri,  6 Dec 2024 11:21:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1894116DE00
	for <lists+linux-tip-commits@lfdr.de>; Fri,  6 Dec 2024 10:20:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF65120764D;
	Fri,  6 Dec 2024 10:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HXGVGG0u";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dw6qCh/n"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46CB72010EF;
	Fri,  6 Dec 2024 10:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733480215; cv=none; b=Iug1RIUszf3yxVvV089+sJ3Nd5n0B9E9iXctqpXo3TXc9AafkGjeSP/73xJrAc17YguWLAAiQI9wUeTC6XbQDokukIW8fByeZgPTtJ3mvWbWqFlpr+MsOP7Sc5jVS/ge0OARu7cQCo/DDWZXk8BFAeDUjTmPAhz9KQm70yuG0zM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733480215; c=relaxed/simple;
	bh=49LyckHvDdAyVGInF+zpvfrM4StYmmjCKjVXqdgdmCA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=sQ8nDTNwKophqxnwb6p24MJZaDLP+BituR0G4oy3B24RhL3KnsvTVy/ch2HHIz3ceAq3id3VuQVnf8A3FrbzGR1JK3KlO466zGRH9XA8RXhu7uA1F6TOJby8crpcGCsZOU9tRqXDofcRn+IJ5ExhYYMm7JwmFd+38dNHK1Xjx5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HXGVGG0u; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dw6qCh/n; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 06 Dec 2024 10:16:50 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1733480211;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DtCSB3rJu40bNV7IDvky63y/dY30ttY3Eiy45rwyqtQ=;
	b=HXGVGG0u0w8DiNqoLhGnIaJ7rPhRgf22MuHos8cZm14v5Kyx29KCgMUQmDdcYTE5WevPPA
	sv3xOX954uAuomgzlk6sb2cx3/i2dF+aVEQGSM4LdRzV7vsxO1G/gW0VrbrBaoulrs3YcX
	d/Y+7jOKR0t3EaIgr+5TG54JABboiiHzqApKlpdXEnbsKKH+J3ax+3PhdNd7XpEhiNtB81
	ypkLVJpakfatYNZ15n5OT3bdg2i+QMYSTH8Xu7tOhTNAGQSBJjyF+jkR4vAVePxqB+sm6+
	h6zaicHOWBf/m5su+itwupjiNCGwKPvbzR33UzINBOoAV5Q7XylekBunkK8vjg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1733480211;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DtCSB3rJu40bNV7IDvky63y/dY30ttY3Eiy45rwyqtQ=;
	b=dw6qCh/n4gJMozGMcPnkG1cWOArhxmQfgP+wUJXIgvxCnxACrmVi8OZkFNFp9dFteGdqNy
	V8DtkqCCL2IzSPCA==
From: "tip-bot2 for David Woodhouse" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/boot] x86/kexec: Use named labels in swap_pages in
 relocate_kernel_64.S
Cc: David Woodhouse <dwmw@amazon.co.uk>, Ingo Molnar <mingo@kernel.org>,
 Kai Huang <kai.huang@intel.com>, Baoquan He <bhe@redhat.com>,
 Vivek Goyal <vgoyal@redhat.com>, Dave Young <dyoung@redhat.com>,
 Eric Biederman <ebiederm@xmission.com>, Ard Biesheuvel <ardb@kernel.org>,
 "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20241205153343.3275139-4-dwmw2@infradead.org>
References: <20241205153343.3275139-4-dwmw2@infradead.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173348021054.412.14617518518711547449.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/boot branch of tip:

Commit-ID:     46d4e205e22c89841552b05663d34e57e9a66611
Gitweb:        https://git.kernel.org/tip/46d4e205e22c89841552b05663d34e57e9a66611
Author:        David Woodhouse <dwmw@amazon.co.uk>
AuthorDate:    Thu, 05 Dec 2024 15:05:09 
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 06 Dec 2024 10:41:58 +01:00

x86/kexec: Use named labels in swap_pages in relocate_kernel_64.S

Make the code a little more readable.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Kai Huang <kai.huang@intel.com>
Cc: Baoquan He <bhe@redhat.com>
Cc: Vivek Goyal <vgoyal@redhat.com>
Cc: Dave Young <dyoung@redhat.com>
Cc: Eric Biederman <ebiederm@xmission.com>
Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Link: https://lore.kernel.org/r/20241205153343.3275139-4-dwmw2@infradead.org
---
 arch/x86/kernel/relocate_kernel_64.S | 30 +++++++++++++--------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/arch/x86/kernel/relocate_kernel_64.S b/arch/x86/kernel/relocate_kernel_64.S
index 92478e2..fea650f 100644
--- a/arch/x86/kernel/relocate_kernel_64.S
+++ b/arch/x86/kernel/relocate_kernel_64.S
@@ -279,31 +279,31 @@ SYM_CODE_START_LOCAL_NOALIGN(swap_pages)
 	movq	%rdi, %rcx	/* Put the indirection_page in %rcx */
 	xorl	%edi, %edi
 	xorl	%esi, %esi
-	jmp	1f
+	jmp	.Lstart		/* Should start with an indirection record */
 
-0:	/* top, read another word for the indirection page */
+.Lloop:	/* top, read another word for the indirection page */
 
 	movq	(%rbx), %rcx
 	addq	$8,	%rbx
-1:
+.Lstart:
 	testb	$0x1,	%cl   /* is it a destination page? */
-	jz	2f
+	jz	.Lnotdest
 	movq	%rcx,	%rdi
 	andq	$0xfffffffffffff000, %rdi
-	jmp	0b
-2:
+	jmp	.Lloop
+.Lnotdest:
 	testb	$0x2,	%cl   /* is it an indirection page? */
-	jz	2f
+	jz	.Lnotind
 	movq	%rcx,   %rbx
 	andq	$0xfffffffffffff000, %rbx
-	jmp	0b
-2:
+	jmp	.Lloop
+.Lnotind:
 	testb	$0x4,	%cl   /* is it the done indicator? */
-	jz	2f
-	jmp	3f
-2:
+	jz	.Lnotdone
+	jmp	.Ldone
+.Lnotdone:
 	testb	$0x8,	%cl   /* is it the source indicator? */
-	jz	0b	      /* Ignore it otherwise */
+	jz	.Lloop	      /* Ignore it otherwise */
 	movq	%rcx,   %rsi  /* For ever source page do a copy */
 	andq	$0xfffffffffffff000, %rsi
 
@@ -328,8 +328,8 @@ SYM_CODE_START_LOCAL_NOALIGN(swap_pages)
 	rep ; movsq
 
 	lea	PAGE_SIZE(%rax), %rsi
-	jmp	0b
-3:
+	jmp	.Lloop
+.Ldone:
 	ANNOTATE_UNRET_SAFE
 	ret
 	int3

