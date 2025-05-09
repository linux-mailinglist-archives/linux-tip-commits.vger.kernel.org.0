Return-Path: <linux-tip-commits+bounces-5514-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDF39AB0801
	for <lists+linux-tip-commits@lfdr.de>; Fri,  9 May 2025 04:40:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 27A977B298C
	for <lists+linux-tip-commits@lfdr.de>; Fri,  9 May 2025 02:39:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9FAF225414;
	Fri,  9 May 2025 02:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eINcCWxD"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0098821CFFA
	for <linux-tip-commits@vger.kernel.org>; Fri,  9 May 2025 02:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746758427; cv=none; b=r065juInEYaIvLDoU/+cKLEk4jpKG+vQ9lThVItJ1c9hmF+v53T3o6lfiARvoqOvpO6ZJXm1CeCAbcIBf/+iUSChq9VeEDbZ5ru3X0c9Mn69T1lnf15VUJzdAceFQ7b16EB/zjpV+PZUqMa2HQXNOXkpIdghzPKHRf/rMyOGzGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746758427; c=relaxed/simple;
	bh=fbU3HjWyMXkb9dGsZnGLbxInBFDNVNu9m2J3gvv0qnM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DSatk+tucK3d4m1SnZANK86jIckJBNcS7EVdCHlDeWU6sH9VQlSBKRPPRNQtazSbRAQ7xJK8moVPi/EdX/U+3HcS/3Y8uSZQGw4YETgdxSQuzxBhLtFioC7lzBCdD6DoBqizLLibmhwP9xi5dAgEecUCt0OpyJ+uuD+NT1t8pH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eINcCWxD; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5fbf1365b1fso5122a12.0
        for <linux-tip-commits@vger.kernel.org>; Thu, 08 May 2025 19:40:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746758424; x=1747363224; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fbU3HjWyMXkb9dGsZnGLbxInBFDNVNu9m2J3gvv0qnM=;
        b=eINcCWxDjU1u5WMzC4bWyzKpLTcSq8kp09EeAwZ0xQl1jnSPwVMY0Jg6czzR32uyN2
         xHAcVRWGKfF/VfNUf9jwpyv/7aQPRjdV+VTns7wy3oV2r2464Ptj2Sp+tshepmCtBziM
         UYzJYmk3VIxMyw2pjHKnWprRvEhKDVdv4SIsawitKDYfdhSrchpkBeqlva3OaJNFjZQ0
         Fg/i/wcKwSxWfoO0mS0kJYbWS+w/i2K1dYubAezrlrwhQ1pqA5PaKfEAArDgal2LlZuS
         BXDVjQR/2b6VpTXz4UeHtYdGw9ieb4muVvc/jL/EFNab9YPKY+OvOQ9Nox7O3b3DZ5jM
         tbQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746758424; x=1747363224;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fbU3HjWyMXkb9dGsZnGLbxInBFDNVNu9m2J3gvv0qnM=;
        b=Qfw5gYkn0qr1xt/mtqTcs9hUOzMaqQjvdtkSSGlGUfVeIBf6HTMYwfkWN50FQoHhxI
         zCYRPzYT26+DCSjCFKHoPIBOv7Mtz0baZZ0wiYDazZP5NtI6IR1P/9ZVLhxuOU/njVY4
         TQBBi12q1KpfrXyHeyaL3OtDp1WuVDDUmsiM63j9Mcr2QoDhSLKmrqpdD7ySmyhlJEhf
         SW5hUjCi9pYMYmpTTN36UMDvmPJRDDLBvNd5XQJpfyyqUiHPz5AHVx1CzbyX856e7S0K
         7FGMfhr5Y6GCzmA8g7WesHcT0XS6rpVi9UmPaDLR0SPmQU2G4fO4yo9xa9ZaOdeZYzYW
         /7sw==
X-Forwarded-Encrypted: i=1; AJvYcCXeTExROUJKlFlrevPuo1rGKJZ78Dldl8ewezG20JqmKIk4RfGVec6elXRQGvoz9IfL3GTbO/ipMpCfjCPzt+9fUA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxnKX41JW5epnblWvCPHLdLlQIO/3hEffNlsI6sRsVgrLG+UbuF
	jct56OFde6gVa+33BlFlRhm+nmKRUF6DeepZiHARCsAJZjK5RWNTVCp3VhbB/qGvrhnTZbESVaR
	6W+LxtjHPoQAMwHcec/h8f5rIzMex3qQKgSog
X-Gm-Gg: ASbGncsid9jyWBnnN7sD+h8jyO5lvwiLOZ5uYXhIi/774LZV6xHBcrhiRr5VSYYEDGy
	cJtt7NVK6SzS9DAoS+Ch8R8EMaWxpRRzbc2S1uogosn2g1qbX/kNCHsGEYebOGh8KVh50aKOmge
	X4+tyl2rOC0VW4A7pndgAs
X-Google-Smtp-Source: AGHT+IHs8N8GIJHV6hQ7v6BVcAhLlzquJwKORlwm8OHV24AyjhJvWrD2zfqx4hpKyBMB0ZsJzP8evSJIQn9Apks+tPQ=
X-Received: by 2002:aa7:cd07:0:b0:5fa:ac6f:ff97 with SMTP id
 4fb4d7f45d1cf-5fca1efb492mr46780a12.2.1746758424053; Thu, 08 May 2025
 19:40:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250425200541.113015-1-xur@google.com> <174601619410.22196.10353886760773998736.tip-bot2@tip-bot2>
 <jj4fu243l7ap4bza5imrgjk5f5dhsoloxezgphdjwo7sb5iqsq@wkt46abbt45r>
 <yrdh2fmzgqlrfe35wvxb3a2z7wdqod3liupdbriqzc5ihqjw5y@fsqeyi34cbgg>
 <xb2rjui75xylasuihl7gdnovv2z6qxgsefmzhxvhntlcuw5ktb@zbstyytmzjag> <20250508152713.GI4439@noisy.programming.kicks-ass.net>
In-Reply-To: <20250508152713.GI4439@noisy.programming.kicks-ass.net>
From: Rong Xu <xur@google.com>
Date: Thu, 8 May 2025 19:40:13 -0700
X-Gm-Features: AX0GCFuXdBKM7y2tZJ4PRPCqtCRq-rf2WAsTlEUdkGvaXI8BntKBO0j8ScCcDyc
Message-ID: <CAF1bQ=S52yEfJhhW8WrqmXu7ux1W4zVyk7Osv80tkiXpvegNqQ@mail.gmail.com>
Subject: Re: [PATCH] objtool: Speed up SHT_GROUP reindexing
To: Peter Zijlstra <peterz@infradead.org>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>, tip-bot2 for Rong Xu <tip-bot2@linutronix.de>, 
	linux-tip-commits@vger.kernel.org, x86@kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 8, 2025 at 8:27=E2=80=AFAM Peter Zijlstra <peterz@infradead.org=
> wrote:
>
> On Wed, May 07, 2025 at 05:11:53PM -0700, Josh Poimboeuf wrote:
> > On Wed, May 07, 2025 at 05:11:03PM -0700, Josh Poimboeuf wrote:
> > > From 2a33e583c87e3283706f346f9d59aac20653b7fd Mon Sep 17 00:00:00 200=
1
> > > Message-ID: <2a33e583c87e3283706f346f9d59aac20653b7fd.1746662991.git.=
jpoimboe@kernel.org>
> > > From: Josh Poimboeuf <jpoimboe@kernel.org>
> > > Date: Wed, 7 May 2025 16:56:55 -0700
> > > Subject: [PATCH] objtool: Speed up SHT_GROUP reindexing
> >
> > Urgh, sorry about the patch formatting, the above can obviously be
> > dropped.
>
> No worries, my script did it almost right :-)
>
> Patch seems sane to me; I'll go stick it into objtool/core. Rong if you
> could verify your case still work correctly that would be appreciated.

I tested the patch, and it works for me.

I also looked at the patch. It assumes there is only one .symtab section.
 In general, there can be multiple symtab sections in an ELF file. But this
(i.e. one symtab) most likely holds for the kernel.

Tested-by: Rong Xu <xur@google.com>

Thanks,

-Rong

>

