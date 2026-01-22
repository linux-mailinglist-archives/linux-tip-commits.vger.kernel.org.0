Return-Path: <linux-tip-commits+bounces-8108-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4E2kClP7cWmvZwAAu9opvQ
	(envelope-from <linux-tip-commits+bounces-8108-lists+linux-tip-commits=lfdr.de@vger.kernel.org>)
	for <lists+linux-tip-commits@lfdr.de>; Thu, 22 Jan 2026 11:26:27 +0100
X-Original-To: lists+linux-tip-commits@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B224653B8
	for <lists+linux-tip-commits@lfdr.de>; Thu, 22 Jan 2026 11:26:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EAF448690FA
	for <lists+linux-tip-commits@lfdr.de>; Thu, 22 Jan 2026 10:20:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD5DC410D35;
	Thu, 22 Jan 2026 10:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CMgm+5E6";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gcT7u9dn"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6881F40B6E8;
	Thu, 22 Jan 2026 10:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769076975; cv=none; b=VQfxlurWrJEFK8PukSWAUlwtm7eZ0QHSoqaFyLLWecCrmkOj5vo9Ip0aoaYpzb8JwMsG4ffDYaqHM3o32z4s6LnS6oGeW3jQaHbt9DJE857Nq/WIn8z/f/0Up7TxBuVtxRB/1aWOa1g97qgyJyd5KLe1t+WpxvFXzrxfG8Nz/sU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769076975; c=relaxed/simple;
	bh=2jA2sYyD6YrLbPXJep038WGVf97aLO1g/hSqFGfWnwM=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=rvVR4bYePVgDt6OpFtOMiV3JMqk4I97WmeSGP4X8lBLyRBVr3DUvFc7ATR0hivN7H/C8xr2bZtiyUDBs11mpwKPXvZVjA97103AlcN1rm3Y4MetDRxX/6mit2gDG5bYyfRiJgJ17PCSdZ/wCd/GDf7kpy0566rUAFPF44zvLZMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CMgm+5E6; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gcT7u9dn; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 22 Jan 2026 10:16:10 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1769076971;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=q52mWizR6R21slQNg5lcPuq8zQ4125Cm/hXaM1YSuJ8=;
	b=CMgm+5E6KWDDHqXQ6qf8hI42ywO95JpYFxSVYIk/PjD3A8VhyJ9kargdFWcv95I2WHaVFd
	Wu3eXMbITSa+F7cOQxz/ytkFgtdDvJZrjPk5BxSu6/9EC9yCseLuxPJXzcAxppKl8+80CL
	PfHvZAs7gKCjFryTE7uwPyYHMtoupCsmNb80so6jdgQIvp8gVpicZWk/U0/zOqZ0IDTyl8
	XisBFhJpGs0lD6tJ5sUdAjBPh6t2CAGGRkXKYkwmSbD8Ny9IseXZqwHwbUHL0CmtG7cj/5
	Ax/2EQjnFiIVujmBtc6y1J4wjZKSFidnhnDSg1f816Cj8G3QnaHwcIb5W9aHcA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1769076971;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=q52mWizR6R21slQNg5lcPuq8zQ4125Cm/hXaM1YSuJ8=;
	b=gcT7u9dnUVFc1TqVv+P55rbOMuHXy9k/fXTYomkzwBNOkWbcZuompuNq1FfBuM0NkJyoUc
	EJPQMqT8Yo7jiUAw==
From: "tip-bot2 for Fushuai Wang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/debug: Convert copy_from_user() +
 kstrtouint() to kstrtouint_from_user()
Cc: Yury Norov <ynorov@nvidia.com>, Fushuai Wang <wangfushuai@baidu.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20260117145615.53455-2-fushuai.wang@linux.dev>
References: <20260117145615.53455-2-fushuai.wang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176907697014.510.1378420592339878350.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	REPLYTO_DOM_EQ_TO_DOM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:helo,dfw.mirrors.kernel.org:rdns,linutronix.de:dkim,nvidia.com:email,vger.kernel.org:replyto,infradead.org:email,msgid.link:url];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-8108-lists,linux-tip-commits=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linutronix.de:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tip-bot2@linutronix.de,linux-tip-commits@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[linutronix.de,none];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	TAGGED_RCPT(0.00)[linux-tip-commits];
	RCPT_COUNT_FIVE(0.00)[6];
	MISSING_XM_UA(0.00)[];
	HAS_REPLYTO(0.00)[linux-kernel@vger.kernel.org]
X-Rspamd-Queue-Id: 8B224653B8
X-Rspamd-Action: no action

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     4fe82cf3024a4bdd2571d584efc25598533d5c96
Gitweb:        https://git.kernel.org/tip/4fe82cf3024a4bdd2571d584efc25598533=
d5c96
Author:        Fushuai Wang <wangfushuai@baidu.com>
AuthorDate:    Sat, 17 Jan 2026 22:56:14 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 22 Jan 2026 11:11:16 +01:00

sched/debug: Convert copy_from_user() + kstrtouint() to kstrtouint_from_user()

Using kstrtouint_from_user() instead of copy_from_user() + kstrtouint()
makes the code simpler and less error-prone.

Suggested-by: Yury Norov <ynorov@nvidia.com>
Signed-off-by: Fushuai Wang <wangfushuai@baidu.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Yury Norov <ynorov@nvidia.com>
Link: https://patch.msgid.link/20260117145615.53455-2-fushuai.wang@linux.dev
---
 kernel/sched/debug.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index 5f9b771..929fdf0 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -172,18 +172,12 @@ static const struct file_operations sched_feat_fops =3D=
 {
 static ssize_t sched_scaling_write(struct file *filp, const char __user *ubu=
f,
 				   size_t cnt, loff_t *ppos)
 {
-	char buf[16];
 	unsigned int scaling;
+	int ret;
=20
-	if (cnt > 15)
-		cnt =3D 15;
-
-	if (copy_from_user(&buf, ubuf, cnt))
-		return -EFAULT;
-	buf[cnt] =3D '\0';
-
-	if (kstrtouint(buf, 10, &scaling))
-		return -EINVAL;
+	ret =3D kstrtouint_from_user(ubuf, cnt, 10, &scaling);
+	if (ret)
+		return ret;
=20
 	if (scaling >=3D SCHED_TUNABLESCALING_END)
 		return -EINVAL;

