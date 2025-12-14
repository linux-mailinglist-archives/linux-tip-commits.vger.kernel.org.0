Return-Path: <linux-tip-commits+bounces-7653-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 082C9CBB786
	for <lists+linux-tip-commits@lfdr.de>; Sun, 14 Dec 2025 08:47:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9B666301357A
	for <lists+linux-tip-commits@lfdr.de>; Sun, 14 Dec 2025 07:46:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5986D29D260;
	Sun, 14 Dec 2025 07:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1lc24rUE";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LLcew43A"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45C342BD59C;
	Sun, 14 Dec 2025 07:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765698408; cv=none; b=puZrmQ+by31IKoW28k7Bf5ymkOthXjNBg1RKQ+Lp/ZidQFuYgOhqBeNG6eG+SU+FZjAaNQzvlBP5tVRdzmboAPLRr2j4l6sAGdW70B9o9Y/iByxDKDNO0j0EBioQws16zqun4gqn5f7zXW6xBAO75IVFbiHt0dpVHi87YzUHIXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765698408; c=relaxed/simple;
	bh=VTgFxdHQoW8AJgklNmLRkJYGUUD0Ys44AAVX6Dbipy8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=ESSRajnfdhcOGAOupBlEh9CspHRMYg7Xe3Iy0mdQCUA2tTRKFWrAR6zbgzq3wUFqzHpyDGpY8P657J/8jPvuT6uruqqmmmRl3I3vZYTs2bFChq2yJZbQOYGn6eE5fdj5f5aDf8VHaiOtESlbSlhXK3EtXSIoUMw6xniK6nFkY30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1lc24rUE; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LLcew43A; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sun, 14 Dec 2025 07:46:37 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1765698399;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4pWYcY478H6I+fPJXnA+p7NKSGG4yzh158Yu1ZVOgyk=;
	b=1lc24rUE3kVeBfsF/ZqVwhP/jd+hfL+HaDndQ+NrOAkCw6QRoESk1OYqaTt5Q3gH0O/GP4
	z5t+YHt8/HS8SnT2YLb0V132WbzVHcmpHeWcV9E5Z0sZFGShfzEK/zCuMhIoqDd3P+DS8U
	E4Gd+aocFTgQhfsXfWP0nHrIfqrLovaCeJwgY0Q6iEnljTDvMF9LiM81GOFxPz3L3mQg/i
	MCyCGV5g6sliBmpQoRYtHgP1EAC3B1hdREP3ibln5Ataf5eD1yIeLcL9imbqdTHRMXGeRg
	YWgVas6aJ3Sot+YWVgsRB+45SBYv0lc5OzCv2IKeWKqeYe5BBckdenQrBT/p8A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1765698399;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4pWYcY478H6I+fPJXnA+p7NKSGG4yzh158Yu1ZVOgyk=;
	b=LLcew43AvB7HlexpksZ7KX5QWqauF9BWmjY+wOlyxEtkX3tnV4oEgu67yyV9Q61WPAIa0W
	CgaD8+GkcExHuGAg==
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
Message-ID: <176569839784.498.14081344283899173849.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     6b6d09f274bd6e5bed2751b3cab23e64f19c9e59
Gitweb:        https://git.kernel.org/tip/6b6d09f274bd6e5bed2751b3cab23e64f19=
c9e59
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Wed, 26 Nov 2025 05:31:28 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sun, 14 Dec 2025 08:25:02 +01:00

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

