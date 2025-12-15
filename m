Return-Path: <linux-tip-commits+bounces-7701-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D73C4CBCE78
	for <lists+linux-tip-commits@lfdr.de>; Mon, 15 Dec 2025 09:03:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B6664303A0A9
	for <lists+linux-tip-commits@lfdr.de>; Mon, 15 Dec 2025 07:59:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3638732AAAB;
	Mon, 15 Dec 2025 07:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ezYj7M3D";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="w/YQRyl9"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FA5B32A3C1;
	Mon, 15 Dec 2025 07:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765785562; cv=none; b=Z4jd8ylmmHM2z+0WufQ26leHcdVRbSlREntv6GUCi8Z7hQYhRsgrYUmlzoSKTG7b19pNrXD8CSZ5zYA62tGQrDAQmbF6P6NMq0zWz4TyEtIYlkIgOnKZcAuRiOz7bhEZjRIvoZTZxqzkLQGJWrdBY/enm+9i2AQFGgoQoY9myJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765785562; c=relaxed/simple;
	bh=GyGhMPMdGZWkPR2HvlEQFWqsytMYAKZ+qiCc1xwskiw=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=RB8NdfAoXfQgCfJUAY7zOzfEHlK7TccCjQfiih2664P3Esk3SQA26H84H5J/cJdb9uxsxj8xmgJFv4SVGR8bnTno7z/W+msqqR96iyutJ8eNACpPryJyzDxfm5hEZYBj5W4c7MH3gDeZFg+xZlb7o866rW1IU+rZQzna+DxEo+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ezYj7M3D; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=w/YQRyl9; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 15 Dec 2025 07:59:12 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1765785554;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6cWmil/tpE/4UvrT4Q9MblAonxTgQsWU2EiujGzdONE=;
	b=ezYj7M3DBm3qkGHqNk8ryg7DdMcvFTBOXzJhGfrPPfiSHQ6i1ZP2cbkbhi5uqrMaqHyTYU
	ui4jgWIwyeb6c+TBKbXYtQ6KDCl5hiaf9bvTdLLSmlqSsmQWTDIom49U5U1k/H2raw3t//
	v94VxdtK5EV1L9oyuPUVdKzCQyoqn+2UjsHKM01B3bxzq43pbpLOF7Mi00nmepOqMXGz5m
	6ipIDr7uShhWBLVPMJVc1IPWCpz+CZJMEwRN/ReZLSzBLyc9QmzP7R3+YyZ4+Mpt0oMBdP
	XudeJrPlfeqMkf+xmlY3uAETkBAG7EMiBC9Cv75zd0gMvRREoHMcSq9Or5X9FA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1765785554;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6cWmil/tpE/4UvrT4Q9MblAonxTgQsWU2EiujGzdONE=;
	b=w/YQRyl9vPeXv38VmCvFSl9S1El/L8TV8yC+ap+Ke+u9pvqXg0WMyTtCEuTW0jwlMcb8SU
	+SYMToiwyE1QLbDA==
From: "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/fair: Separate se->vlag from se->vprot
Cc:
 Ingo Molnar <mingo@kernel.org>, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20251201064647.1851919-4-mingo@kernel.org>
References: <20251201064647.1851919-4-mingo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176578555296.498.828560876846055612.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     80390ead2080071cbd6f427ff8deb94d10a4a50f
Gitweb:        https://git.kernel.org/tip/80390ead2080071cbd6f427ff8deb94d10a=
4a50f
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Wed, 26 Nov 2025 05:31:28 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 15 Dec 2025 07:52:44 +01:00

sched/fair: Separate se->vlag from se->vprot

There's no real space concerns here and keeping these fields
in a union makes reading (and tracing) the scheduler code harder.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://patch.msgid.link/20251201064647.1851919-4-mingo@kernel.org
---
 include/linux/sched.h | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index d395f28..bf96a7d 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -586,15 +586,10 @@ struct sched_entity {
 	u64				sum_exec_runtime;
 	u64				prev_sum_exec_runtime;
 	u64				vruntime;
-	union {
-		/*
-		 * When !@on_rq this field is vlag.
-		 * When cfs_rq->curr =3D=3D se (which implies @on_rq)
-		 * this field is vprot. See protect_slice().
-		 */
-		s64                     vlag;
-		u64                     vprot;
-	};
+	/* Approximated virtual lag: */
+	s64				vlag;
+	/* 'Protected' deadline, to give out minimum quantums: */
+	u64				vprot;
 	u64				slice;
=20
 	u64				nr_migrations;

