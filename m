Return-Path: <linux-tip-commits+bounces-1694-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 14B2F930500
	for <lists+linux-tip-commits@lfdr.de>; Sat, 13 Jul 2024 12:17:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B396E1F227FA
	for <lists+linux-tip-commits@lfdr.de>; Sat, 13 Jul 2024 10:17:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6E6A13698B;
	Sat, 13 Jul 2024 10:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="W9VzaWSr";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="t1Ba7BEM"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11ADB131182;
	Sat, 13 Jul 2024 10:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720865826; cv=none; b=ty1WNNzSn/X3XFfB44lqxiGxXM/7XalQoYpubcZKFwzgXQ3eblYPhTp62RXmZ3kCtgB4Ncrxpxc0FNPvPG8Pv6K50FImKqTatKfVRKKzG2oG47N6DTbb+hxozBWXgrRXE9pZgB2fTrt/2/6Ac1VQK7XfhTStcjtXGlOLfL6x7dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720865826; c=relaxed/simple;
	bh=dvAqkqaeho++tNSRjZJX0pleufWFvYLZUVqbxKHyoKc=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=RCvTq+ccYk/tAV6Mrfb5HVLXEm+z8u3NPap2lJBsU3JbEp8fKujFjs0kHa8W/5eshmSZmyfBMy9LpILTXx6qfDOhVL0gbzuojIGyl9ou4dlEr5slL4LjPeIVDKC7hVbZhvO0MMlmXVcfPoJ5E3p7JMcQ0rG2sR2/DIrZOLjHP+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=W9VzaWSr; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=t1Ba7BEM; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 13 Jul 2024 10:16:56 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1720865816;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+I5QUpuZf21g33S0eiBmM0yT1o+1+LvRKiCU5CywuDU=;
	b=W9VzaWSr3OqJ7/b1jDUdn2PJlmBx0kfc7lkz+/4UYSVtxo38mlJxJRXPsj39NRucmUcgsu
	cWIHW1PYDsL4rNTl6bLqCnz92aZ0hDUUnHnYBm5hX8h4Y6tG0A5MhGvFCfPkh5odfV/3hm
	DSo0g82PwMo57qhHYMtN36pdvFajDYQPbHh8puDjWZFt84Zx4GuYUiSq1mtCpjPMGKEBWn
	tUXi3asCS7nW4/GKaJxEisGIUTYwMN8SZly64aPJvyirZCdDRlfYvIKz8uUKYo739g0bC/
	9U/94q+t8aeqDw/yn2qmEO80g/TvM/X48yJqwWP+GgCrowdCDyJbj8yJoIlvDA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1720865816;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+I5QUpuZf21g33S0eiBmM0yT1o+1+LvRKiCU5CywuDU=;
	b=t1Ba7BEMQZa10cZeMwcwzxBoUxnwRVe9xoZatwXQ++8owdEftLtKYh5+LPA5H8GMAR5KAU
	Rt3EOElxo49B96Aw==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] Merge tag 'timers-v6.11-rc1' of
 https://git.linaro.org/people/daniel.lezcano/linux into timers/core
Cc: x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <91cd05de-4c5d-4242-a381-3b8a4fe6a2a2@linaro.org>
References: <91cd05de-4c5d-4242-a381-3b8a4fe6a2a2@linaro.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172086581648.2215.15523759560414871201.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     b7625d67eb1a63d33b0a2a4518ce4897d27f7465
Gitweb:        https://git.kernel.org/tip/b7625d67eb1a63d33b0a2a4518ce4897d27=
f7465
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Sat, 13 Jul 2024 12:07:10 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sat, 13 Jul 2024 12:07:10 +02:00

Merge tag 'timers-v6.11-rc1' of https://git.linaro.org/people/daniel.lezcano/=
linux into timers/core

Pull clocksource/event driver updates from Daniel Lezcano:

  - Remove unnecessary local variables initialization as they will be
    initialized in the code path anyway right after on the ARM arch
    timer and the ARM global timer (Li kunyu)

  - Fix a race condition in the interrupt leading to a deadlock on the
    SH CMT driver. Note that this fix was not tested on the platform
    using this timer but the fix seems reasonable enough to be picked
    confidently (Niklas S=C3=B6derlund)

  - Increase the rating of the gic-timer and use the configured width
    clocksource register on the MIPS architecture (Jiaxun Yang)

  - Add the DT bindings for the TMU on the Renesas platforms (Geert
    Uytterhoeven)

  - Add the DT bindings for the SOPHGO SG2002 clint on RiscV (Thomas
    Bonnefille)

  - Add the rtl-otto timer driver along with the DT bindings for the
    Realtek platform (Chris Packham)

Link: https://lore.kernel.org/all/91cd05de-4c5d-4242-a381-3b8a4fe6a2a2@linaro=
.org
---

