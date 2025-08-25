Return-Path: <linux-tip-commits+bounces-6361-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 80B65B33CB1
	for <lists+linux-tip-commits@lfdr.de>; Mon, 25 Aug 2025 12:28:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EBAF47A4085
	for <lists+linux-tip-commits@lfdr.de>; Mon, 25 Aug 2025 10:26:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 568632E7171;
	Mon, 25 Aug 2025 10:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RXtmXLWd";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Dy3RPpNK"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4E9D2E610E;
	Mon, 25 Aug 2025 10:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756117500; cv=none; b=myUty/2wJOACmsYwiG7tleC3O8LlOYnr/OpaKKs2LvXhkAUmfleu6HxgX0eXmKnH9Z8JDOWnP/WzeisH6pta2VYqokC2+ufF7Lzi/fccLaiBusBn6X4LfKAoqY0glkqVkXvNfHatN4/tMK5VBwgpHNNwXT0vUVik7rXqWq+KWuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756117500; c=relaxed/simple;
	bh=d2sEt1hM4lv6B8uYu2g1ptoQ3GW0GAMcjQEwG1mYXDI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=ljZU9GwJvnd8ui6S6Shl4o2Bnw4outjsLWWzKz+L5hEFeV42bNjG36SWxSckQrhXc4tjR16lyXKZAeMjyCsdnQEbDTsxstZ78BTC+1/phr7Fl+TSZH+DNY4PJ1v8avTsy8s0hLP3fQYH0mPK5Kdxh5p1IyLtJxmktix7Shtr45k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RXtmXLWd; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Dy3RPpNK; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 25 Aug 2025 10:24:56 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1756117497;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ivoSCd+ziWWonZzqJqSp7g/uVZjkS0BlMnw7IdPb3M8=;
	b=RXtmXLWdWFyd2QX8uirmcqj72evEObDoEZJ3xibgso20fpoCOhopzwEsPOC8xJFmB2fr/I
	ftLGdiAvWybxCLGMktkA5L6Ei4M3Z2c3g9mLDGGOj0mG4JOiAGidhXNiL0gR8MO5h/h+0p
	whGdQpcGrtIzXPOujXF5gu98jTXxLFaUkaXZ/ln8QqTVFPJb/AgndvQnRGwVZE8L+owMOr
	HQoKPTnasr57YP1qCur25BZwZ1GmrVIKJdggZmMXuRbFjyq+vF0ctDVfwujeLI2/jdRBm2
	cYWRAm2hgz2p1Qtt9rKOZjdlXmRoxYst+bcX8R3o5iFdeum6lywFJbPLwVVGgw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1756117497;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ivoSCd+ziWWonZzqJqSp7g/uVZjkS0BlMnw7IdPb3M8=;
	b=Dy3RPpNKZwqvf0XOn09ZBO9a97JRZnQBsCt102w3gQDJ0W7QlxJGmkk6DVc72rGEljPf7F
	UmRXTx8nGzWM91Ag==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] uprobes/x86: Optimize is_optimize()
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250821123656.823296198@infradead.org>
References: <20250821123656.823296198@infradead.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175611749605.1420.17421339510149451281.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     fd54052b60cf6e73cf918fd8653cd7a5c84b0cc3
Gitweb:        https://git.kernel.org/tip/fd54052b60cf6e73cf918fd8653cd7a5c84=
b0cc3
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Wed, 20 Aug 2025 12:37:22 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 21 Aug 2025 20:09:21 +02:00

uprobes/x86: Optimize is_optimize()

Make is_optimized() return a tri-state and avoid return through
argument. This simplifies things a little.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20250821123656.823296198@infradead.org
---
 arch/x86/kernel/uprobes.c | 34 +++++++++++++---------------------
 1 file changed, 13 insertions(+), 21 deletions(-)

diff --git a/arch/x86/kernel/uprobes.c b/arch/x86/kernel/uprobes.c
index 580989d..3b46a89 100644
--- a/arch/x86/kernel/uprobes.c
+++ b/arch/x86/kernel/uprobes.c
@@ -1047,7 +1047,7 @@ static bool __is_optimized(uprobe_opcode_t *insn, unsig=
ned long vaddr)
 	return __in_uprobe_trampoline(vaddr + 5 + call->raddr);
 }
=20
-static int is_optimized(struct mm_struct *mm, unsigned long vaddr, bool *opt=
imized)
+static int is_optimized(struct mm_struct *mm, unsigned long vaddr)
 {
 	uprobe_opcode_t insn[5];
 	int err;
@@ -1055,8 +1055,7 @@ static int is_optimized(struct mm_struct *mm, unsigned =
long vaddr, bool *optimiz
 	err =3D copy_from_vaddr(mm, vaddr, &insn, 5);
 	if (err)
 		return err;
-	*optimized =3D __is_optimized((uprobe_opcode_t *)&insn, vaddr);
-	return 0;
+	return __is_optimized((uprobe_opcode_t *)&insn, vaddr);
 }
=20
 static bool should_optimize(struct arch_uprobe *auprobe)
@@ -1069,17 +1068,14 @@ int set_swbp(struct arch_uprobe *auprobe, struct vm_a=
rea_struct *vma,
 	     unsigned long vaddr)
 {
 	if (should_optimize(auprobe)) {
-		bool optimized =3D false;
-		int err;
-
 		/*
 		 * We could race with another thread that already optimized the probe,
 		 * so let's not overwrite it with int3 again in this case.
 		 */
-		err =3D is_optimized(vma->vm_mm, vaddr, &optimized);
-		if (err)
-			return err;
-		if (optimized)
+		int ret =3D is_optimized(vma->vm_mm, vaddr);
+		if (ret < 0)
+			return ret;
+		if (ret)
 			return 0;
 	}
 	return uprobe_write_opcode(auprobe, vma, vaddr, UPROBE_SWBP_INSN,
@@ -1090,17 +1086,13 @@ int set_orig_insn(struct arch_uprobe *auprobe, struct=
 vm_area_struct *vma,
 		  unsigned long vaddr)
 {
 	if (test_bit(ARCH_UPROBE_FLAG_CAN_OPTIMIZE, &auprobe->flags)) {
-		struct mm_struct *mm =3D vma->vm_mm;
-		bool optimized =3D false;
-		int err;
-
-		err =3D is_optimized(mm, vaddr, &optimized);
-		if (err)
-			return err;
-		if (optimized) {
-			err =3D swbp_unoptimize(auprobe, vma, vaddr);
-			WARN_ON_ONCE(err);
-			return err;
+		int ret =3D is_optimized(vma->vm_mm, vaddr);
+		if (ret < 0)
+			return ret;
+		if (ret) {
+			ret =3D swbp_unoptimize(auprobe, vma, vaddr);
+			WARN_ON_ONCE(ret);
+			return ret;
 		}
 	}
 	return uprobe_write_opcode(auprobe, vma, vaddr, *(uprobe_opcode_t *)&auprob=
e->insn,

