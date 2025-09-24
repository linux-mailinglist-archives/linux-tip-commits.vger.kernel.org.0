Return-Path: <linux-tip-commits+bounces-6713-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 49AACB98855
	for <lists+linux-tip-commits@lfdr.de>; Wed, 24 Sep 2025 09:25:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A9702E3DD0
	for <lists+linux-tip-commits@lfdr.de>; Wed, 24 Sep 2025 07:25:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F8162741DA;
	Wed, 24 Sep 2025 07:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xl00O5BZ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cPHeNHtq"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0417E2741A0;
	Wed, 24 Sep 2025 07:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758698709; cv=none; b=JvOOKp4wmmamQ26MazY260XO3dUuau9trHQLiOMb4yMg9ACQCyq3DGm8eX4C98fMEbY+RqelW20B42hXuZdOGpiOwffRdM2/cZ6mhi/Xw7PmTkwDkb53526kLJoYgUNEmpzwe1wP9TPcEaGJpFsMULpT3xCBGgyheYHb4Pqo32Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758698709; c=relaxed/simple;
	bh=3Xf53nHR/n97vlqvgNQnY/Qdii8msVG0oxEiJF655kc=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=udBh5MOvnlDg3P4ye4IOOhZPXYS8YCm0NI4sUPDZhVi4q900FdoGr0grauUwN66V+pyD6Zf5raWypVSqUun6gHUiDmQzhE7m1YdRqc+u8Wq4IZ7y8ake++nhbckd/0l021GqXIOr9QibCDeVBHsMgH2TBWZHUQx+GwK+v6g3Anw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xl00O5BZ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cPHeNHtq; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 24 Sep 2025 07:24:53 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1758698698;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S7wkPNUQqz+2PeDx+vdg3F0rD/CUoqYG/jHjM1ol0eQ=;
	b=xl00O5BZlqXOIJerJ7RDCGOaOEp0yP52rNV2L39nZ36w2PSTVjNR/ky/Mps+sJ2bY7FY3J
	x9ZtWrVTvKJGS0v3NLSy/DA/BmuWdDTLCji6oeNxsPBKBraC+DqUZp6MXS7VdBnOiJlb80
	Psz/QpyBJg3c9ISRMcW3XsY7FVUEA4kQJDMY52FJtdKic5GnmbiYi4vCjwYGIHO8wiYclz
	wEuqGSva99JSk0EWXop1KBBdbfWj1oKJTw/c0/iS3nduv+WBV/DSRDtpA8II82enu3CTQX
	2dxGWHoXlsm4RSEFhnsz5fffTfk4QUGJn0RFIxrsyIZPPC8+opl76ql6CGIyng==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1758698698;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S7wkPNUQqz+2PeDx+vdg3F0rD/CUoqYG/jHjM1ol0eQ=;
	b=cPHeNHtqGJlCEqd1c3GegDPoqKraT7v6IqEFWgqoejpodjVhlc1YHDgPOQv5EwH7EYWff0
	DDdbQZM3Zd083oDg==
From: "tip-bot2 for Sebastian Andrzej Siewior" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: locking/urgent] futex: Use correct exit on failure from
 futex_hash_allocate_default()
Cc: syzbot+80cb3cc5c14fad191a10@syzkaller.appspotmail.com,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Thomas Gleixner <tglx@linutronix.de>,
 "Steven Rostedt (Google)" <rostedt@goodmis.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250918130945.-7SIRk8Z@linutronix.de>
References: <20250918130945.-7SIRk8Z@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175869869389.709179.4541234801013742071.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the locking/urgent branch of tip:

Commit-ID:     4ec3c15462b9f44562f45723a92e2807746ba7d1
Gitweb:        https://git.kernel.org/tip/4ec3c15462b9f44562f45723a92e2807746=
ba7d1
Author:        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate:    Thu, 18 Sep 2025 15:09:45 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 24 Sep 2025 09:20:02 +02:00

futex: Use correct exit on failure from futex_hash_allocate_default()

copy_process() uses the wrong error exit path from futex_hash_allocate_defaul=
t().
After exiting from futex_hash_allocate_default(), neither tasklist_lock
nor siglock has been acquired. The exit label bad_fork_core_free unlocks
both of these locks which is wrong.

The next exit label, bad_fork_cancel_cgroup, is the correct exit.
sched_cgroup_fork() did not allocate any resources that need to freed.

Use bad_fork_cancel_cgroup on error exit from futex_hash_allocate_default().

Fixes: 7c4f75a21f636 ("futex: Allow automatic allocation of process wide fute=
x hash")
Reported-by: syzbot+80cb3cc5c14fad191a10@syzkaller.appspotmail.com
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Closes: https://lore.kernel.org/all/68cb1cbd.050a0220.2ff435.0599.GAE@google.=
com
---
 kernel/fork.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/fork.c b/kernel/fork.c
index c4ada32..6ca8689 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2295,7 +2295,7 @@ __latent_entropy struct task_struct *copy_process(
 	if (need_futex_hash_allocate_default(clone_flags)) {
 		retval =3D futex_hash_allocate_default();
 		if (retval)
-			goto bad_fork_core_free;
+			goto bad_fork_cancel_cgroup;
 		/*
 		 * If we fail beyond this point we don't free the allocated
 		 * futex hash map. We assume that another thread will be created

