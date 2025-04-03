Return-Path: <linux-tip-commits+bounces-4637-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CCD3A7A3B9
	for <lists+linux-tip-commits@lfdr.de>; Thu,  3 Apr 2025 15:33:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D408E1894BDA
	for <lists+linux-tip-commits@lfdr.de>; Thu,  3 Apr 2025 13:33:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6C7124E008;
	Thu,  3 Apr 2025 13:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rWDy83gj";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WnmNhPX4"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6712210FB;
	Thu,  3 Apr 2025 13:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743687208; cv=none; b=TmkStLAgHCcp3SRD8BBOtZAiZ2WZE0GEFBb6rTsOPykEEazjdrx8FdB81ARV6vF7A7N0L+rocc7xYa4RA1veXpRU7YMjWLesrLjifNVYg/JJXZmHHwxRv9PakEftEZQfrAq7C4a9Q8XiKAxBw2wnJnrOB1c2vwePv0TaiqYOy3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743687208; c=relaxed/simple;
	bh=jYOHyfRRionv7riSMElbkcssVGgqonL4COADqnSol7w=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=QftQ/ycmF/WrmXNXALRowu0nwnnAvHowbRpKEPKA3U0Wz9x6uTs0pzph5UKd1LGNj9MZaTkbsGt+AaK94YBLkhl/JFTWh1wWaAxzBsc0kscbBTFi5fSI3ydny/GQS1abqmniaJO/xsvIViNhymhUMo6GUaHCAwr5gFhWcCxgLlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rWDy83gj; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WnmNhPX4; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 03 Apr 2025 13:33:20 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1743687204;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k1icSSbKg50mSlsrCAXe0ghlayKEXmqtnZFeCqEzDMo=;
	b=rWDy83gjqmD+4IOfhTUNqa7Mw1YXIEiJflqR77LyJ4Ks5wV8VoJcILsnfqL4o5NCikYUWc
	wgmAIFa0c9EBHDh5J2HhwjnYSXxbI4ulxM4BcMVxtaQsQ3DLtjDW/6YeVe7LozYVpbEPpG
	KAIM1iWWxOnqbLgP/DOL1ZFsltVXcORPkEudGJtI0bX4MP2xKGb41WwbP1XRHTXHa3Fhbx
	OeoFCCfd9/X4rnBtYsBt7x8ZEdaGLfiaaoD8PoSqcInLPqzuj3zbr8rI/9ZX4M5P6i+xyJ
	X2g8zu7W9VMlEO83s2zpoiezS58HZCC9FzcJ2/Pml99GqBzL12bcWpqx1TKQ8Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1743687204;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k1icSSbKg50mSlsrCAXe0ghlayKEXmqtnZFeCqEzDMo=;
	b=WnmNhPX4wMTKjJ/vrnJTao0C1njVH5amRVoQIxXj3ekwAD95zxjVYhR/4wNdSqivCynzf3
	uHu+CtbAWDG1eeAQ==
From: "tip-bot2 for Nathan Chancellor" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/kconfig] x86/kbuild/64: Restrict clang versions that can
 use '-march=native'
Cc: Nathan Chancellor <nathan@kernel.org>, Ingo Molnar <mingo@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, Tor Vic <torvic9@mailbox.org>,
 Andy Lutomirski <luto@kernel.org>, Brian Gerst <brgerst@gmail.com>,
 Juergen Gross <jgross@suse.com>, "H. Peter Anvin" <hpa@zytor.com>,
 Kees Cook <keescook@chromium.org>, Josh Poimboeuf <jpoimboe@redhat.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To:
 <20250324-x86-march-native-clang-19-and-newer-v1-1-3a05ed32a89e@kernel.org>
References:
 <20250324-x86-march-native-clang-19-and-newer-v1-1-3a05ed32a89e@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174368720008.30396.5633938489882625239.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/kconfig branch of tip:

Commit-ID:     ad9b861824ac55d81431815fffaaff5e981badc1
Gitweb:        https://git.kernel.org/tip/ad9b861824ac55d81431815fffaaff5e981badc1
Author:        Nathan Chancellor <nathan@kernel.org>
AuthorDate:    Mon, 24 Mar 2025 20:23:00 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 25 Mar 2025 08:24:06 +01:00

x86/kbuild/64: Restrict clang versions that can use '-march=native'

There are two issues that can appear when building with clang and
'-march=native'.

The first issue is a compiler crash in the ipv6 stack with clang-18,
such as when building allmodconfig. This was frequently reported on the
LLVM issue tracker:

  # Link: https://github.com/llvm/llvm-project/issues?q=is%3Aissue%20ip6_rcv_core

  Stack dump:
  0.      Program arguments: clang ... -march=native ... net/ipv6/ip6_input.c
  1.      <eof> parser at end of file
  2.      Code generation
  3.      Running pass 'Function Pass Manager' on module 'net/ipv6/ip6_input.c'.
  4.      Running pass 'X86 DAG->DAG Instruction Selection' on function '@ip6_rcv_core'

The second issue is certain -Wframe-larger-than warnings that appear
with clang versions prior to 19, which introduced an optimization that
produces much better code:

  # Link: https://github.com/llvm/llvm-project/commit/90ba33099cbb17e7c159e9ebc5a512037db99d6d [2]

  clang-18:

    drivers/media/pci/saa7164/saa7164-core.c:605:20: error: stack frame size (2392) exceeds limit (2048) in 'saa7164_irq' [-Werror,-Wframe-larger-than]
      605 | static irqreturn_t saa7164_irq(int irq, void *dev_id)
          |                    ^

  clang-19:

    drivers/media/pci/saa7164/saa7164-core.c:605:20: error: stack frame size (216) exceeds limit (128) in 'saa7164_irq' [-Werror,-Wframe-larger-than]
      605 | static irqreturn_t saa7164_irq(int irq, void *dev_id)
          |                    ^

Restrict the testing of the availability of '-march=native' to all
supported GCC versions and clang-19 and newer to avoid these known
resolved issues.

Fixes: 0480bc7e65dc ("x86/kbuild/64: Add the CONFIG_X86_NATIVE_CPU option to locally optimize the kernel with '-march=native'")
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Nick Desaulniers <ndesaulniers@google.com>
Cc: Tor Vic <torvic9@mailbox.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/r/20250324-x86-march-native-clang-19-and-newer-v1-1-3a05ed32a89e@kernel.org
---
 arch/x86/Kconfig.cpu | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/x86/Kconfig.cpu b/arch/x86/Kconfig.cpu
index 87bede9..f928cf6 100644
--- a/arch/x86/Kconfig.cpu
+++ b/arch/x86/Kconfig.cpu
@@ -248,6 +248,12 @@ endchoice
 config CC_HAS_MARCH_NATIVE
 	# This flag might not be available in cross-compilers:
 	def_bool $(cc-option, -march=native)
+	# LLVM 18 has an easily triggered internal compiler error in core
+	# networking code with '-march=native' on certain systems:
+	# https://github.com/llvm/llvm-project/issues/72026
+	# LLVM 19 introduces an optimization that resolves some high stack
+	# usage warnings that only appear wth '-march=native'.
+	depends on CC_IS_GCC || CLANG_VERSION >= 190100
 
 config X86_NATIVE_CPU
 	bool "Build and optimize for local/native CPU"

