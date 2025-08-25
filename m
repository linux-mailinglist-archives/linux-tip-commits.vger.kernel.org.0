Return-Path: <linux-tip-commits+bounces-6369-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A268B33CC2
	for <lists+linux-tip-commits@lfdr.de>; Mon, 25 Aug 2025 12:29:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB3653ACB47
	for <lists+linux-tip-commits@lfdr.de>; Mon, 25 Aug 2025 10:29:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CD632EB876;
	Mon, 25 Aug 2025 10:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3ZeTEE6M";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fqE8L2zF"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA1CA2EA166;
	Mon, 25 Aug 2025 10:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756117509; cv=none; b=ulwxHFM8DrK/KTSafjJl/BN3M8gohb8wuvm0fkQUgLVKhA6X9Md548z5/W1e4iO4hWVJHm92rLBIKZEQRZmZPiU4wGkT24CPh1lL3uOQ98Wuk1kVExY4lRbqP1m14x9Be4u/YNsqw/kt7e2W7J4ByPyT3F8k7iwa+lOmYVCM+FY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756117509; c=relaxed/simple;
	bh=PECGRCwf/PG3lJoNtZkKW/wpzMCG2vZfkm++6jcpf/Y=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=lc05bIc5e0jscOhSSR6zUNKEhuZ/N60zb4GM5da+Bz3qCglkQX5+2L+wVFbPFn5+EbNQ5w9O8JARLAT3BcnhRbM4cff5LAJ/f1rzR8Crip/kFJ9VPqV0aWFNDBwg2daSTC/5/i/LAbuAmfT+b07kdtkWaBUmnyzdOnQANxJsv8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3ZeTEE6M; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fqE8L2zF; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 25 Aug 2025 10:25:05 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1756117506;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sJ8XFJMkRf67LH+q4sZzDM1wPZdk6u6nT1ZJgWhKBYc=;
	b=3ZeTEE6Me26ts4OSUPOfhIAXsi7ikHLM3N8WiLF77thFCqDMPjNaLjtky02KVtEWFh1ApF
	Ec6NSCAN+LFg/+kRdI7HJUMVoWe150SnadAVzH5uO/g85CJqRPDMh2MFdfNZPK/tvo4+NY
	G0+a5/uUbFQj284vEZgHhey8sozYzXLy1gBo0ZdWMhGav0/mZT5wHiCDop9lT7nMZYPKo6
	RSQnylcCoJz5MIHEt+b9Lyp9NhIQsIDUtCtQoyU+7gquTTpSyXuItLtZgTqC4gMQ6NtBaG
	40KpE1ZgboQrVNBRsg9TNuKDX7jEB3dkhgUXXVmhx5TMLj6jHtAD36MSwGQdxQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1756117506;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sJ8XFJMkRf67LH+q4sZzDM1wPZdk6u6nT1ZJgWhKBYc=;
	b=fqE8L2zFi/LPITuOZ9M4nvqYUwX7qWGs29girVuwqOyQTcYi7k4eL+IWJR02kkuHvBWfNx
	Su7pTnZE4RIC16Cg==
From: "tip-bot2 for Jiri Olsa" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] uprobes: Add uprobe_write function
Cc: Jiri Olsa <jolsa@kernel.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Andrii Nakryiko <andrii@kernel.org>,
 "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
 Oleg Nesterov <oleg@redhat.com>, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250720112133.244369-5-jolsa@kernel.org>
References: <20250720112133.244369-5-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175611750515.1420.14404064572728265895.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     33d7b2beaf34a3c0f6406bc76f6e1b1755150ad9
Gitweb:        https://git.kernel.org/tip/33d7b2beaf34a3c0f6406bc76f6e1b17551=
50ad9
Author:        Jiri Olsa <jolsa@kernel.org>
AuthorDate:    Sun, 20 Jul 2025 13:21:14 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 21 Aug 2025 20:09:19 +02:00

uprobes: Add uprobe_write function

Adding uprobe_write function that does what uprobe_write_opcode did
so far, but allows to pass verify callback function that checks the
memory location before writing the opcode.

It will be used in following changes to implement specific checking
logic for instruction update.

The uprobe_write_opcode now calls uprobe_write with verify_opcode as
the verify callback.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Andrii Nakryiko <andrii@kernel.org>
Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Acked-by: Oleg Nesterov <oleg@redhat.com>
Link: https://lore.kernel.org/r/20250720112133.244369-5-jolsa@kernel.org
---
 include/linux/uprobes.h |  5 +++++
 kernel/events/uprobes.c | 14 ++++++++++----
 2 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/include/linux/uprobes.h b/include/linux/uprobes.h
index 7447e15..e133820 100644
--- a/include/linux/uprobes.h
+++ b/include/linux/uprobes.h
@@ -187,6 +187,9 @@ struct uprobes_state {
 	struct xol_area		*xol_area;
 };
=20
+typedef int (*uprobe_write_verify_t)(struct page *page, unsigned long vaddr,
+				     uprobe_opcode_t *opcode);
+
 extern void __init uprobes_init(void);
 extern int set_swbp(struct arch_uprobe *aup, struct vm_area_struct *vma, uns=
igned long vaddr);
 extern int set_orig_insn(struct arch_uprobe *aup, struct vm_area_struct *vma=
, unsigned long vaddr);
@@ -195,6 +198,8 @@ extern bool is_trap_insn(uprobe_opcode_t *insn);
 extern unsigned long uprobe_get_swbp_addr(struct pt_regs *regs);
 extern unsigned long uprobe_get_trap_addr(struct pt_regs *regs);
 extern int uprobe_write_opcode(struct arch_uprobe *auprobe, struct vm_area_s=
truct *vma, unsigned long vaddr, uprobe_opcode_t);
+extern int uprobe_write(struct arch_uprobe *auprobe, struct vm_area_struct *=
vma, const unsigned long opcode_vaddr,
+			uprobe_opcode_t opcode, uprobe_write_verify_t verify);
 extern struct uprobe *uprobe_register(struct inode *inode, loff_t offset, lo=
ff_t ref_ctr_offset, struct uprobe_consumer *uc);
 extern int uprobe_apply(struct uprobe *uprobe, struct uprobe_consumer *uc, b=
ool);
 extern void uprobe_unregister_nosync(struct uprobe *uprobe, struct uprobe_co=
nsumer *uc);
diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index f993a34..838ac40 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -399,7 +399,7 @@ static bool orig_page_is_identical(struct vm_area_struct =
*vma,
 	return identical;
 }
=20
-static int __uprobe_write_opcode(struct vm_area_struct *vma,
+static int __uprobe_write(struct vm_area_struct *vma,
 		struct folio_walk *fw, struct folio *folio,
 		unsigned long opcode_vaddr, uprobe_opcode_t opcode)
 {
@@ -488,6 +488,12 @@ remap:
 int uprobe_write_opcode(struct arch_uprobe *auprobe, struct vm_area_struct *=
vma,
 		const unsigned long opcode_vaddr, uprobe_opcode_t opcode)
 {
+	return uprobe_write(auprobe, vma, opcode_vaddr, opcode, verify_opcode);
+}
+
+int uprobe_write(struct arch_uprobe *auprobe, struct vm_area_struct *vma,
+		 const unsigned long opcode_vaddr, uprobe_opcode_t opcode, uprobe_write_ve=
rify_t verify)
+{
 	const unsigned long vaddr =3D opcode_vaddr & PAGE_MASK;
 	struct mm_struct *mm =3D vma->vm_mm;
 	struct uprobe *uprobe;
@@ -509,7 +515,7 @@ int uprobe_write_opcode(struct arch_uprobe *auprobe, stru=
ct vm_area_struct *vma,
 	 * page that we can safely modify. Use FOLL_WRITE to trigger a write
 	 * fault if required. When unregistering, we might be lucky and the
 	 * anon page is already gone. So defer write faults until really
-	 * required. Use FOLL_SPLIT_PMD, because __uprobe_write_opcode()
+	 * required. Use FOLL_SPLIT_PMD, because __uprobe_write()
 	 * cannot deal with PMDs yet.
 	 */
 	if (is_register)
@@ -521,7 +527,7 @@ retry:
 		goto out;
 	folio =3D page_folio(page);
=20
-	ret =3D verify_opcode(page, opcode_vaddr, &opcode);
+	ret =3D verify(page, opcode_vaddr, &opcode);
 	if (ret <=3D 0) {
 		folio_put(folio);
 		goto out;
@@ -560,7 +566,7 @@ retry:
 	/* Walk the page tables again, to perform the actual update. */
 	if (folio_walk_start(&fw, vma, vaddr, 0)) {
 		if (fw.page =3D=3D page)
-			ret =3D __uprobe_write_opcode(vma, &fw, folio, opcode_vaddr, opcode);
+			ret =3D __uprobe_write(vma, &fw, folio, opcode_vaddr, opcode);
 		folio_walk_end(&fw, vma);
 	}
=20

