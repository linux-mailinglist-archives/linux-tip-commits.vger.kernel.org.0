Return-Path: <linux-tip-commits+bounces-8337-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OPxZCMp0pWkNBgYAu9opvQ
	(envelope-from <linux-tip-commits+bounces-8337-lists+linux-tip-commits=lfdr.de@vger.kernel.org>)
	for <lists+linux-tip-commits@lfdr.de>; Mon, 02 Mar 2026 12:30:18 +0100
X-Original-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BABA1D7849
	for <lists+linux-tip-commits@lfdr.de>; Mon, 02 Mar 2026 12:30:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D76E63086F31
	for <lists+linux-tip-commits@lfdr.de>; Mon,  2 Mar 2026 11:26:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0774E36212E;
	Mon,  2 Mar 2026 11:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FUGWyTz+";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mkJBSSfV"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8EE833C197;
	Mon,  2 Mar 2026 11:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772450776; cv=none; b=E62Hr8S4yeDgNq3fQUdNvn9hpDACs9DHp1x2PI4fnOFRUiBXrPerBBw4ND8daqwhIHJc2AxMZvO5Jd57OuuMvEQKRYWZL5tVVuJimygwU06LURgef6LqIFnTimhxtdkIFt0DxQUWOJVBG0lsn+XTvT18APZHDqaT8P3TkfRdpxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772450776; c=relaxed/simple;
	bh=1XomDuo9+zcphQmoIH/v4/2IonYlrbBWygn9PcOcnEw=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=eTkZAwcaSa94JD2yDrtA5o8fbrWr6NFhIP53ugxUa2u7ygtxuoCxxs/DJtlrxJ++BaNGCcKopKAoghWy7Qz74KZUPt40i0Yf9W2ryfEy5TAAOuoTNczQ3qIp3Kr4l+Q6xd9wVAoGPNw+2ZP2muD95d/Zlfp8mKaRhAnw2RrsMS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FUGWyTz+; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mkJBSSfV; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 02 Mar 2026 11:26:12 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1772450773;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=qxzpMO1qS2R07ZOrarLLbfRzQqIALXuPWIQgDYW1xSk=;
	b=FUGWyTz+eWNduN5y5n0i1By9PLecstgEkEnhIjst4y7GmlbnQ5+phmJeAig0pJFkZhM2Dx
	DWQV6z3AnD6SZ+90JN9lEQhBGI0N6ykt9I3Ocb/IWP6OkdvEFnIGpczXg2ZkG0Z4g1Xlmm
	WzaCQKusLNt7TchDITDxuDzAwl9UMhEP6u59vb5X2iQACcc3xjxlmMkOw19AUFFgPM1ilT
	ud9imkLDx/YvVm3ok5QKd+x/q4/t18CxdZeIoXH8JwP6nN8HrbWXT8yUuX8A9RkRqTy0ty
	tG8dfiGYmXA0PPyeuvmtpG7Kfhq5cDEJagRWV4IJzho25s21QOzjdBl2xyctUQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1772450773;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=qxzpMO1qS2R07ZOrarLLbfRzQqIALXuPWIQgDYW1xSk=;
	b=mkJBSSfV539i6dRrUTdB3r17UWRY09tEIB7+x07kMEGhqG+Mjp6D6SCQliXAOe2FRi44Co
	L6UThPZkf1w5jVAw==
From: "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/hrtick] sched/hrtick: Mark hrtick_clear() as always used
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>,
 x86@kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <177245077226.1647592.1821545206171336606.tip-bot2@tip-bot2>
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
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8337-lists,linux-tip-commits=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:replyto,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linutronix.de:email,linutronix.de:dkim,infradead.org:email];
	REPLYTO_DOM_EQ_TO_DOM(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tip-bot2@linutronix.de,linux-tip-commits@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linutronix.de:+];
	NEURAL_HAM(-0.00)[-0.998];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-tip-commits];
	MISSING_XM_UA(0.00)[];
	HAS_REPLYTO(0.00)[linux-kernel@vger.kernel.org]
X-Rspamd-Queue-Id: 7BABA1D7849
X-Rspamd-Action: no action

The following commit has been merged into the sched/hrtick branch of tip:

Commit-ID:     d50da4b5915f13443431284d8c77df0820efaa6b
Gitweb:        https://git.kernel.org/tip/d50da4b5915f13443431284d8c77df0820e=
faa6b
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Mon, 02 Mar 2026 12:16:30 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 02 Mar 2026 12:20:51 +01:00

sched/hrtick: Mark hrtick_clear() as always used

This recent commit:

  96d1610e0b20b ("sched: Optimize hrtimer handling")

introduced a new build warning when !CONFIG_HOTPLUG_CPU
while SCHED_HRTIMERS=3Dy [ =3D=3D HIGH_RES_TIMERS=3Dy ]:

  /tip.testing/kernel/sched/core.c:882:13: warning: =E2=80=98hrtick_clear=E2=
=80=99 defined but not used [-Wunused-function]

Mark this helper function as always-used, instead of complicating
the code with another obscure #ifdef.

Fixes: 96d1610e0b20b ("sched: Optimize hrtimer handling")
Cc: linux-kernel@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/sched/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 55550c6..d264733 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -879,7 +879,7 @@ enum {
 	HRTICK_SCHED_REARM_HRTIMER	=3D BIT(3)
 };
=20
-static void hrtick_clear(struct rq *rq)
+static void __used hrtick_clear(struct rq *rq)
 {
 	if (hrtimer_active(&rq->hrtick_timer))
 		hrtimer_cancel(&rq->hrtick_timer);

