Return-Path: <linux-tip-commits+bounces-2144-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 929F39683F8
	for <lists+linux-tip-commits@lfdr.de>; Mon,  2 Sep 2024 12:02:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4EA0B281523
	for <lists+linux-tip-commits@lfdr.de>; Mon,  2 Sep 2024 10:02:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AC5013CF8E;
	Mon,  2 Sep 2024 10:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mjW+Oyt/";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nwkiDdv3"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 763D613B586;
	Mon,  2 Sep 2024 10:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725271363; cv=none; b=lB9lA1KXnU1ZZIKXOsHhpx875h6gc2F5hjhwXICpGMartIQVWL0M2ZzDAs4Jkds3ABFWXXSipjMtvZiJL2yCJXqVkkFCaLSr4hZd0Y7ROSlv0mOxiTjePLSp/occslqL26KSmTMf/sYLT4PsRIPW+CBAWsuQx+ep4ryJa5fNUgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725271363; c=relaxed/simple;
	bh=6KA0iUlSQ8/29A+zGXtEJ9ikpkeimzBknBJDlI09jyE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=QJdX/xXdMiklT+9+ESxNwJllTxftRG7qbL61dFEpkrzKh1g+ESaJpmC5rhA5cwqHqF3ssmot42WOHStO3ailjjEnGhEqSjEUF2sbY42hD8B5DlSLrSMWPV/W6bjEoEXjNeLRjpvsP5X1zJOiOuzl/mLwF8qgSFoDpsNIkin2xWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mjW+Oyt/; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nwkiDdv3; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 02 Sep 2024 10:02:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1725271360;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QMg+WP9EHqp+VdbdG3WwmftBeBzMvcyfYj8sARwyh3c=;
	b=mjW+Oyt/FB/E5Y4fF6YiWNt9KOVde7qf4Xe8vrowEs5DmxRcQdwA+GDop5vH5WMAbfDfc0
	EL69Z5HVQfacGmmcdHAaOhnmaRgoZPCJmhgaoZmXTHWOo+AFL0EbaLvaqzbrHkSUp1KX2f
	WEg24vaXCQRARKBxW36tLIaJq/Z2aSjfyOhovUfUz6dYW+R73Ruse8gPXfHFZsaQgl0niH
	e3J8Gb9xl9V4kZxMwqdnErAVQYLUn2mmnbtFJBMvvg/O7d1T3OCToOJ/2jiqQQto7E4Vhz
	hvvD75zaMEU5HjOsi68KDOHiazaqoMsef4K1/pbQjEmAxmZaFfRcLRt3SaklxQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1725271360;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QMg+WP9EHqp+VdbdG3WwmftBeBzMvcyfYj8sARwyh3c=;
	b=nwkiDdv3sV3LjF+UVZFv+SvlinaEl9wUbqNgcvwU18FRSDgLCy2KVdkr6NYe0lS4ptruyN
	dPyLFlCxlS4JIdAg==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/urgent] Merge tag 'timers-v6.11-rc7' of
 https://git.linaro.org/people/daniel.lezcano/linux into timers/urgent
Cc: x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <d0e93dbd-b796-4726-b38c-089b685591c9@linaro.org>
References: <d0e93dbd-b796-4726-b38c-089b685591c9@linaro.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172527136052.2215.7199046155541314221.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/urgent branch of tip:

Commit-ID:     342123d6913c62be17e5ca1bb325758c5fd0db34
Gitweb:        https://git.kernel.org/tip/342123d6913c62be17e5ca1bb325758c5fd0db34
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 02 Sep 2024 11:56:59 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 02 Sep 2024 11:56:59 +02:00

Merge tag 'timers-v6.11-rc7' of https://git.linaro.org/people/daniel.lezcano/linux into timers/urgent

Pull clocksource driver fixes from Daniel Lezcano:

  - Remove percpu irq related code in the timer-of initialization
    routine as it is broken but also unused (Daniel Lezcano)

  - Fix return -ETIME when delta exceeds INT_MAX and the next event not
    taking effect sometimes (Jacky Bai)

Link: https://lore.kernel.org/all/d0e93dbd-b796-4726-b38c-089b685591c9@linaro.org
---

