Return-Path: <linux-tip-commits+bounces-8260-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iChQOxUWn2nWYwQAu9opvQ
	(envelope-from <linux-tip-commits+bounces-8260-lists+linux-tip-commits=lfdr.de@vger.kernel.org>)
	for <lists+linux-tip-commits@lfdr.de>; Wed, 25 Feb 2026 16:32:37 +0100
X-Original-To: lists+linux-tip-commits@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 09C6F199A49
	for <lists+linux-tip-commits@lfdr.de>; Wed, 25 Feb 2026 16:32:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 125C7300404F
	for <lists+linux-tip-commits@lfdr.de>; Wed, 25 Feb 2026 15:31:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBD223D6494;
	Wed, 25 Feb 2026 15:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QP9sWW0Y";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RSgDmxRW"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0E393AE6F2;
	Wed, 25 Feb 2026 15:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772033493; cv=none; b=hP+Y7ONMH6ddXx16mfoHXwlFuVVjSlo8l/rE/eo2eWyiDbYoZtimLZT9dX+Feahy3FV89fUNEgeNOV8F0lAy5oARALzNcgmgGxvqWWshNbd+8USxUsej8eFMzZ72PN3BYJZ5mpiZQWFIgCp0q9bogj5Am6AwS+HLC+1KWKZyV58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772033493; c=relaxed/simple;
	bh=J6LPca5uTKAleQY6INt0oeV2f+8VK8UYDFayhvtKDWY=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=RPk3zOob0FDpBuD3oOYiJijyrA6b9N1jVGx7lIN1aKZgc1rIw0irMzeRgUs8qUhMMweHUmkFzEAr6LnOFYUwKfMXsgVJJqukxHNR7HP+jYlpSoHb1OKvnc0T805wbzpToObBb1Hc3kyae6rDkBOqy5edfsJbWMfkSc6lzGINICM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QP9sWW0Y; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RSgDmxRW; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 25 Feb 2026 15:31:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1772033491;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SFylRkx4SMZlstOpQsZFURe5TtMuxJvn97CeqYQStus=;
	b=QP9sWW0YFOyCQd9A6C6HGgefVtqEtdrTuww/yqartuG5Z/8N1iztHsfnSJObVPSUzPwDN7
	6A/oOV027iPnO6PvOCBPPJZ27WqZEfmCLt2s/63ZnGpujdQ9A9UN60R9m9WiYPtDJal3M5
	WehQSWrYJlPCBCnZgPQKg3oLswcwp8Y8W9e1JOPODPUPTtl6CArsCtNV3H2Knk3rel+Lnv
	KpFbYsGKV7oupDR3IDfz9VQUR7S1UN8vmjJNdqcsxIT7zODiiNWfGBAVVS2zDOfwT2qFO1
	q66wBLT0FUBwGYvY+fDOxl1GPQaF9VytUV/g6/+rIAs9qIYsrj99clF0vAqczQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1772033491;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SFylRkx4SMZlstOpQsZFURe5TtMuxJvn97CeqYQStus=;
	b=RSgDmxRW+Az0FE6FbBZEtwfLfXt6WmjRdWFISmczAXzPsuJZodOwKrFxi00ImZpFfAIxsH
	IAZYVu89A4vh+TDA==
From: "tip-bot2 for Nathan Chancellor" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: locking/urgent] lib/Kconfig.debug: Require a release version of
 LLVM 22 for context analysis
Cc: Nathan Chancellor <nathan@kernel.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Marco Elver <elver@google.com>, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To:
 <20260224-bump-clang-ver-context-analysis-v1-1-16cc7a90a040@kernel.org>
References:
 <20260224-bump-clang-ver-context-analysis-v1-1-16cc7a90a040@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <177203348968.1647592.11479912891604644667.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8260-lists,linux-tip-commits=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,infradead.org:email,vger.kernel.org:replyto,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	REPLYTO_DOM_EQ_TO_DOM(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tip-bot2@linutronix.de,linux-tip-commits@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linutronix.de:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-tip-commits];
	MISSING_XM_UA(0.00)[];
	HAS_REPLYTO(0.00)[linux-kernel@vger.kernel.org]
X-Rspamd-Queue-Id: 09C6F199A49
X-Rspamd-Action: no action

The following commit has been merged into the locking/urgent branch of tip:

Commit-ID:     ab6088e7a95943af3452b20e3b96caaaef3eeebd
Gitweb:        https://git.kernel.org/tip/ab6088e7a95943af3452b20e3b96caaaef3=
eeebd
Author:        Nathan Chancellor <nathan@kernel.org>
AuthorDate:    Tue, 24 Feb 2026 16:16:30 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 25 Feb 2026 15:36:02 +01:00

lib/Kconfig.debug: Require a release version of LLVM 22 for context analysis

Using a prerelease version as a minimum supported version for
CONFIG_WARN_CONTEXT_ANALYSIS was reasonable to do while LLVM 22 was the
development version so that people could immediately build from main and
start testing and validating this in their own code. However, it can be
problematic when using prerelease versions of LLVM 22, such as Android
clang 22.0.1 (the current android mainline compiler) or when bisecting
LLVM between llvmorg-22-init and llvmorg-23-init, to build the kernel,
as all compiler fixes for the context analysis may not be present,
potentially resulting in warnings that can easily turn into errors.

Now that LLVM 22 is released as 22.1.0, upgrade the check to require at
least this version to ensure that a user's toolchain actually has all
the changes needed for a smooth experience with context analysis.

Fixes: 3269701cb256 ("compiler-context-analysis: Add infrastructure for Conte=
xt Analysis with Clang")
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Marco Elver <elver@google.com>
Link: https://patch.msgid.link/20260224-bump-clang-ver-context-analysis-v1-1-=
16cc7a90a040@kernel.org
---
 lib/Kconfig.debug | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 4e2dfbb..8e2b858 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -630,7 +630,7 @@ config DEBUG_FORCE_WEAK_PER_CPU
=20
 config WARN_CONTEXT_ANALYSIS
 	bool "Compiler context-analysis warnings"
-	depends on CC_IS_CLANG && CLANG_VERSION >=3D 220000
+	depends on CC_IS_CLANG && CLANG_VERSION >=3D 220100
 	# Branch profiling re-defines "if", which messes with the compiler's
 	# ability to analyze __cond_acquires(..), resulting in false positives.
 	depends on !TRACE_BRANCH_PROFILING
@@ -641,7 +641,7 @@ config WARN_CONTEXT_ANALYSIS
 	  and releasing user-definable "context locks".
=20
 	  Clang's name of the feature is "Thread Safety Analysis". Requires
-	  Clang 22 or later.
+	  Clang 22.1.0 or later.
=20
 	  Produces warnings by default. Select CONFIG_WERROR if you wish to
 	  turn these warnings into errors.

