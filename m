Return-Path: <linux-tip-commits+bounces-7600-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 66F64CA1514
	for <lists+linux-tip-commits@lfdr.de>; Wed, 03 Dec 2025 20:17:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 12D0D302CF58
	for <lists+linux-tip-commits@lfdr.de>; Wed,  3 Dec 2025 18:38:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E59D348884;
	Wed,  3 Dec 2025 18:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HgeDWhuL";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uy2t+Zng"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D040C348463;
	Wed,  3 Dec 2025 18:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764786677; cv=none; b=NPFTT39w2LCtsUcEC9ORbm5duN46t48Btw9pOvzoJXBjhcL1bltu6MKiO1AojrpWfoSXwAvpYWWntfmotvP39e52/SblVT+s8/wDadzUjNS/8LsQqX55OkzvJHrEiYeE/brIrfFHBRFUN4cWlo/YVVd62sy0tU+bxzxcXvv8sX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764786677; c=relaxed/simple;
	bh=mhE5HSzv5WOf+prZOZ60HaIMOQQlI+WBavhEpSUwj44=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=FqXwb9l0wUszO+/5dFvhG3GoGQ67xE1+e4z8301qgJtseQOMgdbHHLY7QWEWu9EAGB7naGijSa4ReKOtJv8Wabe5TNxx73+7whTYKhzbJh5eRtQri6YRrRUiW9q4RUR7c5bIGYx+TxFn1PkeNTyLdDfuJlBLvTdt1gJoKlkh9Ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HgeDWhuL; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uy2t+Zng; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 03 Dec 2025 18:31:13 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1764786674;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3gvoG/+svuLzf2vRkbFkJgx3m0SKnnXWxt9fOLG1hbk=;
	b=HgeDWhuLZDuA5novbWkFnGDR9jCnDNc6EEEDXxZiOaPlG1xQGLjnPfjSri+iWe8e3dOI4X
	wMq8j7koY7nb0LyHr96H8KvZN9zgvrgj3ErJ7VmHDqJ5/b60qRPiG8OHrC/nn74GqJ13py
	QlHYb3mUJSFI0twIubXKLMnPwLp/Ftgdx3scqfPm813Qt6anFU1pu3EPDFWrOmiZT03BJ1
	nzA4kWlmSWU8HeBal4BQbC6E5+mh5lRGpCZ/J7nKa3AhfFKxp1Sac8ViGbpFBPXxHSOpwR
	PWOhjycn815oBAzQahWdmzOa6+yBjeOZHdXqMnuGSBK/WFHUhnY+HZBjlVz8Ig==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1764786674;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3gvoG/+svuLzf2vRkbFkJgx3m0SKnnXWxt9fOLG1hbk=;
	b=uy2t+ZnggSHE4AZ56RccpbJCVZjpLRIQHlgjIjF7Ed41tvs+1pLtut04tVHlSQPBMASaid
	VcbrTLiJ32PNbTCg==
From: "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/urgent] sched/headers: Remove whitespace noise from
 kernel/sched/sched.h
Cc:
 Ingo Molnar <mingo@kernel.org>, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <176478595428.498.13816176784792752599.tip-bot2@tip-bot2>
References: <176478595428.498.13816176784792752599.tip-bot2@tip-bot2>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176478667313.498.10184702498785471342.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the sched/urgent branch of tip:

Commit-ID:     1402802b0e7b23cf26b40f81c5c1a28b96aaeda6
Gitweb:        https://git.kernel.org/tip/1402802b0e7b23cf26b40f81c5c1a28b96a=
aeda6
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Wed, 03 Dec 2025 18:19:14=20
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 03 Dec 2025 19:25:26 +01:00

sched/headers: Remove whitespace noise from kernel/sched/sched.h

A single case of space-Tab noise snuck in recently.

Fixes: 36569780b0d6 ("sched: Change nr_uninterruptible type to unsigned long")
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://patch.msgid.link/176478595428.498.13816176784792752599.tip-bot2=
@tip-bot2
---
 kernel/sched/sched.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 8590113..cb80666 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1165,7 +1165,7 @@ struct rq {
 	 * one CPU and if it got migrated afterwards it may decrease
 	 * it on another CPU. Always updated under the runqueue lock:
 	 */
-	unsigned long 		nr_uninterruptible;
+	unsigned long		nr_uninterruptible;
=20
 #ifdef CONFIG_SCHED_PROXY_EXEC
 	struct task_struct __rcu	*donor;  /* Scheduling context */

