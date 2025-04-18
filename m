Return-Path: <linux-tip-commits+bounces-5058-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8D92A93357
	for <lists+linux-tip-commits@lfdr.de>; Fri, 18 Apr 2025 09:15:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3EB546449E
	for <lists+linux-tip-commits@lfdr.de>; Fri, 18 Apr 2025 07:15:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73E9926A0E2;
	Fri, 18 Apr 2025 07:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QJXI6gaR";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZOJQ6wGQ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5A5C2571CF;
	Fri, 18 Apr 2025 07:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744960506; cv=none; b=RIiOBAEd+OePP2+jBZGL8dAC1jYUu1JRtf5bOWZtbso8M4vHWnQUaxZEGhFytkhxN8Byh6ntvXwhTsueuG2DwSWmSwuGfnlIYV8lmV4fZhBuw8CuAyyOp6TOUZ4cDLZOFyPCAhN5Sv4nCamqSe2mN6FsZRf+I/kARRNSdWYbPsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744960506; c=relaxed/simple;
	bh=Wtw/oNtZGlPn5EsTcIh48DpbmWA8Wfaotp9jT9wOB0w=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Xlzx7jSE6U+fFRKT3j67iFdEOfjUcBDYIiazzXKaQKaNOEshyBMuCF30+dka8udAqwdXpS6vgrgq8Kbi4bDu4adBBKoSDDjMP+9FInvYGKofXdNvd2s+qC/IUTwwYa0+M9qRlWHue0IlN++QevFjsEgGy2LCoiwddxU+6VmAI1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QJXI6gaR; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZOJQ6wGQ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 18 Apr 2025 07:15:02 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744960503;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e4PB6JDxuxq+bT4QOlcDzuE+mYx5gAr1KJ5ZJ4k85cU=;
	b=QJXI6gaRxZ62aocjUacWd4y1gW+X9AEIESID+285j5AIlIXlARBCUfkxwjcqgZ7/P6ywPk
	6V3XY0LZn2+yuOyAyP5xaOyijlZlAUKRqTKovCEFSTgS2q6rslLUF4gCnUldCtYWq5tR4q
	56d3ZqfNqdUVXWkwPR9mDkX68lUV90Qe7XHN/UhyEEgjx60dtPiiJI46ikjC5ZWoga0AIB
	m4AC5kty8BOmWCIKpUt69eW7aTJvMQ04ymA8yWeu69EjVmAML+67+qSLiZfPtHrWKfrjZI
	4B3uS+IIy0fM5fLu4rlcfAxZeJSWITuhkvuWsfQwkNq8Bmiwu77W+B0jf6R45g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744960503;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e4PB6JDxuxq+bT4QOlcDzuE+mYx5gAr1KJ5ZJ4k85cU=;
	b=ZOJQ6wGQvEjAyWQhIDDoA5FnbQVdh1n61KbW4tE9Og+XFaYos8CqUhk8z2a63PZ1LUXuxP
	waFiaO37fzVKtICA==
From: "tip-bot2 for Jiri Olsa" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] uprobes/x86: Add support to emulate NOP instructions
Cc: Oleg Nesterov <oleg@redhat.com>, Andrii Nakryiko <andrii@kernel.org>,
 Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@kernel.org>,
 Alan Maguire <alan.maguire@oracle.com>, Hao Luo <haoluo@google.com>,
 John Fastabend <john.fastabend@gmail.com>,
 Masami Hiramatsu <mhiramat@kernel.org>, Song Liu <songliubraving@fb.com>,
 Steven Rostedt <rostedt@goodmis.org>, Yonghong Song <yhs@fb.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250414083647.1234007-1-jolsa@kernel.org>
References: <20250414083647.1234007-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174496050221.31282.986459648353750898.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     610f6e14c29dc7f9637e8d9481e9f241f355e2e4
Gitweb:        https://git.kernel.org/tip/610f6e14c29dc7f9637e8d9481e9f241f355e2e4
Author:        Jiri Olsa <jolsa@kernel.org>
AuthorDate:    Mon, 14 Apr 2025 10:36:46 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 18 Apr 2025 09:03:05 +02:00

uprobes/x86: Add support to emulate NOP instructions

Add support to emulate all NOP instructions as the original uprobe
instruction.

This change speeds up uprobe on top of all NOP instructions and is a
preparation for usdt probe optimization, that will be done on top of
NOP5 instructions.

With this change the usdt probe on top of NOP5s won't take the performance
hit compared to usdt probe on top of standard NOP instructions.

Suggested-by: Oleg Nesterov <oleg@redhat.com>
Suggested-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Oleg Nesterov <oleg@redhat.com>
Acked-by: Andrii Nakryiko <andrii@kernel.org>
Cc: Alan Maguire <alan.maguire@oracle.com>
Cc: Hao Luo <haoluo@google.com>
Cc: John Fastabend <john.fastabend@gmail.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Song Liu <songliubraving@fb.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Yonghong Song <yhs@fb.com>
Link: https://lore.kernel.org/r/20250414083647.1234007-1-jolsa@kernel.org
---
 arch/x86/kernel/uprobes.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/x86/kernel/uprobes.c b/arch/x86/kernel/uprobes.c
index 9194695..6d38383 100644
--- a/arch/x86/kernel/uprobes.c
+++ b/arch/x86/kernel/uprobes.c
@@ -840,6 +840,11 @@ static int branch_setup_xol_ops(struct arch_uprobe *auprobe, struct insn *insn)
 	insn_byte_t p;
 	int i;
 
+	/* x86_nops[insn->length]; same as jmp with .offs = 0 */
+	if (insn->length <= ASM_NOP_MAX &&
+	    !memcmp(insn->kaddr, x86_nops[insn->length], insn->length))
+		goto setup;
+
 	switch (opc1) {
 	case 0xeb:	/* jmp 8 */
 	case 0xe9:	/* jmp 32 */

