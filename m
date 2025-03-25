Return-Path: <linux-tip-commits+bounces-4488-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89DD2A6EC44
	for <lists+linux-tip-commits@lfdr.de>; Tue, 25 Mar 2025 10:08:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 063943B2174
	for <lists+linux-tip-commits@lfdr.de>; Tue, 25 Mar 2025 09:08:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A812257ADE;
	Tue, 25 Mar 2025 09:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="v3GyQ7qb";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AO3u9uy1"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3A26256C89;
	Tue, 25 Mar 2025 09:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742893551; cv=none; b=e3lcxdCMtyAoKfht3LeC73bUqBT8/vlgQcJ4vQfaUaW97qS+XeKTzfucZgNprzDp8clsbuONLORoMEWAw0TWjNfU3PFrFX32yWsO8XrT0cS0ZIuwJ5SoQaAh740A612F8hFl1ksG9RsC2dHsGVgFGh7ymWjNBavxkhDzWVJD1ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742893551; c=relaxed/simple;
	bh=VNU84tiygkm/fVeSQCUj7891f2hzElGzx+ciHhjMQS8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=IPnRThp3e0Nb8sLrmCHYYHcyzpsV28XvfBa3xgpybf6DiHTUoyKRcrAs5rtZe9uiW+crqMAZDK0TTb3Xcu/g/dPYFLUFjNwRk8JVpncItSek0KDHYD/cOcQJ5exXGxrELfLKkYuhJ9ToifupG+KTbmlVeJXdtXrTyOThRY/wgCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=v3GyQ7qb; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=AO3u9uy1; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 25 Mar 2025 09:05:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742893547;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=chNV5b91bWojdYCbY06zEs0yjK7lHf9gXreY29chj3k=;
	b=v3GyQ7qbxKumJIaQrCc1fLpSM2emSJRl3XNZhEaCvjfHF/lhqIuin7+QKH2tMV4sbgOB63
	bvgR5W8KeWSkYniFkkO2GuKrWjAuLxXpJF7jqCrCQmUvZ7FO7tWLQ43gupOfo9mr9l1nKW
	Ou+0H9ub7yMUVTVtiJ7jp8U0eNvbN/vNWV/XPACdoVl7Muah8YSthXJ79syDqATP+mw6Vs
	hOD84L4GRK+6c2Rf/8jsmtQ7TgykRDVLU+99hwkmRFrKZgmmonWpU3W+jHocCQ4arA7ZFh
	iylublR919uQtlp4UvDdYuzhjdyeWbNf/qdr1UEHQBG5qQnksqhkD+dDSUpRJw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742893547;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=chNV5b91bWojdYCbY06zEs0yjK7lHf9gXreY29chj3k=;
	b=AO3u9uy161lvIangrC7xfHR2mVsOwtonZDfkA5di2wBxoJqilZFqYL/kmeE+flw8Uzugqf
	ZmfjybgOK7EeG+CQ==
From: "tip-bot2 for Ahmed S. Darwish" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/cpu] tools/x86/kcpuid: Exit the program on invalid parameters
Cc: "Ahmed S. Darwish" <darwi@linutronix.de>, Ingo Molnar <mingo@kernel.org>,
 "H. Peter Anvin" <hpa@zytor.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250324142042.29010-3-darwi@linutronix.de>
References: <20250324142042.29010-3-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174289354654.14745.7813168122836962597.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     a866a6775793a2554585073704b83c4691d80740
Gitweb:        https://git.kernel.org/tip/a866a6775793a2554585073704b83c4691d80740
Author:        Ahmed S. Darwish <darwi@linutronix.de>
AuthorDate:    Mon, 24 Mar 2025 15:20:23 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 25 Mar 2025 09:53:44 +01:00

tools/x86/kcpuid: Exit the program on invalid parameters

If the user passed an invalid CPUID index value through --leaf=index,
kcpuid prints a warning, does nothing, then exits successfully.
Transform the warning to an error, and exit the program with a proper
error code.

Similarly, if the user passed an invalid subleaf, kcpuid prints a
warning, dumps the whole leaf, then exits successfully.  Print a clear
error message regarding the invalid subleaf and exit the program with the
proper error code.

Note, moving the "Invalid input index" message from index_to_func() to
show_info() localizes error message handling to the latter, where it
should be.  It also allows index_to_func() to be refactored at further
commits.

Note, since after this commit and its parent kcpuid does not just "move
on" on failures, remove the NULL parameter check plus silent exit at
show_func() and show_leaf().

Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Link: https://lore.kernel.org/r/20250324142042.29010-3-darwi@linutronix.de
---
 tools/arch/x86/kcpuid/kcpuid.c | 22 ++++++++--------------
 1 file changed, 8 insertions(+), 14 deletions(-)

diff --git a/tools/arch/x86/kcpuid/kcpuid.c b/tools/arch/x86/kcpuid/kcpuid.c
index 40a9e59..25b10fe 100644
--- a/tools/arch/x86/kcpuid/kcpuid.c
+++ b/tools/arch/x86/kcpuid/kcpuid.c
@@ -481,9 +481,6 @@ static void decode_bits(u32 value, struct reg_desc *rdesc, enum cpuid_reg reg)
 
 static void show_leaf(struct subleaf *leaf)
 {
-	if (!leaf)
-		return;
-
 	if (show_raw) {
 		leaf_print_raw(leaf);
 	} else {
@@ -505,9 +502,6 @@ static void show_func(struct cpuid_func *func)
 {
 	int i;
 
-	if (!func)
-		return;
-
 	for (i = 0; i < func->nr; i++)
 		show_leaf(&func->leafs[i]);
 }
@@ -528,10 +522,9 @@ static inline struct cpuid_func *index_to_func(u32 index)
 	range = (index & 0x80000000) ? leafs_ext : leafs_basic;
 	func_idx = index & 0xffff;
 
-	if ((func_idx + 1) > (u32)range->nr) {
-		warnx("Invalid input index (0x%x)", index);
+	if ((func_idx + 1) > (u32)range->nr)
 		return NULL;
-	}
+
 	return &range->funcs[func_idx];
 }
 
@@ -550,18 +543,19 @@ static void show_info(void)
 		/* Only show specific leaf/subleaf info */
 		func = index_to_func(user_index);
 		if (!func)
-			return;
+			errx(EXIT_FAILURE, "Invalid input leaf (0x%x)", user_index);
 
 		/* Dump the raw data also */
 		show_raw = true;
 
 		if (user_sub != 0xFFFFFFFF) {
-			if (user_sub + 1 <= (u32)func->nr) {
-				show_leaf(&func->leafs[user_sub]);
-				return;
+			if (user_sub + 1 > (u32)func->nr) {
+				errx(EXIT_FAILURE, "Leaf 0x%x has no valid subleaf = 0x%x",
+				     user_index, user_sub);
 			}
 
-			warnx("Invalid input subleaf (0x%x)", user_sub);
+			show_leaf(&func->leafs[user_sub]);
+			return;
 		}
 
 		show_func(func);

