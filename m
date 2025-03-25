Return-Path: <linux-tip-commits+bounces-4457-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D2F9A6EBB1
	for <lists+linux-tip-commits@lfdr.de>; Tue, 25 Mar 2025 09:36:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0A8797A42C8
	for <lists+linux-tip-commits@lfdr.de>; Tue, 25 Mar 2025 08:35:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 265E0256C6D;
	Tue, 25 Mar 2025 08:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hVyDWBWP";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GbN+tqLf"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9264A2566DF;
	Tue, 25 Mar 2025 08:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742891704; cv=none; b=bTOpVnkqarjHSQbJxqFDUkcqETsMigvOTFctYmxxJhU5vnqSZOqgpOrFEW3n14K156FV601X4tLnwZr5sgvb3NwVNw8X93Sa51UT6rIlttugYLEO5DVFm2kDuvpBRlwSBpTeFLGSL4jF/gsZPu63DHW1Lfh9UNYMLVL++j0rXX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742891704; c=relaxed/simple;
	bh=A563X7j4lI87Vt7zCKhDphfmvJA0dvFmem46/JQ2neE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=HD0AjtZAo1phxS8ZsQzH+x9RCaA3d7mddRYwXw5IAuqGD8hGduRJbEQmeqTCWhzv1f4SlkEWFYc9ypNb/FewkTXvdPxKAFO0/8JG0ydDIKvwn4TrUBNwfhRDVtj3iL6PoWwvDOZRJe+USVglcz0ncvw6Fe7j9kQF0SiBjGFIgYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hVyDWBWP; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GbN+tqLf; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 25 Mar 2025 08:35:00 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742891701;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GcRKof4rU32zdDKPY5Y6JHG6IG+vYv0MhaJUDALgaTk=;
	b=hVyDWBWPJ9cBgTUcV9rkLCxzemj7uEkrfpoas6Q/tzBWJ2i+5m+aZOXaBnWxTPfjiOG6L+
	VwKxDz0Umf1eOV9V7qsvMi3th1MQkRlVFkugtjO6BUzqRuORDKc0nIJV5uNC2qHDHPSBA4
	8BalGLUuOEE/FsC2pzyMQa5FuTJscmrHs00KI0YBaQqnLVnrVw26h15Yael0nDOonA9uOF
	SNx4fSKW6RaSeIOii0maTaGeC+Zi6P/alLz2cvxj7ioO+eDlN5pMi6pEnGdXFmBYJVbbHl
	Tl0ulS2lLxVjIL2PVgIb2R4jCao+w0nqnaNNy04du7KIp52m29pW8zbDZl20iw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742891701;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GcRKof4rU32zdDKPY5Y6JHG6IG+vYv0MhaJUDALgaTk=;
	b=GbN+tqLfGH9nsquW08VkJX0KwATOxkn7TKKDYP8Y+9qTqfEUFv21apkb2pj+vBtdDFTsK8
	YT/rkZrAYEayO6Cg==
From: "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/urgent] objtool: Remove --no-unreachable for
 noinstr-only vmlinux.o runs
Cc: Josh Poimboeuf <jpoimboe@kernel.org>, Ingo Molnar <mingo@kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To:
 <05414246a0124db2f21b0d071b652aa9043d039d.1742852847.git.jpoimboe@kernel.org>
References:
 <05414246a0124db2f21b0d071b652aa9043d039d.1742852847.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174289170029.14745.2406901709755619321.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the objtool/urgent branch of tip:

Commit-ID:     876a4bce3849b235d752d13ec3180e15a35e52de
Gitweb:        https://git.kernel.org/tip/876a4bce3849b235d752d13ec3180e15a35e52de
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Mon, 24 Mar 2025 14:56:02 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 25 Mar 2025 09:20:27 +01:00

objtool: Remove --no-unreachable for noinstr-only vmlinux.o runs

For (!X86_KERNEL_IBT && !LTO_CLANG && NOINSTR_VALIDATION), objtool runs
on both translation units and vmlinux.o.  The vmlinux.o run only does
noinstr/noret validation.  In that case --no-unreachable has no effect.
Remove it.

Note that for ((X86_KERNEL_IBT || LTO_CLANG) && KCOV), --no-unreachable
still gets set in objtool-args-y by scripts/Makefile.lib.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/r/05414246a0124db2f21b0d071b652aa9043d039d.1742852847.git.jpoimboe@kernel.org
---
 scripts/Makefile.vmlinux_o | 1 -
 1 file changed, 1 deletion(-)

diff --git a/scripts/Makefile.vmlinux_o b/scripts/Makefile.vmlinux_o
index f476f56..938c745 100644
--- a/scripts/Makefile.vmlinux_o
+++ b/scripts/Makefile.vmlinux_o
@@ -44,7 +44,6 @@ else
 vmlinux-objtool-args-$(CONFIG_OBJTOOL_WERROR)		+= --Werror
 endif
 
-vmlinux-objtool-args-$(CONFIG_GCOV_KERNEL)		+= --no-unreachable
 vmlinux-objtool-args-$(CONFIG_NOINSTR_VALIDATION)	+= --noinstr \
 							   $(if $(or $(CONFIG_MITIGATION_UNRET_ENTRY),$(CONFIG_MITIGATION_SRSO)), --unret)
 

