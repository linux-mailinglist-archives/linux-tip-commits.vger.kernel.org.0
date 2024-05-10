Return-Path: <linux-tip-commits+bounces-1254-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D0E68C22E0
	for <lists+linux-tip-commits@lfdr.de>; Fri, 10 May 2024 13:12:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 233D1282794
	for <lists+linux-tip-commits@lfdr.de>; Fri, 10 May 2024 11:12:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F126170836;
	Fri, 10 May 2024 11:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Xk8ZZUz0";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3oS1W3qC"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF25716F277;
	Fri, 10 May 2024 11:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715339462; cv=none; b=uNgGBcZuNgUkHNDBkKYpnYZQHzYStIFgjxX0aDV5GemrRFrgI1r82HudsgoyudjSttSzUmO7vXVoCI5NUSQB6F6Q3paMwbfkmXiZY0jPU6u20BSfSF0sxDzEbFhCGV1DU2KfopDDj6cR5yhFWsv2HBTnAILspI/BKI8pU+3ltuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715339462; c=relaxed/simple;
	bh=NSp6eYtNBIQMBrwS1fCk4LdfqGl7+X4mjJUp0AIvF74=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=I0Nl1yIULSGACCqfWUodsimkdkkXEUjC5q8fHs/wzvefGZ+OPsFNiTqRtU12QsYKq+Wj1FI6GuTNjFmvIRJJmdjYb/Kqilhf+pdyvsgn39BNBgdZ9gCdQQRVBtD2w2FT4LWtQbY/c6ZVwSD4Hy9FStqLdnCCrdR78K45PtQkMO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Xk8ZZUz0; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3oS1W3qC; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 10 May 2024 11:10:56 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1715339456;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ev96rmYp0eaUYW71DhQqZpKgJD8IihexdClbTUH+oeM=;
	b=Xk8ZZUz0w2GmIsUDqzCTmrNc+k9Dfs3TMPi1Gr9CdJngoyJejoXfN+cAwGWDVW7Aion9Kx
	vCbOK5gE77VPWLJ3oYzN6mRczJZs1G6kGqGT4wb6AL8Ab7j84872LklcoMjprBJYn1Lp73
	znaByneelT3auAXut1D7c1A/tNxVJpFeLC7D1IuMxbOFh5Vls8yH7/rLiIfK6eKN5Gbl/m
	LB11MrPiT1ceRCx2tzcMk/bNstcNchsMBInKKo09ricCA4E/hm6VnNZL1RusGMYAoPxX6T
	AEfHDe+vemb2cIXRuO+FF4ikhin8trJ4qRJ0T0cIU4HjWaQ4/ID5W1h8/a81RQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1715339456;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ev96rmYp0eaUYW71DhQqZpKgJD8IihexdClbTUH+oeM=;
	b=3oS1W3qC3hDNO5EYtpojKDKFkWm5xIKT3MXTIEgsFmfZzQdlBzDUCBCWrwwcVca7iPC7/9
	rVv1Ml0617XiTACQ==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] Merge tag 'timers-v6.10-rc1' of
 https://git.linaro.org/people/daniel.lezcano/linux into timers/core
Cc: x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <7ca1c46a-93e6-4f67-bee3-623cb56764fa@linaro.org>
References: <7ca1c46a-93e6-4f67-bee3-623cb56764fa@linaro.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171533945647.10875.12730685118812958758.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     a3825a7691585485e960cec04ce6667d176b7c67
Gitweb:        https://git.kernel.org/tip/a3825a7691585485e960cec04ce6667d176b7c67
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Fri, 10 May 2024 13:03:56 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 10 May 2024 13:03:56 +02:00

Merge tag 'timers-v6.10-rc1' of https://git.linaro.org/people/daniel.lezcano/linux into timers/core

Pull clockevent/source updates from Daniel Lezcano:

  - Add the R9A09G057 compatible bindings in the DT documentation and
    add specific code to deal with the probe routine being called twice
    (Geert Uytterhoeven)

  - Remove unused field in the struct dmtimer in the TI driver
    (Christophe JAILLET)

  - Constify the hisi_161010101_oem_info variable in the ARM arch timer
    (Stephen Boyd)

Link: https://lore.kernel.org/lkml/7ca1c46a-93e6-4f67-bee3-623cb56764fa@linaro.org
---

