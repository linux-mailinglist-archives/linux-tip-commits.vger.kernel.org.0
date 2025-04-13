Return-Path: <linux-tip-commits+bounces-4951-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6A5CA8738D
	for <lists+linux-tip-commits@lfdr.de>; Sun, 13 Apr 2025 21:28:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84C023B3994
	for <lists+linux-tip-commits@lfdr.de>; Sun, 13 Apr 2025 19:28:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E110E17A2F3;
	Sun, 13 Apr 2025 19:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dEHbO5df"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23D2E39FCE;
	Sun, 13 Apr 2025 19:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744572499; cv=none; b=Y6r1Kx8ZWaIPxun8WGHkzIrMNg4hyzFPZ+4WXVE6FZ0oZmion8rAAAxBU1npUiSzy1L5dvh1M824SlSLaoKMjOsKGwP75VYVtSIWWMuJQYIXEiH2DvR7ft/5XMSSNa1JVqcPLfY5u4u48kmiK+eWm7YqhgvSfOJfjAWhBgAY94M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744572499; c=relaxed/simple;
	bh=7ofykAOqGSRqH4kNnIiNVbQCglWqmrnR4sc5rARRk1s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZmboDTnKx9hRp3wJvDbLqib13x9P2h+tH9Lhxu2XXxkWODaB+418h1dMrrbs0HsBa9fMEJ2bXslVX5hryIYSrBaepmpNIv2LROX7WI5UAqMRrAZDOJgviAOlphOTdnPY1WYEjONGxSG0L8Hsq67dOg8T1a4Ny8isqMsCRvm/myc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dEHbO5df; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-3105ef2a08dso7626541fa.0;
        Sun, 13 Apr 2025 12:28:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744572495; x=1745177295; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7ofykAOqGSRqH4kNnIiNVbQCglWqmrnR4sc5rARRk1s=;
        b=dEHbO5dfoSwQgAmt82RXN0afQiXiwf6bd40dTmacowQidS9PW51ZaO/qmEl1Gk6snq
         oa+oH/5Lli9v0wQ7qEsMrocVH4B9dCpIuOgfMJIGo1NG00fv2jm2irTJ+YHynX4LMKj/
         L0i4MbN+bs1LtnqYkR8V5eAE7bTx/nrKw12Nrg6zp1dAdQUlIt2+ConPD3MtSnoBbHAF
         hFo5YVGIVAOw10s9kJaBuw6tDBeSaHqnjFREsVNsxFEFtmQwjJUR0C9SP27aGf+Xmxky
         QgRKELwPVTT/j5eiEGwMrbsYXDGTTF3JQRHtiZNwsGxaOuMYw7UxZ295562mm54kN2ex
         1Ybg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744572495; x=1745177295;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7ofykAOqGSRqH4kNnIiNVbQCglWqmrnR4sc5rARRk1s=;
        b=ngc6Bq7LU6X8WZoTFvjxwHD0opRbNY9UmK4ro+F2Ml4NSRzdarOtr0dEYwb5y89nUb
         SPXw7oA/C72PkMnuZkJbQ+GS3L7WlOUvLCF1AV8k+sgpjjqf84/MrOF2ZQUFTE/f3hbj
         8PsLUdfcreB4c3ZhrjADbJky3J5/6PcWCBOPk+WaEMmuvxpyUgpRgoheAzHNA1hTIsjK
         tBFlCMar5B+0+PQqQGQC8vVoRbJIfwpdcXoSazo3NNq0ZYZ4WDVaWBK0jay57wSG/dnT
         DbSBF2HAPrz0lcwCf/dS8sVDoAN22KaL45mnu3y7cbL0lFzLdMitalsl5SfOQQcyFASp
         50rw==
X-Forwarded-Encrypted: i=1; AJvYcCUaKKTpyveBxlpztCyYdYWIJhdi7lZSD98KK9smf8xbWVbCinmi4b9qVFH9hAwxbmDm9a5IxuDbw00wrWHn+2ZcsK4=@vger.kernel.org, AJvYcCXCxCdj2/ITQ095hqfYSk8LeYFK1GfId4zhKpel3aZz2+HekzQhTza6xRPO4RiFGCeLlkJPUWpifwtz/sI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyROeUc9RWLDY/coI25W+E/uZOnWWzBB3t+sgd+WOswtrds40GX
	3U8OyhY0dHev7Vhxx167T7XLFUKzOGvlESuscy6PO3RYzDmDM6r1tClGqu8X08iCHt+ZWkLE0M8
	NK/zfUmbpkZYG6Cxc0yEqbOKAZNI=
X-Gm-Gg: ASbGnctufhSHSGDnP02BiPAm+JUKoYddiYUNwXmDaMRGOzubS4YAmDPrYCTGNWmpvb6
	PJkvaUAOLfcGaaUD2s8seKaPXtDdunsov8raxLBbctEBIvFWvSHy8Sb6xirvDZ5A/A1WfvZ/v6z
	CxoJaHOiPJEM7E+YpyAz3erA==
X-Google-Smtp-Source: AGHT+IGddTLuKOZhWx0PtOGeAp++RXlS+0WoN4i9L7nMyvBxOinFQjeB8iUnC3IxpX7CDsvskKgQTNlh293ER0aWVcQ=
X-Received: by 2002:a2e:bd0a:0:b0:30d:b8a5:9b8d with SMTP id
 38308e7fff4ca-310499dff19mr29927831fa.16.1744572494983; Sun, 13 Apr 2025
 12:28:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250404102535.705090-1-ubizjak@gmail.com> <174428272631.31282.1484467383146370221.tip-bot2@tip-bot2>
 <20250411210815.GAZ_mEv8riLWzvERYY@renoirsky.local> <Z_oqalk92C4G6Rqt@gmail.com>
 <CAFULd4bTd6GMftLBX7Nu0xftini00o4v7=1XfuoDC8ydUr9Ueg@mail.gmail.com>
 <Z_t7_brzSoboOsen@gmail.com> <CAFULd4ZBbAG4ndn+rzjjqF+pmtGa3UbyDOWfEXww0XhExJByVA@mail.gmail.com>
 <Z_wI0uNoG2G2TQMC@gmail.com> <CAFULd4b2afcu5PnxhqwwepwWMSA7mvYNyPnMtkCjjT84VG8VXA@mail.gmail.com>
 <Z_wOYOrVJJkUUUF9@gmail.com>
In-Reply-To: <Z_wOYOrVJJkUUUF9@gmail.com>
From: Uros Bizjak <ubizjak@gmail.com>
Date: Sun, 13 Apr 2025 21:28:03 +0200
X-Gm-Features: ATxdqUFV5mm-CzIYsB0nDnzVNhCXrfvZzdg8F8ygjd0krCHhMKYqdCf4S8XzdK8
Message-ID: <CAFULd4ZRTfZggPp395Y-ZJ6DkHFdorvjX-MiFHxR40UGU+3rSQ@mail.gmail.com>
Subject: Re: [tip: core/urgent] compiler.h: Avoid the usage of
 __typeof_unqual__() when __GENKSYMS__ is defined
To: Ingo Molnar <mingo@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Borislav Petkov <bp@alien8.de>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, 
	linux-tip-commits@vger.kernel.org, Paul Menzel <pmenzel@molgen.mpg.de>, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 13, 2025 at 9:20=E2=80=AFPM Ingo Molnar <mingo@kernel.org> wrot=
e:
>
>
> * Uros Bizjak <ubizjak@gmail.com> wrote:
>
> > > > If this commit is removed, [...]
> > >
> > > I did not remove commit ac053946f5c4, it's already upstream. Nor
> > > did I advocate for it to be reverted - I'd like it to be fixed. So
> > > you are barking up the wrong tree.
> >
> > If the intention is to pass my proposed workaround via Andrew's tree,
> > then I'm happy to bark up the wrong tree, but from the referred
> > message trail, I didn't get the clear decision about the patch, and
> > neither am sure which patch "brown paper bag bug" refers to.
>
> It's up to akpm (he merged your original patch that regressed), but I
> think scripts/genksyms/ should be fixed instead of worked around -
> which is why I zapped the workaround.

As said earlier, I have tried to fix genksyms, but the simple fix was
not enough. The correct fix would be somehow more involved, and I have
zero experience in genksyms source. I'm afraid I don't know this
source well enough to offer a fix in the foreseeable future, so I
resorted to the workaround (which at the end of the day is as
effective as the real fix).

Regards,
Uros.

