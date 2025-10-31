Return-Path: <linux-tip-commits+bounces-7120-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 11649C271A1
	for <lists+linux-tip-commits@lfdr.de>; Fri, 31 Oct 2025 23:08:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 460DA3B31B9
	for <lists+linux-tip-commits@lfdr.de>; Fri, 31 Oct 2025 22:08:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE652305077;
	Fri, 31 Oct 2025 22:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DpJAyHn2";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2wWWv5T0"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F57726C3BE;
	Fri, 31 Oct 2025 22:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761948486; cv=none; b=g3nV+JOh7apOH5eRQivW7LMa37+q5RqcyBh4KP9U/rg34h6KFtvvBDGj0F3Fo3QZJSlB4kkKwin5NdDCN/5J0qEk5P6nV2vRfe93EbkJ/ClFFNkcR+ifCsFBsilKXgJvMPA0otFVry4bHV+gltzniJ34dxxNNQNIQSI4kyQLqF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761948486; c=relaxed/simple;
	bh=3Vpaq6bL6JMo9tDmg6tASzD2Ws30qGCzI1GzvYMHmAg=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=kpDmV34a8i7FQ0RdHOoLbzpguII+PdZxSI7vDb85oiywe/FlNOourSOBRC1hrGseIEbngS29rW2Pe9+C/x9rzbNyVQjkUSwz70PQSdB0j64/EhD0xnQMh4z+0jfypijdubu9ayNbmO70YunvQgagDiSLFDlRpsBwp+47YSw/8qE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DpJAyHn2; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2wWWv5T0; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 31 Oct 2025 22:08:01 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761948482;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R8tgJ6Q5XWo2fwfyYMQQE2+9PToi2nnEjNQX2we4uUE=;
	b=DpJAyHn2NGBxmIunDjBTWx+QVE722eBXG0SKToNZV9JekIyhJMCryCK4D5wfBWPg/tHp0J
	qhyhpCXoo54KLdruFaebCrwj81vZyLLtuPrQX06WU+GaBrjce/kei22iII9IUGOp75R5Kt
	wY3JQ1SUj8ZHot8tMtG4U1DwAN+suDQJ5Dzr8xlCZHqtKLo6cZRy9jRjmwa56nnzP97uB1
	WO54tRE7cbUIiskG+APUC4LSZq6rLlZkQZKzHW6scjwevDYp9wzpncvzn7xXTux0PeMkYD
	43PSD77QI2F7XrslSXAqHZKrCpj4LLhOlDOiSq/GhZc9387w7BnZ17A8mcr2Kw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761948482;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R8tgJ6Q5XWo2fwfyYMQQE2+9PToi2nnEjNQX2we4uUE=;
	b=2wWWv5T0xPGbroimihOWUSog7a0o2CqAZIOjqpX0IP0yJ2UNZyKyPH6zrPonKF9wXza7iw
	O0ok1fwsPAiZpqDQ==
From: "tip-bot2 for Nathan Chancellor" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/mm: Ensure clear_page() variants always have
 __kcfi_typeid_ symbols
Cc: Nathan Chancellor <nathan@kernel.org>,
 "Borislav Petkov (AMD)" <bp@alien8.de>,
 Sami Tolvanen <samitolvanen@google.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3C20251013-x86-fix-clear=5Fpage-cfi-full-lto-errors-?=
 =?utf-8?q?v1-1-d69534c0be61=40kernel=2Eorg=3E?=
References: =?utf-8?q?=3C20251013-x86-fix-clear=5Fpage-cfi-full-lto-errors-v?=
 =?utf-8?q?1-1-d69534c0be61=40kernel=2Eorg=3E?=
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176194848107.2601451.9808956538373601331.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     9b041a4b66b3b62c30251e700b5688324cf66625
Gitweb:        https://git.kernel.org/tip/9b041a4b66b3b62c30251e700b5688324cf=
66625
Author:        Nathan Chancellor <nathan@kernel.org>
AuthorDate:    Mon, 13 Oct 2025 14:27:36 -07:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Fri, 31 Oct 2025 22:47:24 +01:00

x86/mm: Ensure clear_page() variants always have __kcfi_typeid_ symbols

When building with CONFIG_CFI=3Dy and CONFIG_LTO_CLANG_FULL=3Dy, there is a s=
eries
of errors from the various versions of clear_page() not having __kcfi_typeid_
symbols.

  $ cat kernel/configs/repro.config
  CONFIG_CFI=3Dy
  # CONFIG_LTO_NONE is not set
  CONFIG_LTO_CLANG_FULL=3Dy

  $ make -skj"$(nproc)" ARCH=3Dx86_64 LLVM=3D1 clean defconfig repro.config b=
zImage
  ld.lld: error: undefined symbol: __kcfi_typeid_clear_page_rep
  >>> referenced by ld-temp.o
  >>>               vmlinux.o:(__cfi_clear_page_rep)

  ld.lld: error: undefined symbol: __kcfi_typeid_clear_page_orig
  >>> referenced by ld-temp.o
  >>>               vmlinux.o:(__cfi_clear_page_orig)

  ld.lld: error: undefined symbol: __kcfi_typeid_clear_page_erms
  >>> referenced by ld-temp.o
  >>>               vmlinux.o:(__cfi_clear_page_erms)

With full LTO, it is possible for LLVM to realize that these functions never
have their address taken (as they are only used within an alternative, which
will make them a direct call) across the whole kernel and either drop or skip
generating their kCFI type identification symbols.

clear_page_{rep,orig,erms}() are defined in clear_page_64.S with
SYM_TYPED_FUNC_START as a result of

  2981557cb040 ("x86,kcfi: Fix EXPORT_SYMBOL vs kCFI"),

as exported functions are free to be called indirectly thus need kCFI type
identifiers.

Use KCFI_REFERENCE with these clear_page() functions to force LLVM to see
these functions as address-taken and generate then keep the kCFI type
identifiers.

Fixes: 2981557cb040 ("x86,kcfi: Fix EXPORT_SYMBOL vs kCFI")
Closes: https://github.com/ClangBuiltLinux/linux/issues/2128
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Sami Tolvanen <samitolvanen@google.com>
Link: https://patch.msgid.link/20251013-x86-fix-clear_page-cfi-full-lto-error=
s-v1-1-d69534c0be61@kernel.org
---
 arch/x86/include/asm/page_64.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/include/asm/page_64.h b/arch/x86/include/asm/page_64.h
index 015d23f..53f4089 100644
--- a/arch/x86/include/asm/page_64.h
+++ b/arch/x86/include/asm/page_64.h
@@ -43,6 +43,9 @@ extern unsigned long __phys_addr_symbol(unsigned long);
 void clear_page_orig(void *page);
 void clear_page_rep(void *page);
 void clear_page_erms(void *page);
+KCFI_REFERENCE(clear_page_orig);
+KCFI_REFERENCE(clear_page_rep);
+KCFI_REFERENCE(clear_page_erms);
=20
 static inline void clear_page(void *page)
 {

