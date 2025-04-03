Return-Path: <linux-tip-commits+bounces-4638-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45823A7A3C2
	for <lists+linux-tip-commits@lfdr.de>; Thu,  3 Apr 2025 15:34:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B0593B3863
	for <lists+linux-tip-commits@lfdr.de>; Thu,  3 Apr 2025 13:33:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E60F24EA9F;
	Thu,  3 Apr 2025 13:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cyTSjyqc";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TflsDi0B"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A8512441A7;
	Thu,  3 Apr 2025 13:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743687210; cv=none; b=AO92fSQv6U/iNgkgH1I+EyV03kzWxlLvNfM6hEDmUvjR6qKbWgqVJkL44FdQADN9NLmv2fTpJJWhNjG22rDRIai/cE1jEgdOOT7Ssx54wGw/UVxaTpHGM1ByeG7lQiTXym5rfJsuF3nEA1oNLGoMet97GxeNxVa9nJtk1G0PqFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743687210; c=relaxed/simple;
	bh=4ziQfrcHD4RvZipomyPNvQbGP5Wxyu/1VDNA2VQ6dgs=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=TjWQ8j1Shrk9s3kte73vKNNUzjqqlc/4dV9JYPfqCOYqjsco5qCpD/NAK07JaHXG+jV4uk4p6w8zloiv4h4gFvgNx6qSQ6WNIP2/8kiEydnuxBHLNCG0UvW1W/FDkUj79PN0rcK1qtlkIQ0eIghW/XrKeox81g6Hxn/N5a1WGCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cyTSjyqc; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TflsDi0B; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 03 Apr 2025 13:33:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1743687205;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M0PdppgWzNSPGPeLiV0fRP8qNH/M0RuituLwAkmGmwA=;
	b=cyTSjyqciwHGXzMPeyJaujLLskxt5XmoFXIAjSIOVDZJu0B3r8/Z7UGRK00myuWYQNCr+K
	GLdFllbx8LzUzBFBL9NMGMEkjhOxeMF+MFxrPpsDfzVOMrn+1qrCzMzpNpvwsJxStSJQIH
	BQH3dLf4PahetKuzL6G4+N68yCTbh3BClkj+rhh22z10JpeKLbYugM4jfCWfWHqdM5ykpO
	UZ2anF/2ZJP5wND+BsXN7W40VbODmdpVahthB19QAEQJ2ppXllplthRFW3dzOPY3jjosgM
	tiNlzmNlagg8INIGbUF+8m4fEwdFZGbj9G+mvPRhCQ5yam+OugoO63lTVjQ+gA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1743687205;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M0PdppgWzNSPGPeLiV0fRP8qNH/M0RuituLwAkmGmwA=;
	b=TflsDi0BjDIu8yVXXNiA9p3zGWyXUBp9VOHmTw+kGjj1cWJHFgNP0djuWHC6ylz/cckxy8
	V6d/XX/37JT3AwDA==
From: "tip-bot2 for Tor Vic" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/kconfig] x86/kbuild/64: Add the CONFIG_X86_NATIVE_CPU
 option to locally optimize the kernel with '-march=native'
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 Tor Vic <torvic9@mailbox.org>, Ingo Molnar <mingo@kernel.org>,
 Andy Lutomirski <luto@kernel.org>, Brian Gerst <brgerst@gmail.com>,
 Juergen Gross <jgross@suse.com>, "H. Peter Anvin" <hpa@zytor.com>,
 Kees Cook <keescook@chromium.org>, Josh Poimboeuf <jpoimboe@redhat.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250321142859.13889-1-torvic9@mailbox.org>
References: <20250321142859.13889-1-torvic9@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174368720522.30396.1418171893248214427.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/kconfig branch of tip:

Commit-ID:     ea1dcca1de129dfdf145338a868648bc0e24717c
Gitweb:        https://git.kernel.org/tip/ea1dcca1de129dfdf145338a868648bc0e24717c
Author:        Tor Vic <torvic9@mailbox.org>
AuthorDate:    Fri, 21 Mar 2025 15:28:58 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 25 Mar 2025 08:24:06 +01:00

x86/kbuild/64: Add the CONFIG_X86_NATIVE_CPU option to locally optimize the kernel with '-march=native'

Add a 'native' option that allows users to build an optimized kernel for
their local machine (i.e. the machine which is used to build the kernel)
by passing '-march=native' to CFLAGS.

The idea comes from Linus' reply to Arnd's initial proposal:

  https://lore.kernel.org/all/CAHk-=wji1sV93yKbc==Z7OSSHBiDE=LAdG_d5Y-zPBrnSs0k2A@mail.gmail.com/

Here are some numbers comparing 'generic' to 'native' on a Skylake dual-core
laptop (generic --> native):

  - vmlinux and compressed modules size:
      125'907'744 bytes --> 125'595'280 bytes  (-0.248 %)
      18'810 kilobytes --> 18'770 kilobytes    (-0.213 %)

  - phoronix, average of 3 runs:
      ffmpeg:
      130.99 --> 131.15                        (+0.122 %)
      nginx:
      10'650 --> 10'725                        (+0.704 %)
      hackbench (lower is better):
      102.27 --> 99.50                         (-2.709 %)

  - xz compression of firefox tarball (lower is better):
      319.57 seconds --> 317.34 seconds        (-0.698 %)

  - stress-ng, bogoops, average of 3 15-second runs:
      fork:
      111'744 --> 115'509                      (+3.397 %)
      bsearch:
      7'211 --> 7'436                          (+3.120 %)
      memfd:
      3'591 --> 3'604                          (+0.362 %)
      mmapfork:
      630 --> 629                              (-0.159 %)
      schedmix:
      42'715 --> 43'251                        (+1.255 %)
      epoll:
      2'443'767 --> 2'454'413                  (+0.436 %)
      vm:
      1'442'256 --> 1'486'615                  (+3.076 %)

  - schbench (two message threads), 30-second runs:
      304 rps --> 305 rps                      (+0.329 %)

There is little difference both in terms of size and of performance, however
the native build comes out on top ever so slightly.

[ mingo: Renamed the option to CONFIG_X86_NATIVE_CPU, expanded the help text
         and added Linus's Suggested-by tag. ]

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Tor Vic <torvic9@mailbox.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Link: https://lore.kernel.org/r/20250321142859.13889-1-torvic9@mailbox.org
---
 arch/x86/Kconfig.cpu | 14 ++++++++++++++
 arch/x86/Makefile    |  5 +++++
 2 files changed, 19 insertions(+)

diff --git a/arch/x86/Kconfig.cpu b/arch/x86/Kconfig.cpu
index 753b876..9d108a5 100644
--- a/arch/x86/Kconfig.cpu
+++ b/arch/x86/Kconfig.cpu
@@ -245,6 +245,20 @@ config MATOM
 
 endchoice
 
+config X86_NATIVE_CPU
+	bool "Build and optimize for local/native CPU"
+	depends on X86_64
+	default n
+	help
+	  Optimize for the current CPU used to compile the kernel.
+	  Use this option if you intend to build the kernel for your
+	  local machine.
+
+	  Note that such a kernel might not work optimally on a
+	  different x86 machine.
+
+	  If unsure, say N.
+
 config X86_GENERIC
 	bool "Generic x86 support"
 	depends on X86_32
diff --git a/arch/x86/Makefile b/arch/x86/Makefile
index 0fc7e8f..436635e 100644
--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -173,8 +173,13 @@ else
 	# Use -mskip-rax-setup if supported.
 	KBUILD_CFLAGS += $(call cc-option,-mskip-rax-setup)
 
+ifdef CONFIG_X86_NATIVE_CPU
+        KBUILD_CFLAGS += -march=native
+        KBUILD_RUSTFLAGS += -Ctarget-cpu=native
+else
         KBUILD_CFLAGS += -march=x86-64 -mtune=generic
         KBUILD_RUSTFLAGS += -Ctarget-cpu=x86-64 -Ztune-cpu=generic
+endif
 
         KBUILD_CFLAGS += -mno-red-zone
         KBUILD_CFLAGS += -mcmodel=kernel

