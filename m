Return-Path: <linux-tip-commits+bounces-8191-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cKh4I7fagWlBLQMAu9opvQ
	(envelope-from <linux-tip-commits+bounces-8191-lists+linux-tip-commits=lfdr.de@vger.kernel.org>)
	for <lists+linux-tip-commits@lfdr.de>; Tue, 03 Feb 2026 12:23:35 +0100
X-Original-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EEA2DD83C9
	for <lists+linux-tip-commits@lfdr.de>; Tue, 03 Feb 2026 12:23:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 96598312A02E
	for <lists+linux-tip-commits@lfdr.de>; Tue,  3 Feb 2026 11:18:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 110CF330645;
	Tue,  3 Feb 2026 11:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kKYN5jC5";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="h3/qrwxv"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B0F63346B9;
	Tue,  3 Feb 2026 11:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770117528; cv=none; b=Ce62cwW0g2uAVl+HEMRgMreQDs+xqyzRNx6eKqGngE0zy6URUJMKxnz/ufnE77Ov49vpZr8aXr8agHTgjeCtGHLtGYfyzeT/Yv7Gtuy3NiMIxy1LJGeXbhtoKhYJgJTxoQup34IKanMxwFatkE1o3xq+u2gwg0WcW1vGe8UCmU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770117528; c=relaxed/simple;
	bh=OQAGrylxfKFB9RlafARPYQ231xELmzLPf5kU88zAgrk=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Y04ASzOMzc3d6y1LVT/rg6OD5oD+XjrMYDF37rvVy80y340b/Uwp6Lpk+uMLXjxPkd9d9btZ2Aw5us698SfBUlmjPh9UVk4w38mjjtxY9tx4/DmiRRj6AzAG/k+CLqTzVrCM0O9e2qWs/jTo+AK1jNFnRLtKXS1V5OKPJOEEEwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kKYN5jC5; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=h3/qrwxv; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 03 Feb 2026 11:18:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1770117526;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xxLYyn/XOr+KnrqLxaaSvkEnaeNjnFAD43SKAzRnNeg=;
	b=kKYN5jC55ov4UYCmsbWUWy4k5QlggQpddNTqDTChAMS2Pu+vkECPo4FH8aQ4RxJ56n1Pxp
	204Y3lt+apkorLdcLQShl8C3gUCyvWrQ7aqihfyYhHi2fN8aRq+dRMcfWyXRLVQrit3erZ
	pB9r75qxewOzyVd0y90U2SjFBBIhd2MvjGH7ohl8mPWkb5qXLX+8Z+mrbrXopAkLma+7Os
	UmBjnHudzjcTFq2Znr8vBwnVP2u17zXW6aH/XcFIz0S3tjsiRoRu5eg5ROa/5CsIef3b1c
	hezpKkSobKCQmK6tTL4XL3Fm+C1u69eWXEovbMBvl3nNBde1lsKJ01jeNFrBkA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1770117526;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xxLYyn/XOr+KnrqLxaaSvkEnaeNjnFAD43SKAzRnNeg=;
	b=h3/qrwxvPb7LoG63DOUbKiAdwClg2G6TpaxcWL8w3nnz/1ARvjgUQsFMqSTl1OIBpfUO1K
	7AKB4ars41HxGFAQ==
From: "tip-bot2 for Joel Fernandes" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/deadline: Clear the defer params
Cc: Joel Fernandes <joelagnelf@nvidia.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Andrea Righi <arighi@nvidia.com>, Juri Lelli <juri.lelli@redhat.com>,
 Christian Loehle <christian.loehle@arm.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20260126100050.3854740-2-arighi@nvidia.com>
References: <20260126100050.3854740-2-arighi@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <177011752492.2495410.6564442211262872750.tip-bot2@tip-bot2>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8191-lists,linux-tip-commits=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_EQ_TO_DOM(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	HAS_REPLYTO(0.00)[linux-kernel@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tip-bot2@linutronix.de,linux-tip-commits@vger.kernel.org];
	DKIM_TRACE(0.00)[linutronix.de:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-tip-commits];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[arm.com:email,vger.kernel.org:replyto,infradead.org:email,nvidia.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linutronix.de:dkim,msgid.link:url]
X-Rspamd-Queue-Id: EEA2DD83C9
X-Rspamd-Action: no action

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     3cb3b27693bf30defb16aa096158a3b24583b8d2
Gitweb:        https://git.kernel.org/tip/3cb3b27693bf30defb16aa096158a3b2458=
3b8d2
Author:        Joel Fernandes <joelagnelf@nvidia.com>
AuthorDate:    Mon, 26 Jan 2026 10:58:59 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 03 Feb 2026 12:04:16 +01:00

sched/deadline: Clear the defer params

The defer params were not cleared in __dl_clear_params. Clear them.

Without this is some of my test cases are flaking and the DL timer is
not starting correctly AFAICS.

Fixes: a110a81c52a9 ("sched/deadline: Deferrable dl server")
Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Andrea Righi <arighi@nvidia.com>
Acked-by: Juri Lelli <juri.lelli@redhat.com>
Tested-by: Christian Loehle <christian.loehle@arm.com>
Link: https://patch.msgid.link/20260126100050.3854740-2-arighi@nvidia.com
---
 kernel/sched/deadline.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 82e7a21..7e181ec 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -3660,6 +3660,9 @@ static void __dl_clear_params(struct sched_dl_entity *d=
l_se)
 	dl_se->dl_non_contending	=3D 0;
 	dl_se->dl_overrun		=3D 0;
 	dl_se->dl_server		=3D 0;
+	dl_se->dl_defer			=3D 0;
+	dl_se->dl_defer_running		=3D 0;
+	dl_se->dl_defer_armed		=3D 0;
=20
 #ifdef CONFIG_RT_MUTEXES
 	dl_se->pi_se			=3D dl_se;

