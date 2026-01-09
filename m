Return-Path: <linux-tip-commits+bounces-7834-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 57995D09623
	for <lists+linux-tip-commits@lfdr.de>; Fri, 09 Jan 2026 13:14:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BC75630B08AC
	for <lists+linux-tip-commits@lfdr.de>; Fri,  9 Jan 2026 12:05:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62A4C359FBA;
	Fri,  9 Jan 2026 12:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Lkb82a23";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Mr+o3mXI"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F26861946C8;
	Fri,  9 Jan 2026 12:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767960341; cv=none; b=NjwPfdgPzh+HG5ksCaltNThoJoOYlNkWHNquhi4MS0FZFl8fwINzXutvYYaRk0ZvUMX0ccZEjPlvC28JZmE9R+Her/8BIjvfxuFAa3jNP1eoWDM6BhRKzIFG5mxxQg22XnFgYCfOXIxqgHPkl+UqUUF4fE6DXNEQ7fySzeJzsKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767960341; c=relaxed/simple;
	bh=Gk5Qx5x2aTbkOmoLpYZkGw5FOrm0zw7xeLdyLnbfUaY=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=HXcSYM/gIatsLgLEpwQUV+xZ5ByqPkB2jsLBidOOeqb3xi/nlegZ4jEOYmNMNZmmpDwTKCct2c8Hv2GKIg81HphWUZ9RhrZhUz6kFK15XjSJVn5oN8D9D1GqG7VL24EEc7Edmm9BcNoJkm6uBgjJUphz0p0OWB2GNaI0D9iwaD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Lkb82a23; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Mr+o3mXI; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 09 Jan 2026 12:05:36 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1767960338;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pRH/8fLsnpSyWon67AZLh4ZyFg5prebNfOZybgPPK7o=;
	b=Lkb82a232xYKnfJwdZpVN3mNnjY5qysvc5tO9CUWfftcdMiZAklAB9ysIva971hZiy5QlZ
	mKQfaONc6++TqwAoTHVMO/Z7j0xir1reUFeJcqX/T6ivOKReyQpb60Hf7oCXqzZY1h+/Ca
	MYNjC2qQmXEwvC1Xisnt1RdDNUisMhvg2L2pj1GN34sVUdn+84OzjINpm7FSeU0BKRHb5H
	+MEXeswCRdLsJfh7+SR8mnHFmW2uL1OIw2yOU2N4LtXhfHs5YGAR2PZ2CJ/Tt269QaHSgH
	CWnSy1DuRg1vH5t18AW8VihcCcNuPZ2kLAOdm/Lop/j6r1N8mgfH7qlvAFW4xA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1767960338;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pRH/8fLsnpSyWon67AZLh4ZyFg5prebNfOZybgPPK7o=;
	b=Mr+o3mXIke4GvHgYlUo/KY3U6n2KcI65erPCKCK9Ct1zx3/FrslDpY9P8d/nrYPFXXMW6I
	Yq+rUnbJCDqExeAA==
From: "tip-bot2 for Cong Wang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/urgent] sched/mm_cid: Prevent NULL mm dereference in
 sched_mm_cid_after_execve()
Cc: Cong Wang <cwang@multikernel.io>, Thomas Gleixner <tglx@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Will Deacon <will@kernel.org>, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20251223215113.639686-1-xiyou.wangcong@gmail.com>
References: <20251223215113.639686-1-xiyou.wangcong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176796033688.510.2605056571822363443.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the sched/urgent branch of tip:

Commit-ID:     2bdf777410dc6e022d1081885ff34673b5dfee99
Gitweb:        https://git.kernel.org/tip/2bdf777410dc6e022d1081885ff34673b5d=
fee99
Author:        Cong Wang <cwang@multikernel.io>
AuthorDate:    Tue, 23 Dec 2025 13:51:13 -08:00
Committer:     Thomas Gleixner <tglx@kernel.org>
CommitterDate: Fri, 09 Jan 2026 13:02:57 +01:00

sched/mm_cid: Prevent NULL mm dereference in sched_mm_cid_after_execve()

sched_mm_cid_after_execve() is called in bprm_execve()'s cleanup path even
when exec_binprm() fails. For the init task's first execve(), this causes a
problem:

  1. current->mm is NULL (kernel threads don't have an mm)
  2. sched_mm_cid_before_execve() exits early because mm is NULL
  3. exec_binprm() fails (e.g., ENOENT for missing script interpreter)
  4. sched_mm_cid_after_execve() is called with mm still NULL
  5. sched_mm_cid_fork() is called unconditionally, triggering WARN_ON

This is easily reproduced by booting with an init that is a shell script
(#!/bin/sh) where the interpreter doesn't exist in the initramfs.

Fix this by checking if t->mm is NULL before calling sched_mm_cid_fork(),
matching the behavior of sched_mm_cid_before_execve() which already
handles this case via sched_mm_cid_exit()'s early return.

Fixes: b0c3d51b54f8 ("sched/mmcid: Provide precomputed maximal value")
Signed-off-by: Cong Wang <cwang@multikernel.io>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Acked-by: Will Deacon <will@kernel.org>
Link: https://patch.msgid.link/20251223215113.639686-1-xiyou.wangcong@gmail.c=
om
---
 kernel/sched/core.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 41ba0be..60afadb 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -10694,10 +10694,11 @@ void sched_mm_cid_before_execve(struct task_struct =
*t)
 	sched_mm_cid_exit(t);
 }
=20
-/* Reactivate MM CID after successful execve() */
+/* Reactivate MM CID after execve() */
 void sched_mm_cid_after_execve(struct task_struct *t)
 {
-	sched_mm_cid_fork(t);
+	if (t->mm)
+		sched_mm_cid_fork(t);
 }
=20
 static void mm_cid_work_fn(struct work_struct *work)

