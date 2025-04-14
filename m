Return-Path: <linux-tip-commits+bounces-4977-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D0E03A8857E
	for <lists+linux-tip-commits@lfdr.de>; Mon, 14 Apr 2025 16:45:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF05B3BAEA5
	for <lists+linux-tip-commits@lfdr.de>; Mon, 14 Apr 2025 14:31:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E238A275875;
	Mon, 14 Apr 2025 14:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DbPeaO5Z"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA0CD275872;
	Mon, 14 Apr 2025 14:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744639687; cv=none; b=YNk3KORgqyQRkI4VKR/hMhdcuChvEMUFRAyCFi2Q2QYWdPXpyARFwrZ5yaSjLBeJns1KmVe9JQ9xAMJ180RqvF8VVqRS+vb8dquVOGjIbnH/6jC7BvTYjdgBuTkLpyeLVRPwaaJSl508666LFTdvQ+8Ume1jO3G8P8aI7VOzPRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744639687; c=relaxed/simple;
	bh=mVXzleBwN6nd3/QYvohoX7roWf9FNuTbGS5M9TLycpk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LXmPGSlHSTyn2Idy7j4wHAesTN44GtzKmaqPlXz0BR0L+kwu/fNwZqRAVm522d5JECGeCJlZfXN+GcGZ7mTBT+5R66tHn0lrlpZs/sJm4mylhZj3N3W8lHqVcfOd6Car5i2SJO7DIcS5tVLp6eSMFcew/WmnXslevS7Rbw6V1t4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DbPeaO5Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34025C4CEEC;
	Mon, 14 Apr 2025 14:08:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744639686;
	bh=mVXzleBwN6nd3/QYvohoX7roWf9FNuTbGS5M9TLycpk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=DbPeaO5ZoqkJ1jfouO54WoEKYhMXO097iZVfHM9OAExjdgxIw6VvawjGvGcyhvHAa
	 cuy8htl6Rzbsot5d//ECHIM4Lou6UqWtjuacIlvg2iYIgRnsocEc1WbsZg11uEFuvT
	 RIh3GlvAH/DJfpNJzInBPAiBiHTDc+3vdlLM5ZmIKVUs/Eg2BO/8e0L0H/DOBd+UFD
	 UsrgD+W6HGCpQcM9zBDFX3M0UUphfNpxzuDXLb5HqE7Wqxv1ccNuS5P2QN7IfiwCvg
	 OwioZ2HRbPIZnbcFKegTjAWwcnmctgG6XoQqzecQEvsG+R8u1604gyNK5F1pcWimnc
	 quE4Uh1RrjACg==
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-30bf1d48843so37686511fa.2;
        Mon, 14 Apr 2025 07:08:06 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVPwuhFoIPJDz5yxeuZpDy71ZUgz0QMpSrbH/B/DsMED+C9u2zBSE5p/v9SzgEq/l7ZRsI4zHJ2orsV4sA/Cksxyw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxSe+BYqUdhdsTU4iQ6/+iRn+O0NJH5zVTRTBkpavB+bZ0e14UB
	SeSkBCstWomJO1x4ZZ79kF112rdhIT4WBxvrg3EEDbvDUjH+K8a2J4f7d2dZCiUeyAyzEm2cPcb
	dLswJfvBSzbPqIcFpJ4J+ZAPavEo=
X-Google-Smtp-Source: AGHT+IH7OxxyR4h0JXlxMB261wcukiaE7crk6AYDbA7texG5N3I/4SXNBYa9M3wsoguijYWfl4ITZaWruFCMeK3zDYQ=
X-Received: by 2002:a2e:bd0d:0:b0:30b:ed8c:b1e7 with SMTP id
 38308e7fff4ca-31049a1ae20mr37817911fa.18.1744639684477; Mon, 14 Apr 2025
 07:08:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250312081204.521411-2-ardb+git@google.com> <174178137443.14745.10057090473999621829.tip-bot2@tip-bot2>
 <20250414135625.GDZ_0UCcIQ-fg8DKZL@fat_crate.local>
In-Reply-To: <20250414135625.GDZ_0UCcIQ-fg8DKZL@fat_crate.local>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Mon, 14 Apr 2025 16:07:53 +0200
X-Gmail-Original-Message-ID: <CAMj1kXEWerW9A7t0njN7hM7Ms48+mE94p3CTv_LP9P-CotOtPg@mail.gmail.com>
X-Gm-Features: ATxdqUG3OaCZJqQnkJUtiKvQtfxuI5gqHG06Tz27A8Eu6AmJzJx6B3m7X-DaUdM
Message-ID: <CAMj1kXEWerW9A7t0njN7hM7Ms48+mE94p3CTv_LP9P-CotOtPg@mail.gmail.com>
Subject: Re: [tip: x86/build] x86/boot: Add back some padding for the CRC-32 checksum
To: Borislav Petkov <bp@alien8.de>
Cc: linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@kernel.org>, Ian Campbell <ijc@hellion.org.uk>, 
	Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 14 Apr 2025 at 15:56, Borislav Petkov <bp@alien8.de> wrote:
>
> On Wed, Mar 12, 2025 at 12:09:34PM -0000, tip-bot2 for Ard Biesheuvel wrote:
> > The following commit has been merged into the x86/build branch of tip:
> >
> > Commit-ID:     e471a86a8c523eccdfd1c4745ed7ac7cbdcc1f3f
> > Gitweb:        https://git.kernel.org/tip/e471a86a8c523eccdfd1c4745ed7ac7cbdcc1f3f
> > Author:        Ard Biesheuvel <ardb@kernel.org>
> > AuthorDate:    Wed, 12 Mar 2025 09:12:05 +01:00
> > Committer:     Ingo Molnar <mingo@kernel.org>
> > CommitterDate: Wed, 12 Mar 2025 13:04:52 +01:00
> >
> > x86/boot: Add back some padding for the CRC-32 checksum
> >
> > Even though no uses of the bzImage CRC-32 checksum are known, ensure
> > that the last 4 bytes of the image are unused zero bytes, so that the
> > checksum can be generated post-build if needed.
>
> Sounds like it is not needed and sounds like we should whack this thing no?
>
> Or are we doing a grace period and then whack it when that grace period
> expires?
>

This was done on hpa's request - maybe he has a duration in mind for
this grace period?

