Return-Path: <linux-tip-commits+bounces-2088-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A4791958F33
	for <lists+linux-tip-commits@lfdr.de>; Tue, 20 Aug 2024 22:35:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6194F1F225B1
	for <lists+linux-tip-commits@lfdr.de>; Tue, 20 Aug 2024 20:35:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EB2F18A6B5;
	Tue, 20 Aug 2024 20:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="x2Mkul9a";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fPtY9jzU"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EECD157464;
	Tue, 20 Aug 2024 20:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724186112; cv=none; b=cMyCyb5rg/0WLNfqRQZ4Yr5AqgqGUzMuAOOHOXtuIk1Ef04a4jz4NpqyEZOAnDJ4Vi0FOM4HCzUcNFDk2oGChZtpqeZGVceIEkR2FqZDxrBVTtZZotD9V6AQWhYNf9vzqjYezqowkWQvN1PMSrg1S9O1N2dFVRRjKfOxi4bMoKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724186112; c=relaxed/simple;
	bh=Jad8aFQSc9hpTfneanO3nQIaSAzp5R9jVBIwfHqp5cQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JjjSikanb7JnSY/KnDBei17AoEh8G+MDH+CB6LRXtBn1pS2pXCv6UeVgZ5Ex7aT/TRv5AWtzBDZckBqLtxdJ2kg/dkfaR1eVHqemRX19ucGeEpLKHPrPGJHDweSlcBXb9lLNCrgDcfXq5XhxkYdRgE69ZCChNtQKMRDFxx6/zuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=x2Mkul9a; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fPtY9jzU; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1724186107;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G6xvUKTrHw7/6WoVlgUHqmgsJAIrmXFAoYA7vV27BsU=;
	b=x2Mkul9aY1Ifb54s9QbwXoWWOye3IxQFl9jcfpXJfbSJqGEtrwKQ7tCYh14x+evaONqdel
	rs7go4KJtFCIp48RnG+urEWM3uPbpjpUkV2OCZLihvu98cjpx8FsBeDhQ+RU3YcwxxXcnf
	+USdnD1VKYh2vFfTwAB8UcwF47FJO1Sw1lxsM1hvTsrMXNX9SMOZdbMdWUnp8a72nRJ3yx
	ge5WsOElo+iDkwxOQQeVArlQSsLt/C4GyIDZeZT/W1OyKlJasiNO33G6w1VPtg0rm27W/B
	byQfV1z5WWfWCIpdCa/hE/fjKoL4f4swd1Botw3qmSC2S66sO7z7YlFNeG5vTg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1724186107;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G6xvUKTrHw7/6WoVlgUHqmgsJAIrmXFAoYA7vV27BsU=;
	b=fPtY9jzUxKCje/UsArMzwQm2nFIWexoe3HJaqZH70PeXd8Fpcp+Qgo65Ef72mEDvSUIYlX
	TewkUkic6eiAiHDQ==
To: tip-bot2 for Max Ramanouski <tip-bot2@linutronix.de>,
 linux-tip-commits@vger.kernel.org
Cc: Max Ramanouski <max8rr8@gmail.com>, Christoph Hellwig <hch@lst.de>,
 Alistair Popple <apopple@nvidia.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [tip: x86/urgent] x86/ioremap: Use is_ioremap_addr() in iounmap()
In-Reply-To: <172380142877.2215.11720831620589167404.tip-bot2@tip-bot2>
References: <20240815205606.16051-2-max8rr8@gmail.com>
 <172380142877.2215.11720831620589167404.tip-bot2@tip-bot2>
Date: Tue, 20 Aug 2024 22:35:06 +0200
Message-ID: <87a5h7j5l1.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 16 2024 at 09:43, tip-bot wrote:
> The following commit has been merged into the x86/urgent branch of tip:
>
> Commit-ID:     7b02ad32d83c16abd4961d79f3154b734d1d5d9c
> Gitweb:        https://git.kernel.org/tip/7b02ad32d83c16abd4961d79f3154b7=
34d1d5d9c
> Author:        Max Ramanouski <max8rr8@gmail.com>
> AuthorDate:    Thu, 15 Aug 2024 23:56:07 +03:00
> Committer:     Thomas Gleixner <tglx@linutronix.de>
> CommitterDate: Fri, 16 Aug 2024 11:33:33 +02:00
>
> x86/ioremap: Use is_ioremap_addr() in iounmap()

This has been removed as it fails on a 32-bit defconfig:

include/linux/ioremap.h: In function =E2=80=98is_ioremap_addr=E2=80=99:
include/linux/ioremap.h:14:25: error: =E2=80=98VMALLOC_START=E2=80=99 undec=
lared (first use in this function); did you mean =E2=80=98KMALLOC_DMA=E2=80=
=99?
   14 | #define IOREMAP_START   VMALLOC_START

Can you please have a look?

Thanks,

        tglx

