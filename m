Return-Path: <linux-tip-commits+bounces-1939-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F1A8C947ABE
	for <lists+linux-tip-commits@lfdr.de>; Mon,  5 Aug 2024 13:56:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FCC81C20E9F
	for <lists+linux-tip-commits@lfdr.de>; Mon,  5 Aug 2024 11:56:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A672B158A22;
	Mon,  5 Aug 2024 11:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PKj7phok";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="U3OnUsAN"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5EEA15747F;
	Mon,  5 Aug 2024 11:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722858970; cv=none; b=cy11AyXMCtHb/QgLeQTmk58ZJrOWvwd9J88SrCrndFSSw+YSgWOCZoIIyCxfJC2G5NL2Fb7/Pg563ZCdTbk5G3w5+TOzRrl8Ls04AqpQ2u3wW+jRTOktTtvcCaECqM8EYRScFHQHObL9R1NN/Y6BVOtvTAlnwA4N+eKyXPCZsuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722858970; c=relaxed/simple;
	bh=CrS5r/+RIx79gQQFVV9SWgI/jzB8/TkDTLF1UR/JkVg=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Z+hmVCxWw+x5z2WdvlFw59ZiNB1LNjXo/gldGcnQCecSxQ3NtvrnDiYS44q9IZO35NFDyMLXABBpuEaGpUMdmOAApnnDRHw8pgXuMQSvx0KJTbMpKurjtx77zVKcCw6Th4fzhjlHWb1WHBA1AssgTYT3NOA2c7CvVFAWG5T2ZhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PKj7phok; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=U3OnUsAN; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 05 Aug 2024 11:56:05 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722858966;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UAB8V7nbXueW1dVFAdAnXlgNWFZbiKfAKU6uYIkEHCI=;
	b=PKj7phokCWFoau2RNTA74ccf6fcXweg0GoMc2x59QavOG28tPUwbMn9dJlF6KFtH/Qn+Ea
	ZD+LFsgudaDTkZOnWLPlGa7cMp7bMvLcBuKqe66nc7WN9dokOnjc3HW3yAjWT+69R0MRWF
	+MAodON2bbhqr9QeQofWgF1aPcdaJboBjULZjzrzJglvwSaiMQZwXKVSnHPcYuLaE3Zfzo
	hA1kFb/CxDaW/B+r7gsbyoF+sRHmJOMRIGhXbBR2Aca+tTUG0EYq8Jx0tuwx7TYhaEfxdW
	V6KJIe5WTgp/lZ5Vn50lzvIxhRatMjvuknlvQILeyWAPS3Ex6YLIF3ZdV6IoHw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722858966;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UAB8V7nbXueW1dVFAdAnXlgNWFZbiKfAKU6uYIkEHCI=;
	b=U3OnUsANXRX/glyVRrSkMkj+/NCPp3K5Sx83Wp+YfiNQZvuevh29Opfo7c/rRBFmPYhz5e
	Lb/QUyvbGal9VKBA==
From: "tip-bot2 for Oleg Nesterov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] uprobes: document the usage of mm->mmap_lock
Cc: Andrii Nakryiko <andrii@kernel.org>, Oleg Nesterov <oleg@redhat.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, Jiri Olsa <jolsa@kernel.org>,
 "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240801132709.GA8780@redhat.com>
References: <20240801132709.GA8780@redhat.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172285896599.2215.2455695217344541134.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     84455e6923c79a37812930787aaa141e82afe315
Gitweb:        https://git.kernel.org/tip/84455e6923c79a37812930787aaa141e82afe315
Author:        Oleg Nesterov <oleg@redhat.com>
AuthorDate:    Thu, 01 Aug 2024 15:27:09 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 02 Aug 2024 11:30:30 +02:00

uprobes: document the usage of mm->mmap_lock

The comment above uprobe_write_opcode() is wrong, unapply_uprobe() calls
it under mmap_read_lock() and this is correct.

And it is completely unclear why register_for_each_vma() takes mmap_lock
for writing, add a comment to explain that mmap_write_lock() is needed to
avoid the following race:

	- A task T hits the bp installed by uprobe and calls
	  find_active_uprobe()

	- uprobe_unregister() removes this uprobe/bp

	- T calls find_uprobe() which returns NULL

	- another uprobe_register() installs the bp at the same address

	- T calls is_trap_at_addr() which returns true

	- T returns to handle_swbp() and gets SIGTRAP.

Reported-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Oleg Nesterov <oleg@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Jiri Olsa <jolsa@kernel.org>
Acked-by: Andrii Nakryiko <andrii@kernel.org>
Acked-by: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Link: https://lore.kernel.org/r/20240801132709.GA8780@redhat.com
---
 kernel/events/uprobes.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index f69ecd3..2d1457e 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -453,7 +453,7 @@ static int update_ref_ctr(struct uprobe *uprobe, struct mm_struct *mm,
  * @vaddr: the virtual address to store the opcode.
  * @opcode: opcode to be written at @vaddr.
  *
- * Called with mm->mmap_lock held for write.
+ * Called with mm->mmap_lock held for read or write.
  * Return 0 (success) or a negative errno.
  */
 int uprobe_write_opcode(struct arch_uprobe *auprobe, struct mm_struct *mm,
@@ -1046,7 +1046,13 @@ register_for_each_vma(struct uprobe *uprobe, struct uprobe_consumer *new)
 
 		if (err && is_register)
 			goto free;
-
+		/*
+		 * We take mmap_lock for writing to avoid the race with
+		 * find_active_uprobe() which takes mmap_lock for reading.
+		 * Thus this install_breakpoint() can not make
+		 * is_trap_at_addr() true right after find_uprobe()
+		 * returns NULL in find_active_uprobe().
+		 */
 		mmap_write_lock(mm);
 		vma = find_vma(mm, info->vaddr);
 		if (!vma || !valid_vma(vma, is_register) ||

