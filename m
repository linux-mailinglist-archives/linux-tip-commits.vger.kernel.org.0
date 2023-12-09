Return-Path: <linux-tip-commits+bounces-1-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED8F980B536
	for <lists+linux-tip-commits@lfdr.de>; Sat,  9 Dec 2023 17:24:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 299571C2081F
	for <lists+linux-tip-commits@lfdr.de>; Sat,  9 Dec 2023 16:24:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDC95171AF;
	Sat,  9 Dec 2023 16:24:25 +0000 (UTC)
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1918AD5B;
	Sat,  9 Dec 2023 08:24:23 -0800 (PST)
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-5d40c728fc4so22640567b3.1;
        Sat, 09 Dec 2023 08:24:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702139062; x=1702743862;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ftMXe68BPe7sn/wEG9nTEA4djliLUETYEQbnl5rzReQ=;
        b=DJow0Xo2uEs06Cl5yrTSatZzSq6kSNATCLZkA3lLOtP7yRC6zHRH4VEsQ3ECGublvS
         9hew/r9JGaPgZb0k8ch7frmkrQmhjgpdzPrxfqFY/T9mFC/6AJ3APnrpP7V55yOu9ldn
         s86nLuOsXrMY6j5k+Yp6/+qq9SEhQKY1c2QZZTye5XwKau7A6TUftmphBwHstI1vUaYg
         kxDIOJZkGmCODY9JrdVf0rv9e5yIkZ89efh2SoGKK06bXnk/SNrF6WPlYXs+6h+cdfI8
         xrYzULPoI/i08W4M1yKfDfzWrRnVCWsCA6YjTg4zjeh6R7991NpOPOg43fhxlQWkr7Mr
         +XVg==
X-Gm-Message-State: AOJu0YwfQhgB3SrjU6yVFkbpjGKxauF6NHuLWZNGdER0tbdcx4HWiP0I
	8SJ4k0CPxJmrfYZWcB4e19Xr8GCGvzsZ8Q==
X-Google-Smtp-Source: AGHT+IGiJ5UeZzU9kvUDP5lqVGRaLlcvLmVbIyfU20DuaxNCi2waXMER/WRdu4urWhf6MLITmg9JgQ==
X-Received: by 2002:a81:7102:0:b0:5d7:1940:3ef5 with SMTP id m2-20020a817102000000b005d719403ef5mr1536399ywc.38.1702139062166;
        Sat, 09 Dec 2023 08:24:22 -0800 (PST)
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com. [209.85.219.175])
        by smtp.gmail.com with ESMTPSA id fq13-20020a05690c350d00b005de8c10f283sm1341083ywb.102.2023.12.09.08.24.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 Dec 2023 08:24:21 -0800 (PST)
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-db54ec0c7b8so2692670276.0;
        Sat, 09 Dec 2023 08:24:21 -0800 (PST)
X-Received: by 2002:a25:b54:0:b0:db9:8492:c7ae with SMTP id
 81-20020a250b54000000b00db98492c7aemr1768008ybl.0.1702139061644; Sat, 09 Dec
 2023 08:24:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231120111820.87398-10-claudiu.beznea.uj@bp.renesas.com> <170207007858.398.5775493085982200914.tip-bot2@tip-bot2>
In-Reply-To: <170207007858.398.5775493085982200914.tip-bot2@tip-bot2>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Sat, 9 Dec 2023 17:24:10 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUgvP9x3eTcvAnxYtH-79Mfb585EJOBYOyev_w0xfCZEg@mail.gmail.com>
Message-ID: <CAMuHMdUgvP9x3eTcvAnxYtH-79Mfb585EJOBYOyev_w0xfCZEg@mail.gmail.com>
Subject: Re: [tip: irq/core] arm64: dts: renesas: r9108g045: Add IA55
 interrupt controller node
To: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-tip-commits@vger.kernel.org, 
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>, x86@kernel.org, 
	linux-kernel@vger.kernel.org, maz@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Thomas,

On Fri, Dec 8, 2023 at 10:16=E2=80=AFPM tip-bot2 for Claudiu Beznea
<tip-bot2@linutronix.de> wrote:
> The following commit has been merged into the irq/core branch of tip:
>
> Commit-ID:     8794f5c3d2299670d16b2fb1e6657f5f33c1518c
> Gitweb:        https://git.kernel.org/tip/8794f5c3d2299670d16b2fb1e6657f5=
f33c1518c
> Author:        Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> AuthorDate:    Mon, 20 Nov 2023 13:18:20 +02:00
> Committer:     Thomas Gleixner <tglx@linutronix.de>
> CommitterDate: Fri, 08 Dec 2023 22:06:35 +01:00
>
> arm64: dts: renesas: r9108g045: Add IA55 interrupt controller node

Please do not apply Renesas DTS patches to your tree without an
explicit ack.
Renesas DTS patches are intended to go in through the renesas-devel
and soc trees.

Thanks!

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

