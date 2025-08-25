Return-Path: <linux-tip-commits+bounces-6360-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C075B33CB6
	for <lists+linux-tip-commits@lfdr.de>; Mon, 25 Aug 2025 12:28:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D03BC189D2B1
	for <lists+linux-tip-commits@lfdr.de>; Mon, 25 Aug 2025 10:28:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D8152E62AE;
	Mon, 25 Aug 2025 10:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xY4b5NdK";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rQTKhLJn"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1C8D2E54C3;
	Mon, 25 Aug 2025 10:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756117499; cv=none; b=R2NS1Pue9ZzHw6igclsQsDE9ou7n47g91eYpgH2htE52P0XPfeNsNMIOa8DODmbrW8RLgB0e98HBHJbUazL6xNE3S6zi5LYST5wOdLgs2dTZasbcNSyV5Y6QP+CzEb1pliMQRKnZg1Z2+Ovnsi3E61m4EyYilHxSDz8v57rR7EE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756117499; c=relaxed/simple;
	bh=R2ZQx1RJDJBGqDuIQaFMQ/OO6G8bKJ+Ye2EN2RNNdPw=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=olUAOM/KMhR0FhQw2oNnlIVm3c/u2j6QkVyM55HRHsGP/q5uUgQWfJ4FB7HiYLJoBwUPn9aCFfajmoSFkBBwGhmPEbwdnA7gXnC4a1pXeyze2/0blRXb8goBrThJXulOpCrucWPwgXX/FSos+3DPVvMpZDpi5YrYDG+kaOWjQOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xY4b5NdK; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rQTKhLJn; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 25 Aug 2025 10:24:54 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1756117496;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eSQfp8mFaa6SIcRgbSbFadrbr1Gpo9jIvgkKF5QqYig=;
	b=xY4b5NdK46pN0QVgLgO7mQdHDsUaFegAr/bnwbeJwhNu1hU500uiZF1JvIl7E60+z+zxTQ
	EqjEEo2rhnFz7/ZgxlmM32m1jiRSKLO3sibSPbMI4VOT73RwxZ/M2r+/qzkODmeaNiZKYS
	0zEgPsEX9/Wg3PQtkyuyBuie+Vmy91u9Dvwq6QROnuS2uv58j1FdtRsIqFGJUUqPOTvX3+
	VbaZvULmtE/KbB5JtUnXyfQIwZowtUpI7odRuHEYARymnUlZv88NWSz+TuB8AEQPf91OdM
	dTsQFK+Pm4A6gCsBgR6u/ev/zP9sprIO1QpqfIL5ZAUD8tuChOvEgUvXhajifw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1756117496;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eSQfp8mFaa6SIcRgbSbFadrbr1Gpo9jIvgkKF5QqYig=;
	b=rQTKhLJnOMt1+WxyNmvjAbsSi90mGLl9HZrYHN0rRqFdUMzaMsDJJ6CBXi2pAggY9DQ2e+
	vjiVKap6lQLOsiAQ==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] uprobes/x86: Accept more NOP forms
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250821123656.935559566@infradead.org>
References: <20250821123656.935559566@infradead.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175611749490.1420.617545851066198361.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     7c2bfc183b05103287cc32ad68184f7d4312c06d
Gitweb:        https://git.kernel.org/tip/7c2bfc183b05103287cc32ad68184f7d431=
2c06d
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Wed, 20 Aug 2025 12:55:14 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 21 Aug 2025 20:09:21 +02:00

uprobes/x86: Accept more NOP forms

Instead of only accepting the x86_64 nop5 chosen by the kernel, accept
any x86_64 NOP or NOPL instruction that is 5 bytes.

Notably, the x86_64 nop5 pattern is valid in 32bit apps and could get
compiler generated when build for i686 (which introduced NOPL). Since
the trampoline is x86_64 only, make sure to limit to x86_64 code.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20250821123656.935559566@infradead.org
---
 arch/x86/kernel/uprobes.c | 37 ++++++++++++++++++++++++++++++++-----
 1 file changed, 32 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/uprobes.c b/arch/x86/kernel/uprobes.c
index 3b46a89..d513c97 100644
--- a/arch/x86/kernel/uprobes.c
+++ b/arch/x86/kernel/uprobes.c
@@ -1157,10 +1157,37 @@ unlock:
 	mmap_write_unlock(mm);
 }
=20
-static bool can_optimize(struct arch_uprobe *auprobe, unsigned long vaddr)
+static bool insn_is_nop(struct insn *insn)
 {
-	if (memcmp(&auprobe->insn, x86_nops[5], 5))
+	return insn->opcode.nbytes =3D=3D 1 && insn->opcode.bytes[0] =3D=3D 0x90;
+}
+
+static bool insn_is_nopl(struct insn *insn)
+{
+	if (insn->opcode.nbytes !=3D 2)
+		return false;
+
+	if (insn->opcode.bytes[0] !=3D 0x0f || insn->opcode.bytes[1] !=3D 0x1f)
+		return false;
+
+	if (!insn->modrm.nbytes)
+		return false;
+
+	if (X86_MODRM_REG(insn->modrm.bytes[0]) !=3D 0)
+		return false;
+
+	/* 0f 1f /0 - NOPL */
+	return true;
+}
+
+static bool can_optimize(struct insn *insn, unsigned long vaddr)
+{
+	if (!insn->x86_64 || insn->length !=3D 5)
 		return false;
+
+	if (!insn_is_nop(insn) && !insn_is_nopl(insn))
+		return false;
+
 	/* We can't do cross page atomic writes yet. */
 	return PAGE_SIZE - (vaddr & ~PAGE_MASK) >=3D 5;
 }
@@ -1177,7 +1204,7 @@ static void riprel_pre_xol(struct arch_uprobe *auprobe,=
 struct pt_regs *regs)
 static void riprel_post_xol(struct arch_uprobe *auprobe, struct pt_regs *reg=
s)
 {
 }
-static bool can_optimize(struct arch_uprobe *auprobe, unsigned long vaddr)
+static bool can_optimize(struct insn *insn, unsigned long vaddr)
 {
 	return false;
 }
@@ -1539,15 +1566,15 @@ static int push_setup_xol_ops(struct arch_uprobe *aup=
robe, struct insn *insn)
  */
 int arch_uprobe_analyze_insn(struct arch_uprobe *auprobe, struct mm_struct *=
mm, unsigned long addr)
 {
-	struct insn insn;
 	u8 fix_ip_or_call =3D UPROBE_FIX_IP;
+	struct insn insn;
 	int ret;
=20
 	ret =3D uprobe_init_insn(auprobe, &insn, is_64bit_mm(mm));
 	if (ret)
 		return ret;
=20
-	if (can_optimize(auprobe, addr))
+	if (can_optimize(&insn, addr))
 		set_bit(ARCH_UPROBE_FLAG_CAN_OPTIMIZE, &auprobe->flags);
=20
 	ret =3D branch_setup_xol_ops(auprobe, &insn);

