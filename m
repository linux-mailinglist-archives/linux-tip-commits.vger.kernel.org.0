Return-Path: <linux-tip-commits+bounces-7726-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 092BECC198A
	for <lists+linux-tip-commits@lfdr.de>; Tue, 16 Dec 2025 09:36:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2A0B8302EFD8
	for <lists+linux-tip-commits@lfdr.de>; Tue, 16 Dec 2025 08:35:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAC5731C56F;
	Tue, 16 Dec 2025 08:35:45 +0000 (UTC)
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com [209.85.222.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED38530F532
	for <linux-tip-commits@vger.kernel.org>; Tue, 16 Dec 2025 08:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765874144; cv=none; b=Ymtm+E2kHnyAJ/NzV4RoIHwFpsLouKVm/Kr/sMSSeTiMtGuWSxUaxrDtkeSKeke+xtnfXG9dbB7BcAyYj8pVvYJcKjiIpcDpkaSTE3rHDPG9ahT93W20pWIV8pzUUkAbP1k1AhXSmIA6N45VUAR1S4J+FGYzLkEdbfMz5WNsd3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765874144; c=relaxed/simple;
	bh=/Ov3Y7rxA0gOa6VLbByhi6NeA/O5stuUy7+ZFh7/gR0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Fy8EejDVlLE60T9poWZ5sUUDEBYGupbudXDpTRqVcrJadNL5z3cJW3cQHBqWEIP5KlpNfv/TA7l4VIb3xc4CCU7vz8hK9olQCdT3nkfgcmeX1xfdfyWqju7P0Vtrbl/HEVAO1G0FVkwzCq6JVNeR6SauFOix1X1QCjbKDhRjQBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-93f573ba819so1110947241.1
        for <linux-tip-commits@vger.kernel.org>; Tue, 16 Dec 2025 00:35:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765874135; x=1766478935;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tzpKec+akZNL0WBBQ4BRLgSAv5EeRs8IKto9EFXrxyQ=;
        b=TyXeEUoO5DWiAk2D+/b5X4kalRY0pMFsJEKvfPQIsXCDgf/SG26lmMscz6puvpI4EK
         NWHjieQGpD5P8VNk/gwNeABbcJ87R+G0QUy2+O3XIm9i4tOtK9t2K6jdnI2hRdGfC7KU
         2esOi8+06tqt07C+CqceG/GTXM8et53aTwu28A5Ad0WrGK8X4fK/nZExEnwL3a36nHHP
         eR0pPlMNp+Wb1chVhMX042rQ+zDGp4qTxy0NHsEyXvqs54gWoGOJ7afz0+sZmO4QoslS
         4bXqwp+7Yi6oYWZDXsKvGhXyOdJDoYyOiya/emj2DPzOzDYtpyGUGHfa7e/5gk8Zbv4d
         KLZw==
X-Gm-Message-State: AOJu0YzYyaEK7MknGA+2v0OQrk06NBsVj5qbwlAlx5WJpMPkugRGl0Jj
	ID8IEoyqfBPuQmfemPDGuixSLbD8jX9/9SIwFbO/PDvYpQGR7WqkFIDfO9hSnCKp
X-Gm-Gg: AY/fxX6GZwsq6xrLLmAr/hrA//FYPXBqlCvJTiuBqSyApqi5VhkP9d85MBucIWx4fYo
	Dp2jIFz++CLyv9MFtuw6qR9rf5417bx5KkqrFPenHNZOg6723R+ug1ty4eGl+kgHeGzHXfF0ZOA
	FhGL3QuU+5WCcY/vYmbSlYDAfYEjAwL3ER+B566RiMYrmVOvfLFrk09jflEjW+01AtjLr6suJ8t
	3+2Uksj6/EwxTWNHNechM+6iodFtxQET5R/u6JtNVwhBzFj6AUilH3ZOOy2qh6sWN0cdnDGOzIS
	M/wk59KT3z8Os6P2Og0khdhE2dCTpehBcLjLfBUtQEDIaXG3MTcNa8YphfmkQxBoXbMIws8zxuw
	2KGvOIniXSECRWsQfnl+diWJ0Mut9gEX+tLBYHMM88QcyczaZ/+qWXwY9ERwq7/0oxuWpQUXy8e
	BuEKDmUNeuoeP91bwwExqIqNHDyxnZbz7SfZH5eov4m7G22CZX
X-Google-Smtp-Source: AGHT+IH2STS0bu4zAf1t0IYpd4Q7SMnOWSZ0Se/Bv64eN2fQ7cFk8qpFZdVkUwWmjdJiMdKIGOskpQ==
X-Received: by 2002:a05:6102:8083:b0:5db:3bbf:8e62 with SMTP id ada2fe7eead31-5e82748aa6dmr3893946137.1.1765874134673;
        Tue, 16 Dec 2025 00:35:34 -0800 (PST)
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com. [209.85.222.50])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-93f5ace659asm5660539241.5.2025.12.16.00.35.34
        for <linux-tip-commits@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Dec 2025 00:35:34 -0800 (PST)
Received: by mail-ua1-f50.google.com with SMTP id a1e0cc1a2514c-93f5905e698so1028454241.0
        for <linux-tip-commits@vger.kernel.org>; Tue, 16 Dec 2025 00:35:34 -0800 (PST)
X-Received: by 2002:a05:6102:54aa:b0:5db:c9cd:673f with SMTP id
 ada2fe7eead31-5e8277bb861mr3642915137.26.1765874133843; Tue, 16 Dec 2025
 00:35:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251201112933.488801-5-cosmin-gabriel.tanislav.xa@renesas.com> <176583521910.510.16822991242218719932.tip-bot2@tip-bot2>
In-Reply-To: <176583521910.510.16822991242218719932.tip-bot2@tip-bot2>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 16 Dec 2025 09:35:23 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXVtpfKyT8ZbuL4LOvDyYAa_Oo_YNxTTj-B_5-kpsyekg@mail.gmail.com>
X-Gm-Features: AQt7F2onkNKHHn16tGXkBeeIY6vzzqyFZZdcP4ummSThRbDBMLYVvDY_iq0Wd6w
Message-ID: <CAMuHMdXVtpfKyT8ZbuL4LOvDyYAa_Oo_YNxTTj-B_5-kpsyekg@mail.gmail.com>
Subject: Re: [tip: irq/drivers] arm64: dts: renesas: r9a09g087: Add ICU support
To: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-tip-commits@vger.kernel.org, 
	Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>, x86@kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Thomas,

On Mon, 15 Dec 2025 at 22:47, tip-bot2 for Cosmin Tanislav
<tip-bot2@linutronix.de> wrote:
> The following commit has been merged into the irq/drivers branch of tip:
>
> Commit-ID:     97232dc43e83987e2c5fc2fb875b31c745ac9c01
> Gitweb:        https://git.kernel.org/tip/97232dc43e83987e2c5fc2fb875b31c745ac9c01
> Author:        Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
> AuthorDate:    Mon, 01 Dec 2025 13:29:33 +02:00
> Committer:     Thomas Gleixner <tglx@linutronix.de>
> CommitterDate: Mon, 15 Dec 2025 22:44:33 +01:00
>
> arm64: dts: renesas: r9a09g087: Add ICU support
>
> The Renesas RZ/N2H (R9A09G087) SoC has an Interrupt Controller (ICU) block
> that routes external interrupts to the GIC's SPIs, with the ability of
> level-translation, and can also produce software and aggregate error
> interrupts.
>
> Add support for it.
>
> Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Link: https://patch.msgid.link/20251201112933.488801-5-cosmin-gabriel.tanislav.xa@renesas.com

Please do not apply DTS patches to the irqchip tree, as this will cause
conflicts with the renesas-dts tree: subsequent patches referring to
the "icu" label depend on this patch.

Thank you for dropping this commit!

> --- a/arch/arm64/boot/dts/renesas/r9a09g087.dtsi
> +++ b/arch/arm64/boot/dts/renesas/r9a09g087.dtsi
> @@ -759,6 +759,79 @@
>                         #power-domain-cells = <0>;
>                 };
>
> +               icu: interrupt-controller@802a0000 {

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

