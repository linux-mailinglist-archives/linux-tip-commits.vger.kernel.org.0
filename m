Return-Path: <linux-tip-commits+bounces-8180-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qMSHBpSOgGkl+wIAu9opvQ
	(envelope-from <linux-tip-commits+bounces-8180-lists+linux-tip-commits=lfdr.de@vger.kernel.org>)
	for <lists+linux-tip-commits@lfdr.de>; Mon, 02 Feb 2026 12:46:28 +0100
X-Original-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 535F3CBE36
	for <lists+linux-tip-commits@lfdr.de>; Mon, 02 Feb 2026 12:46:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E869030382B8
	for <lists+linux-tip-commits@lfdr.de>; Mon,  2 Feb 2026 11:40:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5673235B65F;
	Mon,  2 Feb 2026 11:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TVwP7VJG";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YItof6eX"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E896635C197;
	Mon,  2 Feb 2026 11:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770032433; cv=none; b=TxUSkgd1j1yoX5N1ntSJ10SWm4Woi8ZapbGP/jzBjEFHAw4CW4fb09neQg9+l8G0S1ZFzZ1gpxR9A1ZGR54l1uiW+uwq301qlYzUSJ/6yq/jH7ZBzcxM25+jS6LtPwxJijUSlLfO7sEn2ApzXHsCsdOe6eCcTSHCXvBUo/4DQWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770032433; c=relaxed/simple;
	bh=hCeaAsCpvkm6zgICFGOXp15wJkouBqcFTq64GaLfzLE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=uWqLw0rG0MhHMlYqIe780GbVr1kI4CmHZuYomcmOQO1vS7A2aqifwKpSlIt4+9BePIT4ythDKeAQXpJgAgA6nCrmgqM20FzGuZsKiuGQtfz9HQgDMSaWKtLEElucn9Z2gAR2hMizin2cY3teL4c2Ntt9saHIaTSjN4VheCW4bAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TVwP7VJG; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YItof6eX; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 02 Feb 2026 11:40:28 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1770032430;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lK71o9tADzrQA8E+ocPjzXJurPODkAzk5XpParBBnDo=;
	b=TVwP7VJGYveY4e44WKucdaY6wgVJdIkr1F2ssw8TZfQCj+rd0SP4Bktm5GVeFq4rz7mPqg
	bh7NgD0petYHXT235jdnDkGFZlLcHmVJCGbw75zB/4cwl1S0iu+qLayagWEQJ+tlBbRoBE
	LbZc3WfMoWbzcF2OI2J0g+VfPKx0/xzT6rXEJhAOqGNwz61FAi53r4KSCs0OKEl3O8mdhd
	wTeeWrJ9h6DFlNRMFlAfBq2WH9Ca0AZpbmxnNLdaR07vwvihJF7pe3AI0J8APfpmd/pDyF
	vUgqprl8nCtKZlWiyeN9tE65bSvrLdxp3sFiWNVxF9CFdRcjcbF+pZgQ7ChjWQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1770032430;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lK71o9tADzrQA8E+ocPjzXJurPODkAzk5XpParBBnDo=;
	b=YItof6eXBWjFFIEhHuA/zdcOhZZFQRam1DcatNWS/ncq8rn/CoppNFpbk/tXxnREP0eI5X
	1wEGte9cd/svGHAQ==
From: "tip-bot2 for Mark Brown" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] time/kunit: Document handling of negative years of
 is_leap()
Cc: Mark Brown <broonie@kernel.org>, Thomas Gleixner <tglx@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260130-kunit-fix-leap-year-v1-1-92ddf55dffd7@kernel.org>
References: <20260130-kunit-fix-leap-year-v1-1-92ddf55dffd7@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <177003242835.2495410.14173331775957393387.tip-bot2@tip-bot2>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8180-lists,linux-tip-commits=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linutronix.de:dkim,vger.kernel.org:replyto];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-tip-commits];
	MISSING_XM_UA(0.00)[];
	HAS_REPLYTO(0.00)[linux-kernel@vger.kernel.org]
X-Rspamd-Queue-Id: 535F3CBE36
X-Rspamd-Action: no action

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     24989330fb99189cf9ec4accef6ac81c7b1c31f7
Gitweb:        https://git.kernel.org/tip/24989330fb99189cf9ec4accef6ac81c7b1=
c31f7
Author:        Mark Brown <broonie@kernel.org>
AuthorDate:    Fri, 30 Jan 2026 19:48:35=20
Committer:     Thomas Gleixner <tglx@kernel.org>
CommitterDate: Mon, 02 Feb 2026 12:37:54 +01:00

time/kunit: Document handling of negative years of is_leap()

The code local is_leap() helper was tried to be replaced by the RTC
is_leap_year() function. Unfortunately the two aren't exactly equivalent,
as the kunit variant uses a signed value for the year and the RTC an
unsigned one.

Since the KUnit tests cover a 16000 year range around the epoch they use
year values that are very comfortably negative and hence get mishandled
when passed into is_leap_year().

The change was reverted, so add a comment which prevents further attempts
to do so.

[ tglx: Adapted to the revert ]

Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Link: https://patch.msgid.link/20260130-kunit-fix-leap-year-v1-1-92ddf55dffd7=
@kernel.org
---
 kernel/time/time_test.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/time/time_test.c b/kernel/time/time_test.c
index 2889763..1b99180 100644
--- a/kernel/time/time_test.c
+++ b/kernel/time/time_test.c
@@ -4,7 +4,9 @@
 #include <linux/time.h>
=20
 /*
- * Traditional implementation of leap year evaluation.
+ * Traditional implementation of leap year evaluation, but note that long
+ * is a signed type and the tests do cover negative year values. So this
+ * can't use the is_leap_year() helper from rtc.h.
  */
 static bool is_leap(long year)
 {

