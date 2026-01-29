Return-Path: <linux-tip-commits+bounces-8141-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wAsBEPXSe2nrIgIAu9opvQ
	(envelope-from <linux-tip-commits+bounces-8141-lists+linux-tip-commits=lfdr.de@vger.kernel.org>)
	for <lists+linux-tip-commits@lfdr.de>; Thu, 29 Jan 2026 22:36:53 +0100
X-Original-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ADCD3B4DC5
	for <lists+linux-tip-commits@lfdr.de>; Thu, 29 Jan 2026 22:36:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 040BE303DD3A
	for <lists+linux-tip-commits@lfdr.de>; Thu, 29 Jan 2026 21:32:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21AD135DD1D;
	Thu, 29 Jan 2026 21:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sGM6drud";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="X+y9W09H"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0BD235CB91;
	Thu, 29 Jan 2026 21:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769722334; cv=none; b=CiuyqIylZnvbeyqY+AsjsHRkicpNy00jb2816x3gqxor061d+kvOCxpmXfbhfzEBzl7387GhodTUPXRLUMJSqbTqIgCdc3/8thFC78FAIBGnFYzJ06IiNDM7TpdOWax0Vut9/R5YOHCTZOy1TQQzARh+9woUsnmwJ1xqy6T9DXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769722334; c=relaxed/simple;
	bh=qZK6G+GV9lT3KDPvhmTRNjht+bs1Xc+maNP5o7HlvDk=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=ej4m/dybnyGYWmt6bptGHw/7ly+t9Sea1d/avGnvki/Mv0I2EkW8IlxFbaROYcntaC5Jm9SkpmIgdN0tTnFXI4WbcxnGfAy9quFHXWPvuJAn40tfbjMz2e5N6w3kVpGqR/lDD4RPe7wi9i0Qm8QJ3mIsui3uSdtT7Kff8duA2Vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sGM6drud; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=X+y9W09H; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 29 Jan 2026 21:32:10 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1769722331;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4h/FuSQ5gWf5aoxJaniLuPA0NaLlXzjkMK9vYIucOo4=;
	b=sGM6drudmEmg7rzm99zMtzs+alusdL69BpHSnYLZ+89d/ORz7vAOpI07qaduJyTUn2wXX1
	cOwbFA/kgSlHKAxD/HXJLF47s4+4qItkdiKqhXgEBpR7PHSZ9GySd3v9XTqvVrdzebC2+j
	S5tNEo1POIYhTM86juf7DrnvoRAUIXoJgTo6MeN5tmtFuu6hE2KgKv4nh1lW3bohNU4AKH
	yWyIKob8V032sOA+0UwNTzkPQB4PfN6DOQPEqMrMLLGoMIV49qIETptA62SXSliYEghHv7
	9nfnHTowcJTqVZk6M5DtZ25EIyHBYPf1jixDEohEfGdNLLOevaUEHFn87AMwiQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1769722331;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4h/FuSQ5gWf5aoxJaniLuPA0NaLlXzjkMK9vYIucOo4=;
	b=X+y9W09HKFtVz7sMrcXLuBeAi/Wc/Z4lPrt1S+4P7GttA0KAVjFs/2j6SpUL1OmQA33ssZ
	KnRqK8filtkxV+Bg==
From: "tip-bot2 for Bartosz Golaszewski" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/clocksource] clocksource/drivers/timer-integrator-ap:
 Add missing Kconfig dependency on OF
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20260116111723.10585-1-bartosz.golaszewski@oss.qualcomm.com>
References: <20260116111723.10585-1-bartosz.golaszewski@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176972233000.2495410.2216567941806645456.tip-bot2@tip-bot2>
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
	TAGGED_FROM(0.00)[bounces-8141-lists,linux-tip-commits=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,linaro.org:email,vger.kernel.org:replyto,linutronix.de:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
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
X-Rspamd-Queue-Id: ADCD3B4DC5
X-Rspamd-Action: no action

The following commit has been merged into the timers/clocksource branch of ti=
p:

Commit-ID:     2246464821e2820572e6feefca2029f17629cc50
Gitweb:        https://git.kernel.org/tip/2246464821e2820572e6feefca2029f1762=
9cc50
Author:        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
AuthorDate:    Fri, 16 Jan 2026 12:17:23 +01:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Tue, 20 Jan 2026 18:06:27 +01:00

clocksource/drivers/timer-integrator-ap: Add missing Kconfig dependency on OF

This driver accesses the of_aliases global variable declared in
linux/of.h and defined in drivers/base/of.c. It requires OF support or
will cause a link failure. Add the missing Kconfig dependency.

Closes: https://lore.kernel.org/oe-kbuild-all/202601152233.og6LdeUo-lkp@intel=
.com/
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://patch.msgid.link/20260116111723.10585-1-bartosz.golaszewski@oss=
.qualcomm.com
---
 drivers/clocksource/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index aa59e5b..fd91127 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -254,6 +254,7 @@ config KEYSTONE_TIMER
=20
 config INTEGRATOR_AP_TIMER
 	bool "Integrator-AP timer driver" if COMPILE_TEST
+	depends on OF
 	select CLKSRC_MMIO
 	help
 	  Enables support for the Integrator-AP timer.

