Return-Path: <linux-tip-commits+bounces-4271-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D0D4EA64AC2
	for <lists+linux-tip-commits@lfdr.de>; Mon, 17 Mar 2025 11:50:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DE803A8C35
	for <lists+linux-tip-commits@lfdr.de>; Mon, 17 Mar 2025 10:46:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C0EA22CBE3;
	Mon, 17 Mar 2025 10:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sRF4FFxH";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YAp0cmrf"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84D5E22D4F7;
	Mon, 17 Mar 2025 10:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742208389; cv=none; b=nGKBjkhUwav5LkVgUBw8h0oQontZKIWJ2gSS+UlcwxGSeNM4/Xl9rr9Xp7nG5wieGy6k8bbs0/B+lVu/DpIuiibjuJsVE05+IY4Dqm/B7YAlnntbMLcV9Fu4R2FC9MkPQS90fgRtZ6UPJQjgo4B0eCtu0mvQrHb901YAUd355Rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742208389; c=relaxed/simple;
	bh=T1rKO4WNGPKX+O5/XaMWf7roFS7E0FOf8uotEinZgkA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=tpbSeRL4IrJMMTrVLh7GFGQnFc7UOycuZF6Pp9rMkrTQE+33Ot4gxX7qXhDZskQGGyIPdpDHRHLTgap6uNNisx/64Oqu6PruYCxMZeiSCAp1IPnrcnJHhigcUPBHoIwk6QBvr4cKFuuEjQ+CV5IO2dB7w3grRVJ3DzlPyiiDMmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sRF4FFxH; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YAp0cmrf; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 17 Mar 2025 10:46:21 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742208385;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yfjoXO3j7Thg4ryA6P8iUMyvEXmrUciuNhM0VLujHYs=;
	b=sRF4FFxHpdJsaku2zVMAOKkfvcpj1PHA3tOzckkb8CwL6QU9AbErmXp2yhGaN0asIMh8O+
	Q9IkqmbkztrbUQKOmsB9Dmti5YazFvQD2mnIt3gfuzeaRpDMhMiqTgMEqT8GCL0ZF8gdi+
	8uBHb7Wv6ErmxfidXHKY6P5iLOKIfAAl6tHQPGkWOlPeEzoY9XW7qZfOxNVC0MKk68vxDr
	iPr+J9iWHCU8RY7fP2tLDsLPD6bCTZa/EA/th6RSwtAT9+JWTHjbFBc9NQ5PbFuYgMPG6j
	K4EfxZycKRy+zQQuKu7fdNazKEQ1BEtCRn8UlLTwbXiEgGWSM/MS9DIbDu9Wmg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742208385;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yfjoXO3j7Thg4ryA6P8iUMyvEXmrUciuNhM0VLujHYs=;
	b=YAp0cmrfVrky83KWQUKY9qLEf7A3TYGeq8RGsHrHWqTFoqKdTOjr0tPWu9YL2OPMvpJ/cv
	c7L1Mu3pLmTN8nBg==
From: "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] objtool: Add CONFIG_OBJTOOL_WERROR
Cc: Josh Poimboeuf <jpoimboe@kernel.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To:
 <3e7c109313ff15da6c80788965cc7450115b0196.1741975349.git.jpoimboe@kernel.org>
References:
 <3e7c109313ff15da6c80788965cc7450115b0196.1741975349.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174220838111.14745.231849484340843711.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     9103328c993b0d4f6a4fe483b29b7800855d6960
Gitweb:        https://git.kernel.org/tip/9103328c993b0d4f6a4fe483b29b7800855d6960
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Fri, 14 Mar 2025 12:29:11 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 17 Mar 2025 11:36:02 +01:00

objtool: Add CONFIG_OBJTOOL_WERROR

Objtool warnings can be indicative of crashes, broken live patching, or
even boot failures.  Ignoring them is not recommended.

Add CONFIG_OBJTOOL_WERROR to upgrade objtool warnings to errors by
enabling the objtool --Werror option.  Also set --backtrace to print the
branches leading up to the warning, which can help considerably when
debugging certain warnings.

To avoid breaking bots too badly for now, make it the default for real
world builds only (!COMPILE_TEST).

Co-developed-by: Brendan Jackman <jackmanb@google.com>
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/3e7c109313ff15da6c80788965cc7450115b0196.1741975349.git.jpoimboe@kernel.org
---
 lib/Kconfig.debug    | 12 ++++++++++++
 scripts/Makefile.lib |  1 +
 2 files changed, 13 insertions(+)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 35796c2..bbfb9d5 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -545,6 +545,18 @@ config FRAME_POINTER
 config OBJTOOL
 	bool
 
+config OBJTOOL_WERROR
+	bool "Upgrade objtool warnings to errors"
+	default y
+	depends on OBJTOOL && !COMPILE_TEST
+	help
+	  Fail the build on objtool warnings.
+
+	  Objtool warnings can indicate kernel instability, including boot
+	  failures.  This option is highly recommended.
+
+	  If unsure, say Y.
+
 config STACK_VALIDATION
 	bool "Compile-time stack metadata validation"
 	depends on HAVE_STACK_VALIDATION && UNWINDER_FRAME_POINTER
diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index cad20f0..99e2819 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -277,6 +277,7 @@ objtool-args-$(CONFIG_HAVE_STATIC_CALL_INLINE)		+= --static-call
 objtool-args-$(CONFIG_HAVE_UACCESS_VALIDATION)		+= --uaccess
 objtool-args-$(CONFIG_GCOV_KERNEL)			+= --no-unreachable
 objtool-args-$(CONFIG_PREFIX_SYMBOLS)			+= --prefix=$(CONFIG_FUNCTION_PADDING_BYTES)
+objtool-args-$(CONFIG_OBJTOOL_WERROR)			+= --Werror --backtrace
 
 objtool-args = $(objtool-args-y)					\
 	$(if $(delay-objtool), --link)					\

