Return-Path: <linux-tip-commits+bounces-8242-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yI3VFZJXnWk2OgQAu9opvQ
	(envelope-from <linux-tip-commits+bounces-8242-lists+linux-tip-commits=lfdr.de@vger.kernel.org>)
	for <lists+linux-tip-commits@lfdr.de>; Tue, 24 Feb 2026 08:47:30 +0100
X-Original-To: lists+linux-tip-commits@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EA6D8183371
	for <lists+linux-tip-commits@lfdr.de>; Tue, 24 Feb 2026 08:47:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5A14F3016ADC
	for <lists+linux-tip-commits@lfdr.de>; Tue, 24 Feb 2026 07:47:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B6BF3043CF;
	Tue, 24 Feb 2026 07:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vAgC5kvb";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EQNKPHN3"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0450327281E;
	Tue, 24 Feb 2026 07:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771919248; cv=none; b=ouIeRrPsjgVbRlz6ZMfn+1UxTrWrGBfW8/vbqu3XwbNvHl1s6ZDRh98Th/uEOBKG+JNAGdpZqWCj+otYTVaWtpyHCxmh7qAsWHEbT759OAu5Tb7/ANNpiXONEhaLnJXFiPvyYBzmgtINtAKdCqR6Y69A30P/MTnacy369mNH2bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771919248; c=relaxed/simple;
	bh=A+WN/li5K/jz3PONbl6MqLo5NMXKjsWwzG6qJLtAf90=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Q0egWQZBpBtIkpj9YHwptO5Fsd/5Jkey1bNi7jhpWXQSPE8BSOjzt8wG02H9en1911c2o0wGem0Z9ZSDq/aKX9yPVHkLXQHzRnwW+QxHxP3xm3Cs3aZSuhqbY7ro1cq3FzSe8kz7BUICKnsb1d4W1/9vuVVEbYEWxmttGDoOlo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vAgC5kvb; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=EQNKPHN3; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 24 Feb 2026 07:47:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1771919245;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2B6kDZLmSCQeBrAio13KB0AM3uNoEjfrsbQNofwDXG0=;
	b=vAgC5kvb+UXBogwmlmOZeCsBql5couR+x2zZ0Ckd2YQNKwhh3WboendHt3TX9FbFKJHGHQ
	59h6T6qgQCFmNQBUtXPCPtccr0skuG5WHMCa6AHRCfxqFTZ28yC3aMRlMhftch7SHXgLn6
	gbAAKl/kYxhTImC1/zf7cqSBlk2PA9tQ3clNNaFMTo56Os8TSEumwwKjCeie+CoeGl8hSw
	WMmYZCpV58lLlXdTU8jh5y30WNcQwUsgWKNnkbAShFGZiaDVmvIiumlntp3ewBlMC2hdBS
	5nH+AaZJOGb6VMtjruqmeOH7S6H2Q9pESjcZetBuGj2s4cnnAjy81u+f/89Lzg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1771919245;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2B6kDZLmSCQeBrAio13KB0AM3uNoEjfrsbQNofwDXG0=;
	b=EQNKPHN3fagSk8LURx9LkjrH0w2QbjS36LHB/wfeHrIEVnoFaqKb/tgadELt3oVzod7AeD
	C6eAo0obdB6ytCCg==
From: "tip-bot2 for Ryota Sakamoto" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] time/kunit: Add .kunitconfig
Cc: Ryota Sakamoto <sakamo.ryota@gmail.com>, Thomas Gleixner <tglx@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260223-add-time-kunitconfig-v1-1-1801eeb33ece@gmail.com>
References: <20260223-add-time-kunitconfig-v1-1-1801eeb33ece@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <177191924371.1647592.14653213694084777845.tip-bot2@tip-bot2>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8242-lists,linux-tip-commits=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linutronix.de:dkim];
	REPLYTO_DOM_EQ_TO_DOM(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,vger.kernel.org];
	DKIM_TRACE(0.00)[linutronix.de:+];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tip-bot2@linutronix.de,linux-tip-commits@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-tip-commits];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	HAS_REPLYTO(0.00)[linux-kernel@vger.kernel.org]
X-Rspamd-Queue-Id: EA6D8183371
X-Rspamd-Action: no action

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     bc47b2e823914966c15a09422f8fc3aa98d34c1b
Gitweb:        https://git.kernel.org/tip/bc47b2e823914966c15a09422f8fc3aa98d=
34c1b
Author:        Ryota Sakamoto <sakamo.ryota@gmail.com>
AuthorDate:    Mon, 23 Feb 2026 15:23:24 +09:00
Committer:     Thomas Gleixner <tglx@kernel.org>
CommitterDate: Tue, 24 Feb 2026 08:41:51 +01:00

time/kunit: Add .kunitconfig

Add .kunitconfig file to the time directory to enable easy execution of
KUnit tests.

With the .kunitconfig, developers can run the tests:
  $ ./tools/testing/kunit/kunit.py run --kunitconfig kernel/time

Also, add the new .kunitconfig file to the TIMEKEEPING section in the
MAINTAINERS file.

Signed-off-by: Ryota Sakamoto <sakamo.ryota@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Link: https://patch.msgid.link/20260223-add-time-kunitconfig-v1-1-1801eeb33ec=
e@gmail.com
---
 MAINTAINERS              | 1 +
 kernel/time/.kunitconfig | 2 ++
 2 files changed, 3 insertions(+)
 create mode 100644 kernel/time/.kunitconfig

diff --git a/MAINTAINERS b/MAINTAINERS
index 55af015..22ec64b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -26618,6 +26618,7 @@ F:	include/linux/timekeeping.h
 F:	include/linux/timex.h
 F:	include/uapi/linux/time.h
 F:	include/uapi/linux/timex.h
+F:	kernel/time/.kunitconfig
 F:	kernel/time/alarmtimer.c
 F:	kernel/time/clocksource*
 F:	kernel/time/ntp*
diff --git a/kernel/time/.kunitconfig b/kernel/time/.kunitconfig
new file mode 100644
index 0000000..d60a611
--- /dev/null
+++ b/kernel/time/.kunitconfig
@@ -0,0 +1,2 @@
+CONFIG_KUNIT=3Dy
+CONFIG_TIME_KUNIT_TEST=3Dy

