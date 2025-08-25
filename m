Return-Path: <linux-tip-commits+bounces-6358-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1B5CB33CAB
	for <lists+linux-tip-commits@lfdr.de>; Mon, 25 Aug 2025 12:28:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D1D74857AC
	for <lists+linux-tip-commits@lfdr.de>; Mon, 25 Aug 2025 10:27:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79A992E5D01;
	Mon, 25 Aug 2025 10:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EBUnKa03";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="i3JRM6A8"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 754F72E54CE;
	Mon, 25 Aug 2025 10:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756117497; cv=none; b=ZcQUTo8ED+ytAjcXXnRkPdtbuUdWLSaD74Uz3jcaoZEEAcbvsnZenWM3bJ9bfaWHc2BQoduvOupZtz1WLHQUJYNq+NmRs4tH39iHnhekFrwErciYvRDu9GfGiER8vv/cj+QPmUrOKOhaRdQAYF7a3ZFq7xeaZmA2tuozyLf7aK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756117497; c=relaxed/simple;
	bh=txYpt3lZIcIGZo5YxRdrLIZUZATQGbo31og7wsAOYj4=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=M3P/7ju/+UTvrlcdsI4NCXxItK8tXG6hMxsfNGv2tPHO7ma2N8EPpC1VD7izNMotpET/0/9toWaUNNQUs2q5yXR87eyHDorgilFq3uJPGNlPXT7VAcBZ+mWomHRyth4nItxLZr3bY0wtCcZZcU5p164WWIOMbacMgpNxsi2oYAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=EBUnKa03; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=i3JRM6A8; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 25 Aug 2025 10:24:52 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1756117493;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6/YML6I0X7DLfQAVloDmB4ABh92hJk1kVSbQfmggARo=;
	b=EBUnKa03Ak1zFo+8afnOr1TA84Q6bwTxrhLRTryv77msXd0ZEtKzqQw7KksYIyQC4VD2H2
	JilMALT246va3DFjDjmfETlEDv9TBOy0V7uHz/zMa7EMNVxnJYM62N4ycGbGYSGWX6DjHQ
	OEYpnMAb5ntRS+IOJd7hiBB5FXgnPLBDG9/mMYaUNqEPff7TPUeaiy6rJmE11yK8lSpqvH
	U8kvBkHPdehBiXg6eqTmDugbLielPpDL3hHI52f3aVQXzimTsuWemrGDB5lSuFjig3fzNJ
	5ANd8PjJdfdsLeI+QAzvCDSN/07mLODCn+CTfgwK/gH0G5AO3OrZOOQ/zR9eRQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1756117493;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6/YML6I0X7DLfQAVloDmB4ABh92hJk1kVSbQfmggARo=;
	b=i3JRM6A8mw5UkR4I1KSqMufPOE/5zdqFov62fJMoDFzgMJSMquOEYlbXojnRwbxpqDiuOU
	Io+Od/wTgjuuQODw==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] uprobes/x86: Make asm style consistent
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250821123657.163417243@infradead.org>
References: <20250821123657.163417243@infradead.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175611749254.1420.4676066283924123851.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     60ed85b7e46983725954103beaca5ca41816cd58
Gitweb:        https://git.kernel.org/tip/60ed85b7e46983725954103beaca5ca4181=
6cd58
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Thu, 21 Aug 2025 13:48:48 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 21 Aug 2025 20:09:22 +02:00

uprobes/x86: Make asm style consistent

The asm syntax in uretprobe_trampoline and uprobe_trampoline differs
in the use of operand size suffixes. Make them consistent and remove
all size suffixes.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20250821123657.163417243@infradead.org
---
 arch/x86/kernel/uprobes.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kernel/uprobes.c b/arch/x86/kernel/uprobes.c
index ab6547b..643027e 100644
--- a/arch/x86/kernel/uprobes.c
+++ b/arch/x86/kernel/uprobes.c
@@ -321,21 +321,21 @@ asm (
 	".pushsection .rodata\n"
 	".global uretprobe_trampoline_entry\n"
 	"uretprobe_trampoline_entry:\n"
-	"pushq %rax\n"
-	"pushq %rcx\n"
-	"pushq %r11\n"
-	"movq $" __stringify(__NR_uretprobe) ", %rax\n"
+	"push %rax\n"
+	"push %rcx\n"
+	"push %r11\n"
+	"mov $" __stringify(__NR_uretprobe) ", %rax\n"
 	"syscall\n"
 	".global uretprobe_syscall_check\n"
 	"uretprobe_syscall_check:\n"
-	"popq %r11\n"
-	"popq %rcx\n"
+	"pop %r11\n"
+	"pop %rcx\n"
 	/*
 	 * The uretprobe syscall replaces stored %rax value with final
 	 * return address, so we don't restore %rax in here and just
 	 * call ret.
 	 */
-	"retq\n"
+	"ret\n"
 	".global uretprobe_trampoline_end\n"
 	"uretprobe_trampoline_end:\n"
 	".popsection\n"
@@ -885,7 +885,7 @@ asm (
 	"push %rcx\n"
 	"push %r11\n"
 	"push %rax\n"
-	"movq $" __stringify(__NR_uprobe) ", %rax\n"
+	"mov $" __stringify(__NR_uprobe) ", %rax\n"
 	"syscall\n"
 	"pop %rax\n"
 	"pop %r11\n"

