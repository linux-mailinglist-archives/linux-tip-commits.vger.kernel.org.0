Return-Path: <linux-tip-commits+bounces-7201-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C0B0EC2C8C5
	for <lists+linux-tip-commits@lfdr.de>; Mon, 03 Nov 2025 16:04:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC5E61885B71
	for <lists+linux-tip-commits@lfdr.de>; Mon,  3 Nov 2025 15:03:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BDFA31BC8D;
	Mon,  3 Nov 2025 14:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jqzrnYT0";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hraG2J8i"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6480231BCAF;
	Mon,  3 Nov 2025 14:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762181277; cv=none; b=klq5/HjZF9zJqbF+zjVcjUGHP05/HJHQUaFtKE1RlM6qvTNWEruWTt1EdlxEwBAKiLzEZ0ew9Qniiyxh6jMd5FQV4pN+on16CvyRXMa/GGcqaY1QfTlOzK/tSx5Vq9ujMAbuzPU9hU3cAK/zrgQm1+RTqkrAcN/BG52eBj46czM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762181277; c=relaxed/simple;
	bh=TzEJgu2YXdgySKQ4Gq3SzrWmpiNNO8XqRcms+yfWpB8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=I0zc7I0yMYEFWEXlPtIH7rZHBPZaWGHPBLWcYQ3C7QP3mOzi27KqFT5wXXkU3iMgrF2Eo/kaH0gZL0wN9Dk3LZyhlVOVjMlWphmPtl2xntd2WrI8UaC9Fqfb336Kqk2n1fE3RkikG5Wh/iq4f5Mxl07cfNjhSwva6aorIinrM0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jqzrnYT0; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hraG2J8i; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 03 Nov 2025 14:47:52 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1762181273;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ftdcVJcopmkiLRNuFefVQ5hpWUlWlmXqvZ4TIQLaLQU=;
	b=jqzrnYT0PrpZuAzteRFbOzTs1RUEKeG2NdlFmVzuv3LRM3ykmDe8fz+p1EneXIZGZ3qmn/
	7WQHwXJLzmOmMBnnnZHS5UtjOXgRkpCH+eaGPSAN4ROQarR47pVjJv6rGWZABj/rJRYiku
	2qvAQVuDhBk94k57b6rHvAgOrPumeUcglGPjP6lxm8HoDWpEUfFOzF9ljTpdjDTvLU88xE
	V/EZgjuRknWfqQClOqZI+bNjadF+NHp6oOrtm9eoo7Xi7flpYBXUfwUEUylsQn3vXSfzDY
	oETmYtK5jnlNZIujDo78BEt966NwXuA6fTmrmUHDD1ak3xNwFTvVHqUrQPfpVw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1762181273;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ftdcVJcopmkiLRNuFefVQ5hpWUlWlmXqvZ4TIQLaLQU=;
	b=hraG2J8iRuWI0yDEaYf/LMHpp24A0R8uUalLU9ELt3dZ6UwHvToFD+i8maSD62JKA/rgjG
	Zcytv9xYuwxHFCCA==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: core/rseq] rseq: Simplify registration
Cc: Thomas Gleixner <tglx@linutronix.de>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251027084306.274661227@linutronix.de>
References: <20251027084306.274661227@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176218127249.2601451.23358296039773356.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the core/rseq branch of tip:

Commit-ID:     ae3051d908dda0409d18d8e31a3b89023376ada3
Gitweb:        https://git.kernel.org/tip/ae3051d908dda0409d18d8e31a3b8902337=
6ada3
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 27 Oct 2025 09:44:24 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 03 Nov 2025 15:26:13 +01:00

rseq: Simplify registration

There is no point to read the critical section element in the newly
registered user space RSEQ struct first in order to clear it.

Just clear it and be done with it.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Link: https://patch.msgid.link/20251027084306.274661227@linutronix.de
---
 kernel/rseq.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/kernel/rseq.c b/kernel/rseq.c
index 51fafc4..80af48a 100644
--- a/kernel/rseq.c
+++ b/kernel/rseq.c
@@ -492,11 +492,9 @@ void rseq_syscall(struct pt_regs *regs)
 /*
  * sys_rseq - setup restartable sequences for caller thread.
  */
-SYSCALL_DEFINE4(rseq, struct rseq __user *, rseq, u32, rseq_len,
-		int, flags, u32, sig)
+SYSCALL_DEFINE4(rseq, struct rseq __user *, rseq, u32, rseq_len, int, flags,=
 u32, sig)
 {
 	int ret;
-	u64 rseq_cs;
=20
 	if (flags & RSEQ_FLAG_UNREGISTER) {
 		if (flags & ~RSEQ_FLAG_UNREGISTER)
@@ -557,11 +555,9 @@ SYSCALL_DEFINE4(rseq, struct rseq __user *, rseq, u32, r=
seq_len,
 	 * avoid a potential segfault on return to user-space. The proper thing
 	 * to do would have been to fail the registration but this would break
 	 * older libcs that reuse the rseq area for new threads without
-	 * clearing the fields.
+	 * clearing the fields. Don't bother reading it, just reset it.
 	 */
-	if (rseq_get_rseq_cs_ptr_val(rseq, &rseq_cs))
-	        return -EFAULT;
-	if (rseq_cs && clear_rseq_cs(rseq))
+	if (put_user(0UL, &rseq->rseq_cs))
 		return -EFAULT;
=20
 #ifdef CONFIG_DEBUG_RSEQ

