Return-Path: <linux-tip-commits+bounces-4445-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22BBDA6EB49
	for <lists+linux-tip-commits@lfdr.de>; Tue, 25 Mar 2025 09:16:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 502D03B4F6E
	for <lists+linux-tip-commits@lfdr.de>; Tue, 25 Mar 2025 08:15:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 826742561A3;
	Tue, 25 Mar 2025 08:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hUDFgbuC";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qAWxhzbT"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1CA7254B1C;
	Tue, 25 Mar 2025 08:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742890503; cv=none; b=QxGovltOjdK6xWkmDvkZ7oAgHFSOdju8suhr+/M1ISi+johkp2L8SWvT9DNF4L9S6GYFJjMFypEZCtFJ9mTCfd8rBHRyxjBXwUyz/+bQhcHxvKhHHY9L7Cz5jmevLBxXkfBsK4UFdLHr1YKYirHWERe1+u+NB9I80h18b+8zCN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742890503; c=relaxed/simple;
	bh=CVDLznrlc4N19MHx6revHG01w4dXeiWXIhF1HV8hlpQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=JGV/mDycRTuZYxwzijyEYkCAmIj7ysuNgvS+Pvff0CHK+L4hs5rmoch2TQXSNgeMEqkjMKYJooHsY09aO+oDHTHKEoVgp4QaG8R6eUnQxU1MsAYV1Ke9kxfSsYxfPlbtWc6FK2K61GXGTAop4HrUV7E9IHDNkpLQL09kuanAVVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hUDFgbuC; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qAWxhzbT; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 25 Mar 2025 08:14:59 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742890500;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+1gjmA7mrIwxaUVpK/9PgUoCYgkLgKFNHivIknoMBTQ=;
	b=hUDFgbuCR5+t3oJ8zuyk24xa7mSLWYdZIHiMfYebiygrwQ5zTS5UMo4QlLkwu3lCn6K7Sy
	D8IbK+ArbpSojDVDN8S64sf85O/b3QdlQZgykB2oy7azje6gttcbwpwJhtRJ/sxi9kNSJG
	hwFQfbcadvl27hspfAeivMgdZjOV5A2AUWm2oO2wsmuWPNdVGgRZtoV6D/+S91dA4gU9f3
	Dion3L5GfOZw5OL8I6BNJlT2hmKahvaSeyXH9NLwpGzD1IRBinDeazDwzXcKM31EkFKIL/
	+5dCf2Iv86l2CCYtnx0+u6sd2hE9fJfJa5W4qckwg2GIu3mYjJ4mKX5KDIbEwQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742890500;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+1gjmA7mrIwxaUVpK/9PgUoCYgkLgKFNHivIknoMBTQ=;
	b=qAWxhzbTh7utaasDUDxlIT27heYEb2dTLsPmjSUf8jPJoVdPtLW+gtdLICJorjk35KppvZ
	8bQexYq2WIy8CTAg==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/clocksource] Merge tag 'timers-v6.15-rc1' of
 https://git.linaro.org/people/daniel.lezcano/linux into timers/clocksource
Cc: x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <57f79277-72c9-4597-a40b-d14e30d14c60@linaro.org>
References: <57f79277-72c9-4597-a40b-d14e30d14c60@linaro.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174289049971.14745.17745946328207191392.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/clocksource branch of tip:

Commit-ID:     abfa6d6fe2e9539a6e080088a6e5762f4651017b
Gitweb:        https://git.kernel.org/tip/abfa6d6fe2e9539a6e080088a6e5762f4651017b
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 25 Mar 2025 09:00:19 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 25 Mar 2025 09:00:19 +01:00

Merge tag 'timers-v6.15-rc1' of https://git.linaro.org/people/daniel.lezcano/linux into timers/clocksource

Pull clocksource/event driver updates from Daniel Lezcano:

   - Fixed indentation and style in DTS example in the DT bindings
     (Krzysztof Kozlowski)

   - Added the samsung,exynos990-mct compatible binding (Igor Belwon)

   - Added the samsung,exynos2200-mct-peris compatible binding (Ivaylo
     Ivanov)

   - Fixed a comment spelling error in the exynos-mct driver (Anindya
     Sundar Gayen)

   - Added the support for suspend / resume in the stm32-lptimer driver
     (Fabrice Gasnier)

   - Fixed use of wakeup capable instead of init wakeup in the
     stm32-lptimer driver (Alexandre Torgue)

   - Add SiFive CLINT2 DT bindings (Nick Hu)

Link: https://lore.kernel.org/all/57f79277-72c9-4597-a40b-d14e30d14c60@linaro.org
---

