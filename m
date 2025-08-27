Return-Path: <linux-tip-commits+bounces-6376-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 528C7B37AA1
	for <lists+linux-tip-commits@lfdr.de>; Wed, 27 Aug 2025 08:45:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DB362011F0
	for <lists+linux-tip-commits@lfdr.de>; Wed, 27 Aug 2025 06:45:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C3BC2DECB9;
	Wed, 27 Aug 2025 06:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FnRNEKhZ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SU8B6Sck"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BC3A1862A;
	Wed, 27 Aug 2025 06:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756277123; cv=none; b=bwOd4ACQ0ZzP1LTOLja4tkpblP6fvnE+um8+sA0p5ov5F/zWrFcA36urZSNAkffFoDfxPDxmm2DKVfM8uvq5esatqEhxl8n5SLW4hZZekvDEOtsZT37ushUW6L7sgwdhROPJrf2O4ISLxYo3ub7PdUVEatC/ZOj3mU1M5EakbOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756277123; c=relaxed/simple;
	bh=gFVBkMWQrfbPP/64qYseQhK7lixnZWQnEeoaQaJl48s=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=YG8X1JSru1i6kOg+veoeTecm9uYTxhOacQPu0YSpvqwWt+gfrJ/rLSM7he7uJKEQJmYZksQ1nR7Bg1HAyGYNkp82jhZPxZLc77ijaYBj8zlaM03uIcJDio+EYq6tSYb15zGxnckKWAMNy0WXDmGF0YxyYGlxczabKvN5wZa/p9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FnRNEKhZ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SU8B6Sck; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 27 Aug 2025 06:45:19 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1756277120;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OT2LILf6ourgqg+57JWsPKsI0ACauwr04O2CQvU4Hyk=;
	b=FnRNEKhZfUuVzB/L2s6NM2fZnKSrZWiDm6pSlWb3QPLBN6jnSvrTZb+lYV4DYQjt8Tob/F
	mNf2Ic840FkQdpwWeGDqjwWNMJ1wSok+Jk4eyvxbWSka6fray7G8X2hOI2qdKAIK0s2iQK
	BtNeuIwjfHUXdPi3GZjbVw9ckMvA3BsOVV5KTFWGIqb66d9vTO8qTPwgN6K2DyFTFLII73
	aEFyUPOpo2huA5cKO2ku1qoIPa3LQAbmBN8DDuxodEhB7jq2oKPBZ3xFkxFUR1ikiEPgQC
	Xkrf7s72mIrNHK2SFopyrIiemsgOYPQznKdv6XB38zGWUMkkPWLSw2PbOWup5w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1756277120;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OT2LILf6ourgqg+57JWsPKsI0ACauwr04O2CQvU4Hyk=;
	b=SU8B6ScksHEGGku9khhklrUtKgnpcAH1JpbelIp/MoppeZFxEhnX8bnMq1X6zuW5RKDl8T
	vh4BjrTe/NtWsuBA==
From: "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf: Simplify get_perf_callchain() user logic
Cc: Josh Poimboeuf <jpoimboe@kernel.org>,
 "Steven Rostedt (Google)" <rostedt@goodmis.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Namhyung Kim <namhyung@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250820180428.760066227@kernel.org>
References: <20250820180428.760066227@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175627711939.1920.2206772956007488525.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     d77e3319e31098a6cb97b7ce4e71ba676e327fd7
Gitweb:        https://git.kernel.org/tip/d77e3319e31098a6cb97b7ce4e71ba676e3=
27fd7
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Wed, 20 Aug 2025 14:03:42 -04:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 26 Aug 2025 09:51:13 +02:00

perf: Simplify get_perf_callchain() user logic

Simplify the get_perf_callchain() user logic a bit.  task_pt_regs()
should never be NULL.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Namhyung Kim <namhyung@kernel.org>
Link: https://lore.kernel.org/r/20250820180428.760066227@kernel.org
---
 kernel/events/callchain.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/kernel/events/callchain.c b/kernel/events/callchain.c
index 5982d18..808c0d7 100644
--- a/kernel/events/callchain.c
+++ b/kernel/events/callchain.c
@@ -247,21 +247,19 @@ get_perf_callchain(struct pt_regs *regs, bool kernel, b=
ool user,
 	if (user && !crosstask) {
 		if (!user_mode(regs)) {
 			if (current->flags & (PF_KTHREAD | PF_USER_WORKER))
-				regs =3D NULL;
-			else
-				regs =3D task_pt_regs(current);
+				goto exit_put;
+			regs =3D task_pt_regs(current);
 		}
=20
-		if (regs) {
-			if (add_mark)
-				perf_callchain_store_context(&ctx, PERF_CONTEXT_USER);
+		if (add_mark)
+			perf_callchain_store_context(&ctx, PERF_CONTEXT_USER);
=20
-			start_entry_idx =3D entry->nr;
-			perf_callchain_user(&ctx, regs);
-			fixup_uretprobe_trampoline_entries(entry, start_entry_idx);
-		}
+		start_entry_idx =3D entry->nr;
+		perf_callchain_user(&ctx, regs);
+		fixup_uretprobe_trampoline_entries(entry, start_entry_idx);
 	}
=20
+exit_put:
 	put_callchain_entry(rctx);
=20
 	return entry;

