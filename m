Return-Path: <linux-tip-commits+bounces-2857-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71F299C7CD4
	for <lists+linux-tip-commits@lfdr.de>; Wed, 13 Nov 2024 21:22:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 338C5284097
	for <lists+linux-tip-commits@lfdr.de>; Wed, 13 Nov 2024 20:22:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E095020EA32;
	Wed, 13 Nov 2024 20:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hyf4ZxZi";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PrOwGeo2"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F12A20B7F1;
	Wed, 13 Nov 2024 20:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731529257; cv=none; b=RUzIDa170/csgA8OFkm11E1tT9oGK2ZSGdnxi33wtOXFhDie7Ah2HTEnos9p4ZGwP/xoK9ae2BQDyOyOwYN2QEaClLLCMhkhtb6IibG7coLBrUhAkNpn3gwbJh9sbMP2WldrbMI3dtaTmUnHFB5z36NPWFQ7QO64+x0uNvBe9TI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731529257; c=relaxed/simple;
	bh=GUOtGj4BVWrNihtFbLsuXnaGd8H/mdTz7pFySYtiUwo=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=iZrDUN9NULkXJ1optICNxnbNdtHQLOSNWQ2bcw8hijGJ842UeeGDleyIsggl1OJzsQ/YksiArZkyganHwS695KJU4CCvh+f0IlM3zzU6kd4g/8+2kxQaVCXqezvrrX1UEYCrO/8Uci1ghRvstVGALnEfebLQ6lGuTuH2o57cNC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hyf4ZxZi; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PrOwGeo2; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 13 Nov 2024 20:20:54 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1731529254;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/wB/6JMDNOzv36oKOzdH+D8CQIDHL+74ug7JPuqS+a8=;
	b=hyf4ZxZizGqzLa/Gp8Zsy7HG9yEltd8D5o/5CHq0BDOqdbm6tfHCKDn9YLk4aEmaeLwXHJ
	IWxnmZxumH7iw0kVqv84cMUORX65O6DyjTkm0kO9RfA6wv/bza1tLEeNY7lV6/pPKDC/rn
	4qJBwPjrdQwL/0xd0gy71ZEvkTk1SIJYiZO+ES2tTgAixtjifFpAxFWova7G72xh70txRY
	T9DDgs9ZbnSozu72qV5wMrqthcof8yFrxy9UA0fNfp32U1BoOfQ62AvYzYgiR0B339OtWQ
	YDrLD0Xsew/uvweuGy0Sdsqx4e9LnCfe3thnImNCbXCYqJ86JHTkJsoKp0DMfw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1731529254;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/wB/6JMDNOzv36oKOzdH+D8CQIDHL+74ug7JPuqS+a8=;
	b=PrOwGeo2QnrrlTMlOuDDmjcmf9jf4r7TrmK9v6J1N0IQjxyymm6CSBmvGAN91LgTSLZKHy
	YHd0k3VXQBYBV5Dg==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] Merge tag 'timers-v6.13-rc1' of
 https://git.linaro.org/people/daniel.lezcano/linux into timers/core
Cc: x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <8d402321-96f1-47f7-9347-a850350d60de@linaro.org>
References: <8d402321-96f1-47f7-9347-a850350d60de@linaro.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173152925403.32228.8860008565950381348.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     228ad72e7660e99821fd430a04ac31d7f8fe9fc4
Gitweb:        https://git.kernel.org/tip/228ad72e7660e99821fd430a04ac31d7f8fe9fc4
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 13 Nov 2024 21:09:35 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 13 Nov 2024 21:09:35 +01:00

Merge tag 'timers-v6.13-rc1' of https://git.linaro.org/people/daniel.lezcano/linux into timers/core

Pull clocksource/event updates from Daniel Lezcano:

  - Remove unused dw_apb_clockevent_[pause|resume|stop] functions as
    they are unused since 2021 (David Alan Gilbert)

  - Make the sp804 driver user selectable as they may be unused on some
    platforms (Mark Brown)

  - Don't fail if the ti-dm does not describe an interrupt in the DT as
    this could be a normal situation if the PWM is used (Judith Mendez)

  - Always use cluster 0 counter as a clocksource on a multi-cluster
    system to prevent problems related to the time shifting between
    clusters if multiple per cluster clocksource is used (Paul Burton)

  - Move the RaLink system tick counter from the arch directory to the
    clocksource directory (Sergio Paracuellos)

  - Convert the owl-timer bindings into yaml schema (Ivaylo Ivanov)

  - Fix child node refcount handling on the TI DM by relying on the
    __free annotation to automatically release the refcount on the node
    (Javier Carrasco)

  - Remove pointless cast in the GPX driver as PTR_ERR already does that
    (Tang Bin)

  - Use of_property_present() for non-boolean properties where it is
    possible in the different drivers (Rob Herring)

Link: https://lore.kernel.org/lkml/8d402321-96f1-47f7-9347-a850350d60de@linaro.org
---

