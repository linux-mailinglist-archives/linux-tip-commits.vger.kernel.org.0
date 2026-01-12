Return-Path: <linux-tip-commits+bounces-7868-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 69CA8D1107B
	for <lists+linux-tip-commits@lfdr.de>; Mon, 12 Jan 2026 09:03:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A21E73017126
	for <lists+linux-tip-commits@lfdr.de>; Mon, 12 Jan 2026 08:03:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E2B433CEAF;
	Mon, 12 Jan 2026 08:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uKi/FexN";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EImTj9el"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF2F433C1A2;
	Mon, 12 Jan 2026 08:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768204979; cv=none; b=QE1sHt1HIKlgjs/n6jhfamhr11mwgWMBclSOpksxRAtTZp8HdfhrY47TekKwbEkwbU/alOWLFdVDOGbnSdNy7RacdfRpMYOfjMPQr+OsVgael4No+b03uJmd4beXA37pMveByTRCIe9WpEQVwsLVTijmo4WFGZPfW9C8LHp1c0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768204979; c=relaxed/simple;
	bh=+yDrHB7jrbyH5rIi6XgPlYDaE6M3LKKjG/zZpT2r8p8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=s9GoV2J6DHqvLITHBbEI1I0RvAKZzVfjPQ4/TzQIGUooiryvFwgE40kUCEmky+d5R0Ko7AU/PaT+rRPUk0iMobZCz0hPtU5IyEweS+BDp4o0ShalKnVb7ZemVRcMr/GCeCqaLRkHC5dCq/3up3SS2sq2/vXYkcC2ahkS0GhXTqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uKi/FexN; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=EImTj9el; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 12 Jan 2026 08:02:55 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1768204976;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RtNfw7vA+NYnt353NsdY3gshlzAHBdO9FPijCsSJHGA=;
	b=uKi/FexNyk+VWKyElCwTmp/tukQq+zQ9bOoAmNz856X2v4P2GRAhhBVGIgU8pxvtqX+WDP
	Fu/2WKm79430Q89g1fEuXZnlXWsmOlHB3nYbqG5rSKGn6smw4KRanN6kHqVTF4jO3naTCx
	gR5vdLpuhwpQvv/5pWdFKiSbFsj5Wz55V89vYITAfUUPiHGQAuE7+dCUl/7S5Uu/74Nss+
	Kg/Ds4Dk28jLrYnDyomXcTFIw1VeyDBPBabB8CcjaGWQgQJiIJJaANGNuhzicj9Bw/xyjf
	23MB3c9GIDUCeymqJEhTZlHTQr7S2U30EXRf91PXt2lSVS0VPg3CrTQso02VoA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1768204976;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RtNfw7vA+NYnt353NsdY3gshlzAHBdO9FPijCsSJHGA=;
	b=EImTj9el6hrjdlTjxzgRd88QObrbz3/sxfVckjKuxZgolHzDAMCxBSO96CaB8HVk0kksu7
	W8YcYz7TDdMUrDAw==
From: "tip-bot2 for Keke Ming" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] arm/uprobes: use kmap_local_page() in
 arch_uprobe_copy_ixol()
Cc: Keke Ming <ming.jvle@gmail.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Oleg Nesterov <oleg@redhat.com>, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260103084243.195125-5-ming.jvle@gmail.com>
References: <20260103084243.195125-5-ming.jvle@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176820497512.510.2299383765929268554.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     1752a1ad43a1d4fd450a8ef5f8d240f9e228e0a3
Gitweb:        https://git.kernel.org/tip/1752a1ad43a1d4fd450a8ef5f8d240f9e22=
8e0a3
Author:        Keke Ming <ming.jvle@gmail.com>
AuthorDate:    Sat, 03 Jan 2026 16:42:42 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 06 Jan 2026 16:34:27 +01:00

arm/uprobes: use kmap_local_page() in arch_uprobe_copy_ixol()

Replace deprecated kmap_atomic() with kmap_local_page().

Signed-off-by: Keke Ming <ming.jvle@gmail.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Oleg Nesterov <oleg@redhat.com>
Link: https://patch.msgid.link/20260103084243.195125-5-ming.jvle@gmail.com
---
 arch/arm/probes/uprobes/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/probes/uprobes/core.c b/arch/arm/probes/uprobes/core.c
index 3d96fb4..0e1c6b9 100644
--- a/arch/arm/probes/uprobes/core.c
+++ b/arch/arm/probes/uprobes/core.c
@@ -113,7 +113,7 @@ int arch_uprobe_analyze_insn(struct arch_uprobe *auprobe,=
 struct mm_struct *mm,
 void arch_uprobe_copy_ixol(struct page *page, unsigned long vaddr,
 			   void *src, unsigned long len)
 {
-	void *xol_page_kaddr =3D kmap_atomic(page);
+	void *xol_page_kaddr =3D kmap_local_page(page);
 	void *dst =3D xol_page_kaddr + (vaddr & ~PAGE_MASK);
=20
 	preempt_disable();
@@ -126,7 +126,7 @@ void arch_uprobe_copy_ixol(struct page *page, unsigned lo=
ng vaddr,
=20
 	preempt_enable();
=20
-	kunmap_atomic(xol_page_kaddr);
+	kunmap_local(xol_page_kaddr);
 }
=20
=20

