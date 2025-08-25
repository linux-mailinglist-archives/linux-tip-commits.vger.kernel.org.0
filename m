Return-Path: <linux-tip-commits+bounces-6368-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9446BB33CC8
	for <lists+linux-tip-commits@lfdr.de>; Mon, 25 Aug 2025 12:30:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13E4A1B225A3
	for <lists+linux-tip-commits@lfdr.de>; Mon, 25 Aug 2025 10:29:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95DCF2EA756;
	Mon, 25 Aug 2025 10:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="g+UaaXkq";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QaXxr2mL"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9CFF2E9EA1;
	Mon, 25 Aug 2025 10:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756117508; cv=none; b=YH3gCk6VTV0j7ozMS6nid6mDv7nqU+3MwaP2dJtuP9EqI5OhLviSqerS/KwbwtlrQOx6hMx9JCxvXxqdLrTzSacNaysqAldXxwkDLvRvPbevISdp5G7/83ojOsjlibMTzyNjluBmVWVgZruVBXqpnCg659Ckjx96j2Pk50sGId0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756117508; c=relaxed/simple;
	bh=Eh9azjNiN7Xu5fVqtujAWAHGfgMMUPwLHaIvL0E59+g=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=ikpIKBt8JW633fuiTj5I/Je6KMmcn9msY+vdRP+GfWcU/0QW0NOmRWwj0D/yCCHuuO0o7w0Z8FId3dUtZ/5ytys52qOLe+yozjrjzlEgFySu1+WLRWf8bSDRr62YE9vDh+NZdPXp6sGpkIwE8p/R56+772LQZFhEiMqmcDbLohY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=g+UaaXkq; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QaXxr2mL; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 25 Aug 2025 10:25:04 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1756117505;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ORB3hwPNs9IqCMkQNNOatfyPKZXwtb8D2HzmSfvhjes=;
	b=g+UaaXkq/YlV0i+mJxcxQhGb4ENAAdtFK3mS/CoJAN7h9FD/pMIk4wYPP5vM7AUn8HdbMt
	zJQREmsI/Bnd0c2PgK7WSPo6Aq4WfGCYKEvJA4uQjBuGlUJSHorpszdWadnXx2POEsuzQO
	/EeMo0nWDvr4xSg3OBOKXtQktfHCazU/5lT9KY+S9JjQuljTNDYOi+boDE+ZDSAXw3KmM3
	iHW51FggxCF9FhfGwpV3x6LvzuDyTWwxMPPsZV5t70DkDeYLLLlVgsm6ch7koQJy1RKkK7
	7LaLFnDFIvgvGDlHW8Uqbf8ZFJnGoL9K9Aba8ZFY8+giANvfvCX04bZoFhPTAg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1756117505;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ORB3hwPNs9IqCMkQNNOatfyPKZXwtb8D2HzmSfvhjes=;
	b=QaXxr2mLMFEuD+2DE9V1S6Vi70EkImc+9SfqTU+WwuZcPAXk9T/u0kxNbJp1zvp2Phaoto
	sQtXyV18D9UfgjAw==
From: "tip-bot2 for Jiri Olsa" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] uprobes: Add nbytes argument to uprobe_write
Cc: Jiri Olsa <jolsa@kernel.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Oleg Nesterov <oleg@redhat.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250720112133.244369-6-jolsa@kernel.org>
References: <20250720112133.244369-6-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175611750404.1420.17988795159833293581.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     f8b7c528b4fb7018d12b6bb63bb52576cfc73697
Gitweb:        https://git.kernel.org/tip/f8b7c528b4fb7018d12b6bb63bb52576cfc=
73697
Author:        Jiri Olsa <jolsa@kernel.org>
AuthorDate:    Sun, 20 Jul 2025 13:21:15 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 21 Aug 2025 20:09:19 +02:00

uprobes: Add nbytes argument to uprobe_write

Adding nbytes argument to uprobe_write and related functions as
preparation for writing whole instructions in following changes.

Also renaming opcode arguments to insn, which seems to fit better.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Acked-by: Andrii Nakryiko <andrii@kernel.org>
Acked-by: Oleg Nesterov <oleg@redhat.com>
Link: https://lore.kernel.org/r/20250720112133.244369-6-jolsa@kernel.org
---
 include/linux/uprobes.h |  4 ++--
 kernel/events/uprobes.c | 26 ++++++++++++++------------
 2 files changed, 16 insertions(+), 14 deletions(-)

diff --git a/include/linux/uprobes.h b/include/linux/uprobes.h
index e133820..147c4a0 100644
--- a/include/linux/uprobes.h
+++ b/include/linux/uprobes.h
@@ -188,7 +188,7 @@ struct uprobes_state {
 };
=20
 typedef int (*uprobe_write_verify_t)(struct page *page, unsigned long vaddr,
-				     uprobe_opcode_t *opcode);
+				     uprobe_opcode_t *insn, int nbytes);
=20
 extern void __init uprobes_init(void);
 extern int set_swbp(struct arch_uprobe *aup, struct vm_area_struct *vma, uns=
igned long vaddr);
@@ -199,7 +199,7 @@ extern unsigned long uprobe_get_swbp_addr(struct pt_regs =
*regs);
 extern unsigned long uprobe_get_trap_addr(struct pt_regs *regs);
 extern int uprobe_write_opcode(struct arch_uprobe *auprobe, struct vm_area_s=
truct *vma, unsigned long vaddr, uprobe_opcode_t);
 extern int uprobe_write(struct arch_uprobe *auprobe, struct vm_area_struct *=
vma, const unsigned long opcode_vaddr,
-			uprobe_opcode_t opcode, uprobe_write_verify_t verify);
+			uprobe_opcode_t *insn, int nbytes, uprobe_write_verify_t verify);
 extern struct uprobe *uprobe_register(struct inode *inode, loff_t offset, lo=
ff_t ref_ctr_offset, struct uprobe_consumer *uc);
 extern int uprobe_apply(struct uprobe *uprobe, struct uprobe_consumer *uc, b=
ool);
 extern void uprobe_unregister_nosync(struct uprobe *uprobe, struct uprobe_co=
nsumer *uc);
diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 838ac40..c133fd4 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -191,7 +191,8 @@ static void copy_to_page(struct page *page, unsigned long=
 vaddr, const void *src
 	kunmap_atomic(kaddr);
 }
=20
-static int verify_opcode(struct page *page, unsigned long vaddr, uprobe_opco=
de_t *new_opcode)
+static int verify_opcode(struct page *page, unsigned long vaddr, uprobe_opco=
de_t *insn,
+			 int nbytes)
 {
 	uprobe_opcode_t old_opcode;
 	bool is_swbp;
@@ -208,7 +209,7 @@ static int verify_opcode(struct page *page, unsigned long=
 vaddr, uprobe_opcode_t
 	uprobe_copy_from_page(page, vaddr, &old_opcode, UPROBE_SWBP_INSN_SIZE);
 	is_swbp =3D is_swbp_insn(&old_opcode);
=20
-	if (is_swbp_insn(new_opcode)) {
+	if (is_swbp_insn(insn)) {
 		if (is_swbp)		/* register: already installed? */
 			return 0;
 	} else {
@@ -401,10 +402,10 @@ static bool orig_page_is_identical(struct vm_area_struc=
t *vma,
=20
 static int __uprobe_write(struct vm_area_struct *vma,
 		struct folio_walk *fw, struct folio *folio,
-		unsigned long opcode_vaddr, uprobe_opcode_t opcode)
+		unsigned long insn_vaddr, uprobe_opcode_t *insn, int nbytes)
 {
-	const unsigned long vaddr =3D opcode_vaddr & PAGE_MASK;
-	const bool is_register =3D !!is_swbp_insn(&opcode);
+	const unsigned long vaddr =3D insn_vaddr & PAGE_MASK;
+	const bool is_register =3D !!is_swbp_insn(insn);
 	bool pmd_mappable;
=20
 	/* For now, we'll only handle PTE-mapped folios. */
@@ -429,7 +430,7 @@ static int __uprobe_write(struct vm_area_struct *vma,
 	 */
 	flush_cache_page(vma, vaddr, pte_pfn(fw->pte));
 	fw->pte =3D ptep_clear_flush(vma, vaddr, fw->ptep);
-	copy_to_page(fw->page, opcode_vaddr, &opcode, UPROBE_SWBP_INSN_SIZE);
+	copy_to_page(fw->page, insn_vaddr, insn, nbytes);
=20
 	/*
 	 * When unregistering, we may only zap a PTE if uffd is disabled and
@@ -488,13 +489,14 @@ remap:
 int uprobe_write_opcode(struct arch_uprobe *auprobe, struct vm_area_struct *=
vma,
 		const unsigned long opcode_vaddr, uprobe_opcode_t opcode)
 {
-	return uprobe_write(auprobe, vma, opcode_vaddr, opcode, verify_opcode);
+	return uprobe_write(auprobe, vma, opcode_vaddr, &opcode, UPROBE_SWBP_INSN_S=
IZE, verify_opcode);
 }
=20
 int uprobe_write(struct arch_uprobe *auprobe, struct vm_area_struct *vma,
-		 const unsigned long opcode_vaddr, uprobe_opcode_t opcode, uprobe_write_ve=
rify_t verify)
+		 const unsigned long insn_vaddr, uprobe_opcode_t *insn, int nbytes,
+		 uprobe_write_verify_t verify)
 {
-	const unsigned long vaddr =3D opcode_vaddr & PAGE_MASK;
+	const unsigned long vaddr =3D insn_vaddr & PAGE_MASK;
 	struct mm_struct *mm =3D vma->vm_mm;
 	struct uprobe *uprobe;
 	int ret, is_register, ref_ctr_updated =3D 0;
@@ -504,7 +506,7 @@ int uprobe_write(struct arch_uprobe *auprobe, struct vm_a=
rea_struct *vma,
 	struct folio *folio;
 	struct page *page;
=20
-	is_register =3D is_swbp_insn(&opcode);
+	is_register =3D is_swbp_insn(insn);
 	uprobe =3D container_of(auprobe, struct uprobe, arch);
=20
 	if (WARN_ON_ONCE(!is_cow_mapping(vma->vm_flags)))
@@ -527,7 +529,7 @@ retry:
 		goto out;
 	folio =3D page_folio(page);
=20
-	ret =3D verify(page, opcode_vaddr, &opcode);
+	ret =3D verify(page, insn_vaddr, insn, nbytes);
 	if (ret <=3D 0) {
 		folio_put(folio);
 		goto out;
@@ -566,7 +568,7 @@ retry:
 	/* Walk the page tables again, to perform the actual update. */
 	if (folio_walk_start(&fw, vma, vaddr, 0)) {
 		if (fw.page =3D=3D page)
-			ret =3D __uprobe_write(vma, &fw, folio, opcode_vaddr, opcode);
+			ret =3D __uprobe_write(vma, &fw, folio, insn_vaddr, insn, nbytes);
 		folio_walk_end(&fw, vma);
 	}
=20

