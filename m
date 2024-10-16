Return-Path: <linux-tip-commits+bounces-2469-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C0B989A02AC
	for <lists+linux-tip-commits@lfdr.de>; Wed, 16 Oct 2024 09:35:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2CAD1C24481
	for <lists+linux-tip-commits@lfdr.de>; Wed, 16 Oct 2024 07:35:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A17418FC61;
	Wed, 16 Oct 2024 07:35:10 +0000 (UTC)
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7350433CE;
	Wed, 16 Oct 2024 07:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729064110; cv=none; b=OQuIKAout/E+fj7Wf2+G8dvKXfecanar41srqo+HzjHenwwBzD3p5VpyYmqpnHXcPI9MEd+4ukYrLM3WkG5j3+hEs1Za6Hrk/X0ytF46K4m3jNlReFBiUaK6fNmd6YF6pwZhmpc0XRT3IzQwIdKy5degzS2Tb/Vorr1FCn94Vgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729064110; c=relaxed/simple;
	bh=RmlOCU0LD+Zy7W9c/1tcj+LEr2FVQIbbuV9dw+Uv+dQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=srcxmnbQK+BrxZrQxeCxGq5Dv5MVT8igXKwEP6Gqz2VdaDKcK1XxjlP7Cjnq1P3YcVUjSwkffG8cKCJqj0Z9Z9ymNW8Jb1sSnoOlkROz+myNB72d4ySnYyFeYMJV4mwNQZaHVIKfw0jKnWvkDuADu5hJ1qS4uK/+LsQvKPrF+TM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e29267b4dc4so4231444276.0;
        Wed, 16 Oct 2024 00:35:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729064107; x=1729668907;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/QEFrE87QrYfukN9GRJXRVQgT6TniFvPYDzk8+Z0FuY=;
        b=SBK7MUSOC+7T6nTxZX/fCoF74vwG/1AX/K/hvIoGnLwdjqRPmP7m/pLJXUy/8mWszB
         RC83ZQZaIxBb0XXgNmGvSfwHXxrFAdFDIF+ivgcEMnSnHvpsg9aSm/8MDLaBB3w/z57Z
         fUMeGtM1FbcPgBT3FviZefMCiTo3CFifTJmBLrswt/HVZBa8DhnTAWBbRykCzfUoq9KA
         Fx5KL84Ruo8+ckK+S7LWknrNMJW+iJZGouKkoiehZF8bBCzUGhx2CU6yhHedBQSqmPM4
         7ERmDFH4BX2xwo1n83Sxil7rS9BDcReD1EQIo6t+hh4E7olFYkBcrNxN6DoUrifXQf4D
         6ATg==
X-Forwarded-Encrypted: i=1; AJvYcCX4xVOXA/9xjMlBHSSpQfuE4bZAngoeYQP8PAPlLyQxyAS4w9oMW0Hpzc+eOxOh1UcqZQHFVr/OVS51pJY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5dO3/jnv/ObQ24xFEB7qFbdcs2PXZ59O8qj0+uwWh3kNTs63P
	+Rmr327VVTw3W5++qO1WHjjz3U5VShA9sPzVZIgE8E73BX5uBVopuw/77N8l
X-Google-Smtp-Source: AGHT+IHJYx8T9ce3Pf2LzWy8/7jjRdcN85q45rDbgF5HfrHbRO5ZYptii7PlGiEvuFNmYRS7sJRtcA==
X-Received: by 2002:a05:6902:1ac1:b0:e24:a040:755c with SMTP id 3f1490d57ef6-e2931b645a8mr11001537276.34.1729064107167;
        Wed, 16 Oct 2024 00:35:07 -0700 (PDT)
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com. [209.85.128.174])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e296cc1f09asm510155276.31.2024.10.16.00.35.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Oct 2024 00:35:06 -0700 (PDT)
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-6e214c3d045so46580297b3.0;
        Wed, 16 Oct 2024 00:35:06 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUEyalAJtzGbkc9WaiUTtZ3PxLKHlBvEWTVfAUkfIs5Flq12YZjQWOibQcjOTSJAY3rC/qtTGI9B+TDKio=@vger.kernel.org
X-Received: by 2002:a05:690c:83:b0:6e2:313a:a01e with SMTP id
 00721157ae682-6e3643a5fa5mr124666197b3.32.1729064106281; Wed, 16 Oct 2024
 00:35:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241009230817.798582-4-fabrizio.castro.jz@renesas.com> <172903035374.1442.2455615035848114832.tip-bot2@tip-bot2>
In-Reply-To: <172903035374.1442.2455615035848114832.tip-bot2@tip-bot2>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 16 Oct 2024 09:34:54 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXvvSXbCBywfxqhHU1P6MVADdJ05VY9xe2V5TfCS=Q2rA@mail.gmail.com>
Message-ID: <CAMuHMdXvvSXbCBywfxqhHU1P6MVADdJ05VY9xe2V5TfCS=Q2rA@mail.gmail.com>
Subject: Re: [tip: irq/core] arm64: dts: renesas: r9a09g057: Add ICU node
To: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-tip-commits@vger.kernel.org, 
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, x86@kernel.org, linux-kernel@vger.kernel.org, 
	maz@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Thomas,

On Wed, Oct 16, 2024 at 12:12=E2=80=AFAM tip-bot2 for Fabrizio Castro
<tip-bot2@linutronix.de> wrote:
> The following commit has been merged into the irq/core branch of tip:
>
> Commit-ID:     7607e62525b7f176db4d8115b264e3206c84d6ee
> Gitweb:        https://git.kernel.org/tip/7607e62525b7f176db4d8115b264e32=
06c84d6ee
> Author:        Fabrizio Castro <fabrizio.castro.jz@renesas.com>
> AuthorDate:    Thu, 10 Oct 2024 00:08:17 +01:00
> Committer:     Thomas Gleixner <tglx@linutronix.de>
> CommitterDate: Wed, 16 Oct 2024 00:01:07 +02:00
>
> arm64: dts: renesas: r9a09g057: Add ICU node
>
> Add node for the Interrupt Control Unit IP found on the Renesas
> RZ/V2H(P) SoC, and modify the pinctrl node as its interrupt parent
> is the ICU node.
>
> Signed-off-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Link: https://lore.kernel.org/all/20241009230817.798582-4-fabrizio.castro=
.jz@renesas.com
>
> ---
>  arch/arm64/boot/dts/renesas/r9a09g057.dtsi | 90 +++++++++++++++++++++-

FTR, usually Renesas DTS patches go in through the Renesas and SoC
trees, to avoid conflicts and unmet dependencies.
However, if no further references to the  "icu" node are to be made
in this cycle, queueing it in the tip tree is fine.

Thanks!

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

