Return-Path: <linux-tip-commits+bounces-4782-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7A8EA823CB
	for <lists+linux-tip-commits@lfdr.de>; Wed,  9 Apr 2025 13:43:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5172880D32
	for <lists+linux-tip-commits@lfdr.de>; Wed,  9 Apr 2025 11:43:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93AD825E803;
	Wed,  9 Apr 2025 11:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FBQ4MCg3";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XZpyUeEt"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF31922E3F7;
	Wed,  9 Apr 2025 11:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744199003; cv=none; b=GIp+vEoz/2FZs9kAttav8cEKkmUnyLbpBtVkUo3o3BQIi9FK15SsInksGmNweQwPvv/6flJlkRhV1tV4+uJ9kis+jVQtTKu9xKJrsKaK7fTUd1B4BaJ/mAfrMay+XkiOrYjxfGTeYAcgIP6h+2lL6fln2vqC/xY/eYG5tGNGivc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744199003; c=relaxed/simple;
	bh=n21QkLAeZ0R+4WWZD/1BiczovI5boRahAtQpZFXJvGk=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=bm9WeSs1BEWdlyA2YGgJ0ugZaD8PxJt4KbgoRBUjTTPMladbcxrtH7eGpflVAEyNqNoJ9USDe78zJbmesL6rb+e0Ek7uQ5Z6xBd87buccfDX/ayEXbCo+ALpGJtp4aWWSSnPbARB/4HV6ILSjYaEPlJrcxeCgupl0rP/RWlahLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FBQ4MCg3; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XZpyUeEt; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 09 Apr 2025 11:43:19 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744199000;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=33uQZ77MnucxsNOafNAlXbntxU2rO0uiJyJGawLxGUs=;
	b=FBQ4MCg3mKgVSBGgNLQ27L6jzfJUBM4o9hTAA308Ugu59/+B+f5EWpHAY7MkjJP767zNGD
	mHfvqY/lOL9KlS3RP1vRBP7T0H0NAWvf2mcApvyZQdKoaxPdw7LhUbDfjlEkWru8TZ9V+V
	Z1nn0dZa8erBnBZoa+DLQgmEe/6W7VSk+tGNzY3qKlu8icErdyiA8LQLBhIuTb4SkubEi0
	h7JWpZW7WdJIoCXoGASFq/uanFmcfEz40khALWYHk+KKDsDSev/JyAHPvErK8CZNHr+rE3
	8QKv/4Bja8CUEv0vaYERuPGjSQinJCg+7/qz3UmgrAOu3JdVKs5GDor9jzUS0w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744199000;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=33uQZ77MnucxsNOafNAlXbntxU2rO0uiJyJGawLxGUs=;
	b=XZpyUeEtRGmfe4tlcXRSLFactWw9Z9nfDuPYoUpSLrNNoSKmP4Jtv7TvoKmBGdjQsCFJ7y
	jyuP6cFi/Kbj/gBA==
From: "tip-bot2 for Jiri Olsa" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] uprobes/x86: Add support to emulate NOP5 instruction
Cc: Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Brian Gerst <brgerst@gmail.com>,
 Juergen Gross <jgross@suse.com>, "H. Peter Anvin" <hpa@zytor.com>,
 Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250408211310.51491-1-jolsa@kernel.org>
References: <20250408211310.51491-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174419899905.31282.16125441491898382603.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     38440aebd4acc7bb3721eea77829bdb724d2551a
Gitweb:        https://git.kernel.org/tip/38440aebd4acc7bb3721eea77829bdb724d2551a
Author:        Jiri Olsa <jolsa@kernel.org>
AuthorDate:    Tue, 08 Apr 2025 23:13:09 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 09 Apr 2025 12:35:17 +02:00

uprobes/x86: Add support to emulate NOP5 instruction

Adding support to emulate NOP5 as the original uprobe instruction.

This change speeds up uprobe on top of NOP5 and is a preparation for
usdt probe optimization, that will be done on top of NOP5 instruction.

With this change the usdt probe on top of NOP5 won't take the performance
hit compared to usdt probe on top of standard NOP instruction.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Link: https://lore.kernel.org/r/20250408211310.51491-1-jolsa@kernel.org
---
 arch/x86/kernel/uprobes.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/x86/kernel/uprobes.c b/arch/x86/kernel/uprobes.c
index 9194695..63cc68e 100644
--- a/arch/x86/kernel/uprobes.c
+++ b/arch/x86/kernel/uprobes.c
@@ -608,6 +608,16 @@ static void riprel_post_xol(struct arch_uprobe *auprobe, struct pt_regs *regs)
 		*sr = utask->autask.saved_scratch_register;
 	}
 }
+
+static int is_nop5_insn(uprobe_opcode_t *insn)
+{
+	return !memcmp(insn, x86_nops[5], 5);
+}
+
+static bool emulate_nop5_insn(struct arch_uprobe *auprobe)
+{
+	return is_nop5_insn((uprobe_opcode_t *) &auprobe->insn);
+}
 #else /* 32-bit: */
 /*
  * No RIP-relative addressing on 32-bit
@@ -621,6 +631,10 @@ static void riprel_pre_xol(struct arch_uprobe *auprobe, struct pt_regs *regs)
 static void riprel_post_xol(struct arch_uprobe *auprobe, struct pt_regs *regs)
 {
 }
+static bool emulate_nop5_insn(struct arch_uprobe *auprobe)
+{
+	return false;
+}
 #endif /* CONFIG_X86_64 */
 
 struct uprobe_xol_ops {
@@ -852,6 +866,8 @@ static int branch_setup_xol_ops(struct arch_uprobe *auprobe, struct insn *insn)
 		break;
 
 	case 0x0f:
+		if (emulate_nop5_insn(auprobe))
+			goto setup;
 		if (insn->opcode.nbytes != 2)
 			return -ENOSYS;
 		/*

