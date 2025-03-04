Return-Path: <linux-tip-commits+bounces-3997-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E1ACA4EE91
	for <lists+linux-tip-commits@lfdr.de>; Tue,  4 Mar 2025 21:41:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0EEE3AB22C
	for <lists+linux-tip-commits@lfdr.de>; Tue,  4 Mar 2025 20:41:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE4A920C039;
	Tue,  4 Mar 2025 20:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Wqp33F2V"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5A381F8917
	for <linux-tip-commits@vger.kernel.org>; Tue,  4 Mar 2025 20:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741120891; cv=none; b=Nv7tF6M4DS3STs7088hhWpnduSTRtO077plkwVcKnNNiYwR6f6kopg3xy3wUcVn2nhHwpd3ybdsHPCkq+NGHapAfksOihIxWEhR9x+ld3IzPVwSC2MbCcoEsT5py1iQq3o8FbZW/60MSI9Dw+hZt7s5/Bo7MpTeVLA3+1HEEj4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741120891; c=relaxed/simple;
	bh=GJUYkFswbf3vcwD4sF00gsfWBJ+WhaC1VZb82bhTK0c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Nn/DJJ5Acj3lpUDZrX62QtKkyE2e5CV1o1N0VCtmak5K1R9pMtsgk3le0z2ur48qkvgxDDzjsMFhPCIR+bvm+NQ7PIk81GFnzffR89prevhofjkVVbjWLXSYAmj/R2YDeFsIFJsw3Dq12fDWt4X8iUl/8erMQDZWGou8/RhApOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Wqp33F2V; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-ac202264f9cso130941066b.0
        for <linux-tip-commits@vger.kernel.org>; Tue, 04 Mar 2025 12:41:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1741120888; x=1741725688; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kxXwhDVyR6qbTJQoUXWwo1wlriinEbaY/hOWV7spF6o=;
        b=Wqp33F2VaPIJFh3mI3JhHiImierCA39zLrSmudtiepBvTcdh3eG+b9tf17hNy7DoGY
         rLqWfYOuxk9hjCh8ZrbQFVSmionL8x6fKsTeqm6BIKhl7LZfWsT+yDY1TWb1qspUzI4a
         H0X+SkUrNsedwghaoFQoFTHdg/o1x1zaMGStM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741120888; x=1741725688;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kxXwhDVyR6qbTJQoUXWwo1wlriinEbaY/hOWV7spF6o=;
        b=c2Cti94mQvnlfg2S0TjCr8DchdsekN6OOx9Lq2TqD6wm2l9sw1nmR2wKarWGU0W43e
         1Mb28uq25PmItxQfwXnzEi0IG4eA65CcAd3B05HMMbGLnx+vUuIow9o6TdoFVCW4BaPA
         3F9E6EgZ2eV1shf4yd3rmChVYIOtCZH6gGWTe+cDbJqR2UHRiZ61OqC2swyg7g+Ds0Y+
         E8LtYdF6RsByrRpIiHqJlnRfWFwI28bFuFrZl0fGXShOWwIZoKj6YIUxd9np+gvYLjX3
         VvYDc9dzsDdGG9cvkQ81cUi3oa9hTIUqGTlpxi+GW7xYItlJcZcPAUAo6hWyiz7SZf4l
         3TqA==
X-Forwarded-Encrypted: i=1; AJvYcCWDS5tGkLFu21GsYF02dv2XAdfklUEQbyIPEnODQKH8F36lNLx4HOchbdawZjU9FHXwyG/19uP2CRy8m1I+NHnkeg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzbV7rGeL6YjIvzeeiT7oi+iHadW9DmSgh0nRsFNqh8dvOCBBMx
	FfyunEussLamCWngzEMzLLGUfvWArRPl2BdYJpO/5POycQ161DO85BOZ4O7snIYo97IWkpVLxxl
	s6tircQ==
X-Gm-Gg: ASbGncu1qz3cfbEVV9d7m2VUTnjf4GAKPUHfB3TsK7YxP0FAw5pgqCcOxHuWEwbzUmr
	1Xfk2+54x867FIPEIl+qJyfy4m8iYC7U5ohJC3HuHdhl++XCdauOstszCLNYDy+qFfKEdzPc4LY
	AOZvLcQXj1nULtVv6jhXzv3BqwmndLwLvtleMGAYnI50KIInvnHzKQAVFb1Jl+t+0x3boEDLLZR
	IsyrrLp89i0iwXgv4e7izD8YzpF8vqKxelNdl4dwEghWqs+uE32muF4b90UMYOt5DWeSYCs0+zo
	29rqLBslB/UuLqVIKGsKR95iHicltmY+obM0ytN/DTppIPZMlFTfnlC6fMbj0rNMljnpx/xFCaL
	9l5LO5Ne43e1n2Cc+A90=
X-Google-Smtp-Source: AGHT+IHNSWbJEyiTG0L2pnBOJWVI5vHOxmHleGPIm87gwZ1wQr5NCrGrahUqYiVttF+9yqNi8D3zUg==
X-Received: by 2002:a17:907:7b8d:b0:ac1:e5b1:86fb with SMTP id a640c23a62f3a-ac20da46ccdmr64799366b.10.1741120887733;
        Tue, 04 Mar 2025 12:41:27 -0800 (PST)
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com. [209.85.218.47])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abf7663b935sm422723466b.150.2025.03.04.12.41.26
        for <linux-tip-commits@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Mar 2025 12:41:26 -0800 (PST)
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-abf4b376f2fso618253966b.3
        for <linux-tip-commits@vger.kernel.org>; Tue, 04 Mar 2025 12:41:26 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWIxt6JdBqyp+Q30tkzFR2ZCODzzyXe5VFWSQFhttLzBf86o8ThwV22RLOPvM5RpBHBJV5V+vYjb3zZEj6sj9hqZA==@vger.kernel.org
X-Received: by 2002:a17:907:d94:b0:ac1:da0c:f668 with SMTP id
 a640c23a62f3a-ac20e153524mr57232366b.43.1741120886518; Tue, 04 Mar 2025
 12:41:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <174099976188.10177.7153571701278544000.tip-bot2@tip-bot2>
 <CAHk-=wjSwqJhvzAT-=AY88+7QmN=U0A121cGr286ZpuNdC+yaw@mail.gmail.com>
 <Z8a66_DbMbP-V5mi@gmail.com> <CAHk-=wjRsMfndBGLZzkq7DOU7JOVZLsUaXnfjFvOcEw_Kd6h5g@mail.gmail.com>
 <CAHk-=wjc8jnsOkLq1YfmM0eQqceyTunLEcfpXcm1EBhCDaLLgg@mail.gmail.com>
 <20250304182132.fcn62i4ry5ndli7l@jpoimboe> <CAHk-=wjgGD1p2bOCOeTjikNKmyDJ9zH8Fxiv5A+ts3JYacD3fA@mail.gmail.com>
 <CAHk-=whqPZjtH6VwLT3vL5-b3ONL2F83yEzxMMco+uFXe8CdKg@mail.gmail.com>
 <20250304195625.qcxvtv63fqqk6fx4@jpoimboe> <CAHk-=wizdAA_d1yHZQGHoJs2fqywPiT=NJT2wNA0xybV+GVefw@mail.gmail.com>
In-Reply-To: <CAHk-=wizdAA_d1yHZQGHoJs2fqywPiT=NJT2wNA0xybV+GVefw@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 4 Mar 2025 10:41:08 -1000
X-Gmail-Original-Message-ID: <CAHk-=wiwhHKvxZoaCPs2Zs4gaMAfCyZ=arBvXdP_kvNKOH5sKA@mail.gmail.com>
X-Gm-Features: AQ5f1JqwCdnEAOm6EQyOOf2Fa04agj1a8LvsPchd0a3tBCRJF8Yhs-p8vOWYtdw
Message-ID: <CAHk-=wiwhHKvxZoaCPs2Zs4gaMAfCyZ=arBvXdP_kvNKOH5sKA@mail.gmail.com>
Subject: Re: [tip: x86/asm] x86/asm: Make ASM_CALL_CONSTRAINT conditional on
 frame pointers
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-tip-commits@vger.kernel.org, 
	"Peter Zijlstra (Intel)" <peterz@infradead.org>, Brian Gerst <brgerst@gmail.com>, 
	"H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 4 Mar 2025 at 10:13, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Does clang even need it?

Bah. Yes it does. I may not have clang sources to try to look at, but
I can do a test-build.

Anyway, I do think it would be better to make this compiler-specific,
and keep gcc using the old tested case that works well regardless of
whether frame pointers are enabled or not, since it doesn't _care_.

And I think there's a better way to deal with the whole "generate
better code when not needed" too, if clang really has to have that
disgusting __builtin_frame_pointer() thing that then has problems when
frame pointers aren't enabled.

IOW, you could do something pointless like

   extern int unused_variable;
  #define ASM_CALL_CONSTRAINT "+m" (unused_variable)

which generates a dependency that doesn't matter, and then doesn't
then require preprocessor hacks for when it is empty.

So I *think* the patch could be something like

 - move the define to <asm/compiler-xyzzy,.h>

 - for gcc, use the old tested code

 - for clang, use the "either __builtin_frame_pointer(0) or dummy
dependency" thing

 - have big comments about it, because our historical changelogs
clearly are not accurate wrt this all.

                 Linus

