Return-Path: <linux-tip-commits+bounces-7341-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6429EC5D149
	for <lists+linux-tip-commits@lfdr.de>; Fri, 14 Nov 2025 13:22:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 740C135BA36
	for <lists+linux-tip-commits@lfdr.de>; Fri, 14 Nov 2025 12:20:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 441E6319840;
	Fri, 14 Nov 2025 12:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EN9arHv5";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="albT0THT"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3A1E315D5C;
	Fri, 14 Nov 2025 12:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763122751; cv=none; b=uZI7ThrYfO0UZ44bIIw/CGCdZFoZO+7qqkpDlNYU3vDnyCkTrp6hfFY591XhXPCP8cf+Yr8McDFX4BISJcVOgCQ1anWcksZ8d/NOj7uiy2OaQFc6jhPoUTyIxuyitYkIWaytlqxokkxW9qahN2Mty/9NjN+DcwaizACceQRjmWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763122751; c=relaxed/simple;
	bh=JZJm2zuGlujrYRzeXwKh6u+HVgG63YpCNX/TJTPPdv8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=kn57+fVLXvtOGMVp4PTdyJE/A0RLp4szITOnEvxnivkHIZ0M7JsKbCYneL1t6K0XyDX63XDl3vErzPSNcKdTza0rJv/bLfUOtu1TC69IlSrOk0YM7i7QeZ3bLwhuyxdQYsXrNYzkszHC6w6Rl80wMxl91BedvIefgwHite4ypg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=EN9arHv5; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=albT0THT; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 14 Nov 2025 12:19:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1763122748;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=poaIbmNGlZg/mCCW+Xg9nO1wQZdpKrYXbuUUPAP+eko=;
	b=EN9arHv5V8IOhnz2H/wCbi+B65v6E6xGrZXEjH7yApMOVrTo6+4qljynSB1Wi8DZkrdf66
	T0pbUZhg6ML+vgXBa1T0GZA3OF4prc2Inykk3SAvLU/f0SFoJ3cf8SrdKKfMRubRW/kiIJ
	Ud/X1Af+opYnslMpmLsvBEx5+Q+r0ByD/fnXAk3hjAQjAgaqwOnJha0Qofx62HAi72VYUN
	fR6rn/2TtAJYlHfDL/pKWLpRDKhAjrwkPFl1vQfV6P29aHm8F8o9DxqFxS2kzybueaaqjs
	Oq4rsRYHMnROHNkp7oWLe+cuoNg2flR62jwgYHnCRUOzC9D4b8sWwTOsX6DLNA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1763122748;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=poaIbmNGlZg/mCCW+Xg9nO1wQZdpKrYXbuUUPAP+eko=;
	b=albT0THTxaCPt061NzBm5xwlhlgVTpWZsLQ0C9xLwAp1T7mSsgt1dH4ayqTCFrOg9vyVfF
	pHdQ7TmW2WNNC0Ag==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: sched/core] sched/fair: Have SD_SERIALIZE affect newidle balancing
Cc: Shrikanth Hegde <sshegde@linux.ibm.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3C6fed119b723c71552943bfe5798c93851b30a361=2E1762800?=
 =?utf-8?q?251=2Egit=2Etim=2Ec=2Echen=40linux=2Eintel=2Ecom=3E?=
References: =?utf-8?q?=3C6fed119b723c71552943bfe5798c93851b30a361=2E17628002?=
 =?utf-8?q?51=2Egit=2Etim=2Ec=2Echen=40linux=2Eintel=2Ecom=3E?=
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176312274709.498.12705068759622763172.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     22c929d23ebf500d376a4b087d2f276ede943232
Gitweb:        https://git.kernel.org/tip/22c929d23ebf500d376a4b087d2f276ede9=
43232
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Wed, 12 Nov 2025 14:52:28 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 14 Nov 2025 13:03:06 +01:00

sched/fair: Have SD_SERIALIZE affect newidle balancing

Also serialize the possiblty much more frequent newidle balancing for
the 'expensive' domains that have SD_BALANCE set.

Initial benchmarking by K Prateek and Tim showed no negative effect.

Split out from the larger patch moving sched_balance_running around
for ease of bisect and such.

Suggested-by: Shrikanth Hegde <sshegde@linux.ibm.com>
Seconded-by: K Prateek Nayak <kprateek.nayak@amd.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/df068896-82f9-458d-8fff-5a2f654e8ffd@amd.com
Link: https://patch.msgid.link/6fed119b723c71552943bfe5798c93851b30a361.17628=
00251.git.tim.c.chen@linux.intel.com
---
 kernel/sched/fair.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 5feb5a6..320eedd 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -11732,7 +11732,7 @@ redo:
 		goto out_balanced;
 	}
=20
-	if (!need_unlock && (sd->flags & SD_SERIALIZE) && idle !=3D CPU_NEWLY_IDLE)=
 {
+	if (!need_unlock && (sd->flags & SD_SERIALIZE)) {
 		if (!atomic_try_cmpxchg_acquire(&sched_balance_running, 0, 1))
 			goto out_balanced;
=20

