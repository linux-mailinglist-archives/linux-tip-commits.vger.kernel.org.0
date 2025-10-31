Return-Path: <linux-tip-commits+bounces-7108-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EC94C24AD9
	for <lists+linux-tip-commits@lfdr.de>; Fri, 31 Oct 2025 12:04:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 554E91894CE1
	for <lists+linux-tip-commits@lfdr.de>; Fri, 31 Oct 2025 11:04:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD55734403E;
	Fri, 31 Oct 2025 11:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PMf0OR7o";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="02+dcts2"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF6323431F8;
	Fri, 31 Oct 2025 11:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761908649; cv=none; b=a/KB98c102dzan4yrU8il0XVOGwRGUzHLHQ+jO+FIP0rC3lfGwVjVraXXb32qwSNNg5dDbkUfKv134osbijiKXkn4zNb/O8aOtA4zW6z492ESJKn6M3H6HEkAcAVNlQUgChg5PvMh6zTpt1lY/MqMZl1qBbldm7Oy882acgkCgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761908649; c=relaxed/simple;
	bh=nEhlBd7/EweDQf9gqY++lWHMs9KlgkonXkB18UdjcKk=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=axMZwrwXvp/xbbhuW6AeglfEbwnycxgfGqkqCTQQ6BeHh88FwR50YkK7xJv8X+I3JSnGfWmm9DqRctQZHL8j0iLD9nz+jbWexpQyJLkFB0gxmccwKNi6SjQFbS9MPwYkTz3oNMEfA3ewwNFELFtlWtMtEv74G7d61J+3FQSjSmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PMf0OR7o; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=02+dcts2; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 31 Oct 2025 11:04:00 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761908645;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/Mu1dSbRCkITf72Z3tZ+DZSPMONsNtDOYBznnOAflyw=;
	b=PMf0OR7o9jhRsdbASt3A2bXEtRp+YNs2OSaafMIg4Cjqo49pzCVx37wieBqL0clddm7gxL
	0dwLCoJNNgVxLy2V1UQc1SXfAdhn4aMdx8WRwU7k4fDCKeBZrdDMg+cVWT6gbRbysR1UL/
	4uQ9dkeeCevEGTsrrj6WpOR7IYzqFl+PAC29Z6bL8rCAReX/eqORqUBaxu5cMzVwu8NNfH
	BALRWjwKdmdafORn+jhsjQwu2TTPhxE9HQZf5MMEmVRipVwYrdeCnRIXZagTDQDg50D5xX
	NlvSxvjA9mX0colqIHOFOTzyIJJBEGib3wstu8zeX8qzM5npDgn6Jq9UyVKJaA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761908645;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/Mu1dSbRCkITf72Z3tZ+DZSPMONsNtDOYBznnOAflyw=;
	b=02+dcts25HrHKg3NMvqf2mqbidZH49nPU7JKm0DGi+ieWToqt2TQReX+aV/Rvt/LCPNXja
	uIiWmfHmOY192UAQ==
From: "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] vmlinux.lds: Exclude .text.startup and .text.exit
 from TEXT_MAIN
Cc: Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
 Josh Poimboeuf <jpoimboe@kernel.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To:
 <07f74b4e5c43872572b7def30f2eac45f28675d9.1761872421.git.jpoimboe@kernel.org>
References:
 <07f74b4e5c43872572b7def30f2eac45f28675d9.1761872421.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176190864070.2601451.11865431354213171498.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     6568f14cb5ae68cd6c612604ca0c89301cf3a0d0
Gitweb:        https://git.kernel.org/tip/6568f14cb5ae68cd6c612604ca0c89301cf=
3a0d0
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Thu, 30 Oct 2025 18:01:54 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 31 Oct 2025 11:19:21 +01:00

vmlinux.lds: Exclude .text.startup and .text.exit from TEXT_MAIN

An ftrace warning was reported in ftrace_init_ool_stub():

   WARNING: arch/powerpc/kernel/trace/ftrace.c:234 at ftrace_init_ool_stub+0x=
188/0x3f4, CPU#0: swapper/0

The problem is that the linker script is placing .text.startup in .text
rather than in .init.text, due to an inadvertent match of the TEXT_MAIN
'.text.[0-9a-zA-Z_]*' pattern.

This bug existed for some configurations before, but is only now coming
to light due to the TEXT_MAIN macro unification in commit 1ba9f8979426
("vmlinux.lds: Unify TEXT_MAIN, DATA_MAIN, and related macros").

The .text.startup section consists of constructors which are used by
KASAN, KCSAN, and GCOV.  The constructors are only called during boot,
so .text.startup is supposed to match the INIT_TEXT pattern so it can be
placed in .init.text and freed after init.  But since INIT_TEXT comes
*after* TEXT_MAIN in the linker script, TEXT_MAIN needs to manually
exclude .text.startup.

Update TEXT_MAIN to exclude .text.startup (and its .text.startup.*
variant from -ffunction-sections), along with .text.exit and
.text.exit.* which should match EXIT_TEXT.

Specifically, use a series of more specific glob patterns to match
generic .text.* sections (for -ffunction-sections) while explicitly
excluding .text.startup[.*] and .text.exit[.*].

Also update INIT_TEXT and EXIT_TEXT to explicitly match their
-ffunction-sections variants (.text.startup.* and .text.exit.*).

Fixes: 1ba9f8979426 ("vmlinux.lds: Unify TEXT_MAIN, DATA_MAIN, and related ma=
cros")
Closes: https://lore.kernel.org/72469502-ca37-4287-90b9-a751cecc498c@linux.ib=
m.com
Reported-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Debugged-by: Hari Bathini <hbathini@linux.ibm.com>
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Link: https://patch.msgid.link/07f74b4e5c43872572b7def30f2eac45f28675d9.17618=
72421.git.jpoimboe@kernel.org
---
 include/asm-generic/vmlinux.lds.h | 28 ++++++++++++++++++++++------
 1 file changed, 22 insertions(+), 6 deletions(-)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.=
lds.h
index 5facbc9..9de1d90 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -88,13 +88,29 @@
=20
 /*
  * Support -ffunction-sections by matching .text and .text.*,
- * but exclude '.text..*'.
+ * but exclude '.text..*', .text.startup[.*], and .text.exit[.*].
  *
- * Special .text.* sections that are typically grouped separately, such as
+ * .text.startup and .text.startup.* are matched later by INIT_TEXT.
+ * .text.exit and .text.exit.* are matched later by EXIT_TEXT.
+ *
+ * Other .text.* sections that are typically grouped separately, such as
  * .text.unlikely or .text.hot, must be matched explicitly before using
  * TEXT_MAIN.
  */
-#define TEXT_MAIN .text .text.[0-9a-zA-Z_]*
+#define TEXT_MAIN							\
+	.text								\
+	.text.[_0-9A-Za-df-rt-z]*					\
+	.text.s[_0-9A-Za-su-z]*						\
+	.text.st[_0-9A-Zb-z]*						\
+	.text.sta[_0-9A-Za-qs-z]*					\
+	.text.star[_0-9A-Za-su-z]*					\
+	.text.start[_0-9A-Za-tv-z]*					\
+	.text.startu[_0-9A-Za-oq-z]*					\
+	.text.startup[_0-9A-Za-z]*					\
+	.text.e[_0-9A-Za-wy-z]*						\
+	.text.ex[_0-9A-Za-hj-z]*					\
+	.text.exi[_0-9A-Za-su-z]*					\
+	.text.exit[_0-9A-Za-z]*
=20
 /*
  * Support -fdata-sections by matching .data, .data.*, and others,
@@ -713,16 +729,16 @@
=20
 #define INIT_TEXT							\
 	*(.init.text .init.text.*)					\
-	*(.text.startup)
+	*(.text.startup .text.startup.*)
=20
 #define EXIT_DATA							\
 	*(.exit.data .exit.data.*)					\
 	*(.fini_array .fini_array.*)					\
-	*(.dtors .dtors.*)						\
+	*(.dtors .dtors.*)
=20
 #define EXIT_TEXT							\
 	*(.exit.text)							\
-	*(.text.exit)							\
+	*(.text.exit .text.exit.*)
=20
 #define EXIT_CALL							\
 	*(.exitcall.exit)

