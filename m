Return-Path: <linux-tip-commits+bounces-7900-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B6262D1822C
	for <lists+linux-tip-commits@lfdr.de>; Tue, 13 Jan 2026 11:46:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 06F2B3067DEB
	for <lists+linux-tip-commits@lfdr.de>; Tue, 13 Jan 2026 10:43:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B63EA349AEE;
	Tue, 13 Jan 2026 10:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ttbcenN7";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="+yLyNQeo"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02DE5346E5A;
	Tue, 13 Jan 2026 10:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768301004; cv=none; b=DOPsQgmyhztCOBBWc1+9rGc7nV9t8I03NEpxxv0VHzH7K4DueaC+hnyzccIr0oJhBNM6wUFI6K+Sm04Acwkg4QjhawmG2wdcAmgkVPkNlYMrQ5hUVh1klReycNKrUG/3dyG3CFUOon2AYZxSj7e8pEEZkceyyqr4nLe729TIKlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768301004; c=relaxed/simple;
	bh=FG69zyL1oNTWvST1Os7a0JH01Rw83c3ZFfjBBUy2hqg=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=BokD1LoW+fYa2WqMyjUb1XC0rAWUs8mwsCpP07dhlMI/uy/EF+rueQ068L279QzrFoDodQBztiiPU43QIBE0LWvvjHa940Fe38FKlckShvsZss92XJNP7uaLe9j/PB2vNEiu4mLeNDw1H4SfRFfj5BtTGRdiLaIDR4aaTO+PIEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ttbcenN7; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=+yLyNQeo; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 13 Jan 2026 10:43:20 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1768301001;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dimbJisPeRpiqsU+plEY8qJ5TINw1DQNs0fou95xS1M=;
	b=ttbcenN7uQivACYrxS7EDdf6CTmnjSar+qlDD2j4uKSpmlwGRsKxa+z347eKCCqi+c76E0
	V5tyckfi3p7wO1DM5pENmYsvLufJXF9aJPoe0IilFZx+Xg9/jHgaJbmtcAS0MCCnD0eox8
	XRf4Ab/kTbp5o8Y+Qe0Jg9imFu+a+GqI+PMZNwJ3Ieo1M+8VPsBeAQabYBB9jzk7jBZlMU
	7casobDAiSnMLxelvk1tRmJ4OVzaUf7o7epehlnwZiTExrIOEqK3WRNQ1OuxF42OrdpxOK
	mB7qKLqJDyPmg0RAyviCGm+e+w2A8zrhKpBgOmelNP1Uobkx1RWLuBU2bkmTkg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1768301001;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dimbJisPeRpiqsU+plEY8qJ5TINw1DQNs0fou95xS1M=;
	b=+yLyNQeoCcA7VS7H64LRP6zuNYU02qxswO8Nr4wnmTz0Y6cYJyPyBTY0ILJ+hyHDZYvXdW
	gsp5asVfrMCEzNDA==
From: "tip-bot2 for Gabriele Monaco" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched: Export hidden tracepoints to modules
Cc: Gabriele Monaco <gmonaco@redhat.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, Phil Auld <pauld@redhat.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20251205131621.135513-9-gmonaco@redhat.com>
References: <20251205131621.135513-9-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176830100012.510.16387932052230943652.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     6c125b85f3c87b4bf7dba91af6f27d9600b9dba0
Gitweb:        https://git.kernel.org/tip/6c125b85f3c87b4bf7dba91af6f27d9600b=
9dba0
Author:        Gabriele Monaco <gmonaco@redhat.com>
AuthorDate:    Fri, 05 Dec 2025 14:16:16 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 13 Jan 2026 11:37:53 +01:00

sched: Export hidden tracepoints to modules

The tracepoints sched_entry, sched_exit and sched_set_need_resched
are not exported to tracefs as trace events, this allows only kernel
code to access them. Helper modules like [1] can be used to still have
the tracepoints available to ftrace for debugging purposes, but they do
rely on the tracepoints being exported.

Export the 3 not exported tracepoints.
Note that sched_set_state is already exported as the macro is called
from modules.

[1] - https://github.com/qais-yousef/sched_tp.git

Fixes: adcc3bfa8806 ("sched: Adapt sched tracepoints for RV task model")
Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Phil Auld <pauld@redhat.com>
Link: https://patch.msgid.link/20251205131621.135513-9-gmonaco@redhat.com
---
 kernel/sched/core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index fa72075..b033f97 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -119,6 +119,9 @@ EXPORT_TRACEPOINT_SYMBOL_GPL(sched_util_est_cfs_tp);
 EXPORT_TRACEPOINT_SYMBOL_GPL(sched_util_est_se_tp);
 EXPORT_TRACEPOINT_SYMBOL_GPL(sched_update_nr_running_tp);
 EXPORT_TRACEPOINT_SYMBOL_GPL(sched_compute_energy_tp);
+EXPORT_TRACEPOINT_SYMBOL_GPL(sched_entry_tp);
+EXPORT_TRACEPOINT_SYMBOL_GPL(sched_exit_tp);
+EXPORT_TRACEPOINT_SYMBOL_GPL(sched_set_need_resched_tp);
=20
 DEFINE_PER_CPU_SHARED_ALIGNED(struct rq, runqueues);
 DEFINE_PER_CPU(struct rnd_state, sched_rnd_state);

