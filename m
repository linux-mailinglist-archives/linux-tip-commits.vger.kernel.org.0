Return-Path: <linux-tip-commits+bounces-6372-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E7CCB33CCE
	for <lists+linux-tip-commits@lfdr.de>; Mon, 25 Aug 2025 12:31:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71D50178D0C
	for <lists+linux-tip-commits@lfdr.de>; Mon, 25 Aug 2025 10:30:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B13422EC561;
	Mon, 25 Aug 2025 10:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VrLc2baW";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bjOQBmwW"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E24242ECD13;
	Mon, 25 Aug 2025 10:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756117513; cv=none; b=j2QjmYc/OUpP4idRx97vQ7h8+b4dCRazS4wrGc6VJXLDqh/Z1PPNSrZrQ2WmI1P217pDjL4xTYdU0qUXKTqhjSEU0bsJvUJ0TFbNAj3L7SfVzGPNlvT6mYtv68zljT09Dm72Kit4Uiz+XEMqOaVhRIsCqNg1SqEP/zKcZGB73iQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756117513; c=relaxed/simple;
	bh=oQU45IFyIDhyK9CmiC3KJigsu0sONMEtKjRziiVe7BM=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=jLiklavf1BJ5ur3o4i2IDUDsaG9NgnAo2mmv29RjDRUYGXW9ovyBHUjJScRo4HRS9hQ38+blf38C7RV5sQbr3/0IGSla4V/4Lc2P5cnkl0IIBha0EIbgVfRDEp/sC+/i4ieyTRyfBoeiioEcpwU4wbHkNqXrZVZqlNUh1cb3C88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VrLc2baW; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bjOQBmwW; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 25 Aug 2025 10:25:09 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1756117510;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ex7lyt7Yu/2zY52yOjMi5p39cbf+JiAHbHdUL6P6cHw=;
	b=VrLc2baWEILjukvY2LwWt8Flnnv7MzxaIt1n65ILXIdx1rDgkZcSatywR5aFPt+Dl4NmM5
	d0CB9eLfYYT/XDTZiH46j+ANmLPhY1Xlj92xi05JGkNS5DzImTMEnHLh/h3qf6e/TzOgom
	eXlHvTy9S+aEYuBeBqqpWW90MWgpWHYWfttcc/3NqkoMrGAEJ+NHzBx8VST5w4FkV+ltv6
	OtuLFq/v5quZTWzOKoCGrXXo8Ncv1CWvEQ3PkGQEHMV+bZVoEGBMIAu74L29thK1pfjfpX
	AAk6G/EuCN943YL5ATokgTbP2yuh0QSPCU8n9zvsE8wprRowniEeKDYyedLsaQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1756117510;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ex7lyt7Yu/2zY52yOjMi5p39cbf+JiAHbHdUL6P6cHw=;
	b=bjOQBmwWAllKPJ977wBromREUSLkJJb3UVHq7VJWHXZWM8RT8+nuevYMW61UfgKItDTJPp
	2pxJ8gCyz4YuOvAA==
From: "tip-bot2 for Jiri Olsa" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] uprobes: Remove breakpoint in unapply_uprobe under
 mmap_write_lock
Cc: Jiri Olsa <jolsa@kernel.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Andrii Nakryiko <andrii@kernel.org>,
 "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
 Oleg Nesterov <oleg@redhat.com>, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250720112133.244369-2-jolsa@kernel.org>
References: <20250720112133.244369-2-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175611750907.1420.16310655013957778625.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     7769cb177b23142b83f22abd06e492cc25157893
Gitweb:        https://git.kernel.org/tip/7769cb177b23142b83f22abd06e492cc251=
57893
Author:        Jiri Olsa <jolsa@kernel.org>
AuthorDate:    Sun, 20 Jul 2025 13:21:11 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 21 Aug 2025 20:09:18 +02:00

uprobes: Remove breakpoint in unapply_uprobe under mmap_write_lock

Currently unapply_uprobe takes mmap_read_lock, but it might call
remove_breakpoint which eventually changes user pages.

Current code writes either breakpoint or original instruction, so it can
go away with read lock as explained in here [1]. But with the upcoming
change that writes multiple instructions on the probed address we need
to ensure that any update to mm's pages is exclusive.

[1] https://lore.kernel.org/all/20240710140045.GA1084@redhat.com/

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Andrii Nakryiko <andrii@kernel.org>
Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Acked-by: Oleg Nesterov <oleg@redhat.com>
Link: https://lore.kernel.org/r/20250720112133.244369-2-jolsa@kernel.org
---
 kernel/events/uprobes.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 7ca1940..1cbfe3c 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -482,7 +482,7 @@ remap:
  * @opcode_vaddr: the virtual address to store the opcode.
  * @opcode: opcode to be written at @opcode_vaddr.
  *
- * Called with mm->mmap_lock held for read or write.
+ * Called with mm->mmap_lock held for write.
  * Return 0 (success) or a negative errno.
  */
 int uprobe_write_opcode(struct arch_uprobe *auprobe, struct vm_area_struct *=
vma,
@@ -1463,7 +1463,7 @@ static int unapply_uprobe(struct uprobe *uprobe, struct=
 mm_struct *mm)
 	struct vm_area_struct *vma;
 	int err =3D 0;
=20
-	mmap_read_lock(mm);
+	mmap_write_lock(mm);
 	for_each_vma(vmi, vma) {
 		unsigned long vaddr;
 		loff_t offset;
@@ -1480,7 +1480,7 @@ static int unapply_uprobe(struct uprobe *uprobe, struct=
 mm_struct *mm)
 		vaddr =3D offset_to_vaddr(vma, uprobe->offset);
 		err |=3D remove_breakpoint(uprobe, vma, vaddr);
 	}
-	mmap_read_unlock(mm);
+	mmap_write_unlock(mm);
=20
 	return err;
 }

