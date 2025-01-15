Return-Path: <linux-tip-commits+bounces-3238-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 32DEDA11D68
	for <lists+linux-tip-commits@lfdr.de>; Wed, 15 Jan 2025 10:22:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3498A3A5EF8
	for <lists+linux-tip-commits@lfdr.de>; Wed, 15 Jan 2025 09:21:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94F56244FA3;
	Wed, 15 Jan 2025 09:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XaAUfZZ8";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YOT5onO3"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E41A243359;
	Wed, 15 Jan 2025 09:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736932677; cv=none; b=ARmx6vnwIUqvzTyl9t/euIv9R9y6lMyE1V5zR6LFKnUKI9jl45RgGE4JTygqT/UP88rkgktifNjSgp4j30CdItQirlUx5+7GHjpXRVYP0oNTjdtYriSGKdArzKtU7FvU7A0+fDXrRcZ7Zy4LNszAOb+jKLf+FTcRcA2utnyM4Ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736932677; c=relaxed/simple;
	bh=tQgadanVFvTyuJozn7eXDByfen9eYzhx//rLskaEPd8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Y1Vwri33+uhJONyISZWjRpcwdtbH1jPqOGTohDApkvODksXJZW7ePJp5+VaHIZ3q95uo42VgSxIlr//gpduxB+32NxM7NRkjhc6NYFl0HSUmyLz2relQiFIRLfB7plK0sfaBAgopgdscYxyMsinUiPXNB28yu8Rg5ZY6AIn1WBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XaAUfZZ8; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YOT5onO3; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 15 Jan 2025 09:17:52 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1736932673;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AM7nfEkYE9DkJg6JMLQY7GzAcX24f0nsWymRdtvncbA=;
	b=XaAUfZZ8VwJlasEecJsB4M+9pfHzX2KdllWw++fGqsRaIlG11EK3OMnzfiQWCEO86csG20
	jtkMdZ5C6w976H+qWlUmu5/pRMiX9MWPRMv++i+oefxJkuJp7UegCPkPdzGHJzXbnDQzpD
	zjhH7RZi2mjAsI3cdTzFSWCsQY6qh0vVTyyN1Fivb1K5R8gCRtpL8M/NwZraB9PWlPSuG0
	0Or52nUAbrWhbZNiFtpPHLFvAC6eHxfUghJz9Fn4VUClip3i4eA5p6TmP816YLuuYbLLo+
	0kip+S4nX6I1OnNw4a0I2V6kedzuV+87SUj5JVMyypnf6MGFRLVM/u+PlRy4RQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1736932673;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AM7nfEkYE9DkJg6JMLQY7GzAcX24f0nsWymRdtvncbA=;
	b=YOT5onO3uZuVaoaNo8r1h0Zv2hYRIhci6kU4LOqt9oThf4RJjaAcyQkOLTJ+HYf0BlBVch
	2N1reXKAVff4QRBA==
From: "tip-bot2 for Nathan Chancellor" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/boot] x86/kexec: Fix location of relocate_kernel with
 -ffunction-sections
Cc: Nathan Chancellor <nathan@kernel.org>, David Woodhouse <dwmw@amazon.co.uk>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250109140757.2841269-6-dwmw2@infradead.org>
References: <20250109140757.2841269-6-dwmw2@infradead.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173693267258.31546.13330052848248237371.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/boot branch of tip:

Commit-ID:     eeed9150411a63dd0611490cf31fdae681427918
Gitweb:        https://git.kernel.org/tip/eeed9150411a63dd0611490cf31fdae681427918
Author:        Nathan Chancellor <nathan@kernel.org>
AuthorDate:    Thu, 09 Jan 2025 14:04:17 
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Tue, 14 Jan 2025 13:00:18 +01:00

x86/kexec: Fix location of relocate_kernel with -ffunction-sections

After commit

  cb33ff9e063c ("x86/kexec: Move relocate_kernel to kernel .data section"),

kernels configured with an option that uses -ffunction-sections, such as
CONFIG_LTO_CLANG, crash when kexecing because the value of relocate_kernel
does not match the value of __relocate_kernel_start so incorrect code gets
copied via machine_kexec_prepare().

  $ llvm-nm good-vmlinux &| rg relocate_kernel
  ffffffff83280d41 T __relocate_kernel_end
  ffffffff83280b00 T __relocate_kernel_start
  ffffffff83280b00 T relocate_kernel

  $ llvm-nm bad-vmlinux &| rg relocate_kernel
  ffffffff83266100 D __relocate_kernel_end
  ffffffff83266100 D __relocate_kernel_start
  ffffffff8120b0d8 T relocate_kernel

When -ffunction-sections is enabled, TEXT_MAIN matches on
'.text.[0-9a-zA-Z_]*' to coalesce the function specific functions back
into .text during link time after they have been optimized. Due to the
placement of TEXT_TEXT before KEXEC_RELOCATE_KERNEL in the x86 linker
script, the .text.relocate_kernel section ends up in .text instead of
.data.

Use a second dot in the relocate_kernel section name to avoid matching
on TEXT_MAIN, which matches a similar situation that happened in
commit

  79cd2a11224e ("x86/retpoline,kprobes: Fix position of thunk sections with CONFIG_LTO_CLANG"),

which allows kexec to function properly.

While .data.relocate_kernel still ends up in the .data section via
DATA_MAIN -> DATA_DATA, ensure it is located with the
.text.relocate_kernel section as intended by performing the same
transformation.

Fixes: cb33ff9e063c ("x86/kexec: Move relocate_kernel to kernel .data section")
Fixes: 8dbec5c77bc3 ("x86/kexec: Add data section to relocate_kernel")
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20250109140757.2841269-6-dwmw2@infradead.org
---
 arch/x86/kernel/relocate_kernel_64.S | 6 +++---
 arch/x86/kernel/vmlinux.lds.S        | 4 ++--
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/relocate_kernel_64.S b/arch/x86/kernel/relocate_kernel_64.S
index a95691b..14ed40b 100644
--- a/arch/x86/kernel/relocate_kernel_64.S
+++ b/arch/x86/kernel/relocate_kernel_64.S
@@ -23,11 +23,11 @@
 #define PAGE_ATTR (_PAGE_PRESENT | _PAGE_RW | _PAGE_ACCESSED | _PAGE_DIRTY)
 
 /*
- * The .text.relocate_kernel and .data.relocate_kernel sections are copied
+ * The .text..relocate_kernel and .data..relocate_kernel sections are copied
  * into the control page, and the remainder of the page is used as the stack.
  */
 
-	.section .data.relocate_kernel,"a";
+	.section .data..relocate_kernel,"a";
 /* Minimal CPU state */
 SYM_DATA_LOCAL(saved_rsp, .quad 0)
 SYM_DATA_LOCAL(saved_cr0, .quad 0)
@@ -39,7 +39,7 @@ SYM_DATA(kexec_pa_table_page, .quad 0)
 SYM_DATA(kexec_pa_swap_page, .quad 0)
 SYM_DATA_LOCAL(pa_backup_pages_map, .quad 0)
 
-	.section .text.relocate_kernel,"ax";
+	.section .text..relocate_kernel,"ax";
 	.code64
 SYM_CODE_START_NOALIGN(relocate_kernel)
 	UNWIND_HINT_END_OF_STACK
diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index 0c89399..63ff60a 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -100,8 +100,8 @@ const_pcpu_hot = pcpu_hot;
 #define KEXEC_RELOCATE_KERNEL					\
 	. = ALIGN(0x100);					\
 	__relocate_kernel_start = .;				\
-	*(.text.relocate_kernel);				\
-	*(.data.relocate_kernel);				\
+	*(.text..relocate_kernel);				\
+	*(.data..relocate_kernel);				\
 	__relocate_kernel_end = .;
 
 ASSERT(__relocate_kernel_end - __relocate_kernel_start <= KEXEC_CONTROL_CODE_MAX_SIZE,

