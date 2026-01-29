Return-Path: <linux-tip-commits+bounces-8143-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qLoWJyLTe2nrIgIAu9opvQ
	(envelope-from <linux-tip-commits+bounces-8143-lists+linux-tip-commits=lfdr.de@vger.kernel.org>)
	for <lists+linux-tip-commits@lfdr.de>; Thu, 29 Jan 2026 22:37:38 +0100
X-Original-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CFD39B4DEB
	for <lists+linux-tip-commits@lfdr.de>; Thu, 29 Jan 2026 22:37:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9354C3048080
	for <lists+linux-tip-commits@lfdr.de>; Thu, 29 Jan 2026 21:32:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 489E135FF63;
	Thu, 29 Jan 2026 21:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Tjo+r8Ht";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ec+Fwrue"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3F5735E54F;
	Thu, 29 Jan 2026 21:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769722337; cv=none; b=ZUUo+h5Mou0tNfxuh7a3llgH/NkgwxQaxxR/4B/CQ4ZqQKFgcdg4GtWKUmZC8qF9KRPOZATD/hiHoyEsG0Oa50oJ3YbSb3BwSkeciHXhY4bqBhGli8v25NOXflz0Zcf+90iuJtXu1jUHb75XsHTW9N5fVTqfBrQQiDLGe8oZfUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769722337; c=relaxed/simple;
	bh=iKEDOAzxsS7GRkX+d2xSoTG0D2ezh6+z+rwL4+7DwGo=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=OX5J1FmmRgEx4FakHP7myNJ02CIJlKI3XhB1kzQrWtoZw6uOmHOfQHnwoXSawlNgITaJy8UEpyddFddM1Hn1u1H1pTXK1cs9Ar5egMtPXQYm/7EBL5sGwpch8lGWXZa544tlkZ7Gg9EnmAINw08ObWFBy5cNN58pG2lbyrPSRkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Tjo+r8Ht; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ec+Fwrue; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 29 Jan 2026 21:32:12 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1769722333;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=T9JSolLmIxzpb3sGTm1BWI4vVBgniIasoBDxHe5eges=;
	b=Tjo+r8HtmwD7h/7HWWCxCdkMbKAcFCnz1NoNtoPqkdxbr7NsMV532srvgOyXg0L/gYq5+q
	+U1vyJuMBtpcTl6CQ+bSnNxpwj1npRVdeIFH/G3wIUdmotNftK881bK4MBFTCvuzJzSBqI
	KH8vT5uFBA5ImVSi2Z9fvMu8ZdH3RWn6Ra4nSa3GV2WP0IUtywI8FzeD8dt0GUbAy/IZgw
	VL+D7stiWso+lDv2nyo+jhxFi1U4oFA5rOGpkFjNeH3AdQY70iyN+KyLd1qbFZHXgFmVZ5
	lCsYHT6SF1imdhnofs/EzVKyXWvh6bPfDIXHEaArQ1lPmUo2VhwGef3wHyv9ZQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1769722333;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=T9JSolLmIxzpb3sGTm1BWI4vVBgniIasoBDxHe5eges=;
	b=ec+FwrueAjGjkGMKu96umICx1XBMoGaw8TrqnbuanydSuqNA4N2qZQ4LgxEGVXhMovncHh
	D7GPuwTLun6URzAA==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/clocksource] Merge tag 'timers-v7.0' of
 git://git.kernel.org/pub/scm/linux/kernel/git/daniel.lezcano/linux into
 timers/clocksource
Cc: x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <75b163aa-5098-4949-a539-ae1e59e3aaca@linaro.org>
References: <75b163aa-5098-4949-a539-ae1e59e3aaca@linaro.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176972233220.2495410.8609884429268454889.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8143-lists,linux-tip-commits=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	REPLYTO_DOM_EQ_TO_DOM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	HAS_REPLYTO(0.00)[linux-kernel@vger.kernel.org];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tip-bot2@linutronix.de,linux-tip-commits@vger.kernel.org];
	DKIM_TRACE(0.00)[linutronix.de:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-tip-commits];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:replyto,msgid.link:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linutronix.de:dkim]
X-Rspamd-Queue-Id: CFD39B4DEB
X-Rspamd-Action: no action

The following commit has been merged into the timers/clocksource branch of ti=
p:

Commit-ID:     7eaf8e32de5f4ed4defda6fff81749041bb9d23f
Gitweb:        https://git.kernel.org/tip/7eaf8e32de5f4ed4defda6fff81749041bb=
9d23f
Author:        Thomas Gleixner <tglx@kernel.org>
AuthorDate:    Thu, 29 Jan 2026 22:23:51 +01:00
Committer:     Thomas Gleixner <tglx@kernel.org>
CommitterDate: Thu, 29 Jan 2026 22:23:51 +01:00

Merge tag 'timers-v7.0' of git://git.kernel.org/pub/scm/linux/kernel/git/dani=
el.lezcano/linux into timers/clocksource

Pull clocksource/events updates from Daniel Lezcano:

  - Always leave device running after probe in the sh TMU driver to
    overcome the locking validation scheme warning when the PREEMPT_RT
    is enabled (Niklas S=C3=B6derlund)

  - Add missing Kconfig dependency on OF for the integrator AP (Bartosz
    Golaszewski)

  - Fix a dead link in timer bindings for the Armada 370XP (Soham Metha)

  - Fix an Oops when read_current_timer is called on ARM32 platforms
    where the SP804 is not registered as the sched_clock (Stephen Eta
    Zhou)

  - Move GIC timer to use request_percpu_irq() instead of
    setup_percpu_irq() to allow the removal of the latter (Marc Zyngier)

Link: https://patch.msgid.link/75b163aa-5098-4949-a539-ae1e59e3aaca@linaro.org
---

