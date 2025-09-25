Return-Path: <linux-tip-commits+bounces-6767-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A729BA19EA
	for <lists+linux-tip-commits@lfdr.de>; Thu, 25 Sep 2025 23:42:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 288263A2F90
	for <lists+linux-tip-commits@lfdr.de>; Thu, 25 Sep 2025 21:41:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7878632D5CC;
	Thu, 25 Sep 2025 21:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZVz8SMJj";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Za/I+vHV"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7026322DCC;
	Thu, 25 Sep 2025 21:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758836037; cv=none; b=la646dncMGQnxwQfPyKfUM4sRh5kU6722pKfFLCZxSsa4oEPqlYX5sVXOlYeHR/bo7uKyKWjR9Sdv+4MaC/KQkPUxkGAzdaKAmkETmDyfoPtfX1niBxMxkZHkgbc/UhV0djL+MCmO5Ann43OzBolVoKsa0vIVijeKgsNd/2bhso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758836037; c=relaxed/simple;
	bh=kSzOgkdS/DwPr3F7/yXuhoQIgRSmS4wAOWQKUq1LJ28=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=ntBIPw39O5hHqgSeF32BMHDm81S4eL0mbKKRanmdIieFSHdplghGHqvdn83K5yZgeNO0gxdhDrtnERAozdBOwkV/rkEUhHdM8u9LlfwZKdgcFqd/qVEm6blOD7ydoaKn63atBOoeSOXjze6H0BxjRbtC70iXEjNOAXu91wjfWmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZVz8SMJj; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Za/I+vHV; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 25 Sep 2025 21:33:52 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1758836034;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=dU7kDgYCHD/Of8cotNXwIaTmcgwXxD0fmyjN+aAFyhU=;
	b=ZVz8SMJjze5PzCJ3JvheiKLwXMxKugbBRRd+JMpdg3gEpGFiLFe6iNRNqg9f5bootjMNR5
	IrsO8UkaoDZ2cSb3jXwwC6E2jwPCdFo9FAfEgOstxxWeNNpJJDbMZ+PWI27JPtAa6p/6KA
	tbW5NroNv+VbU3IHcG2TEw+DVP0E1zohBili+yt6dHMHKgU8kORRkdwxjfA9v0m/Xojipm
	lAt9vbVEvxzyo44nvImXtu5Z/KubpifLXdKBKcHTBL8bYks9JtQ0g8eQ/eK8+aLvpeLipd
	f93KIaQqizR6rA8ILwqQhecEI25nOB32NNkElSKjeM4zjiHqFEvnknSyCfLr5A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1758836034;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=dU7kDgYCHD/Of8cotNXwIaTmcgwXxD0fmyjN+aAFyhU=;
	b=Za/I+vHVQKOC3D7Fo4aj2eNrNCizzJ4Ei+/kk/LRWmdMdc8xKrKkpv/3S4HH1QJasXW+Q5
	ahgO4MgzWjZhVgCA==
From: "tip-bot2 for Daniel Lezcano" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/clocksource] time/sched_clock: Export symbol for
 sched_clock register function
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>,
 Thomas Gleixner <tglx@linutronix.de>, Carlos Llamas <cmllamas@google.com>,
 Will McVicker <willmcvicker@google.com>, John Stultz <jstultz@google.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175883603264.709179.1504490930131844570.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/clocksource branch of ti=
p:

Commit-ID:     84b1a903aed876a3fd6bb04786947f640d4d8e62
Gitweb:        https://git.kernel.org/tip/84b1a903aed876a3fd6bb04786947f640d4=
d8e62
Author:        Daniel Lezcano <daniel.lezcano@linaro.org>
AuthorDate:    Mon, 02 Jun 2025 17:18:51 +02:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Tue, 23 Sep 2025 10:52:31 +02:00

time/sched_clock: Export symbol for sched_clock register function

The timer drivers could be converted into modules. The different
functions to register the clocksource or the clockevent are already
exporting their symbols for modules but the sched_clock_register()
function is missing.

Export the symbols so the drivers using this function can be converted
into modules.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Carlos Llamas <cmllamas@google.com>
Reviewed-by: Will McVicker <willmcvicker@google.com>
Acked-by: John Stultz <jstultz@google.com>
Link: https://lore.kernel.org/r/20250602151853.1942521-8-daniel.lezcano@linar=
o.org
---
 kernel/time/sched_clock.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/time/sched_clock.c b/kernel/time/sched_clock.c
index cc15fe2..cc1afec 100644
--- a/kernel/time/sched_clock.c
+++ b/kernel/time/sched_clock.c
@@ -174,8 +174,7 @@ static enum hrtimer_restart sched_clock_poll(struct hrtim=
er *hrt)
 	return HRTIMER_RESTART;
 }
=20
-void __init
-sched_clock_register(u64 (*read)(void), int bits, unsigned long rate)
+void sched_clock_register(u64 (*read)(void), int bits, unsigned long rate)
 {
 	u64 res, wrap, new_mask, new_epoch, cyc, ns;
 	u32 new_mult, new_shift;
@@ -247,6 +246,7 @@ sched_clock_register(u64 (*read)(void), int bits, unsigne=
d long rate)
=20
 	pr_debug("Registered %pS as sched_clock source\n", read);
 }
+EXPORT_SYMBOL_GPL(sched_clock_register);
=20
 void __init generic_sched_clock_init(void)
 {

