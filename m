Return-Path: <linux-tip-commits+bounces-6366-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 00D0EB33CC0
	for <lists+linux-tip-commits@lfdr.de>; Mon, 25 Aug 2025 12:29:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9296F1B21CB5
	for <lists+linux-tip-commits@lfdr.de>; Mon, 25 Aug 2025 10:29:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6063D2DF3EC;
	Mon, 25 Aug 2025 10:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JMRaWd8u";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="/u0+b9Sy"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6CB82E888A;
	Mon, 25 Aug 2025 10:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756117506; cv=none; b=VO+LYVACXupMGF0wc5v0ExDdo6cIS35OdTfCLvr1NckRZo2PilA7s9ZwcyTM55rVfDtz1R9TYgAsyZUeUrXn4QpunjFpmjPRA016AlE4gvKt1o4Gj32EBZQ7q+6hjxX+ExUxPM7fm/Obk8+nxfB3ssxyC18EJHiVt1YuqydVZDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756117506; c=relaxed/simple;
	bh=A55iEYDRrC+lw13VS2nsu9F7ooC1elaj7Pm2f08PSPE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=P59B719P9nPpMbycsRXlD8tcGrZBIDSUGLkea/I+ngCreqJB1zIDENsCmUvclaF6QJye5DwZkII0k/R0tpRW8/XSiuiE4+DIbKctsRcW9cxMaZldJMg+myBstpAxe9bN0JEvy2gp3hqXfEp/PTIr4z+I4F3E0QWP1k25pvQxSaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JMRaWd8u; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=/u0+b9Sy; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 25 Aug 2025 10:25:01 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1756117502;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=egNwJ3357XXCUPpRj6n89UndxzZ98g3dI94i/ixKpfU=;
	b=JMRaWd8uyr4w4PZBuz7NGQ7TjL+YeFry5yWpqoHtvNGU2CMrZZMgPZuGNIgxvo4ALl9xV2
	2u7pOfBFCWUyaUrWe3yMVvpyqgfVhCJmfY4wR0jv4QFKEePq8txK56/ItpdECw2yeM6u4R
	+uQEh77ya118u9FIeOs6pSgN7E2Soi3Gi8QN9eon8e809u+7v2jRe+sRVI6BIm+4svzXLN
	6qd17gjjmDOja8chC1WksGWl93xAr9wD9M43xEjbUKyYraoLbk2P8ZZ3vF0ja87odmpCMF
	ZaPnAt6b3rFKeCzyS1ahysFVq8lQtwzmkJCRg1OkxpS/h7Dhg6XWHcz2fgd2Xg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1756117502;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=egNwJ3357XXCUPpRj6n89UndxzZ98g3dI94i/ixKpfU=;
	b=/u0+b9SyAx6Wl3tJL/mDDZYJfk1iSP1UxN7iCfd4SOuvp6atZ7hFIbSdjn+5yQ9g9Ds125
	ahHlpd6lhoKgJ1Cg==
From: "tip-bot2 for Jiri Olsa" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: perf/core] uprobes: Add do_ref_ctr argument to uprobe_write function
Cc: Jiri Olsa <jolsa@kernel.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Oleg Nesterov <oleg@redhat.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250720112133.244369-8-jolsa@kernel.org>
References: <20250720112133.244369-8-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175611750173.1420.10521159088686098877.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     18a111256a0b4fedfe47101f084441a84d7e357a
Gitweb:        https://git.kernel.org/tip/18a111256a0b4fedfe47101f084441a84d7=
e357a
Author:        Jiri Olsa <jolsa@kernel.org>
AuthorDate:    Sun, 20 Jul 2025 13:21:17 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 21 Aug 2025 20:09:20 +02:00

uprobes: Add do_ref_ctr argument to uprobe_write function

Making update_ref_ctr call in uprobe_write conditional based
on do_ref_ctr argument. This way we can use uprobe_write for
instruction update without doing ref_ctr_offset update.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Acked-by: Andrii Nakryiko <andrii@kernel.org>
Acked-by: Oleg Nesterov <oleg@redhat.com>
Link: https://lore.kernel.org/r/20250720112133.244369-8-jolsa@kernel.org
---
 include/linux/uprobes.h | 2 +-
 kernel/events/uprobes.c | 8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/linux/uprobes.h b/include/linux/uprobes.h
index 518b267..5080619 100644
--- a/include/linux/uprobes.h
+++ b/include/linux/uprobes.h
@@ -200,7 +200,7 @@ extern unsigned long uprobe_get_trap_addr(struct pt_regs =
*regs);
 extern int uprobe_write_opcode(struct arch_uprobe *auprobe, struct vm_area_s=
truct *vma, unsigned long vaddr, uprobe_opcode_t,
 			       bool is_register);
 extern int uprobe_write(struct arch_uprobe *auprobe, struct vm_area_struct *=
vma, const unsigned long opcode_vaddr,
-			uprobe_opcode_t *insn, int nbytes, uprobe_write_verify_t verify, bool is_=
register);
+			uprobe_opcode_t *insn, int nbytes, uprobe_write_verify_t verify, bool is_=
register, bool do_update_ref_ctr);
 extern struct uprobe *uprobe_register(struct inode *inode, loff_t offset, lo=
ff_t ref_ctr_offset, struct uprobe_consumer *uc);
 extern int uprobe_apply(struct uprobe *uprobe, struct uprobe_consumer *uc, b=
ool);
 extern void uprobe_unregister_nosync(struct uprobe *uprobe, struct uprobe_co=
nsumer *uc);
diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 955e5ed..da2b3d0 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -491,12 +491,12 @@ int uprobe_write_opcode(struct arch_uprobe *auprobe, st=
ruct vm_area_struct *vma,
 		bool is_register)
 {
 	return uprobe_write(auprobe, vma, opcode_vaddr, &opcode, UPROBE_SWBP_INSN_S=
IZE,
-			    verify_opcode, is_register);
+			    verify_opcode, is_register, true /* do_update_ref_ctr */);
 }
=20
 int uprobe_write(struct arch_uprobe *auprobe, struct vm_area_struct *vma,
 		 const unsigned long insn_vaddr, uprobe_opcode_t *insn, int nbytes,
-		 uprobe_write_verify_t verify, bool is_register)
+		 uprobe_write_verify_t verify, bool is_register, bool do_update_ref_ctr)
 {
 	const unsigned long vaddr =3D insn_vaddr & PAGE_MASK;
 	struct mm_struct *mm =3D vma->vm_mm;
@@ -537,7 +537,7 @@ retry:
 	}
=20
 	/* We are going to replace instruction, update ref_ctr. */
-	if (!ref_ctr_updated && uprobe->ref_ctr_offset) {
+	if (do_update_ref_ctr && !ref_ctr_updated && uprobe->ref_ctr_offset) {
 		ret =3D update_ref_ctr(uprobe, mm, is_register ? 1 : -1);
 		if (ret) {
 			folio_put(folio);
@@ -589,7 +589,7 @@ retry:
=20
 out:
 	/* Revert back reference counter if instruction update failed. */
-	if (ret < 0 && ref_ctr_updated)
+	if (do_update_ref_ctr && ret < 0 && ref_ctr_updated)
 		update_ref_ctr(uprobe, mm, is_register ? -1 : 1);
=20
 	/* try collapse pmd for compound page */

