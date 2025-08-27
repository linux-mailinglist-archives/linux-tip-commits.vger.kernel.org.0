Return-Path: <linux-tip-commits+bounces-6375-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C500B37A9F
	for <lists+linux-tip-commits@lfdr.de>; Wed, 27 Aug 2025 08:45:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 787FC4E03E1
	for <lists+linux-tip-commits@lfdr.de>; Wed, 27 Aug 2025 06:45:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 553CF2701C2;
	Wed, 27 Aug 2025 06:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Lb/pgR+a";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jB5my3d5"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3AA41E520C;
	Wed, 27 Aug 2025 06:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756277123; cv=none; b=jEB4lEDNfyhpTQbzHZitD7qxeqLkTcvTuwOvBgt2N6uQ8zQ/451jr3+yisFMljD9qGOf/Ck0Bth5BAXz9HpdVwc+t6br2i6CORAhDVG1sJCZ3FpkiC8MsVtgEDX7/JysFMJDIQfHdxcD76pPReD+3hnTo0ulKOoqGToaa5N6ivc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756277123; c=relaxed/simple;
	bh=4n3vCaPQp28RW2Mt27NfChjc+Yb5lJV4y6AosBbYjCI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=sYO1uDpLv2JcsOzLVUt5b6G0NFNkvukOB+fGbHiMI/UhLJqGmNycHp6wO9dnfUxsx3YUB1mgyLgtN5uPy9XytuLTPsizQHpNPv6wxBpVJyZ+89IVChMG3G9Isas+W5n+kDDnK7YiCqW+zKb7/d4PjKhJuCiVTIZH878/MwNGnWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Lb/pgR+a; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jB5my3d5; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 27 Aug 2025 06:45:14 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1756277119;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=psdguZ1Ssn+7A0tSYTSIx/6mRmbLjMtDHpA1rG9guqM=;
	b=Lb/pgR+a8sjew7VkX9clWGXNH6mD0TdyybQWEff05dc3fi2c7dwEwhwUTTMEQkVHkqC4Nz
	ZkQWnbzXcYuTS2sKdNLdpdi/MsVjPlxSimweb24quE1Vw7sDAbRVlKIRMrqkLnL4isoufk
	o4C31NYztneQ2NwAnaeZwhOt6CzGtAHdjKdIO+zzdlm04fetrBFc4JRDqo2AUo3ic61vML
	ywSUvl1b8mYWEnoTpz777h4GgU6f4k9sayZ6kN7AWWRaw5KDrNy2qKdyW+HjDHMJGMPeRy
	kP1jjqQkMXs1KGsLMkzEutDVRSTktwnFL4HOFStNdJN5frmKbigYyyCRsWXKNg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1756277119;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=psdguZ1Ssn+7A0tSYTSIx/6mRmbLjMtDHpA1rG9guqM=;
	b=jB5my3d5BtZtXMEDtKoMdztPp1SQACxOiaKg/Xr3d5wIrxC1r3le7wzHcdHsaskSqmswvQ
	AnGVDZ+BSfXCmdAQ==
From: "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: perf/core] perf: Skip user unwind if the task is a kernel thread
Cc: Josh Poimboeuf <jpoimboe@kernel.org>,
 "Steven Rostedt (Google)" <rostedt@goodmis.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250820180428.930791978@kernel.org>
References: <20250820180428.930791978@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175627711485.1920.5265767868281233884.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     16ed389227651330879e17bd83d43bd234006722
Gitweb:        https://git.kernel.org/tip/16ed389227651330879e17bd83d43bd2340=
06722
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Wed, 20 Aug 2025 14:03:43 -04:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 26 Aug 2025 09:51:13 +02:00

perf: Skip user unwind if the task is a kernel thread

If the task is not a user thread, there's no user stack to unwind.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20250820180428.930791978@kernel.org
---
 kernel/events/core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index f880cec..28de3ba 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -8198,7 +8198,8 @@ struct perf_callchain_entry *
 perf_callchain(struct perf_event *event, struct pt_regs *regs)
 {
 	bool kernel =3D !event->attr.exclude_callchain_kernel;
-	bool user   =3D !event->attr.exclude_callchain_user;
+	bool user   =3D !event->attr.exclude_callchain_user &&
+		!(current->flags & (PF_KTHREAD | PF_USER_WORKER));
 	/* Disallow cross-task user callchains. */
 	bool crosstask =3D event->ctx->task && event->ctx->task !=3D current;
 	const u32 max_stack =3D event->attr.sample_max_stack;

