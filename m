Return-Path: <linux-tip-commits+bounces-2104-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5462C95E354
	for <lists+linux-tip-commits@lfdr.de>; Sun, 25 Aug 2024 14:37:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7CAE0B20EF4
	for <lists+linux-tip-commits@lfdr.de>; Sun, 25 Aug 2024 12:37:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF0DB13D28F;
	Sun, 25 Aug 2024 12:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ISiw/ai2";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="K+AaNoiV"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 261362562E;
	Sun, 25 Aug 2024 12:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724589434; cv=none; b=V4oC0wlXzS87H+JtxUN8dML5AGbL5In0+gRua8scBnBh9lDZge6JbVYUyn84644aAYjRfhWKyZokZNJrJXY84sbRLAIk40Mb5SUxDaTydtFHBvsRPCgE0USkKyZBZzyoVWvwvOrNhP09IMvnKto4x8d5LlhgW9YRY/vXydkLF8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724589434; c=relaxed/simple;
	bh=CIby5V+SzHmuyaJsGS4yX2xVjVOrs47436/5dAzW6fo=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=asf514/qtR7BoJCvOBNhAZ7CF7hxPdisjX+ahbGzET7JBUdSWgy85OWHxWJL/5csaTgbfg9PntAn+6lC+exfX7fUwqNVh3HisxCulwy/U+Q22FSNQ9e9YYjoQf6ykcWLm+bjdDskR6vO3aqUKPcK+fLv9ZoHBueW4RLImCAbeZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ISiw/ai2; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=K+AaNoiV; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sun, 25 Aug 2024 12:37:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1724589431;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=owHmetSXgsuFgE+rJ6yxDIDhVkGvA9l8wINBe8MMuiU=;
	b=ISiw/ai2xmz3LCCMmjKm9EIivSdm+AoJgMryewYcOd1of9nB5jpZwkMpAwis3DgUnTiX9C
	7mei7O2UqtyFMj53gn7KAV9GYUnelIP+rjuN41C7b/ORiEltTzx8yCyJbLVSWRTx8QWywX
	ksxAkcnh8ZT9z31ug5I5itCuJ3m6DM/GWp5KVJngdXpsIZnvpiBtnUFG6rle3OpVIoXTdr
	VQgZFHbRAYGBf335j/zKSZqWwgCgfuaafifJGhbwhvGTqll+KRIP5zxus3oLFlHDPVzhBg
	Y40RTWEyA6T+0N/b2irqE2RUZ+DYxJhLW4LvLbE9kxAH7SN8fFwW+v2OhsE21g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1724589431;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=owHmetSXgsuFgE+rJ6yxDIDhVkGvA9l8wINBe8MMuiU=;
	b=K+AaNoiVd0T98sN/WtTE+cj8npNba2Go0oiHFvhr4PieFmY/60iCIKYfTllW989Jc3G3l6
	4yyKB4pPrepO1OCA==
From: "tip-bot2 for Kai Huang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] x86/kexec: Add comments around swap_pages()
 assembly to improve readability
Cc: Kai Huang <kai.huang@intel.com>, Thomas Gleixner <tglx@linutronix.de>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To:
 <8b52b0b8513a34b2a02fb4abb05c6700c2821475.1724573384.git.kai.huang@intel.com>
References:
 <8b52b0b8513a34b2a02fb4abb05c6700c2821475.1724573384.git.kai.huang@intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172458943113.2215.12518487594417401349.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cleanups branch of tip:

Commit-ID:     ea49cdb26e7cffc261ceb1db26707e6d337fa104
Gitweb:        https://git.kernel.org/tip/ea49cdb26e7cffc261ceb1db26707e6d337fa104
Author:        Kai Huang <kai.huang@intel.com>
AuthorDate:    Sun, 25 Aug 2024 20:18:06 +12:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sun, 25 Aug 2024 14:29:39 +02:00

x86/kexec: Add comments around swap_pages() assembly to improve readability

The current assembly around swap_pages() in the relocate_kernel() takes
some time to follow because the use of registers can be easily lost when
the line of assembly goes long.  Add a couple of comments to clarify the
code around swap_pages() to improve readability.

Signed-off-by: Kai Huang <kai.huang@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Link: https://lore.kernel.org/all/8b52b0b8513a34b2a02fb4abb05c6700c2821475.1724573384.git.kai.huang@intel.com

---
 arch/x86/kernel/relocate_kernel_64.S | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/relocate_kernel_64.S b/arch/x86/kernel/relocate_kernel_64.S
index f7a3ca3..e9e88c3 100644
--- a/arch/x86/kernel/relocate_kernel_64.S
+++ b/arch/x86/kernel/relocate_kernel_64.S
@@ -170,6 +170,7 @@ SYM_CODE_START_LOCAL_NOALIGN(identity_mapped)
 	wbinvd
 .Lsme_off:
 
+	/* Save the preserve_context to %r11 as swap_pages clobbers %rcx. */
 	movq	%rcx, %r11
 	call	swap_pages
 
@@ -289,18 +290,21 @@ SYM_CODE_START_LOCAL_NOALIGN(swap_pages)
 	movq	%rcx,   %rsi  /* For ever source page do a copy */
 	andq	$0xfffffffffffff000, %rsi
 
-	movq	%rdi, %rdx
-	movq	%rsi, %rax
+	movq	%rdi, %rdx    /* Save destination page to %rdx */
+	movq	%rsi, %rax    /* Save source page to %rax */
 
+	/* copy source page to swap page */
 	movq	%r10, %rdi
 	movl	$512, %ecx
 	rep ; movsq
 
+	/* copy destination page to source page */
 	movq	%rax, %rdi
 	movq	%rdx, %rsi
 	movl	$512, %ecx
 	rep ; movsq
 
+	/* copy swap page to destination page */
 	movq	%rdx, %rdi
 	movq	%r10, %rsi
 	movl	$512, %ecx

