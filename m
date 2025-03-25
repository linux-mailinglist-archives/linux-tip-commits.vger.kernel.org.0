Return-Path: <linux-tip-commits+bounces-4547-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D6722A70C9A
	for <lists+linux-tip-commits@lfdr.de>; Tue, 25 Mar 2025 23:11:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 916D4189B95A
	for <lists+linux-tip-commits@lfdr.de>; Tue, 25 Mar 2025 22:10:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F35B26A0CA;
	Tue, 25 Mar 2025 22:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1vfqCbme";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RKc7vq/f"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE25626A089;
	Tue, 25 Mar 2025 22:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742940601; cv=none; b=CGCTIHVh1U1ajrkgoJ8UIN0bbTf4J1WwqlOQiBrvGDtR/N8Uuak1wp0q2s2Ffr5h1X1GbsJVjvzuSmxTu9zz/YZtWiifSvlRp6BjDyTIpUvCfOm5PFnJCWVrh49vTUhKLBrx6weJffG8TR/vq4g2r4vVMwUafLjKq8jAPya055I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742940601; c=relaxed/simple;
	bh=RqAXqi9jp2Hz0wvQKiUyPPhc63Hf/9yevhWlVZvCm2s=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=UcZNkQFjEW5JhlbTPtq81cnQiHsaJCMnB4v/p8CCDaxF7d8VS9QiawwFX27qglp3VG5LL1AlIeD24K4MKYp6eHBPZOZsLYnCXbpW0sJHdxMh/bvpahlMIYNr0n53q1qxP/DoV+QLfMn8hBoCQ4LC83mT6aNic2wRHl3W6nz+JTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1vfqCbme; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RKc7vq/f; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 25 Mar 2025 22:09:57 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742940598;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lDsRPElPddL87uhXICVdDaI8K/CYp49SGGqBMBqq/QM=;
	b=1vfqCbmeokDB25PuHORfOqA5xG7Mv34jUbHfnRqpNmLxV+FdwJQ3LiTxPUhbyh0/JmcAtl
	BSFvS24NBzCiL2Fn6xIJZ0qYknvsYAYXIees+m5LZHBAw52FvU8TOQXtDJa635Uf8UYj6l
	uzEIfmmpln+cWm1YYeGk7F1EFHBEdZOxyHgZe9H0b7a8+gVqV0gYL4BujRK+mFCKDTJ2kT
	xuwBlp0Ecwz0UoshGkud3taxKjWSfKnFAlPHohljycJDt6wqzJCUM/HLyNTcRtsvW+wkzN
	yTyMjwCqzZmrlK48dsIZYSbesO5HV/xa7qRJr9CuWAu7jzQgbzxBSfpKviqKuQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742940598;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lDsRPElPddL87uhXICVdDaI8K/CYp49SGGqBMBqq/QM=;
	b=RKc7vq/fy02KvVJdjz24yRz4vZFyf15wKPDo5Da+dbekqR5pWCYfRkGBrp73H6NBH7iks4
	owBN7iLmgJakozAQ==
From: "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: objtool/urgent] objtool, panic: Disable SMAP in __stack_chk_fail()
Cc: Josh Poimboeuf <jpoimboe@kernel.org>, Ingo Molnar <mingo@kernel.org>,
 Kees Cook <keescook@chromium.org>, Andrew Morton <akpm@linux-foundation.org>,
 Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To:
 <a3e97e0119e1b04c725a8aa05f7bc83d98e657eb.1742852847.git.jpoimboe@kernel.org>
References:
 <a3e97e0119e1b04c725a8aa05f7bc83d98e657eb.1742852847.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174294059741.14745.11488224291595030457.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the objtool/urgent branch of tip:

Commit-ID:     72c774aa9d1e16bfd247096935e7dae194d84929
Gitweb:        https://git.kernel.org/tip/72c774aa9d1e16bfd247096935e7dae194d84929
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Mon, 24 Mar 2025 14:56:07 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 25 Mar 2025 23:00:15 +01:00

objtool, panic: Disable SMAP in __stack_chk_fail()

__stack_chk_fail() can be called from uaccess-enabled code.  Make sure
uaccess gets disabled before calling panic().

Fixes the following warning:

  kernel/trace/trace_branch.o: error: objtool: ftrace_likely_update+0x1ea: call to __stack_chk_fail() with UACCESS enabled

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Kees Cook <keescook@chromium.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/r/a3e97e0119e1b04c725a8aa05f7bc83d98e657eb.1742852847.git.jpoimboe@kernel.org
---
 kernel/panic.c        | 6 ++++++
 tools/objtool/check.c | 5 ++++-
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/kernel/panic.c b/kernel/panic.c
index d8635d5..f9f0c51 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -832,9 +832,15 @@ device_initcall(register_warn_debugfs);
  */
 __visible noinstr void __stack_chk_fail(void)
 {
+	unsigned long flags;
+
 	instrumentation_begin();
+	flags = user_access_save();
+
 	panic("stack-protector: Kernel stack is corrupted in: %pB",
 		__builtin_return_address(0));
+
+	user_access_restore(flags);
 	instrumentation_end();
 }
 EXPORT_SYMBOL(__stack_chk_fail);
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 0caabf0..3bf2992 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -1194,12 +1194,15 @@ static const char *uaccess_safe_builtin[] = {
 	"__ubsan_handle_load_invalid_value",
 	/* STACKLEAK */
 	"stackleak_track_stack",
+	/* TRACE_BRANCH_PROFILING */
+	"ftrace_likely_update",
+	/* STACKPROTECTOR */
+	"__stack_chk_fail",
 	/* misc */
 	"csum_partial_copy_generic",
 	"copy_mc_fragile",
 	"copy_mc_fragile_handle_tail",
 	"copy_mc_enhanced_fast_string",
-	"ftrace_likely_update", /* CONFIG_TRACE_BRANCH_PROFILING */
 	"rep_stos_alternative",
 	"rep_movs_alternative",
 	"__copy_user_nocache",

