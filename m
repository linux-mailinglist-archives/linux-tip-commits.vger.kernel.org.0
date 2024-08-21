Return-Path: <linux-tip-commits+bounces-2090-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7522B959786
	for <lists+linux-tip-commits@lfdr.de>; Wed, 21 Aug 2024 12:13:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 04602B20C5D
	for <lists+linux-tip-commits@lfdr.de>; Wed, 21 Aug 2024 10:13:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 834C116DC01;
	Wed, 21 Aug 2024 08:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OiwwfGy3"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9CF0199FD6;
	Wed, 21 Aug 2024 08:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724229356; cv=none; b=b2W0I9Diz0+CMOfFdK6fGFwlnwpYk5HllJM5rYsPDNLC+KeMHodVb/fBxfhK5ZP/4jRCEBV784ymge8SgYC3AvFJ168n6PKa8Us1hlcVDVuqZGn4nkZXM7TsfeWjdY8p5zle8OX8KGgW4jlIYBDK+vF45PbKn9bS8wi2o8ca4L0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724229356; c=relaxed/simple;
	bh=R+wRgSiVOb2gmh55nvSz3BLXVEWnplSPE0Nvb657Zok=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CoDxnkxXsb7MLeAecfpdX8D3ajsPsN0gGrG+LBQtGVy8fos0Nfni6C+qH5hnEsG4IxaKCPkSeSG3eDrkeiRxS+bGBYSXFnOzbK8HCjEoIabA6i6yaacDcCOgZkSeM3Gl4c5HlQbw8xllDMUB393G95XBKmfvxXyvi0GJSV4fbQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OiwwfGy3; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5bec50de782so969394a12.1;
        Wed, 21 Aug 2024 01:35:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724229353; x=1724834153; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gE/zU+9gsfuazjju8L9T1wI4aS038iOn7Pia/ZlHSoU=;
        b=OiwwfGy3zaxmVJDBOADKO+Ju+6uaRgtjQjVugBDc12IzeBtY2s5FCLayI8sfr2q/NT
         0FZ3lCKYkktPhIi82Ax3M7BJo305hr5PIZyAmpIn7ezHvww0Wfo/jOFEYNcwVUqIWl/n
         XY184Vo8abzAjxO2Nf55g3nnQzQ9HcUC+ORr7bzZmwgwyzZh4AL3hx7mTRWljSsQJ6Ac
         3gKkayNQQ4Icdc8iGfjYOOw4cckyQ8mSDp95yK9KJrE6Cr851MdJnU7MSv7XMOaiuLwa
         fnxu4nrzcftt0uJv8SFsn4PH632dsuMBVB06ROxliJ1VbW6nNRJFlooCcBYcYOXKwCs/
         CX6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724229353; x=1724834153;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gE/zU+9gsfuazjju8L9T1wI4aS038iOn7Pia/ZlHSoU=;
        b=eMB7cu8ULIBgHHIc1mOrim3A15qizRvIQgZoea26fS4IgV3Xsu7+/ZBHryPXUeMsg+
         VjCBBWXp56J3dfcvOqxIA9dvgcYTkGWuwVc7LSGOGTTN2hkZHwswhLOerknDPXxlT6Oj
         MTltwmre3KT5RB3ge+YMvq36+eL3HUi1H6Wpmm0ZYoWNxqOXROFggV+Hu9yYeGgAOWex
         9hylqjW9ZySAh0OjyigfnW+xHSBG7DCXUeHYIIRxscxVxU+pkp56fC39XfEx99NGyvpa
         VrqDZNK9PPW39sthOKnEBuA/1sk0Sa88/biiqogGnzfMSLO4Bn6QchZrYsap74bJZqqp
         d4iw==
X-Forwarded-Encrypted: i=1; AJvYcCW/UGWbjTn9Y5GFH686WBbDPImKfQgLMhqN8LEWek8EWgtBrYlWozj8Nj4SKSftAdhjcuGr6s1FTs9yLSqAPWDqLqE=@vger.kernel.org, AJvYcCXtn01vfU6zey3QaN43U73K6nI3nEnWPD5tufiL4OI8PvQyw43bR0hqXrmSgz9h/a6L0s8L4v+8WY9sfjQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzomzW0mEWttKHNwaLMCZ0JoyQHF+mYIRkODMOy1QHV78s7LzP
	nxTyl6pqNeCXECPop8s1WagVa0fhr+mIAC5WXzKpNpdnBFEYf7L+D+wetaZ14dgG4hH+kJgI7Qw
	a+I5aComxgBLapSQUWcsX3hcbK9U=
X-Google-Smtp-Source: AGHT+IGgB7zTNRoAijHXOcGbqbV4DdMicZx0YW1MFKctJyvNPLocYLupZdsC4/8+SmME++i/vr5EXBV1DK0rcSrDJPY=
X-Received: by 2002:a05:6402:5205:b0:5a1:a82:1a38 with SMTP id
 4fb4d7f45d1cf-5bf1f0dd18cmr565156a12.2.1724229352861; Wed, 21 Aug 2024
 01:35:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240815205606.16051-2-max8rr8@gmail.com> <172380142877.2215.11720831620589167404.tip-bot2@tip-bot2>
 <87a5h7j5l1.ffs@tglx>
In-Reply-To: <87a5h7j5l1.ffs@tglx>
From: Max R <max8rr8@gmail.com>
Date: Wed, 21 Aug 2024 11:35:41 +0300
Message-ID: <CAJrpu5n5ReFCWrtAYsWpneAb+g6hAs4E-NeFh40chJfArEsioQ@mail.gmail.com>
Subject: Re: [tip: x86/urgent] x86/ioremap: Use is_ioremap_addr() in iounmap()
To: Thomas Gleixner <tglx@linutronix.de>
Cc: tip-bot2 for Max Ramanouski <tip-bot2@linutronix.de>, linux-tip-commits@vger.kernel.org, 
	Christoph Hellwig <hch@lst.de>, Alistair Popple <apopple@nvidia.com>, x86@kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Apparently,  x86-32 doesn't provide VMALLOC_START in asm/pgtable.h,
and after a quick glance it seems to be the only arch to do so...
Probably the correct solution is to add include asm/vmalloc.h to
include/linux/ioremap.h, considering it uses VMALLOC_START. Will
resubmit the v4 version of patch later today.

Best regards,
Max


On Tue, 20 Aug 2024 at 23:35, Thomas Gleixner <tglx@linutronix.de> wrote:
>
> On Fri, Aug 16 2024 at 09:43, tip-bot wrote:
> > The following commit has been merged into the x86/urgent branch of tip:
> >
> > Commit-ID:     7b02ad32d83c16abd4961d79f3154b734d1d5d9c
> > Gitweb:        https://git.kernel.org/tip/7b02ad32d83c16abd4961d79f3154=
b734d1d5d9c
> > Author:        Max Ramanouski <max8rr8@gmail.com>
> > AuthorDate:    Thu, 15 Aug 2024 23:56:07 +03:00
> > Committer:     Thomas Gleixner <tglx@linutronix.de>
> > CommitterDate: Fri, 16 Aug 2024 11:33:33 +02:00
> >
> > x86/ioremap: Use is_ioremap_addr() in iounmap()
>
> This has been removed as it fails on a 32-bit defconfig:
>
> include/linux/ioremap.h: In function =E2=80=98is_ioremap_addr=E2=80=99:
> include/linux/ioremap.h:14:25: error: =E2=80=98VMALLOC_START=E2=80=99 und=
eclared (first use in this function); did you mean =E2=80=98KMALLOC_DMA=E2=
=80=99?
>    14 | #define IOREMAP_START   VMALLOC_START
>
> Can you please have a look?
>
> Thanks,
>
>         tglx

