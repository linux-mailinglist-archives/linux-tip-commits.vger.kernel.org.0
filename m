Return-Path: <linux-tip-commits+bounces-7590-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CA1ECA0E22
	for <lists+linux-tip-commits@lfdr.de>; Wed, 03 Dec 2025 19:19:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BF21A30019F6
	for <lists+linux-tip-commits@lfdr.de>; Wed,  3 Dec 2025 18:19:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA20A30749A;
	Wed,  3 Dec 2025 18:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VVX+meD8";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0utXhjYW"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E15C3064A0;
	Wed,  3 Dec 2025 18:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764785953; cv=none; b=cJD62nziq/dqtIHUDqWorhycK2ls3OZW16hghcfs4OgUxAqhoo7PhOXlI1pX3lrI2m9q8EO8cbz5OqftJd5Wrgj7tcQ8XEVc8scnuHLxJw46f9ZfYuKZjr5Z6c0Ir70xk/0us6Xyps2l5gWoCpZswW2L2ohYV43qwZ8zeuuAC84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764785953; c=relaxed/simple;
	bh=dcQeS/H9/AJO5fsh2Q2B0gJ6VIRoKF3jzExvjIYfTJ8=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=uCqlIBz2/S4J/C2qb5JvqQdKB9+7ee6VoyFwlImK418uOIqAL6GRr+qb8syit3ClDMjc5xvAzG0TLjfEX/7z96Nmpy9FYawY1isWYE3LnT8rJIYpBATc3QHPMNgm0JpoZ2MUXCckuuxHinyhE3NZFUVXPnDAiEjVULxMyXnv+TU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VVX+meD8; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0utXhjYW; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 03 Dec 2025 18:19:08 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1764785950;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=/DhzzKc25FwJ1BTV6+kVCT5xhGz3UcNZ0EbytCJlwS4=;
	b=VVX+meD8HKscjbY3D9D5XirWC5zQiMdFA1VqWGnMh1gFR8cQUySAPftwfv+G55b3KBwR4c
	wdLrRRG9k78uBalc41KIDrQ2P0+nX6J37S4u/tspZzV6YaT9zdEmn9IEreC7lT96bW4C7N
	L+4cdua8WaisRREwFGMEyxMGj3/JxOe6VJryhS9mXNPbfiSx4t0YJ+8jJ2OWBqqV5MjUUn
	8ySP0/pUvUODO5ifzr/q5nhVbfYrnkxrxPs9bssdYoTQNgBWLD8UEIpWSKaWNT7Is/22Pq
	inlCrs2TbJky2AYqOIX+kk5oIp0O0kSAnxXHP8X5JlUT4GDlUwILF1kBEtdwmg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1764785950;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=/DhzzKc25FwJ1BTV6+kVCT5xhGz3UcNZ0EbytCJlwS4=;
	b=0utXhjYWqRBt6aKnBNHVUUkcy+f2PjcBM2MPEHuDAzJ/OsKCkx524yocpPWSW9c5pM48u0
	vwwp7nda9vA8XSDA==
From: "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf/uprobes: Remove <space><Tab> whitespace noise
Cc:
 Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org, x86@kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176478594889.498.15611228524880763978.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     4f7a433d5d5080a89bceabbbaab787b8d66a399b
Gitweb:        https://git.kernel.org/tip/4f7a433d5d5080a89bceabbbaab787b8d66=
a399b
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Wed, 03 Dec 2025 19:06:01 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 03 Dec 2025 19:07:03 +01:00

perf/uprobes: Remove <space><Tab> whitespace noise

A few cases of space-Tab noise snuck in.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org
---
 kernel/events/uprobes.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index f11ceb8..d546d32 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -79,7 +79,7 @@ struct uprobe {
 	 * The generic code assumes that it has two members of unknown type
 	 * owned by the arch-specific code:
 	 *
-	 * 	insn -	copy_insn() saves the original instruction here for
+	 *	insn -	copy_insn() saves the original instruction here for
 	 *		arch_uprobe_analyze_insn().
 	 *
 	 *	ixol -	potentially modified instruction to execute out of
@@ -107,8 +107,8 @@ static LIST_HEAD(delayed_uprobe_list);
  * allocated.
  */
 struct xol_area {
-	wait_queue_head_t 		wq;		/* if all slots are busy */
-	unsigned long 			*bitmap;	/* 0 =3D free slot */
+	wait_queue_head_t		wq;		/* if all slots are busy */
+	unsigned long			*bitmap;	/* 0 =3D free slot */
=20
 	struct page			*page;
 	/*
@@ -116,7 +116,7 @@ struct xol_area {
 	 * itself.  The probed process or a naughty kernel module could make
 	 * the vma go away, and we must handle that reasonably gracefully.
 	 */
-	unsigned long 			vaddr;		/* Page(s) of instruction slots */
+	unsigned long			vaddr;		/* Page(s) of instruction slots */
 };
=20
 static void uprobe_warn(struct task_struct *t, const char *msg)

