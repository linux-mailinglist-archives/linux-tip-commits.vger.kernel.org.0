Return-Path: <linux-tip-commits+bounces-6378-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 271B6B37AA6
	for <lists+linux-tip-commits@lfdr.de>; Wed, 27 Aug 2025 08:45:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E196D1B6196D
	for <lists+linux-tip-commits@lfdr.de>; Wed, 27 Aug 2025 06:46:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CE7E3128DF;
	Wed, 27 Aug 2025 06:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qB6EZDPQ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="POzBwa2e"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F0DE2F28E3;
	Wed, 27 Aug 2025 06:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756277127; cv=none; b=X5iGTCIywLalU7yJiIyo5gnrElRAR5wgUZuWd/JEpObkChST4cfFtQYO1eYEcD+VFLD+JF/LlxWACo3t0D6Du91A7Giz62gpvXE2xXoNlfNc3URC/GCk+L64zUzB2wTS/DqBODaxKi4gSGlt2Vsu05v2UE1KAb67EvMAjjrVACU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756277127; c=relaxed/simple;
	bh=/mGRaMKUEd3Mf/+xU+RbqMX+U46HibYT5UyWGD32PHY=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=SfnQJl3uVujy5HTspq5Qkakw7SBASC/sc4fMulu0qugKc3eI25cdJki0fYU4RP9/PpR4v6oFcVVG0IdhjgNuH4m8BeexhujWfUwO99UXasoeviqdbTM3QNA2kjagi9dYSWKCeRacNbYKzHTOIt0VfGqKFE2tiv1MR4f6scLIw60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qB6EZDPQ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=POzBwa2e; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 27 Aug 2025 06:45:21 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1756277124;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ue28V9L5jZ3ATwn8bpXKQaOZq986Y8P1XC2H3oLhTto=;
	b=qB6EZDPQP5mOIILJ29eokPOxcuej8W4zPhQXjESlXLazvmudWWkgMvrVgCn6T850qADp43
	2orOTXEzHlXepzOXQKRbTFHe682vVyhKLqehJzPeodJY7VTIlWbRTIgIbCkZZ5jtanMFY2
	Rr5J/rCYaDl+v2jlLbPFBArH7qbD0zYOoVT40J+q73a2aasBbel9mV6EdTzBubbt6xRZ7j
	vz2RGEc76qBVMAg74LtC0wDOAJmWeYn5+KY5I70j/qAfzpn0UoA0j3Cf0JIVN2/wqd54w0
	EC5rALZt/0N1O5GJeyFnWAjZxu7UGoinNihqMNn+vKhetTGCEGHQSg6yglVoYA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1756277124;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ue28V9L5jZ3ATwn8bpXKQaOZq986Y8P1XC2H3oLhTto=;
	b=POzBwa2e4YAW8VcicDlYx3OhTdDhQhBZnt6ynWNkfkD3DiG+3K+SFgUXymK6gLyXbKZbM6
	MJ5CUQ1hGNY8wMBw==
From: "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf: Have get_perf_callchain() return NULL if
 crosstask and user are set
Cc: Josh Poimboeuf <jpoimboe@kernel.org>,
 "Steven Rostedt (Google)" <rostedt@goodmis.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250820180428.426423415@kernel.org>
References: <20250820180428.426423415@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175627712187.1920.14304918617440613309.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     153f9e74dec230f2e070e16fa061bc7adfd2c450
Gitweb:        https://git.kernel.org/tip/153f9e74dec230f2e070e16fa061bc7adfd=
2c450
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Wed, 20 Aug 2025 14:03:40 -04:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 26 Aug 2025 09:51:12 +02:00

perf: Have get_perf_callchain() return NULL if crosstask and user are set

get_perf_callchain() doesn't support cross-task unwinding for user space
stacks, have it return NULL if both the crosstask and user arguments are
set.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20250820180428.426423415@kernel.org
---
 kernel/events/callchain.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/kernel/events/callchain.c b/kernel/events/callchain.c
index b0f5bd2..cd0e3fc 100644
--- a/kernel/events/callchain.c
+++ b/kernel/events/callchain.c
@@ -224,6 +224,10 @@ get_perf_callchain(struct pt_regs *regs, bool kernel, bo=
ol user,
 	struct perf_callchain_entry_ctx ctx;
 	int rctx, start_entry_idx;
=20
+	/* crosstask is not supported for user stacks */
+	if (crosstask && user && !kernel)
+		return NULL;
+
 	entry =3D get_callchain_entry(&rctx);
 	if (!entry)
 		return NULL;
@@ -240,7 +244,7 @@ get_perf_callchain(struct pt_regs *regs, bool kernel, boo=
l user,
 		perf_callchain_kernel(&ctx, regs);
 	}
=20
-	if (user) {
+	if (user && !crosstask) {
 		if (!user_mode(regs)) {
 			if  (current->mm)
 				regs =3D task_pt_regs(current);
@@ -249,9 +253,6 @@ get_perf_callchain(struct pt_regs *regs, bool kernel, boo=
l user,
 		}
=20
 		if (regs) {
-			if (crosstask)
-				goto exit_put;
-
 			if (add_mark)
 				perf_callchain_store_context(&ctx, PERF_CONTEXT_USER);
=20
@@ -261,7 +262,6 @@ get_perf_callchain(struct pt_regs *regs, bool kernel, boo=
l user,
 		}
 	}
=20
-exit_put:
 	put_callchain_entry(rctx);
=20
 	return entry;

