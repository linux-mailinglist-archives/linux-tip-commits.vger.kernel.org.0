Return-Path: <linux-tip-commits+bounces-1463-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F4FB90D4BD
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Jun 2024 16:25:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F322428B405
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Jun 2024 14:25:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7E541AAE13;
	Tue, 18 Jun 2024 14:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DxLAcUP2";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4v3+rZd9"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8199E1A4F0E;
	Tue, 18 Jun 2024 14:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718719318; cv=none; b=lXAAZsn1KNFhdiTpyA6vKMEh431iuH48kMa8e8TjfZ+DsNq8goPfQQskwZz5BkncLnSAp2/L785SWYyiAQEd/9rWNgjhYkFjgwcFDoW36N04erJBysGiXdt453/B0WNi1VTmNZzJUg9H3K7GOBQHEUuHdj+oI1i1gKA7AjuskaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718719318; c=relaxed/simple;
	bh=sl5OYPZZLfbifOaG2fkT/uA6NLYTrseI0Q15YXuQgWc=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=q/QhEZtu5ar5Vn+sx7sQYEXlF5LIIDcwb0pezTjpGByc2ckLhwbXE7IoWNz10snYsoN3lW9yquvar6qm3aJubCGZctJSvu/WeQi4Uqmr3EnzLzSCN3lg/7s49jugh10YbIpObLOVZKAwrp9dX5PdoyWeFyo3l88kGAz2oCRDUmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DxLAcUP2; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4v3+rZd9; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 18 Jun 2024 14:01:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1718719304;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=XP/7gr87fUPU3qMCuWI4fIwjmhgA699HrF0zjXpbJ0E=;
	b=DxLAcUP2AaBgZRc/A4rF29dNB2YVcv25A3wh4L3QfQHeGpS+R5zaG3Qiy4RaBorbwLTGoJ
	vIG+P5y8VWDS+GHse1Y1x4XwX+xMrauPZ8Zv39GPIiK+WN27jTl1wiMdQcMsxSW7Stf0eu
	CZWNJkP/clz6gi3j/RcpQ+HljpWZ8SHBNfKkQ+NWqDk50MUsSAyQJV7v+VMJRjxT28zAhT
	86vdNvi+9AyCvtLZ5Q2jVau8ydaBSwHPoooAJs3ow+Zf12Doyvb7K2ag3RFdX22uaiK2ic
	82XOL+4y3Z225/iV1YfKlBkY/6NEDAnLlVZpnlDTUgCUBJQbMj8pA2bYD4/N9Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1718719304;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=XP/7gr87fUPU3qMCuWI4fIwjmhgA699HrF0zjXpbJ0E=;
	b=4v3+rZd9+Jy5ZfkeCiI1jrew/8ZxOvKU/NnOobPxrktA+V0l/nEFgDYhPvfWvuOUMclSb/
	b81w2wvyrVGSz7Bg==
From: "tip-bot2 for Nikolay Borisov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cc] x86/kexec: Remove spurious unconditional JMP from from
 identity_mapped()
Cc: Nikolay Borisov <nik.borisov@suse.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171871930432.10875.16268210467052883074.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cc branch of tip:

Commit-ID:     54183d103d38e5efefce8500ec41dfbfaba9c19d
Gitweb:        https://git.kernel.org/tip/54183d103d38e5efefce8500ec41dfbfaba9c19d
Author:        Nikolay Borisov <nik.borisov@suse.com>
AuthorDate:    Wed, 29 May 2024 18:28:50 +03:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 17 Jun 2024 17:45:19 +02:00

x86/kexec: Remove spurious unconditional JMP from from identity_mapped()

This seemingly straightforward JMP was introduced in the initial version
of the the 64bit kexec code without any explanation.

It turns out (check accompanying Link) it's likely a copy/paste artefact
from 32-bit code, where such a JMP could be used as a serializing
instruction for the 486's prefetch queue. On x86_64 that's not needed
because there's already a preceding write to cr4 which itself is
a serializing operation.

  [ bp: Typos. Let's try this and see what cries out. If it does,
    reverting it is trivial. ]

Signed-off-by: Nikolay Borisov <nik.borisov@suse.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/all/55bc0649-c017-49ab-905d-212f140a403f@citrix.com/
---
 arch/x86/kernel/relocate_kernel_64.S | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/x86/kernel/relocate_kernel_64.S b/arch/x86/kernel/relocate_kernel_64.S
index 56cab1b..54e6200 100644
--- a/arch/x86/kernel/relocate_kernel_64.S
+++ b/arch/x86/kernel/relocate_kernel_64.S
@@ -153,9 +153,6 @@ SYM_CODE_START_LOCAL_NOALIGN(identity_mapped)
 1:
 	movq	%rax, %cr4
 
-	jmp 1f
-1:
-
 	/* Flush the TLB (needed?) */
 	movq	%r9, %cr3
 

