Return-Path: <linux-tip-commits+bounces-6367-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 65967B33CC6
	for <lists+linux-tip-commits@lfdr.de>; Mon, 25 Aug 2025 12:30:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA2351B22350
	for <lists+linux-tip-commits@lfdr.de>; Mon, 25 Aug 2025 10:29:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BCD32EA149;
	Mon, 25 Aug 2025 10:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KmrI/t+c";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fIys7k5v"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB9E12E92CD;
	Mon, 25 Aug 2025 10:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756117507; cv=none; b=lwUwQltZtpftPf6Sy5iVfov6V43/cLuvqfaV+wfQ4b752UBPu3YCm/eaU83Bg3dEM7q5cYbuAF6xwdnot+AsJbGQLIBRB0yQYjspQmw8FQNU7iCg5MG/O8hSkiAB3aiI9NaqNjNXa/3mlwnfLIeNoRpC1BxqZnbfAql9xP4D75o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756117507; c=relaxed/simple;
	bh=UP8ThAg3/PNXANwY/kuGRic9Hkm+B6ypozw0wn/fOuw=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=evg2DW6PApIHZSFpm0IQoDA41C58hbTT7KbJnrLBiFzECWXfphh9f/sFTIUOO82K3YAcSHMu7IA20SO0Txn05tdDBjrW61BAXWEYOwAFCzwnLbQm2dXuGBP+7HXENuueZ2c2tmM6mtroO6s0+4CRQe2i08rWw4WL7PPYm4fnUNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KmrI/t+c; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fIys7k5v; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 25 Aug 2025 10:25:02 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1756117504;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FNCLH9J2TV/OnmsamRNg5yjq2kpjuaikpmefyIbFtmM=;
	b=KmrI/t+cV5s+UmINVulm4nzVcCH7KApa8FITl/IyZGdL3rFHMipCDATyWEp6it7f5xxrjC
	G4GtEiY5KpzymExBJjn61pY4MKjk5JnKqtgS1HGkUPuDywUtENlA1UJriFu/oXaMsnW5Un
	j4wrGSguDY+k1MSm60oLUEZ9CQ9+CaZo7pp83JdgJQ14Ex2K3d2jm4d71bV112AD9NkSGJ
	AEr+GEZjasVfb6o/8VJPqSQFUhab515k9A9ExWdwlhxZMVL4QRpuh/3bOZTLrILElJ6Imf
	xZwLjUaapexiOJIAN/elsL9/5WCWtixUDLF9Rrhb/GvH4GKHsHuwSzGCsm5PMg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1756117504;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FNCLH9J2TV/OnmsamRNg5yjq2kpjuaikpmefyIbFtmM=;
	b=fIys7k5vTU7pPny3eTzlWsxx261rD8Cvibz8/wTS9rCvvZNk1oKHzA7OoX+8CJnCFoBiWJ
	cXl9caLJCnYDN5Aw==
From: "tip-bot2 for Jiri Olsa" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] uprobes: Add is_register argument to uprobe_write
 and uprobe_write_opcode
Cc: Jiri Olsa <jolsa@kernel.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Oleg Nesterov <oleg@redhat.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250720112133.244369-7-jolsa@kernel.org>
References: <20250720112133.244369-7-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175611750287.1420.3127365759663201907.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     ec46350fe1e2338f42ee84974c36b25afe8ba53a
Gitweb:        https://git.kernel.org/tip/ec46350fe1e2338f42ee84974c36b25afe8=
ba53a
Author:        Jiri Olsa <jolsa@kernel.org>
AuthorDate:    Sun, 20 Jul 2025 13:21:16 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 21 Aug 2025 20:09:19 +02:00

uprobes: Add is_register argument to uprobe_write and uprobe_write_opcode

The uprobe_write has special path to restore the original page when we
write original instruction back. This happens when uprobe_write detects
that we want to write anything else but breakpoint instruction.

Moving the detection away and passing it to uprobe_write as argument,
so it's possible to write different instructions (other than just
breakpoint and rest).

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Acked-by: Andrii Nakryiko <andrii@kernel.org>
Acked-by: Oleg Nesterov <oleg@redhat.com>
Link: https://lore.kernel.org/r/20250720112133.244369-7-jolsa@kernel.org
---
 arch/arm/probes/uprobes/core.c |  2 +-
 include/linux/uprobes.h        |  5 +++--
 kernel/events/uprobes.c        | 21 +++++++++++----------
 3 files changed, 15 insertions(+), 13 deletions(-)

diff --git a/arch/arm/probes/uprobes/core.c b/arch/arm/probes/uprobes/core.c
index 885e0c5..3d96fb4 100644
--- a/arch/arm/probes/uprobes/core.c
+++ b/arch/arm/probes/uprobes/core.c
@@ -30,7 +30,7 @@ int set_swbp(struct arch_uprobe *auprobe, struct vm_area_st=
ruct *vma,
 	     unsigned long vaddr)
 {
 	return uprobe_write_opcode(auprobe, vma, vaddr,
-		   __opcode_to_mem_arm(auprobe->bpinsn));
+		   __opcode_to_mem_arm(auprobe->bpinsn), true);
 }
=20
 bool arch_uprobe_ignore(struct arch_uprobe *auprobe, struct pt_regs *regs)
diff --git a/include/linux/uprobes.h b/include/linux/uprobes.h
index 147c4a0..518b267 100644
--- a/include/linux/uprobes.h
+++ b/include/linux/uprobes.h
@@ -197,9 +197,10 @@ extern bool is_swbp_insn(uprobe_opcode_t *insn);
 extern bool is_trap_insn(uprobe_opcode_t *insn);
 extern unsigned long uprobe_get_swbp_addr(struct pt_regs *regs);
 extern unsigned long uprobe_get_trap_addr(struct pt_regs *regs);
-extern int uprobe_write_opcode(struct arch_uprobe *auprobe, struct vm_area_s=
truct *vma, unsigned long vaddr, uprobe_opcode_t);
+extern int uprobe_write_opcode(struct arch_uprobe *auprobe, struct vm_area_s=
truct *vma, unsigned long vaddr, uprobe_opcode_t,
+			       bool is_register);
 extern int uprobe_write(struct arch_uprobe *auprobe, struct vm_area_struct *=
vma, const unsigned long opcode_vaddr,
-			uprobe_opcode_t *insn, int nbytes, uprobe_write_verify_t verify);
+			uprobe_opcode_t *insn, int nbytes, uprobe_write_verify_t verify, bool is_=
register);
 extern struct uprobe *uprobe_register(struct inode *inode, loff_t offset, lo=
ff_t ref_ctr_offset, struct uprobe_consumer *uc);
 extern int uprobe_apply(struct uprobe *uprobe, struct uprobe_consumer *uc, b=
ool);
 extern void uprobe_unregister_nosync(struct uprobe *uprobe, struct uprobe_co=
nsumer *uc);
diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index c133fd4..955e5ed 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -402,10 +402,10 @@ static bool orig_page_is_identical(struct vm_area_struc=
t *vma,
=20
 static int __uprobe_write(struct vm_area_struct *vma,
 		struct folio_walk *fw, struct folio *folio,
-		unsigned long insn_vaddr, uprobe_opcode_t *insn, int nbytes)
+		unsigned long insn_vaddr, uprobe_opcode_t *insn, int nbytes,
+		bool is_register)
 {
 	const unsigned long vaddr =3D insn_vaddr & PAGE_MASK;
-	const bool is_register =3D !!is_swbp_insn(insn);
 	bool pmd_mappable;
=20
 	/* For now, we'll only handle PTE-mapped folios. */
@@ -487,26 +487,27 @@ remap:
  * Return 0 (success) or a negative errno.
  */
 int uprobe_write_opcode(struct arch_uprobe *auprobe, struct vm_area_struct *=
vma,
-		const unsigned long opcode_vaddr, uprobe_opcode_t opcode)
+		const unsigned long opcode_vaddr, uprobe_opcode_t opcode,
+		bool is_register)
 {
-	return uprobe_write(auprobe, vma, opcode_vaddr, &opcode, UPROBE_SWBP_INSN_S=
IZE, verify_opcode);
+	return uprobe_write(auprobe, vma, opcode_vaddr, &opcode, UPROBE_SWBP_INSN_S=
IZE,
+			    verify_opcode, is_register);
 }
=20
 int uprobe_write(struct arch_uprobe *auprobe, struct vm_area_struct *vma,
 		 const unsigned long insn_vaddr, uprobe_opcode_t *insn, int nbytes,
-		 uprobe_write_verify_t verify)
+		 uprobe_write_verify_t verify, bool is_register)
 {
 	const unsigned long vaddr =3D insn_vaddr & PAGE_MASK;
 	struct mm_struct *mm =3D vma->vm_mm;
 	struct uprobe *uprobe;
-	int ret, is_register, ref_ctr_updated =3D 0;
+	int ret, ref_ctr_updated =3D 0;
 	unsigned int gup_flags =3D FOLL_FORCE;
 	struct mmu_notifier_range range;
 	struct folio_walk fw;
 	struct folio *folio;
 	struct page *page;
=20
-	is_register =3D is_swbp_insn(insn);
 	uprobe =3D container_of(auprobe, struct uprobe, arch);
=20
 	if (WARN_ON_ONCE(!is_cow_mapping(vma->vm_flags)))
@@ -568,7 +569,7 @@ retry:
 	/* Walk the page tables again, to perform the actual update. */
 	if (folio_walk_start(&fw, vma, vaddr, 0)) {
 		if (fw.page =3D=3D page)
-			ret =3D __uprobe_write(vma, &fw, folio, insn_vaddr, insn, nbytes);
+			ret =3D __uprobe_write(vma, &fw, folio, insn_vaddr, insn, nbytes, is_regi=
ster);
 		folio_walk_end(&fw, vma);
 	}
=20
@@ -610,7 +611,7 @@ out:
 int __weak set_swbp(struct arch_uprobe *auprobe, struct vm_area_struct *vma,
 		unsigned long vaddr)
 {
-	return uprobe_write_opcode(auprobe, vma, vaddr, UPROBE_SWBP_INSN);
+	return uprobe_write_opcode(auprobe, vma, vaddr, UPROBE_SWBP_INSN, true);
 }
=20
 /**
@@ -626,7 +627,7 @@ int __weak set_orig_insn(struct arch_uprobe *auprobe,
 		struct vm_area_struct *vma, unsigned long vaddr)
 {
 	return uprobe_write_opcode(auprobe, vma, vaddr,
-			*(uprobe_opcode_t *)&auprobe->insn);
+			*(uprobe_opcode_t *)&auprobe->insn, false);
 }
=20
 /* uprobe should have guaranteed positive refcount */

