Return-Path: <linux-tip-commits+bounces-6548-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7625AB52A20
	for <lists+linux-tip-commits@lfdr.de>; Thu, 11 Sep 2025 09:35:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49F4C1891A55
	for <lists+linux-tip-commits@lfdr.de>; Thu, 11 Sep 2025 07:35:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29526274669;
	Thu, 11 Sep 2025 07:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IzTa9Udv";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OkGM4c3v"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B339272E5E;
	Thu, 11 Sep 2025 07:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757576099; cv=none; b=EO/iEPC9komPhQqU34GlI52IIdzengdVjpY097n0mP+yJVSJmjLjFEyJzEg7uPyemKcA547wRFptt7J9hnnlQhHHK2bTrkArP3azdxhBZzXY2FLCBPRyrzGEvk8jga1AGnBeo/IGabyHYj7konqxZKsEne6pJ7CuQbbcNwwc6QI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757576099; c=relaxed/simple;
	bh=Mgm5Uj53c5qwgooObs25v3ysEjyw1nydCQRm1LWUies=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=iVcjo2ZFwI34X32H/htZaIkE+9dH57R9R5zNYfDku00wso9GYuQBXirLifeXhy82zGaJOfLIJTpNNEU/XLiDHzxr2rK7GdGk75cliJDxv1upu4BYD4NLbYUV8YC7koS1mR9yzB7gZdRFznJQR6/3SzZmugeYD+LdEIbrI7ghlns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IzTa9Udv; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OkGM4c3v; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 11 Sep 2025 07:34:54 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757576095;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=ZlfZ1QMz9/wNDdEOrClmeYeeMnD4dyfzCI/f0cfdKEM=;
	b=IzTa9UdvRQVLYt+SbrrhHM0iHZAKVpuMiPEo+0XtK3uqHUF5pxlRQPzy9M8W6jH9p33vIN
	Eeo9f1M8BthdFU7GuuLuLCdFz4X4Pz5iuAunMkxmFBb0t0grREE4Tbzf/BgA22M8vakCcl
	N3OBzYjfWJ6+EBJPDb+4IFoU2hYuxklpTrR6fcQ75qClAFkdYfbdMcgZnXJrWQaa+45WJO
	00bigb1Cmmxy3ERAl7utS2JoJOf9l5EJLE8+iG9T/elGn+wJhILYzcSRiHjhtCTgfqpWoa
	97xZAKKPh8+GhWFw4U3E7DYH9rL4mV1knyMY7UWSp4GD5mqmUzIux7A55m/phQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757576095;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=ZlfZ1QMz9/wNDdEOrClmeYeeMnD4dyfzCI/f0cfdKEM=;
	b=OkGM4c3vhSDHiJQYt5IZ38+guUZ73i28PW0UxP/kzPdrjO2vPcRMC5ZaRWT9xvGXTfilm9
	IT/hpu9ojxwXmLBQ==
From: "tip-bot2 for Kees Cook" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86/cfi: Remove __noinitretpoline and __noretpoline
Cc: Kees Cook <kees@kernel.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175757609428.709179.17908913236124655304.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     0b815825b1b0bd6762ca028e9b6631b002efb7ca
Gitweb:        https://git.kernel.org/tip/0b815825b1b0bd6762ca028e9b6631b002e=
fb7ca
Author:        Kees Cook <kees@kernel.org>
AuthorDate:    Wed, 03 Sep 2025 20:46:45 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 04 Sep 2025 21:59:08 +02:00

x86/cfi: Remove __noinitretpoline and __noretpoline

Commit 66f793099a63 ("x86/retpoline: Avoid retpolines for built-in __init
functions") disabled retpolines in __init sections (__noinitretpoline)
as a precaution against potential issues with retpolines in early boot,
but it has not been a problem in practice (i.e. see Clang below).

Commit 87358710c1fb ("x86/retpoline: Support retpoline builds with Clang")
narrowed this to only GCC, as Clang doesn't have per-function control
over retpoline emission. As such, Clang has been booting with retpolines
in __init since retpoline support was introduced.

Clang KCFI has been instrumenting __init since CFI was introduced.

With the introduction of KCFI for GCC, KCFI instrumentation with
retpolines disabled means that objtool does not construct .retpoline_sites
section entries for the non-retpoline KCFI calls. At boot, the KCFI
rehashing code, via __apply_fineibt(), misses all __init KCFI calls
(since they are not retpolines), resulting in immediate hash mismatches:
all preambles are rehashed (via .cfi_sites) and none of the __init call
sites are rehashed.

Remove __noinitretpoline since it provides no meaningful utility and
creates problems with CFI. Additionally remove __noretpoline since it
is now unused.

Alternatively, cfi_rand_callers() could walk the .kcfi_traps section which
is exactly the list of KCFI instrumentation sites. But it seems better to
have as few differences in common instruction sequences between compilers
as possible, so better to remove the special handling of retpolines in
__init for GCC.

Signed-off-by: Kees Cook <kees@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20250904034656.3670313-6-kees@kernel.org
---
 include/linux/compiler-gcc.h | 4 ----
 include/linux/init.h         | 8 --------
 2 files changed, 12 deletions(-)

diff --git a/include/linux/compiler-gcc.h b/include/linux/compiler-gcc.h
index 5d07c46..5de824a 100644
--- a/include/linux/compiler-gcc.h
+++ b/include/linux/compiler-gcc.h
@@ -35,10 +35,6 @@
 	(typeof(ptr)) (__ptr + (off));					\
 })
=20
-#ifdef CONFIG_MITIGATION_RETPOLINE
-#define __noretpoline __attribute__((__indirect_branch__("keep")))
-#endif
-
 #if defined(LATENT_ENTROPY_PLUGIN) && !defined(__CHECKER__)
 #define __latent_entropy __attribute__((latent_entropy))
 #endif
diff --git a/include/linux/init.h b/include/linux/init.h
index a60d32d..17c1bc7 100644
--- a/include/linux/init.h
+++ b/include/linux/init.h
@@ -7,13 +7,6 @@
 #include <linux/stringify.h>
 #include <linux/types.h>
=20
-/* Built-in __init functions needn't be compiled with retpoline */
-#if defined(__noretpoline) && !defined(MODULE)
-#define __noinitretpoline __noretpoline
-#else
-#define __noinitretpoline
-#endif
-
 /* These macros are used to mark some functions or=20
  * initialized data (doesn't apply to uninitialized data)
  * as `initialization' functions. The kernel can take this
@@ -50,7 +43,6 @@
 /* These are for everybody (although not all archs will actually
    discard it in modules) */
 #define __init		__section(".init.text") __cold __latent_entropy	\
-						__noinitretpoline	\
 						__no_kstack_erase
 #define __initdata	__section(".init.data")
 #define __initconst	__section(".init.rodata")

