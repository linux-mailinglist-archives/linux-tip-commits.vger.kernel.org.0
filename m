Return-Path: <linux-tip-commits+bounces-7867-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B0D0D11078
	for <lists+linux-tip-commits@lfdr.de>; Mon, 12 Jan 2026 09:03:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2242B3006E1B
	for <lists+linux-tip-commits@lfdr.de>; Mon, 12 Jan 2026 08:03:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6078833C1B3;
	Mon, 12 Jan 2026 08:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jQN6oEcs";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0sf7PuS6"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0715333BBDF;
	Mon, 12 Jan 2026 08:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768204978; cv=none; b=DF0uZHFQUyGHypZUGVowMn0pSuY/76p1m/5iy8McOlK0bNXvEPR6L1FxoXMa0Pyn7Q3tvLNOutpWQxWuW62WaBZmE6YPqzh6CL14lMvOE7QcwL1Sr57Io3ZcuT4MzvKBXVsAUgz9ubhtCgh2448GA3yA1ApMn/jXbrElKZ/hPN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768204978; c=relaxed/simple;
	bh=VkF3FlXhotZ3/frgcl0rPhKRnhIFY44kDt6+2iN1pQ4=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=d51PDr+B2/lawp7nUuAhGGGjpeAsntwQUoudgOHOcrTXr0OrZHTAZOmcksRLV+92bmMrBh3rYtUxBRcgeQZDPBDJIleZjC0RcuPbvG0JNerbnx/U6Aju2FIA1X6CgueYa2s24RVUTzsjUCm85Hr06+Ei7IH8AOvhpMmseaop2RE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jQN6oEcs; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0sf7PuS6; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 12 Jan 2026 08:02:49 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1768204975;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ybVFZlFnZLyaWpIES92Zx+dsszdKQ0kO4rCdPMyMb7U=;
	b=jQN6oEcsrg/0E7R1b19M8F/2AQyXFwpIHMcBeHW1QcRt8ThrWng+TtpZe9r2ekqurkyq4L
	fCBN38cBchHh93U6+ncBzzslnqWdQAenjXNGRjoWEQyfWPny3ssLZT/y3dnDJZdw5E316W
	PdgafiJobsLStRVkZzv2TO+2riCNdB6JOnYpj8rc1ivFm+xIlhRR58GsVmSUJLKNZL1604
	EFLBzMAkG6ztNWX6Y87WuM/MGfDUHW3a/YKGp8LhqWDiORBn1DqJhVDwsfVwkiQzBBSGMh
	JwFcbzqMK9BXg8pAFcDrPCJZDJcmCHZlP7VCzDPBeFtA4onhJa+SJapyA1aHEw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1768204975;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ybVFZlFnZLyaWpIES92Zx+dsszdKQ0kO4rCdPMyMb7U=;
	b=0sf7PuS6QpG1qK73lSx/kX8cQlLvdhQy0Y8eCWLRRNraTaWB20URxCSd663ZzSL50AKo1n
	6FCDk9K/RPyXEmAg==
From: "tip-bot2 for Keke Ming" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: perf/core] uprobes: use kmap_local_page() for temporary page mappings
Cc: Keke Ming <ming.jvle@gmail.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Oleg Nesterov <oleg@redhat.com>, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260103084243.195125-6-ming.jvle@gmail.com>
References: <20260103084243.195125-6-ming.jvle@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176820496954.510.6355066077664200722.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     a491c02c2770c9c2d02b96fad7e3a176d77bb737
Gitweb:        https://git.kernel.org/tip/a491c02c2770c9c2d02b96fad7e3a176d77=
bb737
Author:        Keke Ming <ming.jvle@gmail.com>
AuthorDate:    Sat, 03 Jan 2026 16:42:43 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 06 Jan 2026 16:34:28 +01:00

uprobes: use kmap_local_page() for temporary page mappings

Replace deprecated kmap_atomic() with kmap_local_page().

Signed-off-by: Keke Ming <ming.jvle@gmail.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Oleg Nesterov <oleg@redhat.com>
Link: https://patch.msgid.link/20260103084243.195125-6-ming.jvle@gmail.com
---
 kernel/events/uprobes.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index d546d32..a7d7d83 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -179,16 +179,16 @@ bool __weak is_trap_insn(uprobe_opcode_t *insn)
=20
 void uprobe_copy_from_page(struct page *page, unsigned long vaddr, void *dst=
, int len)
 {
-	void *kaddr =3D kmap_atomic(page);
+	void *kaddr =3D kmap_local_page(page);
 	memcpy(dst, kaddr + (vaddr & ~PAGE_MASK), len);
-	kunmap_atomic(kaddr);
+	kunmap_local(kaddr);
 }
=20
 static void copy_to_page(struct page *page, unsigned long vaddr, const void =
*src, int len)
 {
-	void *kaddr =3D kmap_atomic(page);
+	void *kaddr =3D kmap_local_page(page);
 	memcpy(kaddr + (vaddr & ~PAGE_MASK), src, len);
-	kunmap_atomic(kaddr);
+	kunmap_local(kaddr);
 }
=20
 static int verify_opcode(struct page *page, unsigned long vaddr, uprobe_opco=
de_t *insn,
@@ -323,7 +323,7 @@ __update_ref_ctr(struct mm_struct *mm, unsigned long vadd=
r, short d)
 		return ret =3D=3D 0 ? -EBUSY : ret;
 	}
=20
-	kaddr =3D kmap_atomic(page);
+	kaddr =3D kmap_local_page(page);
 	ptr =3D kaddr + (vaddr & ~PAGE_MASK);
=20
 	if (unlikely(*ptr + d < 0)) {
@@ -336,7 +336,7 @@ __update_ref_ctr(struct mm_struct *mm, unsigned long vadd=
r, short d)
 	*ptr +=3D d;
 	ret =3D 0;
 out:
-	kunmap_atomic(kaddr);
+	kunmap_local(kaddr);
 	put_page(page);
 	return ret;
 }

