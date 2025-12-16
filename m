Return-Path: <linux-tip-commits+bounces-7725-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 02680CC1978
	for <lists+linux-tip-commits@lfdr.de>; Tue, 16 Dec 2025 09:35:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6F409302283D
	for <lists+linux-tip-commits@lfdr.de>; Tue, 16 Dec 2025 08:34:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CE8C3126D8;
	Tue, 16 Dec 2025 08:34:52 +0000 (UTC)
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DF312EBDD9
	for <linux-tip-commits@vger.kernel.org>; Tue, 16 Dec 2025 08:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765874089; cv=none; b=aCcTLvhuyGvoly057aegS1lLBUNWrbKK/VXpFUm/9uL4kReiYheZcdYirppM7ts82h1zZsruC7N9jXMTTpjmvK4rv/MOpWzvkuM3oo+GVGh1jlHqoFxf4NRfzReC3j7eFC7DIuawdZI6u3kmClX5oNGpfFqsXj11H75/HENxUvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765874089; c=relaxed/simple;
	bh=uVDy/u6R2fBDcB56KleNKWYpdwkJVuyXm9qJkbDwqMw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PEXVzVk1/nbAXNwszQYfUS5nBH/VEiaQaCzdXLHFgiBOYz3M42aCCsaZd6QvWLgb0CawZgZlnxthW7nw6ItEWhQngk+JRzoxTgnINUxejKs7dXVzN7rnMB4CxlymOfLYfx27fh7CNTD7T5mrZqi6PEem0/1Fv1t5gE/60ME12Lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-56021f809acso77213e0c.0
        for <linux-tip-commits@vger.kernel.org>; Tue, 16 Dec 2025 00:34:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765874075; x=1766478875;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8NqCDo+V8567XBDiswOeiMp3rI6eH2vb0e+Twt1SNuM=;
        b=JBVp0lNW/Ds6REXTezj7yKvTx4xIF0rexd0GEAtLQpujpJDpwrYJ/0Pvf+VgGRdZQV
         aQYJf+Fpn5NDWi3pccFsfDD4sFCUCkG3CzPQU32qBaruxRlaAJMUXOJnPtAskBKYbtyr
         hGTrkF61r+dwOTbqeYs4+x7ITqedixJ5DGNySJaKmvn/Nrpk29CMI+fAIuRd4Jrk1Qui
         9us2ICs/klP0mxEuu3Ej9meHX77mOwmQxp/EGDuYDQyuj7oNR4XGid4+o3QJAW8aSN3N
         t3s4VCXoc+YeDa4/l2/zd4mntVFUuOE39XcFhXq0EbKliaKV28JIJaAxt9E7lpNHsGP8
         W7vA==
X-Gm-Message-State: AOJu0YyeeaULq9ePzcQ4L4UQ0QtTOal4Hv2CzDVFdz3yE11ItbmT6+tn
	NToa5fFkXS5cKfOoyhpyogr8GASHfjNHbBu9lrNGf3ZCXlORdqMbNfysonHq9AeR
X-Gm-Gg: AY/fxX54RZHh0Jmc4ndSbhy5jgcif8QxqDDEzBP19jBUhE13i7fjRrZbfrC9JAjcBaX
	IZILCImgi3Pl0s6EkuTAcfvVWMTgyp13dVVb+HLJVpINhJBL9HfDujK2iGkcfrOqpJrKZz+OIIo
	LsGssP9kng2ooCdVDE4FcxIpJVh9XFvG39tP1t5h1632I4MkUbsV1VPGrRORgMYvJagBcp5UW5o
	8mpD0/1hI61rop6LeidXgSNAJvLFAK+RIyZYOknlTCWqtPCfpXJaFad178InxvaNIaCzu2zpP0/
	tW/KJ3BZt2/uIqRUl+wt9OzVIBodffyuG+9luFL54vLbNg0GZj8fMJznEmNmfC4+cfK2N8HI1Tz
	nYexqzJKJv4X2RRpXfJWiDChGZaQT4UyqvACEIgCi/XSl0uFkiiMy2s/xvMVLDsO2lBEfuVBe5W
	wkj9Rok2OqaAmoqEx+Z0StrEopVvpsa2VZ6E/5RqyXbNuEmHecEzu+
X-Google-Smtp-Source: AGHT+IGHQ8srIDxnU7a+9fB7ebP0hng2vVTmZ+nmdMXHD+3Jm1NcUGRQ+RzZZ9SIrI5Ffjs9mv/bNA==
X-Received: by 2002:a05:6122:208d:b0:55b:9bee:ff61 with SMTP id 71dfb90a1353d-55fed6389c2mr3881581e0c.16.1765874075501;
        Tue, 16 Dec 2025 00:34:35 -0800 (PST)
Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com. [209.85.221.177])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-55fdc616500sm7458775e0c.6.2025.12.16.00.34.34
        for <linux-tip-commits@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Dec 2025 00:34:35 -0800 (PST)
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-55b22d3b39fso1081961e0c.2
        for <linux-tip-commits@vger.kernel.org>; Tue, 16 Dec 2025 00:34:34 -0800 (PST)
X-Received: by 2002:a05:6102:5345:b0:5de:31b1:2011 with SMTP id
 ada2fe7eead31-5e8276a37c7mr4184206137.17.1765874074529; Tue, 16 Dec 2025
 00:34:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251201112933.488801-4-cosmin-gabriel.tanislav.xa@renesas.com> <176583522037.510.2787917344082896454.tip-bot2@tip-bot2>
In-Reply-To: <176583522037.510.2787917344082896454.tip-bot2@tip-bot2>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 16 Dec 2025 09:34:21 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVk3-u_RqR3rU0xA-Juv9-JTWKf5dNafPQn+7NCodQoMg@mail.gmail.com>
X-Gm-Features: AQt7F2o1XXr_n4PQkW8WrK6mxywIdD1O2DwEx5MDMTtY5LiSVP5-AkaztEdFg9s
Message-ID: <CAMuHMdVk3-u_RqR3rU0xA-Juv9-JTWKf5dNafPQn+7NCodQoMg@mail.gmail.com>
Subject: Re: [tip: irq/drivers] arm64: dts: renesas: r9a09g077: Add ICU support
To: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-tip-commits@vger.kernel.org, 
	Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>, x86@kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Thomas,

On Mon, 15 Dec 2025 at 22:53, tip-bot2 for Cosmin Tanislav
<tip-bot2@linutronix.de> wrote:
> The following commit has been merged into the irq/drivers branch of tip:
>
> Commit-ID:     9b1138aef9a254dfc3412673a2dccfcd7f54c844
> Gitweb:        https://git.kernel.org/tip/9b1138aef9a254dfc3412673a2dccfcd7f54c844
> Author:        Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
> AuthorDate:    Mon, 01 Dec 2025 13:29:32 +02:00
> Committer:     Thomas Gleixner <tglx@linutronix.de>
> CommitterDate: Mon, 15 Dec 2025 22:44:32 +01:00
>
> arm64: dts: renesas: r9a09g077: Add ICU support
>
> The Renesas RZ/T2H (R9A09G077) SoC has an Interrupt Controller (ICU) block
> that routes external interrupts to the GIC's SPIs, with the ability of
> level-translation, and can also produce software and aggregate error
> interrupts.
>
> Add support for it.
>
> Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Link: https://patch.msgid.link/20251201112933.488801-4-cosmin-gabriel.tanislav.xa@renesas.com

Please do not apply DTS patches to the irqchip tree, as this will cause
conflicts with the renesas-dts tree: subsequent patches referring to
the "icu" label depend on this patch.

Thank you for dropping this commit!

> --- a/arch/arm64/boot/dts/renesas/r9a09g077.dtsi
> +++ b/arch/arm64/boot/dts/renesas/r9a09g077.dtsi
> @@ -756,6 +756,79 @@
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

