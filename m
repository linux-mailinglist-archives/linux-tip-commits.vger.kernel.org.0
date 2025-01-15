Return-Path: <linux-tip-commits+bounces-3240-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D9334A11D5A
	for <lists+linux-tip-commits@lfdr.de>; Wed, 15 Jan 2025 10:21:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20FDB1887335
	for <lists+linux-tip-commits@lfdr.de>; Wed, 15 Jan 2025 09:21:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4280F244FAD;
	Wed, 15 Jan 2025 09:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xcoK/F8B";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="R0IIfa11"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AF63284A72;
	Wed, 15 Jan 2025 09:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736932678; cv=none; b=XF6ngoyq1/RaHWJe2A3esa9hn+y6G3GX87LZbAugF/92QunWIdGD/3FSr9SSSZwod6/wAxtrSdHPp8mbZcfXU92Xm9UTfQ9TArn+JcZMx1e4hySHFcwf387WvRSMsNaRIBA/ikzW281aa9Z6h5O9yUZqfD/oStZltKHTdeIqrks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736932678; c=relaxed/simple;
	bh=tnu7BX6WmsnaavhUcZxQVRPHmR38Ek9l+G3DJ2dclZg=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=SZs+VlqRGeIbZVi38t3bxafp/foOMK1Rin+oBvw7Uq7P0bR4fshpo3hygfLwtzKPYtfpZWRTUBckko7o1+DUgkNW9t61qGyV6PTgZVL5gZ5kIU3Jq2bfDVoYtwXpvgzy4ysfrnIU+jacG7i3VVlGa+64tJPyf2K/TIokbg0SkOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xcoK/F8B; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=R0IIfa11; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 15 Jan 2025 09:17:54 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1736932674;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l2QfyIzTEEqieyBzTT4IdcaTitEFIr3Pdr9vIDkYeOY=;
	b=xcoK/F8Bxf/2VOKLoqBKm6EilscNrkWs+qiHYbrx5+mTAyMRrfKDitAaPYMNIEZzYsAQG4
	+chk1ALIxKKU2hBxK2A3c6/CGx1zdGyaqnrW8nmWSFZGdJmG7r1a/QSiFErtVVItkDklg6
	2mkL//uOTb2Z7ZI+j2eCjL3jOZk6LNEGk+jx7MXrrgnmV4qclIQX6UwdxvtfcoXHveTSxN
	fYEXxUcYV7MorFu4nZM2kWo+9ca8Yj3lDwLvtKpyPHcwYPJxyOp1W5Z+U5BfHgz99i63D3
	lraJZUdDww96faYKLca5Crfjj2sjy1vEQPCocqsu9uOfGWeiGNdWNWerHQImXg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1736932674;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l2QfyIzTEEqieyBzTT4IdcaTitEFIr3Pdr9vIDkYeOY=;
	b=R0IIfa11erCEHElY8w/zlWgaq4I4DJZt6e1g3x/y9T4obfW/Nkd7zAirsYG25oABlEu0id
	SLNvQyVq25IQW8DA==
From: "tip-bot2 for David Woodhouse" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/boot] x86/kexec: Disable global pages before writing to
 control page
Cc: Nathan Chancellor <nathan@kernel.org>,
 "Ning, Hongyu" <hongyu.ning@linux.intel.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 David Woodhouse <dwmw@amazon.co.uk>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250109140757.2841269-2-dwmw2@infradead.org>
References: <20250109140757.2841269-2-dwmw2@infradead.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173693267429.31546.3478834571587592913.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/boot branch of tip:

Commit-ID:     d144d8a65286fb4a9f06ca80dea6e02e7d846558
Gitweb:        https://git.kernel.org/tip/d144d8a65286fb4a9f06ca80dea6e02e7d8=
46558
Author:        David Woodhouse <dwmw@amazon.co.uk>
AuthorDate:    Thu, 09 Jan 2025 14:04:13=20
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Tue, 14 Jan 2025 12:46:17 +01:00

x86/kexec: Disable global pages before writing to control page

The kernel switches to a new set of page tables during kexec. The global
mappings (_PAGE_GLOBAL=3D=3D1) can remain in the TLB after this switch. This
is generally not a problem because the new page tables use a different
portion of the virtual address space than the normal kernel mappings.

The critical exception to that generalisation (and the only mapping
which isn't an identity mapping) is the kexec control page itself =E2=80=94
which was ROX in the original kernel mapping, but should be RWX in the
new page tables. If there is a global TLB entry for that in its prior
read-only state, it definitely needs to be flushed before attempting to
write through that virtual mapping.

It would be possible to just avoid writing to the virtual address of the
page and defer all writes until they can be done through the identity
mapping. But there's no good reason to keep the old TLB entries around,
as they can cause nothing but trouble.

Clear the PGE bit in %cr4 early, before storing data in the control page.

Fixes: 5a82223e0743 ("x86/kexec: Mark relocate_kernel page as ROX instead of =
RWX")
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D219592
Reported-by: Nathan Chancellor <nathan@kernel.org>
Reported-by: "Ning, Hongyu" <hongyu.ning@linux.intel.com>
Co-developed-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Tested-by: Nathan Chancellor <nathan@kernel.org>
Tested-by: "Ning, Hongyu" <hongyu.ning@linux.intel.com>
Link: https://lore.kernel.org/r/20250109140757.2841269-2-dwmw2@infradead.org
---
 arch/x86/kernel/relocate_kernel_64.S | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/relocate_kernel_64.S b/arch/x86/kernel/relocate_=
kernel_64.S
index 8bc86a1..9bd601d 100644
--- a/arch/x86/kernel/relocate_kernel_64.S
+++ b/arch/x86/kernel/relocate_kernel_64.S
@@ -70,14 +70,20 @@ SYM_CODE_START_NOALIGN(relocate_kernel)
 	movq	kexec_pa_table_page(%rip), %r9
 	movq	%r9, %cr3
=20
+	/* Leave CR4 in %r13 to enable the right paging mode later. */
+	movq	%cr4, %r13
+
+	/* Disable global pages immediately to ensure this mapping is RWX */
+	movq	%r13, %r12
+	andq	$~(X86_CR4_PGE), %r12
+	movq	%r12, %cr4
+
 	/* Save %rsp and CRs. */
+	movq	%r13, saved_cr4(%rip)
 	movq    %rsp, saved_rsp(%rip)
 	movq	%rax, saved_cr3(%rip)
 	movq	%cr0, %rax
 	movq	%rax, saved_cr0(%rip)
-	/* Leave CR4 in %r13 to enable the right paging mode later. */
-	movq	%cr4, %r13
-	movq	%r13, saved_cr4(%rip)
=20
 	/* save indirection list for jumping back */
 	movq	%rdi, pa_backup_pages_map(%rip)

