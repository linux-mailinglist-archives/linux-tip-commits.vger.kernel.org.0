Return-Path: <linux-tip-commits+bounces-3-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A823F80C8FF
	for <lists+linux-tip-commits@lfdr.de>; Mon, 11 Dec 2023 13:06:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 300F7B21115
	for <lists+linux-tip-commits@lfdr.de>; Mon, 11 Dec 2023 12:06:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64FBF3A276;
	Mon, 11 Dec 2023 12:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2B0cL0Hw";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MTpmbXwL"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68B3BFD;
	Mon, 11 Dec 2023 04:06:20 -0800 (PST)
Date: Mon, 11 Dec 2023 12:06:18 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1702296379;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VfTPl/nW9rDgb6I9nd5VFUQTJIv7AQKSpG+8w24XWxg=;
	b=2B0cL0HwQk/aPIxgPF+q3+qmJmNCR2zriNdqdInHiEhpQqEmxHpUqJ/2MkWq4FCsixWtUz
	2zvwuM+bNqmw2oweLeQLb9Jd64G+WkwRlrewYava2VEStdMPvalbRxv8IVNK27/cctY3NR
	eSEtWHoPHG4i0jLkSXz/d6xw5cyb8Um5I0wT5XzyRnnvKveyUDCWKHA7ProO1iTvsSs+Pn
	S9W93ggkargHHzmDdbvrrFs0hHyU46/Z7K2EKebSwWfMVGoHuNXSvF55CcBty0Yi25ECmT
	mlt1hZjSM6oXNhjSLhrsqH+uqOB7uJJTkKPEowIQTosXVDgYZ5UbS460wre1kw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1702296379;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VfTPl/nW9rDgb6I9nd5VFUQTJIv7AQKSpG+8w24XWxg=;
	b=MTpmbXwLJP4DtyKIdC+P4R64LflOAoTXmLRUR1JyGN9kGMpqEIcJVqIhKMTk7SkswX6K+p
	ZLsVldSOFqLFMrCA==
From: "tip-bot2 for Uros Bizjak" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/percpu] x86/traps: Use current_top_of_stack() helper in traps.c
Cc: Uros Bizjak <ubizjak@gmail.com>, Ingo Molnar <mingo@kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20231204210320.114429-2-ubizjak@gmail.com>
References: <20231204210320.114429-2-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170229637816.398.6506455819507623200.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/percpu branch of tip:

Commit-ID:     13408c6ae684181d53c870cceddbd3a62ae34c3e
Gitweb:        https://git.kernel.org/tip/13408c6ae684181d53c870cceddbd3a62ae34c3e
Author:        Uros Bizjak <ubizjak@gmail.com>
AuthorDate:    Mon, 04 Dec 2023 22:02:30 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 11 Dec 2023 11:47:15 +01:00

x86/traps: Use current_top_of_stack() helper in traps.c

Use current_top_of_stack() helper in sync_regs() and vc_switch_off_ist()
instead of open-coding the reading of  the top_of_stack percpu variable
explicitly.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/r/20231204210320.114429-2-ubizjak@gmail.com
---
 arch/x86/kernel/traps.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index c876f1d..78b1d1a 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -772,7 +772,7 @@ DEFINE_IDTENTRY_RAW(exc_int3)
  */
 asmlinkage __visible noinstr struct pt_regs *sync_regs(struct pt_regs *eregs)
 {
-	struct pt_regs *regs = (struct pt_regs *)this_cpu_read(pcpu_hot.top_of_stack) - 1;
+	struct pt_regs *regs = (struct pt_regs *)current_top_of_stack() - 1;
 	if (regs != eregs)
 		*regs = *eregs;
 	return regs;
@@ -790,7 +790,7 @@ asmlinkage __visible noinstr struct pt_regs *vc_switch_off_ist(struct pt_regs *r
 	 * trust it and switch to the current kernel stack
 	 */
 	if (ip_within_syscall_gap(regs)) {
-		sp = this_cpu_read(pcpu_hot.top_of_stack);
+		sp = current_top_of_stack();
 		goto sync;
 	}
 

