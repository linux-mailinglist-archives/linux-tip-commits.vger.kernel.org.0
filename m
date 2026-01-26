Return-Path: <linux-tip-commits+bounces-8114-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QJYvIgGHd2m9hgEAu9opvQ
	(envelope-from <linux-tip-commits+bounces-8114-lists+linux-tip-commits=lfdr.de@vger.kernel.org>)
	for <lists+linux-tip-commits@lfdr.de>; Mon, 26 Jan 2026 16:23:45 +0100
X-Original-To: lists+linux-tip-commits@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CD8888A160
	for <lists+linux-tip-commits@lfdr.de>; Mon, 26 Jan 2026 16:23:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3715B3030769
	for <lists+linux-tip-commits@lfdr.de>; Mon, 26 Jan 2026 15:23:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACE4233E374;
	Mon, 26 Jan 2026 15:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="anPfVHdX";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2Vg43fWL"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 413E125771;
	Mon, 26 Jan 2026 15:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769440981; cv=none; b=dqbV9v0A0JFEc1bAIJ3yZqlR+2/wxXtMvLMBAjMgDy4Ekry0FXpNDxVKfBFM/gHOWEjvsbYv8JGvP7JJt+L464eN4HKnHvqpTDTjwks3MdwVG9KmOJiITqxefm54lAGE+syMo0GwDZmHcSqXiwbDdKRM8V1et7D6W43ig7Lc9w4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769440981; c=relaxed/simple;
	bh=jpYP5QgKblp0gs9O/wak7VsBzQY+rGQ+HxIvFIIj8Ws=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=W1p0gjasDdK4IQS/FjBwwtRoXEygU1YLzcJ+s0XkJ1Wv4SArZPQDRaNBcHL5WiN2EiDlRdSjMB0jdh+UK7VQPUiVQW33tHSz7Utx2L/kyyPAbUyz8uQmIqBv5xAkOB2QUV7k2cFCrjK+SN2+fd8KSi1cNgTT4Sgcf2XRAf3RKFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=anPfVHdX; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2Vg43fWL; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 26 Jan 2026 15:22:56 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1769440978;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dO68BgLrMItxrZQKcPvsbW0HgT/77cc06ulJNY0szww=;
	b=anPfVHdXgpw96Ggm+4vXJLAXDokrgLe2DeZ0R3iz+jVVRBsywJx7jJOF76Bduy23dJgz8i
	/XKB6yuvzZE4Sx0W38gsNG5wAOyl6znnA2tGYhRr8y8XdoNh/QSlcFbvN9kK8WW+WL3k0t
	NIVzGnRdrJf352Cl6hErD59otUuWS+ZwRXr+OctoPohUo1bVoLrYBcZC7oSQbHqKk48Mu8
	7ZbemDbLDe6iR6qV0dLiDOXTUh1+dgDLMq9o7eS4QGk6MNzwavJszjSivLSjvNpEcxpWXg
	6vu7OSefR+t5cXVv7JLzwKvmXRuurqLakX2Gdyv990RQqK+Up12TKsFFCCxnfA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1769440978;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dO68BgLrMItxrZQKcPvsbW0HgT/77cc06ulJNY0szww=;
	b=2Vg43fWLvp0eISUtsPNmi69/etlUYHZ1xYlZtDvCzHk5kk7P7WCJy1KNLGk8DptPIa5BAm
	LI1XYNL1bcOKrMDw==
From: "tip-bot2 for Jinjie Ruan" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] time/kunit: Use is_leap_year() helper
Cc: Jinjie Ruan <ruanjinjie@huawei.com>, Thomas Gleixner <tglx@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260123080940.335474-1-ruanjinjie@huawei.com>
References: <20260123080940.335474-1-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176944097652.510.12277737328875446092.tip-bot2@tip-bot2>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8114-lists,linux-tip-commits=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linutronix.de:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,msgid.link:url,vger.kernel.org:replyto];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-tip-commits];
	MISSING_XM_UA(0.00)[];
	HAS_REPLYTO(0.00)[linux-kernel@vger.kernel.org]
X-Rspamd-Queue-Id: CD8888A160
X-Rspamd-Action: no action

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     3d431a106947a4a18ff5d3ba270a25df6a136e2f
Gitweb:        https://git.kernel.org/tip/3d431a106947a4a18ff5d3ba270a25df6a1=
36e2f
Author:        Jinjie Ruan <ruanjinjie@huawei.com>
AuthorDate:    Fri, 23 Jan 2026 16:09:40 +08:00
Committer:     Thomas Gleixner <tglx@kernel.org>
CommitterDate: Mon, 26 Jan 2026 16:05:09 +01:00

time/kunit: Use is_leap_year() helper

Use the is_leap_year() helper from rtc.h instead of open coding it.

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Link: https://patch.msgid.link/20260123080940.335474-1-ruanjinjie@huawei.com
---
 kernel/time/time_test.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/kernel/time/time_test.c b/kernel/time/time_test.c
index 2889763..7c2fb5f 100644
--- a/kernel/time/time_test.c
+++ b/kernel/time/time_test.c
@@ -2,14 +2,7 @@
=20
 #include <kunit/test.h>
 #include <linux/time.h>
-
-/*
- * Traditional implementation of leap year evaluation.
- */
-static bool is_leap(long year)
-{
-	return year % 4 =3D=3D 0 && (year % 100 !=3D 0 || year % 400 =3D=3D 0);
-}
+#include <linux/rtc.h>
=20
 /*
  * Gets the last day of a month.
@@ -17,7 +10,7 @@ static bool is_leap(long year)
 static int last_day_of_month(long year, int month)
 {
 	if (month =3D=3D 2)
-		return 28 + is_leap(year);
+		return 28 + is_leap_year(year);
 	if (month =3D=3D 4 || month =3D=3D 6 || month =3D=3D 9 || month =3D=3D 11)
 		return 30;
 	return 31;

