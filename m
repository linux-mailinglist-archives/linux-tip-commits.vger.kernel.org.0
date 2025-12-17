Return-Path: <linux-tip-commits+bounces-7740-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 93CF8CC7B3C
	for <lists+linux-tip-commits@lfdr.de>; Wed, 17 Dec 2025 13:51:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AD8E03087991
	for <lists+linux-tip-commits@lfdr.de>; Wed, 17 Dec 2025 12:47:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E68E9345CB1;
	Wed, 17 Dec 2025 12:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JojKaCk9";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KCp94ljE"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3816D3451A7;
	Wed, 17 Dec 2025 12:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765975089; cv=none; b=KRFh8qkPFxySbnOPIOlGaRUr9rsE8yzXQhdp5uR64oTvVl4bsaqGcEMlN5E0XXKOIkfFEiCELnRfMKXAv5Gm3Yvvzrn/bPstxrMEgJQ2zx77/wv7SrVax2rsm6kzw5vMV3MuaTxjC70CaI0ogiO3QwML2gIish4WIGXJ47JW0H4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765975089; c=relaxed/simple;
	bh=0ryz5+PZWkmQBp/annbH4tdiDuc9ZPirRQ+/kkhWDaI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=eAO8PFjM2/XiUoCknwjf6v44+kakrt3lx31F4bS8jBsZT0+Cb+GUjZWp4ZgV+hjO4mMVRjwQosL/wc91SkL2yrKmhqpQI8oA4vlcztJVMXyteIw5VgBhCSIebiFezKcEQtgr9g6oCMgEbHegxm85ozKz9FLOh2Yq8dy580aKQAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JojKaCk9; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KCp94ljE; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 17 Dec 2025 12:38:05 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1765975086;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dxh5Xyq7yNSDiFI1Gp/hFK/ypgOAp9s/TbvGDjVXPXQ=;
	b=JojKaCk97o+2ZKp924obIpixWhYC+i47ZuedeFm7sKbTOGtEnx9F9YWkFGLjTkeFUMYFDn
	M3vIHUzVdO8RbbdaMn2/Zm7Kpi7u7p8JbHVHeuS5DDkxvd7xOCc6ALQ6kA6wq9p0X5QCU/
	dmTNC5v4zsH+bFDa6zQQ555l6fO9yKX76nlPGa6l8uWT35xvmXCWb7/20HaT6U/Y0Q7k1E
	m7sTx0bYxUf+2vGWcEU5gO4J6ORWqmzFxvqmMyhURJEhpWH2DrgMRqCxm/wwrnr8aWom5J
	ujH39m/d7YgcVoNZ7UreTeB1DjYtN/0ZxNpPDeyOF1k4G/rIpXNmT1PbA49bSg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1765975086;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dxh5Xyq7yNSDiFI1Gp/hFK/ypgOAp9s/TbvGDjVXPXQ=;
	b=KCp94ljEEHwypU1FVVv7gwvxB1lrBmGY/yMNqJe3UCQLXfVUHRA46p9CVonpCyXUKnEDR/
	MBjF9dkeRz6DBACA==
From: "tip-bot2 for Jens Remus" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] unwind_user: Enhance comments on get CFA, FP, and RA
Cc: Jens Remus <jremus@linux.ibm.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251208160352.1363040-2-jremus@linux.ibm.com>
References: <20251208160352.1363040-2-jremus@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176597508521.510.9459757707168769746.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     2d6ad925fb2386f3ee1d26f5022f7ea71bbc1541
Gitweb:        https://git.kernel.org/tip/2d6ad925fb2386f3ee1d26f5022f7ea71bb=
c1541
Author:        Jens Remus <jremus@linux.ibm.com>
AuthorDate:    Mon, 08 Dec 2025 17:03:49 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 17 Dec 2025 13:31:07 +01:00

unwind_user: Enhance comments on get CFA, FP, and RA

Move the comment "Get the Canonical Frame Address (CFA)" to the top
of the sequence of statements that actually get the CFA.  Reword the
comment "Find the Return Address (RA)" to "Get ...", as the statements
actually get the RA.  Add a respective comment to the statements that
get the FP.  This will be useful once future commits extend the logic
to get the RA and FP.

While at it align the comment on the "stack going in wrong direction"
check to the following one on the "address is word aligned" check.

Signed-off-by: Jens Remus <jremus@linux.ibm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://patch.msgid.link/20251208160352.1363040-2-jremus@linux.ibm.com
---
 kernel/unwind/user.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/unwind/user.c b/kernel/unwind/user.c
index 39e2707..0ca434f 100644
--- a/kernel/unwind/user.c
+++ b/kernel/unwind/user.c
@@ -31,6 +31,7 @@ static int unwind_user_next_common(struct unwind_user_state=
 *state,
 {
 	unsigned long cfa, fp, ra;
=20
+	/* Get the Canonical Frame Address (CFA) */
 	if (frame->use_fp) {
 		if (state->fp < state->sp)
 			return -EINVAL;
@@ -38,11 +39,9 @@ static int unwind_user_next_common(struct unwind_user_stat=
e *state,
 	} else {
 		cfa =3D state->sp;
 	}
-
-	/* Get the Canonical Frame Address (CFA) */
 	cfa +=3D frame->cfa_off;
=20
-	/* stack going in wrong direction? */
+	/* Make sure that stack is not going in wrong direction */
 	if (cfa <=3D state->sp)
 		return -EINVAL;
=20
@@ -50,10 +49,11 @@ static int unwind_user_next_common(struct unwind_user_sta=
te *state,
 	if (cfa & (state->ws - 1))
 		return -EINVAL;
=20
-	/* Find the Return Address (RA) */
+	/* Get the Return Address (RA) */
 	if (get_user_word(&ra, cfa, frame->ra_off, state->ws))
 		return -EINVAL;
=20
+	/* Get the Frame Pointer (FP) */
 	if (frame->fp_off && get_user_word(&fp, cfa, frame->fp_off, state->ws))
 		return -EINVAL;
=20

