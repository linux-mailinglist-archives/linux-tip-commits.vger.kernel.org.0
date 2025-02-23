Return-Path: <linux-tip-commits+bounces-3606-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B3F13A410E0
	for <lists+linux-tip-commits@lfdr.de>; Sun, 23 Feb 2025 19:30:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B3D63B7171
	for <lists+linux-tip-commits@lfdr.de>; Sun, 23 Feb 2025 18:29:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B4A218E362;
	Sun, 23 Feb 2025 18:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vvAmEQ8w";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Tz+B0qKa"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ECF21925AB;
	Sun, 23 Feb 2025 18:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740335338; cv=none; b=OyCzNV61mkZ5+pfLlTmb4OGIKwkXhtnLOwRXuaQwk/EV72bAwjkVa/b1eHC+6vvnOvJ5KA+ie/B93GLjqjvqllejqlvCphMkjGXszXSynfViGGo5IJPj/Wd1O28DnG51TjrpkDBQ7CzRPjT22OP+niI4WsSITK3lDRhELs/3ADo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740335338; c=relaxed/simple;
	bh=o5CG4d7TvlpoloPdAVGirVgQNhYBb0r+kCmyvzBwsHQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=DF6OXb4jcdKgV1weH7+JwHEbmmIra4kwSFiEVDLo+x7acj0yB6bisTkYfRhDi9NQXQQV48p4KpkfCeKjT+8S1htJ9aR+R3K9rNIJx4ujUGcM0vv8gSBS05sCsUKy6Ll+1ooQjf/6gdpyTbpKtI/XJf/JocG1sd5CChlhL3+AC8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vvAmEQ8w; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Tz+B0qKa; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sun, 23 Feb 2025 18:28:50 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740335334;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4D1EoePEGwz4CPzZV7w08dpOj5OOynMuIenk1yfdErk=;
	b=vvAmEQ8wb4GhMMdIpg04qRsuqSVrQ5eHRAFdkGRR1jXYbaZMYtcbcLEUW9P7hqTX2hl5g1
	Rfs76wm5CKOb/x0oTQXhTmcQgYnIJShrxq8fawe6+fW2WP1gmPrPO+9YK5LD0u+xhnFpbI
	L/y7X2OqbEDio0pkgyWpvtq2dy/jaRq5E3wgMH2yADbv1449Wq8FH82+WDgZQ1FZUlIdtW
	Y1iuSw+fghrbI4MWPkr9PKbRNOBdrjJBSNspXYbR01jiehdX7BTBiWfcTmVDFfaAIzGMVh
	5UPpTztPMaB9L6XvM7rCp5k1KTQKCM2Jz3G0npGAkcfSqhuCflrhVuGy79f13w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740335334;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4D1EoePEGwz4CPzZV7w08dpOj5OOynMuIenk1yfdErk=;
	b=Tz+B0qKaf5EUzGev8Pr8sByGxoNlunChY237RUSWM6HGhmvFst2j454NN0vodDY0l79RcW
	reHxhjnQqJIXAgCw==
From: "tip-bot2 for Uros Bizjak" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/asm] x86/ioperm: Use atomic64_inc_return() in ksys_ioperm()
Cc: Uros Bizjak <ubizjak@gmail.com>, Ingo Molnar <mingo@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250223161355.3607-1-ubizjak@gmail.com>
References: <20250223161355.3607-1-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174033533094.10177.10012973191295330448.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/asm branch of tip:

Commit-ID:     dc8bd769e70ecae0916bf1b05acad6120c6bd6f0
Gitweb:        https://git.kernel.org/tip/dc8bd769e70ecae0916bf1b05acad6120c6bd6f0
Author:        Uros Bizjak <ubizjak@gmail.com>
AuthorDate:    Sun, 23 Feb 2025 17:13:38 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sun, 23 Feb 2025 19:18:18 +01:00

x86/ioperm: Use atomic64_inc_return() in ksys_ioperm()

Use atomic64_inc_return(&ref) instead of atomic64_add_return(1, &ref)
to use optimized implementation on targets that define
atomic_inc_return() and to remove now unneeded initialization of the
%eax/%edx register pair before the call to atomic64_inc_return().

On x86_32 the code improves from:

 1b0:    b9 00 00 00 00           mov    $0x0,%ecx
            1b1: R_386_32    .bss
 1b5:    89 43 0c                 mov    %eax,0xc(%ebx)
 1b8:    31 d2                    xor    %edx,%edx
 1ba:    b8 01 00 00 00           mov    $0x1,%eax
 1bf:    e8 fc ff ff ff           call   1c0 <ksys_ioperm+0xa8>
            1c0: R_386_PC32    atomic64_add_return_cx8
 1c4:    89 03                    mov    %eax,(%ebx)
 1c6:    89 53 04                 mov    %edx,0x4(%ebx)

to:

 1b0:    be 00 00 00 00           mov    $0x0,%esi
            1b1: R_386_32    .bss
 1b5:    89 43 0c                 mov    %eax,0xc(%ebx)
 1b8:    e8 fc ff ff ff           call   1b9 <ksys_ioperm+0xa1>
            1b9: R_386_PC32    atomic64_inc_return_cx8
 1bd:    89 03                    mov    %eax,(%ebx)
 1bf:    89 53 04                 mov    %edx,0x4(%ebx)

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20250223161355.3607-1-ubizjak@gmail.com
---
 arch/x86/kernel/ioport.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/ioport.c b/arch/x86/kernel/ioport.c
index e2fab3c..6290dd1 100644
--- a/arch/x86/kernel/ioport.c
+++ b/arch/x86/kernel/ioport.c
@@ -144,7 +144,7 @@ long ksys_ioperm(unsigned long from, unsigned long num, int turn_on)
 	 * Update the sequence number to force a TSS update on return to
 	 * user mode.
 	 */
-	iobm->sequence = atomic64_add_return(1, &io_bitmap_sequence);
+	iobm->sequence = atomic64_inc_return(&io_bitmap_sequence);
 
 	return 0;
 }

