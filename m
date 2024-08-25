Return-Path: <linux-tip-commits+bounces-2105-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 34F3B95E353
	for <lists+linux-tip-commits@lfdr.de>; Sun, 25 Aug 2024 14:37:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D20FA1F217AB
	for <lists+linux-tip-commits@lfdr.de>; Sun, 25 Aug 2024 12:37:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04EA6149C6F;
	Sun, 25 Aug 2024 12:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ydTlu/WH";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="InVCwpG5"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71E112B9D4;
	Sun, 25 Aug 2024 12:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724589434; cv=none; b=nTEbJfaayECDBthoIsguJmBGndDZ8kGIX6B+Riw/DgV0rInm/3IID/egUKGofVjemOvsyM+QyRiRfuYMxIhbgvBkmgZnzG6Bs5Xz9pJQ8vtQLkdDiUk/5KkM9FgwjLicR9hhbxWn6IsG9TAjLNsX0rBoe5BtZTU1GcdfFsE8XSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724589434; c=relaxed/simple;
	bh=WX2f8+5hcQSaVgHVYSDIxjUmHaKxg3OtFY2XqAyT6dU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=h19GQHIPGcyb3EbHaNkLJKO6IjFYg8zpXL2IoX5dIDPVihu55sIpej2aw5P7oDS1gXsoEDbauEsB9M/E4mE2AJX1vk8GJC1Vccql9ioLGfrvtWPoixiTSH/d2Guv/8RS2FF0+F70dOz6rqyLQGr68AIRC8MHJ02xo3RkQBljniU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ydTlu/WH; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=InVCwpG5; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sun, 25 Aug 2024 12:37:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1724589432;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qyfiPcAgpPHGvCoeXi9U2h4cwrLb6cB2aYJT+j27WuM=;
	b=ydTlu/WHlRzoOfseiFNW0S08matkr6Zsdz7EQaa2bzmaKsgQv3PIAInBT/0L70Ibh+5ITf
	S7os2+qgi0oRwGQ3zL+qQJrxwDstrUIDV8H4hTIxrotiyPyEX3pTwEPaH2jvuCRwJb8UZ+
	RX03g86VvQaNhjqWu1RTL7HGXcyD2zb9TKrwk74skt4shbEcaOyZ6gcEkf3MbdBwUkFGiE
	JZ55I75GSIbYcr23L8KbPLNYIGT0Po2VjtA90CUojliLmhz7gn6jHduS249+9YTOg+CdKe
	kwVlzkx+P07mzvlk4r+vAjHRitobmPCh31yjRmtMQUM2OacDETsNkN6yV7Y5QA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1724589432;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qyfiPcAgpPHGvCoeXi9U2h4cwrLb6cB2aYJT+j27WuM=;
	b=InVCwpG5ME1Psp/WjHivyrxPgcSE3IgepUDc5VOf07PjFqh/f7QgjYIZMPrBaoZyMerIoA
	GUJoTHi+Ks8nZLDQ==
From: "tip-bot2 for Kai Huang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] x86/kexec: Fix a comment of swap_pages() assembly
Cc: Kai Huang <kai.huang@intel.com>, Thomas Gleixner <tglx@linutronix.de>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To:
 <adafdfb1421c88efce04420fc9a996c0e2ca1b34.1724573384.git.kai.huang@intel.com>
References:
 <adafdfb1421c88efce04420fc9a996c0e2ca1b34.1724573384.git.kai.huang@intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172458943155.2215.14451665523819413189.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cleanups branch of tip:

Commit-ID:     3c41ad39f179c0e41f585975eb6834cd14f286ec
Gitweb:        https://git.kernel.org/tip/3c41ad39f179c0e41f585975eb6834cd14f286ec
Author:        Kai Huang <kai.huang@intel.com>
AuthorDate:    Sun, 25 Aug 2024 20:18:05 +12:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sun, 25 Aug 2024 14:29:39 +02:00

x86/kexec: Fix a comment of swap_pages() assembly

When relocate_kernel() gets called, %rdi holds 'indirection_page' and
%rsi holds 'page_list'.  And %rdi always holds 'indirection_page' when
swap_pages() is called.

Therefore the comment of the first line code of swap_pages()

	movq    %rdi, %rcx      /* Put the page_list in %rcx */

.. isn't correct because it actually moves the 'indirection_page' to
the %rcx.  Fix it.

Signed-off-by: Kai Huang <kai.huang@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Link: https://lore.kernel.org/all/adafdfb1421c88efce04420fc9a996c0e2ca1b34.1724573384.git.kai.huang@intel.com

---
 arch/x86/kernel/relocate_kernel_64.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/relocate_kernel_64.S b/arch/x86/kernel/relocate_kernel_64.S
index 042c9a0..f7a3ca3 100644
--- a/arch/x86/kernel/relocate_kernel_64.S
+++ b/arch/x86/kernel/relocate_kernel_64.S
@@ -258,7 +258,7 @@ SYM_CODE_END(virtual_mapped)
 	/* Do the copies */
 SYM_CODE_START_LOCAL_NOALIGN(swap_pages)
 	UNWIND_HINT_END_OF_STACK
-	movq	%rdi, %rcx	/* Put the page_list in %rcx */
+	movq	%rdi, %rcx	/* Put the indirection_page in %rcx */
 	xorl	%edi, %edi
 	xorl	%esi, %esi
 	jmp	1f

