Return-Path: <linux-tip-commits+bounces-8185-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +IShNpbZgWlYKgMAu9opvQ
	(envelope-from <linux-tip-commits+bounces-8185-lists+linux-tip-commits=lfdr.de@vger.kernel.org>)
	for <lists+linux-tip-commits@lfdr.de>; Tue, 03 Feb 2026 12:18:46 +0100
X-Original-To: lists+linux-tip-commits@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 49E22D828E
	for <lists+linux-tip-commits@lfdr.de>; Tue, 03 Feb 2026 12:18:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DEE42306243F
	for <lists+linux-tip-commits@lfdr.de>; Tue,  3 Feb 2026 11:18:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE41B32FA34;
	Tue,  3 Feb 2026 11:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VwVtTYWG";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="c1o96YaO"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C70133123F;
	Tue,  3 Feb 2026 11:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770117518; cv=none; b=Rq5jPLYH73ha4DmzYtz8Bj+pt13yC3JAp1TMrdUU02oRKlci7U/1KL+OnPWsnkLH3AhCnUj25u+IcFL1Tl1mbgw8Vcm4XlJQ/dlmlldGQbShUSAMqZerIy4H5PcnLMztdCJa24yYhNNNr5NrpoJdsH6HSUe1Gr8PPr3zCfJCHI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770117518; c=relaxed/simple;
	bh=tTEv4sCz+Fv2a1gxRJtIFyvOMM1N+auPTM4OktcVkI8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=jd+vKUiPGLY7bI7SAHcvywz5dt+DCqx7OxxofYws7Hg07igodeOvPCQBYccc1MCN4hd+EPsgUJDRAmB+Snm0jFfHkvnznEx5jkpduYVYirFjzqOAt3B3RFn6nAF25nThWznMonMxlKY0aGA0s662SmgRRQ/O8qwyNvt9f/ksSaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VwVtTYWG; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=c1o96YaO; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 03 Feb 2026 11:18:33 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1770117515;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=luRhG5fK2EZkx2mHFFinO2OBpr7IbbI7uQt+JxkdClI=;
	b=VwVtTYWG5JnNz4Gc70HW+BaS96Jp3i3IX2r+6I6F9jXJRxlIZnhR5jhSOT65xMCYkXPkv3
	Gw3fjgc+tkK6QlUUh3EiKmrzQYkUuTVrE6kAWFNpxor2O8MzMpi7i7WRCZhDLF2ecvectq
	KvjA50P/GWtWKlGeJHrfgxT44iOenSFxvvPtpy0Srs48MLtX48t8GtOxr8ahb97zZPU3Ia
	P3fPM3gRSG/+3KxUl0vXnesOkmx7Jrb1AY5i5D9v6b+4Zg6fjRD7Frh7H5lgYtUcnN81/G
	NruFaET+0gkPxzYPJYSo8z9AGi5Ud2dVi+gouXUxhtj9/GCS1UtU41GdSXxuSA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1770117515;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=luRhG5fK2EZkx2mHFFinO2OBpr7IbbI7uQt+JxkdClI=;
	b=c1o96YaOLpWkaZTso9tP/3B0LO0I/8VBZKMXqa4HitL4+Kq3aOkjskljoDLsqTTFYPos8h
	Ajcvw0yzb7VvfdAw==
From: "tip-bot2 for zenghongling" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: sched/core] sched/cpufreq: Use %pe format for PTR_ERR() printing
Cc: zenghongling <zenghongling@kylinos.cn>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20260120083333.148385-1-zenghongling@kylinos.cn>
References: <20260120083333.148385-1-zenghongling@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <177011751378.2495410.4471143953201920684.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8185-lists,linux-tip-commits=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linutronix.de:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,infradead.org:email,vger.kernel.org:replyto,msgid.link:url];
	REPLYTO_DOM_EQ_TO_DOM(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tip-bot2@linutronix.de,linux-tip-commits@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linutronix.de:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-tip-commits];
	MISSING_XM_UA(0.00)[];
	HAS_REPLYTO(0.00)[linux-kernel@vger.kernel.org]
X-Rspamd-Queue-Id: 49E22D828E
X-Rspamd-Action: no action

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     742fe830b7d9c01b5c36add9f664a5267caca4f5
Gitweb:        https://git.kernel.org/tip/742fe830b7d9c01b5c36add9f664a5267ca=
ca4f5
Author:        zenghongling <zenghongling@kylinos.cn>
AuthorDate:    Tue, 20 Jan 2026 16:33:33 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 03 Feb 2026 12:04:19 +01:00

sched/cpufreq: Use %pe format for PTR_ERR() printing

Use %pe format specifier for printing PTR_ERR() error values
to make error messages more readable.

Found by Coccinelle:
./cpufreq_schedutil.c:685:49-56: WARNING: Consider using %pe to print PTR_ERR=
()

Signed-off-by: zenghongling <zenghongling@kylinos.cn>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://patch.msgid.link/20260120083333.148385-1-zenghongling@kylinos.cn
---
 kernel/sched/cpufreq_schedutil.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_scheduti=
l.c
index 0ab5f9d..cfc4018 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -682,7 +682,7 @@ static int sugov_kthread_create(struct sugov_policy *sg_p=
olicy)
 				"sugov:%d",
 				cpumask_first(policy->related_cpus));
 	if (IS_ERR(thread)) {
-		pr_err("failed to create sugov thread: %ld\n", PTR_ERR(thread));
+		pr_err("failed to create sugov thread: %pe\n", thread);
 		return PTR_ERR(thread);
 	}
=20

