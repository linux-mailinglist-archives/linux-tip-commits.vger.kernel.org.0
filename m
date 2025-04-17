Return-Path: <linux-tip-commits+bounces-5023-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D43EAA91918
	for <lists+linux-tip-commits@lfdr.de>; Thu, 17 Apr 2025 12:19:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40C693BBD54
	for <lists+linux-tip-commits@lfdr.de>; Thu, 17 Apr 2025 10:19:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12DA3225A37;
	Thu, 17 Apr 2025 10:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SUoW0+P/";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OyQg5pWS"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66AF54683;
	Thu, 17 Apr 2025 10:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744885161; cv=none; b=tvQoDYL33Q7KuGdPxEqtHnhqCz44sVbLmMjGH65lrUWUJMeAnraWoeVcRfiX2l+KQ3ACA7QAzBm4ZSvTVzAo0eN2z4/JoLk1hpZxPXVYTi9o44uHA9Kb+0nQbKGT+aT8BfNJkrhH3hZdEIUfP90S/eEAslMMyc46ABcPU4eicAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744885161; c=relaxed/simple;
	bh=M/FUhkc5lYOE9OhPZXVDsTXa1E/RPY8FZlbRB1otVTo=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Txy+h2KMlBuEapKW/YNERD+JsoGmaZ6qsyVx8wfizBBIGKDErrX8SsFR/sIwX5sLdOBQ5MavOUORqogCkWCaNi5jJswO1HQLr9PeiGu3gp/+sQMikrGbMBt+vguzOL+etCND+1JpeRbn3dYh6fzXR8eu+AH9NJ5J6bJI2fjHCwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SUoW0+P/; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OyQg5pWS; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 17 Apr 2025 10:19:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744885157;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xhDHKpi6vb953+ilVSBHIzJIpD+YPrR0qoq+iAMTf1I=;
	b=SUoW0+P/niv1Mkj8B6v+qpwbd7L3OUOVouz0PfspVud63sJcbRYjQZpsaBHif3ol92QiWk
	5mn2ONiUJSheO/4+L/viVIlE5FN2syHk0XcmytTC26dsX1/Y+JvcWRSl2emVaSbBIOVO1z
	k1NEb5dRA9z7cdefmdWqn8affI5KzkpOJMdyKZUSPNPVFGuzfy/e/Zt9zdrpnotTGVJ6OC
	jDwFjMBbSw+Mv+S6H2PXS2grnpaHh3blAA05H16DcIGJJsXjewzGDICupGezlVNehxsnKY
	y6mUORFosw/akf5vwl2qAKRerZo0EJfEJuJ6PmkUe22utjbdzV9+KALfm38I0Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744885157;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xhDHKpi6vb953+ilVSBHIzJIpD+YPrR0qoq+iAMTf1I=;
	b=OyQg5pWShQ18pEpB5h5KZW5K6V9G3oEmYnaA7XT8PI1ve2LoT6oeY+W5xJzFxrD7CZB+0K
	wHEmwoIm1VamcpAg==
From: "tip-bot2 for Nathan Chancellor" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/boot] x86/boot/startup: Disable LTO for the startup code
Cc: Linux Kernel Functional Testing <lkft@linaro.org>,
 Nathan Chancellor <nathan@kernel.org>, Ingo Molnar <mingo@kernel.org>,
 Ard Biesheuvel <ardb@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
 Kees Cook <keescook@chromium.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 David Woodhouse <dwmw@amazon.co.uk>, llvm@lists.linux.dev, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To:
 <20250414-x86-boot-startup-lto-error-v1-1-7c8bed7c131c@kernel.org>
References: <20250414-x86-boot-startup-lto-error-v1-1-7c8bed7c131c@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174488515226.31282.12005558142806434294.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/boot branch of tip:

Commit-ID:     498cb872a111e25021ca5e2d91af7b7a2e62630f
Gitweb:        https://git.kernel.org/tip/498cb872a111e25021ca5e2d91af7b7a2e62630f
Author:        Nathan Chancellor <nathan@kernel.org>
AuthorDate:    Mon, 14 Apr 2025 12:26:07 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 17 Apr 2025 12:09:30 +02:00

x86/boot/startup: Disable LTO for the startup code

When building with CONFIG_LTO_CLANG, there is an error in the x86 boot
startup code because it builds with a different code model than the rest
of the kernel:

  ld.lld: error: Function Import: link error: linking module flags 'Code Model': IDs have conflicting values: 'i32 2' from vmlinux.a(head64.o at 1302448), and 'i32 1' from vmlinux.a(map_kernel.o at 1314208)
  ld.lld: error: Function Import: link error: linking module flags 'Code Model': IDs have conflicting values: 'i32 2' from vmlinux.a(common.o at 1306108), and 'i32 1' from vmlinux.a(gdt_idt.o at 1314148)

As this directory is for code that only runs during early system
initialization, LTO is not very important, so filter out the LTO flags
from KBUILD_CFLAGS for arch/x86/boot/startup to resolve the build error.

Fixes: 4cecebf200ef ("x86/boot: Move the early GDT/IDT setup code into startup/")
Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Ard Biesheuvel <ardb@kernel.org>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: David Woodhouse <dwmw@amazon.co.uk>
Cc: llvm@lists.linux.dev
Link: https://lore.kernel.org/r/20250414-x86-boot-startup-lto-error-v1-1-7c8bed7c131c@kernel.org

Closes: https://lore.kernel.org/CA+G9fYvnun+bhYgtt425LWxzOmj+8Jf3ruKeYxQSx-F6U7aisg@mail.gmail.com/
---
 arch/x86/boot/startup/Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/boot/startup/Makefile b/arch/x86/boot/startup/Makefile
index ccdfc42..bb7c826 100644
--- a/arch/x86/boot/startup/Makefile
+++ b/arch/x86/boot/startup/Makefile
@@ -7,8 +7,9 @@ KBUILD_CFLAGS		+= -D__DISABLE_EXPORTS -mcmodel=small -fPIC \
 			   -fno-stack-protector -D__NO_FORTIFY \
 			   -include $(srctree)/include/linux/hidden.h
 
-# disable ftrace hooks
+# disable ftrace hooks and LTO
 KBUILD_CFLAGS	:= $(subst $(CC_FLAGS_FTRACE),,$(KBUILD_CFLAGS))
+KBUILD_CFLAGS	:= $(filter-out $(CC_FLAGS_LTO),$(KBUILD_CFLAGS))
 KASAN_SANITIZE	:= n
 KCSAN_SANITIZE	:= n
 KMSAN_SANITIZE	:= n

