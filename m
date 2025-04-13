Return-Path: <linux-tip-commits+bounces-4947-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 357C7A8737C
	for <lists+linux-tip-commits@lfdr.de>; Sun, 13 Apr 2025 21:15:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 279C216E363
	for <lists+linux-tip-commits@lfdr.de>; Sun, 13 Apr 2025 19:15:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D97E1F37D4;
	Sun, 13 Apr 2025 19:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IjU4m2lg"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4680413B797;
	Sun, 13 Apr 2025 19:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744571707; cv=none; b=ru/zU4/GZXK0HKA5JAFgDP4M8KouOQaM3McY8h8Bf86eyK1L4saX88CINrNCFl+LL+Ap29Pp5l3OBpW0E6pHSiEaDGHI9Tw+yFMGxbc6VqOk76UuNB88OWJn+yEC1wV8/Br2QidYO+/Jb4g41Ks+kW+a8lPvNyBdtfovw8veATA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744571707; c=relaxed/simple;
	bh=KjjMpi6J03nK1WjILmY3OQ3wjSjjqoByRSWubExX/UI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jL2QdkaYsXu0FjGAyu9/9XmFOM+l+4AxEhCgeFSgJ4mFGQOxnOwUvvHSB+HFnzLesAB7dFu8wFBxRkWIJJj9LcplNiEVOFTYdk2slujEcbMDaJ7VmAqpzyJFuYnN++dniO8f3plvpDxJ88PSn9kqf+A7JGJyl+kS+aOtRMczPzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IjU4m2lg; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-30beedb99c9so32376351fa.3;
        Sun, 13 Apr 2025 12:15:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744571703; x=1745176503; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vmKq3xpHPXNUFt7rqGHQXR/B6BEh35GMMQihkbDJYrs=;
        b=IjU4m2lgZzPUkaARgINHHSZVGGJY/KKI3KylCNq1msFrLHvfSnjI0vgJmD3ACZP/md
         FRsb7U0KU5Bx0J06m8MNtO5VcOlQsrMrPgE8SJ0UmrpB/C5BJLRukxnHvXGMVxKeRs21
         V966oh9+DJj6sE1cA4uuXvVWA22IO8J8jme8gn6BM/l1kFyGY0eVBJwEw7Ll4pT+8c2W
         a3aMFdo+KUMyhor8+04KZv4Z3NC2ASmaDuTTfRmHEjYAhQLXMTOcgkYutK/OsNnUH7YN
         MxWiethzsJLLfbWR50WIX++q1P7nQPSyxehiTmLZPwTDy8d1OHjkjUJO15cBR+ecoSka
         d/XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744571703; x=1745176503;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vmKq3xpHPXNUFt7rqGHQXR/B6BEh35GMMQihkbDJYrs=;
        b=llwmskZoKRIT/HBNsLvQjIL61TxSZ9d/v1kKN+TvL5EV9mBRGuB1mRO7Z/OP2m+HVQ
         bqxtKyCd9kjxYQn4nFtpng1WD6/BMEdRLkGCyVtxQ22o611SvBf/kxKfxOwBVghGWawm
         XNoqYFqVGzxP6OGg44RWxE6k3Xm68b2z+CD3IuczkndoYJWj9yEsThKcsXjMFvPhl5cb
         t5ZUupGZ8LKW/HXeAcR5NFfCIv2IezDmrJ7iRU2dVTgkieJZdVUD2e1qHqXrOlqMT5e0
         pbtRouwP408NQWpnBMDhZqC/m7k70HeM4tP/79ize38zcV5VpLN59xrYltTJ6H6VErzE
         mR0Q==
X-Forwarded-Encrypted: i=1; AJvYcCWPh6URVZ5R4t4RkADVCDbZIl+zkZZAXT0i+XULEouJBKgASctT0GC6lunyXB9b3s6n9UecCc5rkGycO5I=@vger.kernel.org, AJvYcCWpeuDy398bjyqTPwb+mEAbRcAZJB+MHdqFeEE7Cs3eYvGPhYqE67gzAkM4+UpcZRpvvK5ivLqjkQujBzMv8k8WvSU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/7odFLmIsATU1oISaf5pjrqlf+uqr+pKljOyW5pWQd9TCwmGl
	KekZrYAqXRfhJl+WPPyfBnuuLCRJxIaq8kXqUY8mvYau5C1fnrtH2oGVTVYwUlidS4FTUX7QVpe
	nqvobFQ9c4SEzHVgJVPKvzi6w2Ck=
X-Gm-Gg: ASbGnctUYFip93FD0TIedMS2EHqLBdbyliKXBhz48CbInB4OAMYQH3bYtBlUDdzYVPC
	uf7+O7UJRQhEL3LwK8H9c4AVh0PRhfJKam9AWsvjuXV4CoXS2wUP1aHg8lX4Nw967al3k5/xrza
	2inhvHWZwr51xhnyXfYWZkCw==
X-Google-Smtp-Source: AGHT+IFr3TeqkzVWuRiZtu9xjYpcTJEdaa+lZx+GFRfKPeYh40Cp+avV8LYZthRUallYwiIjIVVj9HC6L9IQ1mSDdV8=
X-Received: by 2002:a05:651c:1545:b0:30b:c3ce:ea1f with SMTP id
 38308e7fff4ca-310499fbc07mr25452381fa.15.1744571703056; Sun, 13 Apr 2025
 12:15:03 -0700 (PDT)
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
 <Z_wI0uNoG2G2TQMC@gmail.com>
In-Reply-To: <Z_wI0uNoG2G2TQMC@gmail.com>
From: Uros Bizjak <ubizjak@gmail.com>
Date: Sun, 13 Apr 2025 21:14:51 +0200
X-Gm-Features: ATxdqUH6GkkG2QNWIiBcMACJGEzQp-J92_Zv1yKOb6xNPUgXURNSmQpqDR3N3WY
Message-ID: <CAFULd4b2afcu5PnxhqwwepwWMSA7mvYNyPnMtkCjjT84VG8VXA@mail.gmail.com>
Subject: Re: [tip: core/urgent] compiler.h: Avoid the usage of
 __typeof_unqual__() when __GENKSYMS__ is defined
To: Ingo Molnar <mingo@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Borislav Petkov <bp@alien8.de>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, 
	linux-tip-commits@vger.kernel.org, Paul Menzel <pmenzel@molgen.mpg.de>, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 13, 2025 at 8:56=E2=80=AFPM Ingo Molnar <mingo@kernel.org> wrot=
e:
>
>
> * Uros Bizjak <ubizjak@gmail.com> wrote:
>
> > On Sun, Apr 13, 2025 at 10:55=E2=80=AFAM Ingo Molnar <mingo@kernel.org>=
 wrote:
> > >
> > >
> > > * Uros Bizjak <ubizjak@gmail.com> wrote:
> > >
> > > > > Yeah, agreed, I've removed this workaround from tip:core/urgent f=
or
> > > > > the time being - it's not like genksyms is some magic external
> > > > > entity we have to work around, it's an in-kernel tool that can be
> > > > > fixed/enhanced in scripts/genksyms/.
> > > >
> > > > Please note that you will disable a check that is finally able to
> > > > fail the build for a whole class of very subtle percpu bugs.
> > >
> > > I simply zapped a commit that was applied two days ago and asked akpm
> > > to resolve a regression that was introduced upstream via his tree
> > > through this commit, in this merge window:
> > >
> > >   ac053946f5c4 ("compiler.h: introduce TYPEOF_UNQUAL() macro")
> > >
> > > What 'disabled checks' are you talking about?
> >
> > Percpu checks require TYPEOF_UNQUAL() macro, so removing
> > USE_TYPEOF_UNQUAL definition
>
> I did nothing to remove the USE_TYPEOF_UNQUAL definition, did I?

So ... let's slow the ball down a bit. The patch I'm worried about is [1]:

-#if CC_HAS_TYPEOF_UNQUAL && !defined(__CHECKER__)
-# define USE_TYPEOF_UNQUAL 1
-#endif
+#undef USE_TYPEOF_UNQUAL

[1] https://lore.kernel.org/lkml/20250411210815.GAZ_mEv8riLWzvERYY@renoirsk=
y.local/

and in [2] my proposed patch is commented as:

--q--
> So mingo is right - this is not really a fix but a brown-paper bag of
> sorts.

Yeah, agreed, I've removed this workaround from tip:core/urgent for the
time being - it's not like genksyms is some magic external entity we
have to work around, it's an in-kernel tool that can be fixed/enhanced
in scripts/genksyms/.

Maybe akpm can merge this or some other fix and sort it out? AFAICS the
bug came in via the -mm tree in January, via:

  ac053946f5c4 ("compiler.h: introduce TYPEOF_UNQUAL() macro")
--/q--

[2] https://lore.kernel.org/lkml/Z_oqalk92C4G6Rqt@gmail.com/

> > [...] will skip the definition of __percpu_qual in
> > arch/x86/include/asm/percpu.h (please see
> > 6a367577153acd9b432a5340fb10891eeb7e10f1), and consequently __percpu
> > macro won't be defined with __seg_gs (please see
> > 6cea5ae714ba47ea4807d15903baca9857a450e6).
> >
> > If this commit is removed, [...]
>
> I did not remove commit ac053946f5c4, it's already upstream. Nor did I
> advocate for it to be reverted - I'd like it to be fixed. So you are
> barking up the wrong tree.

If the intention is to pass my proposed workaround via Andrew's tree,
then I'm happy to bark up the wrong tree, but from the referred
message trail, I didn't get the clear decision about the patch, and
neither am sure which patch "brown paper bag bug" refers to.

Thanks,
Uros.

