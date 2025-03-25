Return-Path: <linux-tip-commits+bounces-4447-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E1F7A6EB9D
	for <lists+linux-tip-commits@lfdr.de>; Tue, 25 Mar 2025 09:34:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4E63188BF38
	for <lists+linux-tip-commits@lfdr.de>; Tue, 25 Mar 2025 08:35:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3062F2528FC;
	Tue, 25 Mar 2025 08:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="P9CtCmAp";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bTPwil7i"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 997521E9B26;
	Tue, 25 Mar 2025 08:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742891695; cv=none; b=K8Gs/m/NphSg1brBR/ggHXQX07wMYDPPoNNWQZO+MioOpPQh/vQ43fpoC0NNUMQ5OTyoABfCR6uGx1nrMrxzoALBRjZ+mxApO38tFcShubHLviycesgGnStL6SzvllfeegLoBwLrn09VZBYtbYoxKMTCOVOS2Avr57A3S5DOcCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742891695; c=relaxed/simple;
	bh=kAYSLH4MolkT8DzXnGmuWhTlEptTGPplHND2lLWbaa8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=c3JQRSczQQFCYq5KWdQsksr/VpzWH3RZftDVH14i9CPj98l2sJ7ieiYBJzvmDn5tSxYgjvgud+o/sias5fwLYt2RkGHGOP6mWMxxvd/toVRuyXV2Gb6vdT+xLiXMcANSIi/fTpgPV4qjM1tOh5Dv/WhNiuKRHmfJkrmTRFmkRsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=P9CtCmAp; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bTPwil7i; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 25 Mar 2025 08:34:50 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742891691;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kJ1gAehpE01b4ZaMOlQNDQEnzsNNzqGABusib0qeMy8=;
	b=P9CtCmApjNmW/zWdMx3CoIChkzsOzIptApCkthhcnlyrdJAjtcswbQDTuhWk2olospslch
	DBDe3DKzlwePikz3P79003Z0dkSj5Ry3dNncj9vmNLkD3Pj17sYZBfn4hkKqjQwwHjw2ov
	7/rAcfWv0qDsNbqlBTM/r0mMmNKokSG0BWt6nzaJhEVyK+p1qrEPa0CGDlZs/f8jOz7B8i
	h5ZLETU+7/5ItxecB4t5nuPdIComxeT8D//EwLvQYa5EFKNunY8YZJmC3yDK/vUf+nTdkl
	V3JMCav12u21AIWC3YJ7/YiNVmlH1eMTN8z/OMPCvpw5ugPBkJfF1nEF7ETO7g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742891691;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kJ1gAehpE01b4ZaMOlQNDQEnzsNNzqGABusib0qeMy8=;
	b=bTPwil7iVP5umpAEhE69XDE6HF+cwlA3nb4NziLR2VcHrK32j8EZXso5jUSoW7uIFD6MkH
	CXZHLQ9f9LjBEZAg==
From: "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: objtool/urgent] objtool, lkdtm: Obfuscate the do_nothing() pointer
Cc: kernel test robot <lkp@intel.com>, Josh Poimboeuf <jpoimboe@kernel.org>,
 Ingo Molnar <mingo@kernel.org>, Kees Cook <kees@kernel.org>,
 Arnd Bergmann <arnd@arndb.de>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To:
 <30b9abffbddeb43c4f6320b1270fa9b4d74c54ed.1742852847.git.jpoimboe@kernel.org>
References:
 <30b9abffbddeb43c4f6320b1270fa9b4d74c54ed.1742852847.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174289169036.14745.18072654948931716330.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the objtool/urgent branch of tip:

Commit-ID:     33fea486a42d952a40eb110a9b7885a7ac8d2778
Gitweb:        https://git.kernel.org/tip/33fea486a42d952a40eb110a9b7885a7ac8d2778
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Mon, 24 Mar 2025 14:56:12 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 25 Mar 2025 09:20:33 +01:00

objtool, lkdtm: Obfuscate the do_nothing() pointer

If execute_location()'s memcpy of do_nothing() gets inlined and unrolled
by the compiler, it copies one word at a time:

    mov    0x0(%rip),%rax    R_X86_64_PC32    .text+0x1374
    mov    %rax,0x38(%rbx)
    mov    0x0(%rip),%rax    R_X86_64_PC32    .text+0x136c
    mov    %rax,0x30(%rbx)
    ...

Those .text references point to the middle of the function, causing
objtool to complain about their lack of ENDBR.

Prevent that by resolving the function pointer at runtime rather than
build time.  This fixes the following warning:

  drivers/misc/lkdtm/lkdtm.o: warning: objtool: execute_location+0x23: relocation to !ENDBR: .text+0x1378

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Kees Cook <kees@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/r/30b9abffbddeb43c4f6320b1270fa9b4d74c54ed.1742852847.git.jpoimboe@kernel.org
Closes: https://lore.kernel.org/oe-kbuild-all/202503191453.uFfxQy5R-lkp@intel.com/
---
 drivers/misc/lkdtm/perms.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/misc/lkdtm/perms.c b/drivers/misc/lkdtm/perms.c
index 5b861db..6c24426 100644
--- a/drivers/misc/lkdtm/perms.c
+++ b/drivers/misc/lkdtm/perms.c
@@ -29,6 +29,13 @@ static const unsigned long rodata = 0xAA55AA55;
 static unsigned long ro_after_init __ro_after_init = 0x55AA5500;
 
 /*
+ * This is a pointer to do_nothing() which is initialized at runtime rather
+ * than build time to avoid objtool IBT validation warnings caused by an
+ * inlined unrolled memcpy() in execute_location().
+ */
+static void __ro_after_init *do_nothing_ptr;
+
+/*
  * This just returns to the caller. It is designed to be copied into
  * non-executable memory regions.
  */
@@ -65,13 +72,12 @@ static noinline __nocfi void execute_location(void *dst, bool write)
 {
 	void (*func)(void);
 	func_desc_t fdesc;
-	void *do_nothing_text = dereference_function_descriptor(do_nothing);
 
-	pr_info("attempting ok execution at %px\n", do_nothing_text);
+	pr_info("attempting ok execution at %px\n", do_nothing_ptr);
 	do_nothing();
 
 	if (write == CODE_WRITE) {
-		memcpy(dst, do_nothing_text, EXEC_SIZE);
+		memcpy(dst, do_nothing_ptr, EXEC_SIZE);
 		flush_icache_range((unsigned long)dst,
 				   (unsigned long)dst + EXEC_SIZE);
 	}
@@ -267,6 +273,8 @@ static void lkdtm_ACCESS_NULL(void)
 
 void __init lkdtm_perms_init(void)
 {
+	do_nothing_ptr = dereference_function_descriptor(do_nothing);
+
 	/* Make sure we can write to __ro_after_init values during __init */
 	ro_after_init |= 0xAA;
 }

